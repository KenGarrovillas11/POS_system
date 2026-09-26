<?php

namespace App\Http\Controllers;

use App\Enums\InventoryMovementType;
use App\Http\Requests\StockAdjustmentRequest;
use App\Models\Category;
use App\Models\InventoryMovement;
use App\Models\Product;
use App\Services\InventoryService;
use App\Support\AuditLogger;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Illuminate\View\View;

class InventoryController extends Controller
{
    public function __construct(private readonly InventoryService $inventory) {}

    /**
     * Stock levels - readable by staff (read-only) and admins.
     */
    public function index(Request $request): View
    {
        $validated = $request->validate([
            'q' => ['nullable', 'string', 'max:120'],
            'category_id' => ['nullable', 'integer', Rule::exists('categories', 'id')],
            'status' => ['nullable', Rule::in(['low', 'out', 'ok'])],
        ]);

        $query = Product::query()->with('category');

        $query->search($validated['q'] ?? null);

        if (! empty($validated['category_id'])) {
            $query->where('category_id', $validated['category_id']);
        }

        match ($validated['status'] ?? null) {
            'low' => $query->lowStock(),
            'out' => $query->where('stock', '<=', 0),
            'ok' => $query->whereColumn('stock', '>', 'low_stock_threshold'),
            default => null,
        };

        $query->orderBy('stock')->orderBy('name');

        $canAdjust = $request->user()->isAdmin();

        return view('inventory.index', [
            'products' => $query->paginate(15)->withQueryString(),
            'categories' => Category::orderBy('name')->get(),
            'filters' => $validated,
            'canAdjust' => $canAdjust,
            'lowStockCount' => Product::lowStock()->count(),
            'outOfStockCount' => Product::where('stock', '<=', 0)->count(),
            'stockValue' => (float) Product::query()->selectRaw('COALESCE(SUM(stock * cost_price), 0) as v')->value('v'),
        ]);
    }

    /**
     * The stock-in / stock-out history log. Admin only.
     */
    public function movements(Request $request): View
    {
        $validated = $request->validate([
            'q' => ['nullable', 'string', 'max:120'],
            'type' => ['nullable', Rule::in(InventoryMovementType::values())],
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date', 'after_or_equal:from'],
        ]);

        $query = InventoryMovement::query()->with(['product.category', 'user']);

        if ($term = trim((string) ($validated['q'] ?? ''))) {
            $like = '%'.str_replace(['%', '_'], ['\%', '\_'], $term).'%';
            $query->where(function ($q) use ($like) {
                $q->where('reason', 'like', $like)
                    ->orWhereHas('product', fn ($p) => $p->where('name', 'like', $like));
            });
        }

        if (! empty($validated['type'])) {
            $query->where('type', $validated['type']);
        }

        if (! empty($validated['from'])) {
            $query->whereDate('created_at', '>=', $validated['from']);
        }

        if (! empty($validated['to'])) {
            $query->whereDate('created_at', '<=', $validated['to']);
        }

        return view('inventory.movements', [
            'movements' => $query->latest()->paginate(20)->withQueryString(),
            'filters' => $validated,
            'types' => collect(InventoryMovementType::cases())
                ->mapWithKeys(fn (InventoryMovementType $type) => [$type->value => $type->label()])
                ->all(),
        ]);
    }

    public function create(Request $request, Product $product): View
    {
        return view('inventory.adjust', [
            'product' => $product,
            'types' => [
                InventoryMovementType::StockIn->value => InventoryMovementType::StockIn->label(),
                InventoryMovementType::StockOut->value => InventoryMovementType::StockOut->label(),
                InventoryMovementType::Adjustment->value => InventoryMovementType::Adjustment->label(),
            ],
        ]);
    }

    public function store(StockAdjustmentRequest $request, Product $product): RedirectResponse
    {
        $type = InventoryMovementType::from($request->validated('type'));
        $reason = $request->validated('reason');
        $user = $request->user();

        $movement = DB::transaction(function () use ($product, $type, $reason, $request, $user) {
            return match ($type) {
                InventoryMovementType::StockIn => $this->inventory->increase(
                    $product,
                    (int) $request->validated('quantity'),
                    $type,
                    $reason,
                    null,
                    $user,
                ),
                InventoryMovementType::StockOut => $this->inventory->decrease(
                    $product,
                    (int) $request->validated('quantity'),
                    $type,
                    $reason,
                    null,
                    $user,
                ),
                default => $this->inventory->setStock(
                    $product,
                    (int) $request->validated('new_stock'),
                    $reason,
                    $user,
                ),
            };
        });

        AuditLogger::record(
            AuditLogger::STOCK_ADJUSTED,
            sprintf(
                '%s on "%s": %+d units (%d -> %d). Reason: %s',
                $type->label(),
                $product->name,
                $movement->quantity,
                $movement->before_stock,
                $movement->after_stock,
                $reason,
            ),
            $product,
            ['stock' => $movement->before_stock],
            ['stock' => $movement->after_stock],
        );

        return redirect()
            ->route('inventory.index')
            ->with('success', sprintf('Stock updated for "%s" (%d -> %d).', $product->name, $movement->before_stock, $movement->after_stock));
    }
}
