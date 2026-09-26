<?php

namespace App\Http\Requests;

use App\Enums\PaymentMethod;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Validator;

class RefundRequest extends FormRequest
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
            'reason' => ['required', 'string', 'max:255'],
            'method' => ['required', Rule::in(array_column(PaymentMethod::cases(), 'value'))],
            'note' => ['nullable', 'string', 'max:1000'],
            'items' => ['required', 'array', 'min:1'],
            'items.*' => ['required', 'integer', 'min:1'],
        ];
    }

    /**
     * Each requested quantity must be within that line's refundable balance.
     */
    public function withValidator(Validator $validator): void
    {
        $validator->after(function (Validator $validator) {
            $order = $this->route('order');

            if (! $order) {
                return;
            }

            $requested = (array) $this->input('items', []);

            if ($requested === []) {
                $validator->errors()->add('items', 'Select at least one item to refund.');

                return;
            }

            $lines = $order->items()
                ->whereIn('id', array_keys($requested))
                ->get()
                ->keyBy('id');

            foreach ($requested as $orderItemId => $quantity) {
                $line = $lines->get((int) $orderItemId);

                if (! $line) {
                    $validator->errors()->add('items', 'One of the selected items is no longer part of this order.');

                    continue;
                }

                $available = $line->quantity - $line->refunded_quantity;

                if ((int) $quantity > $available) {
                    $validator->errors()->add("items.{$orderItemId}", sprintf(
                        'Only %d unit(s) of "%s" remain refundable.',
                        $available,
                        $line->product_name,
                    ));
                }
            }
        });
    }

    public function attributes(): array
    {
        return [
            'items' => 'refund items',
        ];
    }
}
