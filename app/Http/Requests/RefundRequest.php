<?php

namespace App\Http\Requests;

use App\Enums\PaymentMethod;
use App\Models\Order;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Validator;

class RefundRequest extends FormRequest
{
    public function authorize(): bool
    {
        $user = $this->user();
        $order = $this->route('order');

        if (! $user) {
            return false;
        }

        // Admins may return anything; a cashier may only return a sale they
        // rang up themselves.
        return $user->isAdmin()
            || ($order instanceof Order && $order->user_id === $user->getAuthIdentifier());
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        return [
            'reason' => ['required', 'string', 'max:255'],
            'method' => ['required', Rule::in(array_keys(PaymentMethod::selectable()))],
            'note' => ['nullable', 'string', 'max:1000'],
            'items' => ['required', 'array', 'min:1'],
            // The form posts one box per line, so every product the cashier did
            // not pick arrives as 0. That is "not selected", not a bad value, so
            // the floor is 0 here and the real check is below: at least one line
            // has to carry a quantity.
            'items.*' => ['required', 'integer', 'min:0'],
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

            // Drop the untouched lines, then insist at least one survives.
            $requested = array_filter($requested, fn ($quantity) => (int) $quantity > 0);

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
