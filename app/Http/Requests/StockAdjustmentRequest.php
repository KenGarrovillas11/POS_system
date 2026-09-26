<?php

namespace App\Http\Requests;

use App\Enums\InventoryMovementType;
use App\Models\Product;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Validator;

class StockAdjustmentRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->isAdmin() === true;
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        return [
            'type' => ['required', Rule::in([
                InventoryMovementType::StockIn->value,
                InventoryMovementType::StockOut->value,
                InventoryMovementType::Adjustment->value,
            ])],
            'quantity' => ['nullable', 'integer', 'min:1', 'max:1000000'],
            'new_stock' => ['nullable', 'integer', 'min:0', 'max:1000000'],
            'reason' => ['required', 'string', 'max:255'],
        ];
    }

    public function withValidator(Validator $validator): void
    {
        $type = $this->input('type');

        $validator->after(function (Validator $validator) use ($type) {
            if ($type === InventoryMovementType::Adjustment->value) {
                if ($this->input('new_stock') === null || $this->input('new_stock') === '') {
                    $validator->errors()->add('new_stock', 'Enter the new stock level for an adjustment.');
                }

                return;
            }

            if (! $this->filled('quantity')) {
                $validator->errors()->add('quantity', 'Enter the number of units.');
            }
        });

        // A stock-out must not drive stock below zero.
        $validator->after(function (Validator $validator) {
            if ($this->input('type') !== InventoryMovementType::StockOut->value) {
                return;
            }

            $product = $this->route('product');

            if ($product instanceof Product && (int) $this->input('quantity') > $product->stock) {
                $validator->errors()->add('quantity', sprintf(
                    'Cannot remove %d units - only %d in stock.',
                    (int) $this->input('quantity'),
                    $product->stock,
                ));
            }
        });
    }

    public function attributes(): array
    {
        return [
            'new_stock' => 'new stock level',
        ];
    }
}
