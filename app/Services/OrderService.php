<?php

namespace App\Services;

use App\Enums\DiscountType;
use App\Enums\InventoryMovementType;
use App\Enums\OrderStatus;
use App\Enums\PaymentMethod;
use App\Exceptions\InsufficientStockException;
use App\Exceptions\OrderStateException;
use App\Models\Order;
use App\Models\Product;
use App\Models\Setting;
use App\Models\User;
use App\Support\AuditLogger;
use Illuminate\Support\Facades\DB;

class OrderService
{
    public function __construct(private readonly InventoryService $inventory) {}

    /**
     * Create an order, its items and the matching stock movements atomically.
     *
     * @param  array<string, mixed>  $cart  Raw cart payload (items, discount, note).
     * @param  array<string, mixed>  $payment  paid_amount, payment_method, note.
     *
     * @throws InsufficientStockException
     */
    public function checkout(array $cart, array $payment, User $cashier): Order
    {
        $lines = $cart['items'] ?? [];

        if ($lines === []) {
            throw new \InvalidArgumentException('Cannot complete an order with an empty cart.');
        }

        return DB::transaction(function () use ($lines, $cart, $payment, $cashier) {
            $products = Product::whereIn('id', array_keys($lines))
                ->lockForUpdate()
                ->get()
                ->keyBy('id');

            // Validate every line up-front so we never half-write an order.
            foreach ($lines as $productId => $line) {
                $product = $products->get((int) $productId);

                if (! $product) {
                    throw new \RuntimeException(sprintf('Product #%s is no longer available.', $productId));
                }

                if (! $product->is_active) {
                    throw new \RuntimeException(sprintf('"%s" is no longer available for sale.', $product->name));
                }

                if ($product->stock < (int) $line['quantity']) {
                    throw new InsufficientStockException($product, (int) $line['quantity']);
                }

                // Stock on hand is not the same as stock that may be sold: an
                // expired lot is still counted in products.stock but FEFO is
                // not allowed to draw from it.
                $sellable = $product->sellableStock();

                if ($sellable < (int) $line['quantity']) {
                    throw new InsufficientStockException(
                        $product,
                        (int) $line['quantity'],
                        $sellable,
                        $product->expiredQuantity(),
                    );
                }
            }

            $subtotal = 0.0;
            $lineTotals = [];

            foreach ($lines as $productId => $line) {
                $lineTotal = round((float) $line['unit_price'] * (int) $line['quantity'], 2);
                $lineTotals[$productId] = $lineTotal;
                $subtotal += $lineTotal;
            }

            $subtotal = round($subtotal, 2);

            $discountType = DiscountType::tryFrom($cart['discount_type'] ?? 'fixed') ?? DiscountType::Fixed;
            $discountValue = max(0, (float) ($cart['discount_value'] ?? 0));

            $discountAmount = match ($discountType) {
                DiscountType::Percentage => round($subtotal * min($discountValue, 100) / 100, 2),
                DiscountType::Fixed => min(round($discountValue, 2), $subtotal),
            };

            $taxable = round(max(0, $subtotal - $discountAmount), 2);
            $taxRate = Setting::taxRate();
            $taxAmount = round($taxable * $taxRate / 100, 2);
            $total = round($taxable + $taxAmount, 2);

            $paid = round(max(0, (float) ($payment['paid_amount'] ?? $total)), 2);
            $method = PaymentMethod::tryFrom($payment['payment_method'] ?? 'cash') ?? PaymentMethod::Cash;

            $order = Order::create([
                'order_number' => Order::generateOrderNumber(),
                'user_id' => $cashier->getAuthIdentifier(),
                'status' => OrderStatus::Completed,
                'subtotal' => $subtotal,
                'discount_type' => $discountType,
                'discount_value' => $discountValue,
                'discount_amount' => $discountAmount,
                'tax_rate' => $taxRate,
                'tax_amount' => $taxAmount,
                'total' => $total,
                'refunded_amount' => 0,
                'paid_amount' => $paid,
                'change_amount' => round(max(0, $paid - $total), 2),
                'payment_method' => $method,
                'customer_note' => $payment['note'] ?? ($cart['note'] ?? null),
            ]);

            foreach ($lines as $productId => $line) {
                $product = $products->get((int) $productId);
                $quantity = (int) $line['quantity'];

                // FEFO: the service draws from the soonest-expiring lots first
                // and may span several, so the split is read back and recorded.
                $movements = $this->inventory->decrease(
                    $product,
                    $quantity,
                    InventoryMovementType::Sale,
                    sprintf('Sale %s', $order->order_number),
                    $order,
                    $cashier,
                );

                $item = $order->items()->create([
                    'product_id' => $product->getKey(),
                    'product_name' => $product->name,
                    'unit_price' => $line['unit_price'],
                    // Freeze the buying price so historic profit stays correct
                    // even after the product's cost is edited later.
                    'unit_cost' => (float) $product->cost_price,
                    'quantity' => $quantity,
                    'refunded_quantity' => 0,
                    'discount_amount' => 0,
                    'line_total' => $lineTotals[$productId],
                ]);

                // Record which lot each unit left from, so a cancellation or a
                // refund can put it back on the same date it came off.
                foreach ($movements as $movement) {
                    $item->batchUsages()->create([
                        'batch_id' => $movement->batch_id,
                        'quantity' => abs((int) $movement->quantity),
                    ]);
                }
            }

            AuditLogger::record(
                AuditLogger::ORDER_CREATED,
                sprintf('Completed order %s for %s (cashier: %s).', $order->order_number, Setting::money($total), $cashier->name),
                $order,
                null,
                ['total' => $total, 'items' => $order->items()->count()],
            );

            return $order->load(['items.product', 'user']);
        });
    }

    /**
     * Cancel an order and return every line to stock, atomically.
     *
     * @throws OrderStateException
     */
    public function cancel(Order $order, string $reason, User $actor): Order
    {
        return DB::transaction(function () use ($order, $reason, $actor) {
            $order = Order::whereKey($order->getKey())->lockForUpdate()->firstOrFail();

            if ($order->isCancelled()) {
                throw OrderStateException::cannotCancel($order->order_number, 'already cancelled');
            }

            if ($order->refunded_amount > 0) {
                throw OrderStateException::cannotCancel(
                    $order->order_number,
                    $order->isFullyRefunded() ? 'fully refunded' : 'partially refunded',
                );
            }

            foreach ($order->items()->with('product')->get() as $item) {
                if (! $item->product) {
                    continue;
                }

                // Back onto the exact lots the units were sold from, dates intact.
                $this->inventory->returnToLots(
                    $item,
                    $item->quantity,
                    InventoryMovementType::SaleCancellation,
                    sprintf('Order %s cancelled', $order->order_number),
                    $order,
                    $actor,
                );
            }

            $order->forceFill([
                'status' => OrderStatus::Cancelled,
                'cancelled_at' => now(),
                'cancel_reason' => $reason,
                'change_amount' => 0,
            ])->save();

            AuditLogger::record(
                AuditLogger::ORDER_CANCELLED,
                sprintf('Cancelled order %s (%s).', $order->order_number, $reason),
                $order,
                ['status' => $order->status->value],
                ['status' => OrderStatus::Cancelled->value],
            );

            return $order->fresh(['items.product', 'user']);
        });
    }
}
