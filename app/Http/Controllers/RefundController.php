<?php

namespace App\Http\Controllers;

use App\Exceptions\OrderStateException;
use App\Http\Requests\RefundRequest;
use App\Models\Order;
use App\Models\Refund;
use App\Models\Setting;
use App\Services\RefundService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class RefundController extends Controller
{
    public function __construct(private readonly RefundService $refunds) {}

    public function index(Request $request): View
    {
        $validated = $request->validate([
            'q' => ['nullable', 'string', 'max:120'],
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date', 'after_or_equal:from'],
        ]);

        $query = Refund::query()->with(['order', 'user', 'items']);

        if ($term = trim((string) ($validated['q'] ?? ''))) {
            $like = '%'.str_replace(['%', '_'], ['\%', '\_'], $term).'%';
            $query->where(fn ($q) => $q
                ->where('refund_number', 'like', $like)
                ->orWhere('reason', 'like', $like)
                ->orWhereHas('order', fn ($o) => $o->where('order_number', 'like', $like)));
        }

        if (! empty($validated['from'])) {
            $query->whereDate('created_at', '>=', $validated['from']);
        }

        if (! empty($validated['to'])) {
            $query->whereDate('created_at', '<=', $validated['to']);
        }

        $summary = (clone $query)
            ->reorder()
            ->selectRaw('COALESCE(SUM(amount), 0) as total, COUNT(*) as count')
            ->first();

        return view('refunds.index', [
            'refunds' => $query->latest()->paginate(15)->withQueryString(),
            'filters' => $validated,
            'totalRefunded' => (float) $summary->total,
            'refundCount' => (int) $summary->count,
        ]);
    }

    public function create(Request $request, Order $order): View
    {
        abort_if($order->isCancelled(), 404, 'Cancelled orders cannot be refunded.');

        return view('refunds.create', [
            'order' => $order->load(['items.product', 'user']),
            'refundableItems' => $order->items->filter(fn ($item) => $item->refundable_quantity > 0)->values(),
            'refundTotal' => (float) $order->refunded_amount,
        ]);
    }

    public function store(RefundRequest $request, Order $order): RedirectResponse
    {
        try {
            $refund = $this->refunds->refund(
                $order,
                (array) $request->validated('items'),
                $request->validated('reason'),
                $request->validated('method'),
                $request->validated('note'),
                $request->user(),
            );
        } catch (OrderStateException $e) {
            return back()->withInput()->with('error', $e->getMessage());
        }

        return redirect()
            ->route('admin.refunds.show', $refund)
            ->with('success', sprintf(
                'Refund %s processed for %s. Stock has been restored.',
                $refund->refund_number,
                Setting::money($refund->amount),
            ));
    }

    public function show(Refund $refund): View
    {
        return view('refunds.show', [
            'refund' => $refund->load(['items.product', 'user', 'order.items']),
        ]);
    }
}
