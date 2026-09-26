<?php

namespace App\Services;

use App\Enums\InventoryMovementType;
use App\Enums\OrderStatus;
use App\Enums\PaymentMethod;
use App\Enums\RefundStatus;
use App\Exceptions\OrderStateException;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Refund;
use App\Models\Setting;
use App\Models\User;
use App\Support\AuditLogger;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class RefundService
{
    public function __construct(private readonly InventoryService $inventory) {}

    /**
     * Refund part or all of an order and restock the returned units, atomically.
     *
     * @param  array<int, int>  $quantities  order_item_id => quantity to refund.
     *
     * @throws OrderStateException
     */
    public function refund(
        Order $order,
        array $quantities,
        string $reason,
        string $method,
        ?string $note,
        User $actor,
    ): Refund {
        return DB::transaction(function () use ($order, $quantities, $reason, $method, $note, $actor) {
            $order = Order::whereKey($order->getKey())->lockForUpdate()->firstOrFail();

            if ($order->isCancelled()) {
                throw OrderStateException::cannotCancel($order->order_number, 'cancelled');
            }

            $quantities = array_filter($quantities, fn ($qty) => (int) $qty > 0);

            if ($quantities === []) {
                throw OrderStateException::nothingToRefund($order->order_number);
            }

            /** @var Collection<int, OrderItem> $items */
            $items = $order->items()
                ->whereIn('id', array_keys($quantities))
                ->lockForUpdate()
                ->get()
                ->keyBy('id');

            if ($items->count() !== count($quantities)) {
                throw OrderStateException::nothingToRefund($order->order_number);
            }

            $refund = new Refund([
                'refund_number' => Refund::generateRefundNumber(),
                'order_id' => $order->getKey(),
                'user_id' => $actor->getAuthIdentifier(),
                'status' => RefundStatus::Completed,
                'reason' => $reason,
                'method' => PaymentMethod::tryFrom($method) ?? PaymentMethod::Cash,
                'note' => $note,
                'refunded_at' => now(),
                // Placeholder: the real total is written once the lines are priced.
                'amount' => 0,
            ]);

            // Persist before writing lines: refund_items.refund_id and the
            // movement reference both need the refund's primary key.
            $refund->save();

            $refundAmount = 0.0;

            foreach ($quantities as $orderItemId => $quantity) {
                /** @var OrderItem $item */
                $item = $items->get((int) $orderItemId);
                $quantity = (int) $quantity;

                $available = $item->quantity - $item->refunded_quantity;

                if ($quantity > $available) {
                    throw OrderStateException::exceedsRefundable($quantity, $available, $item->product_name);
                }

                // Refund proportionally to the line's discounted total.
                $unitAmount = $item->quantity > 0
                    ? round((float) $item->line_total / $item->quantity, 2)
                    : (float) $item->unit_price;

                $amount = round($unitAmount * $quantity, 2);
                $refundAmount += $amount;

                $refund->items()->create([
                    'order_item_id' => $item->getKey(),
                    'product_id' => $item->product_id,
                    'product_name' => $item->product_name,
                    'quantity' => $quantity,
                    'unit_price' => $item->unit_price,
                    'amount' => $amount,
                ]);

                $item->forceFill([
                    'refunded_quantity' => $item->refunded_quantity + $quantity,
                ])->save();

                if ($item->product) {
                    $this->inventory->increase(
                        $item->product,
                        $quantity,
                        InventoryMovementType::ReturnRestock,
                        sprintf('Refund %s for order %s', $refund->refund_number, $order->order_number),
                        $refund,
                        $actor,
                    );
                }
            }

            $refund->amount = round($refundAmount, 2);
            $refund->save();

            $order->refunded_amount = round((float) $order->refunded_amount + (float) $refund->amount, 2);

            $fullyRefunded = $order->items()
                ->whereColumn('refunded_quantity', '>=', 'quantity')
                ->count() === $order->items()->count();

            $order->status = $fullyRefunded
                ? OrderStatus::Refunded
                : OrderStatus::PartiallyRefunded;

            $order->save();

            AuditLogger::record(
                AuditLogger::REFUND_CREATED,
                sprintf(
                    'Refunded %s against order %s (%s).',
                    Setting::money($refund->amount),
                    $order->order_number,
                    $reason,
                ),
                $refund,
                ['order_status' => $order->status->value],
                ['amount' => $refund->amount, 'order_status' => $order->status->value],
            );

            return $refund->load(['items', 'user', 'order']);
        });
    }
}
