<?php

namespace Database\Seeders;

use App\Enums\PaymentMethod;
use App\Exceptions\InsufficientStockException;
use App\Models\AuditLog;
use App\Models\InventoryMovement;
use App\Models\Product;
use App\Models\User;
use App\Services\OrderService;
use Illuminate\Database\Seeder;
use Illuminate\Support\Carbon;

/**
 * Rings up 30 days of believable sales through the real OrderService, so stock
 * levels, movements, order numbers and revenue all stay consistent.
 */
class DemoSalesSeeder extends Seeder
{
    public function run(OrderService $orders): void
    {
        $cashiers = User::where('is_active', true)->get();

        if ($cashiers->isEmpty()) {
            $this->command?->warn('No active users found - run UserSeeder first.');

            return;
        }

        $products = Product::where('is_active', true)->where('stock', '>', 4)->get();

        if ($products->isEmpty()) {
            $this->command?->warn('No sellable products found - run CatalogSeeder first.');

            return;
        }

        $methods = [PaymentMethod::Cash, PaymentMethod::Card, PaymentMethod::Mobile, PaymentMethod::Cash, PaymentMethod::Card];

        for ($day = 29; $day >= 0; $day--) {
            // Busier at weekends, quiet on Mondays.
            $date = Carbon::today()->subDays($day);
            $isWeekend = $date->isWeekend();
            $ordersToday = random_int($isWeekend ? 6 : 3, $isWeekend ? 11 : 7);

            for ($n = 0; $n < $ordersToday; $n++) {
                $cashier = $cashiers->random();
                $lines = [];

                foreach ($products->random(random_int(1, 5)) as $product) {
                    $existing = $lines[$product->getKey()] ?? null;
                    $quantity = random_int(1, 3);

                    if ($existing) {
                        $quantity += $existing['quantity'];
                    }

                    $lines[$product->getKey()] = [
                        'quantity' => $quantity,
                        'unit_price' => (float) $product->selling_price,
                    ];
                }

                $method = $methods[array_rand($methods)];
                $stamp = $date->copy()->setTime(random_int(9, 20), random_int(0, 59));

                try {
                    $order = $orders->checkout(
                        [
                            'items' => $lines,
                            'discount_type' => random_int(1, 10) === 1 ? 'percentage' : 'fixed',
                            'discount_value' => random_int(1, 10) === 1 ? random_int(5, 15) : random_int(1, 5),
                        ],
                        [
                            'payment_method' => $method->value,
                            'paid_amount' => 0,
                            'note' => null,
                        ],
                        $cashier,
                    );
                } catch (InsufficientStockException) {
                    // Ran out of stock mid-demo; skip that basket.
                    continue;
                }

                // Backdate the sale so the dashboard and reports have a trend.
                $order->forceFill(['created_at' => $stamp, 'updated_at' => $stamp])->save();
                $order->items()->update(['created_at' => $stamp, 'updated_at' => $stamp]);

                InventoryMovement::query()
                    ->where('reference_type', $order->getMorphClass())
                    ->where('reference_id', $order->getKey())
                    ->update(['created_at' => $stamp, 'updated_at' => $stamp]);

                AuditLog::query()
                    ->where('auditable_type', $order->getMorphClass())
                    ->where('auditable_id', $order->getKey())
                    ->update(['created_at' => $stamp, 'updated_at' => $stamp]);
            }
        }
    }
}
