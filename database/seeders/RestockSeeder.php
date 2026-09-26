<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Services\InventoryService;
use Illuminate\Database\Seeder;

/**
 * Demo sales drain stock, which leaves too many products at zero to be a useful
 * demo. Tops up anything that sold out, then deliberately leaves a couple of
 * products just below their threshold so the low-stock alerts have content.
 */
class RestockSeeder extends Seeder
{
    public function run(InventoryService $inventory): void
    {
        // Anything that sold out goes back to a comfortable level.
        Product::query()
            ->where('stock', '<=', 0)
            ->each(function (Product $product) use ($inventory) {
                $inventory->setStock(
                    $product,
                    max(10, (int) $product->low_stock_threshold * 3),
                    'Restock after demo sales',
                );
            });

        // Every eighth product is left one unit below its alert threshold.
        Product::query()
            ->orderBy('id')
            ->get()
            ->values()
            ->filter(fn (Product $product, int $index) => $index % 8 === 3)
            ->each(function (Product $product) use ($inventory) {
                $target = max(0, (int) $product->low_stock_threshold - 1);

                if ((int) $product->stock <= $target) {
                    $inventory->setStock($product, $target, 'Stock count correction');
                }
            });
    }
}
