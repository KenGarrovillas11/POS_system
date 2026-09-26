<?php

namespace App\Services;

use App\Enums\DiscountType;
use App\Models\Product;
use App\Models\Setting;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Session;

/**
 * Session-backed POS cart.
 *
 * Holds product snapshots so a cart survives product edits between the time it
 * was built and checkout. Stock is re-validated at checkout time.
 */
class CartService
{
    public const SESSION_KEY = 'pos_cart';

    /**
     * @return array<string, mixed>
     */
    public function raw(): array
    {
        $cart = Session::get(self::SESSION_KEY, []);

        return is_array($cart) ? $cart + ['items' => [], 'discount_type' => 'fixed', 'discount_value' => 0, 'note' => null] : $cart;
    }

    public function put(array $cart): void
    {
        Session::put(self::SESSION_KEY, $cart);
    }

    /**
     * Cart lines, each with the live product attached when it still exists.
     *
     * @return Collection<int, array<string, mixed>>
     */
    public function items(): Collection
    {
        $items = $this->raw()['items'] ?? [];

        if ($items === []) {
            return collect();
        }

        $products = Product::with('category')
            ->whereIn('id', array_keys($items))
            ->get()
            ->keyBy('id');

        return collect($items)
            ->map(function (array $line, int|string $productId) use ($products) {
                $product = $products->get((int) $productId);
                $quantity = (int) $line['quantity'];
                $unitPrice = (float) $line['unit_price'];

                return [
                    'product_id' => (int) $productId,
                    'name' => $line['name'],
                    'unit' => $line['unit'] ?? 'pcs',
                    'unit_price' => $unitPrice,
                    'quantity' => $quantity,
                    'line_total' => round($unitPrice * $quantity, 2),
                    'category' => $product?->category?->name,
                    // Live stock, used to warn the cashier before checkout.
                    'stock' => $product?->stock,
                    'is_active' => (bool) ($product?->is_active ?? false),
                    'product_exists' => $product !== null,
                    'stock_ok' => $product !== null && $product->stock >= $quantity,
                ];
            })
            ->values();
    }

    public function add(Product $product, int $quantity = 1): void
    {
        $cart = $this->raw();
        $productId = (int) $product->id;
        $quantity = max(1, $quantity);

        $existing = (int) ($cart['items'][$productId]['quantity'] ?? 0);
        $cart['items'][$productId] = [
            'product_id' => $productId,
            'name' => $product->name,
            'unit' => $product->unit,
            'unit_price' => (float) $product->selling_price,
            'quantity' => $existing + $quantity,
        ];

        $this->put($cart);
    }

    public function updateQuantity(int $productId, int $quantity): void
    {
        $cart = $this->raw();

        if (! isset($cart['items'][$productId])) {
            return;
        }

        if ($quantity <= 0) {
            $this->remove($productId);

            return;
        }

        $cart['items'][$productId]['quantity'] = $quantity;
        $this->put($cart);
    }

    public function remove(int $productId): void
    {
        $cart = $this->raw();
        unset($cart['items'][$productId]);
        $this->put($cart);
    }

    public function clear(): void
    {
        Session::forget(self::SESSION_KEY);
    }

    public function setDiscount(DiscountType $type, float $value): void
    {
        $cart = $this->raw();
        $cart['discount_type'] = $type->value;
        $cart['discount_value'] = $value;
        $this->put($cart);
    }

    public function setNote(?string $note): void
    {
        $cart = $this->raw();
        $cart['note'] = $note;
        $this->put($cart);
    }

    public function count(): int
    {
        return count($this->raw()['items'] ?? []);
    }

    public function totalQuantity(): int
    {
        return (int) collect($this->raw()['items'] ?? [])->sum('quantity');
    }

    public function isEmpty(): bool
    {
        return $this->count() === 0;
    }

    /**
     * Cart subtotal, discount, tax and grand total.
     *
     * @return array{subtotal: float, discount_type: string, discount_value: float, discount_amount: float, taxable: float, tax_rate: float, tax_amount: float, total: float, item_count: int, quantity: int}
     */
    public function totals(): array
    {
        $raw = $this->raw();
        $subtotal = round(
            collect($raw['items'] ?? [])->sum(
                fn (array $line) => round((float) $line['unit_price'] * (int) $line['quantity'], 2)
            ),
            2
        );

        $type = DiscountType::tryFrom($raw['discount_type'] ?? 'fixed') ?? DiscountType::Fixed;
        $value = max(0, (float) ($raw['discount_value'] ?? 0));

        $discountAmount = match ($type) {
            DiscountType::Percentage => round($subtotal * min($value, 100) / 100, 2),
            DiscountType::Fixed => min(round($value, 2), $subtotal),
        };

        $taxable = round(max(0, $subtotal - $discountAmount), 2);
        $taxRate = Setting::taxRate();
        $taxAmount = round($taxable * $taxRate / 100, 2);

        return [
            'subtotal' => $subtotal,
            'discount_type' => $type->value,
            'discount_value' => $value,
            'discount_amount' => $discountAmount,
            'taxable' => $taxable,
            'tax_rate' => $taxRate,
            'tax_amount' => $taxAmount,
            'total' => round($taxable + $taxAmount, 2),
            'item_count' => $this->count(),
            'quantity' => $this->totalQuantity(),
        ];
    }
}
