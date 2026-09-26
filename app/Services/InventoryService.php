<?php

namespace App\Services;

use App\Enums\InventoryMovementType;
use App\Exceptions\InsufficientStockException;
use App\Models\InventoryMovement;
use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;

/**
 * Single place where stock levels change, so every change is traceable
 * through the inventory_movements log.
 *
 * Callers are responsible for wrapping multi-write work in a transaction.
 */
class InventoryService
{
    /**
     * Apply a signed delta to a product's stock and record the movement.
     *
     * @param  int  $quantity  Positive to increase stock, negative to decrease.
     *
     * @throws InsufficientStockException when decreasing below zero.
     */
    public function adjust(
        Product $product,
        int $quantity,
        InventoryMovementType $type,
        ?string $reason = null,
        ?Model $reference = null,
        ?User $user = null,
    ): InventoryMovement {
        if ($quantity === 0) {
            throw new \InvalidArgumentException('Inventory adjustment quantity cannot be zero.');
        }

        // Lock the row so concurrent checkouts cannot oversell.
        $product = Product::whereKey($product->getKey())->lockForUpdate()->firstOrFail();

        $before = (int) $product->stock;
        $after = $before + $quantity;

        if ($after < 0) {
            throw new InsufficientStockException($product, abs($quantity));
        }

        $product->forceFill(['stock' => $after])->save();

        return InventoryMovement::create([
            'product_id' => $product->getKey(),
            'user_id' => $user?->getAuthIdentifier(),
            'type' => $type,
            'quantity' => $quantity,
            'before_stock' => $before,
            'after_stock' => $after,
            'reason' => $reason,
            'reference_type' => $reference?->getMorphClass(),
            'reference_id' => $reference?->getKey(),
        ]);
    }

    /**
     * Increase stock (stock-in, return restock, cancelled sale).
     */
    public function increase(
        Product $product,
        int $quantity,
        InventoryMovementType $type,
        ?string $reason = null,
        ?Model $reference = null,
        ?User $user = null,
    ): InventoryMovement {
        return $this->adjust($product, abs($quantity), $type, $reason, $reference, $user);
    }

    /**
     * Decrease stock (sale, manual stock-out).
     *
     * @throws InsufficientStockException
     */
    public function decrease(
        Product $product,
        int $quantity,
        InventoryMovementType $type,
        ?string $reason = null,
        ?Model $reference = null,
        ?User $user = null,
    ): InventoryMovement {
        return $this->adjust($product, -abs($quantity), $type, $reason, $reference, $user);
    }

    /**
     * Set stock to an absolute value, logging the difference as an adjustment.
     */
    public function setStock(
        Product $product,
        int $newStock,
        string $reason,
        ?User $user = null,
    ): InventoryMovement {
        $newStock = max(0, $newStock);
        $delta = $newStock - (int) $product->stock;

        if ($delta === 0) {
            $delta = 0;
        }

        // A zero delta still needs a log row, so bypass the guard above.
        if ($delta === 0) {
            $product = Product::whereKey($product->getKey())->lockForUpdate()->firstOrFail();
            $before = (int) $product->stock;
            $product->forceFill(['stock' => $newStock])->save();

            return InventoryMovement::create([
                'product_id' => $product->getKey(),
                'user_id' => $user?->getAuthIdentifier(),
                'type' => InventoryMovementType::Adjustment,
                'quantity' => 0,
                'before_stock' => $before,
                'after_stock' => $newStock,
                'reason' => $reason,
            ]);
        }

        return $this->adjust(
            $product,
            $delta,
            InventoryMovementType::Adjustment,
            $reason,
            null,
            $user,
        );
    }
}
