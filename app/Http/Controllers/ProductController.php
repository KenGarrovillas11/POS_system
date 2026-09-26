<?php

namespace App\Http\Controllers;

use App\Enums\InventoryMovementType;
use App\Enums\OrderStatus;
use App\Http\Requests\ProductRequest;
use App\Models\Category;
use App\Models\Product;
use App\Services\InventoryService;
use App\Support\AuditLogger;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Illuminate\View\View;

class ProductController extends Controller
{
    public function index(Request $request): View
    {
        $validated = $request->validate([
            'q' => ['nullable', 'string', 'max:120'],
            'category_id' => ['nullable', 'integer', Rule::exists('categories', 'id')],
            'status' => ['nullable', Rule::in(['active', 'inactive', 'low', 'out'])],
            'sort' => ['nullable', Rule::in(['name', 'stock', 'price', 'created_at'])],
            'direction' => ['nullable', Rule::in(['asc', 'desc'])],
        ]);

        $query = Product::query()->with('category');

        $query->search($validated['q'] ?? null);

        if (! empty($validated['category_id'])) {
            $query->where('category_id', $validated['category_id']);
        }

        match ($validated['status'] ?? null) {
            'active' => $query->where('is_active', true),
            'inactive' => $query->where('is_active', false),
            'low' => $query->lowStock(),
            'out' => $query->where('stock', '<=', 0),
            default => null,
        };

        $sort = $validated['sort'] ?? 'name';
        $query->orderBy($sort, ($validated['direction'] ?? 'asc') === 'desc' ? 'desc' : 'asc');

        $products = $query->paginate(15)->withQueryString();

        return view('products.index', [
            'products' => $products,
            'categories' => Category::orderBy('name')->get(),
            'filters' => $validated,
        ]);
    }

    public function show(Product $product): View
    {
        $product->load('category');

        return view('products.show', [
            'product' => $product,
            'movements' => $product->inventoryMovements()->with('user')->latest()->limit(20)->get(),
            'sales' => $product->orderItems()
                ->whereHas('order', fn (Builder $q) => $q->where('status', '!=', OrderStatus::Cancelled->value))
                ->with('order')
                ->latest()
                ->limit(20)
                ->get(),
            'totalsSold' => (int) $product->orderItems()
                ->whereHas('order', fn (Builder $q) => $q->where('status', '!=', OrderStatus::Cancelled->value))
                ->sum('quantity'),
            'revenue' => (float) $product->orderItems()
                ->whereHas('order', fn (Builder $q) => $q->where('status', '!=', OrderStatus::Cancelled->value))
                ->sum('line_total'),
        ]);
    }

    public function create(): View
    {
        return view('products.create', [
            'product' => new Product(['is_active' => true, 'low_stock_threshold' => 5, 'unit' => 'pcs']),
            'categories' => Category::orderBy('name')->get(),
        ]);
    }

    public function store(ProductRequest $request): RedirectResponse
    {
        $data = $request->validated();
        $openingStock = (int) ($data['stock'] ?? 0);

        $product = DB::transaction(function () use ($request, $data, $openingStock) {
            // Start at zero so the opening quantity is applied - and logged - once.
            $product = Product::create(array_merge($data, ['stock' => 0]));

            if ($openingStock > 0) {
                app(InventoryService::class)->increase(
                    $product,
                    $openingStock,
                    InventoryMovementType::StockIn,
                    'Opening stock',
                    null,
                    $request->user(),
                );
            }

            return $product;
        });

        AuditLogger::record(
            AuditLogger::PRODUCT_CREATED,
            sprintf('Created product "%s".', $product->name),
            $product,
            null,
            $product->only(['name', 'selling_price', 'stock']),
        );

        return redirect()
            ->route('products.index')
            ->with('success', sprintf('Product "%s" created.', $product->name));
    }

    public function edit(Product $product): View
    {
        return view('products.edit', [
            'product' => $product,
            'categories' => Category::orderBy('name')->get(),
        ]);
    }

    public function update(ProductRequest $request, Product $product): RedirectResponse
    {
        $before = $product->only(['name', 'category_id', 'cost_price', 'selling_price', 'low_stock_threshold', 'unit', 'is_active']);
        $data = $request->validated();
        $newStock = (int) $data['stock'];

        // Stock is deliberately left out of the mass assignment so the change
        // flows through InventoryService and keeps a before/after trail.
        unset($data['stock']);

        DB::transaction(function () use ($product, $data, $newStock, $request) {
            $stockChanged = $newStock !== (int) $product->stock;

            $product->fill($data)->save();

            if ($stockChanged) {
                app(InventoryService::class)->setStock(
                    $product->fresh(),
                    $newStock,
                    'Stock level updated on product edit',
                    $request->user(),
                );
            }
        });

        $product->refresh();
        $diff = AuditLogger::diff($before, $product->only(array_keys($before)));

        AuditLogger::record(
            AuditLogger::PRODUCT_UPDATED,
            sprintf('Updated product "%s".', $product->name),
            $product,
            $diff['old'],
            $diff['new'],
        );

        return redirect()
            ->route('products.index')
            ->with('success', sprintf('Product "%s" updated.', $product->name));
    }

    public function destroy(Product $product): RedirectResponse
    {
        $name = $product->name;

        if ($product->orderItems()->exists()) {
            return back()->with('error', sprintf(
                'Cannot delete "%s" because it appears in past orders. Deactivate it instead to keep sales history intact.',
                $name,
            ));
        }

        AuditLogger::record(
            AuditLogger::PRODUCT_DELETED,
            sprintf('Deleted product "%s".', $name),
            $product,
            $product->only(['name', 'selling_price', 'stock']),
        );

        $product->delete();

        return redirect()
            ->route('products.index')
            ->with('success', sprintf('Product "%s" deleted.', $name));
    }
}
