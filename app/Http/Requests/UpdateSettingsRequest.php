<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateSettingsRequest extends FormRequest
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
            'store_name' => ['required', 'string', 'max:150'],
            'store_address' => ['nullable', 'string', 'max:255'],
            'store_phone' => ['nullable', 'string', 'max:30'],
            'store_email' => ['nullable', 'email', 'max:255'],
            'currency_symbol' => ['required', 'string', 'max:8'],
            'tax_rate' => ['required', 'numeric', 'min:0', 'max:100'],
            'receipt_footer' => ['nullable', 'string', 'max:500'],
            'receipt_size' => ['required', 'in:80mm,58mm'],
            'low_stock_default' => ['required', 'integer', 'min:0', 'max:100000'],
        ];
    }

    public function attributes(): array
    {
        return [
            'tax_rate' => 'tax rate',
            'low_stock_default' => 'default low-stock threshold',
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'store_name' => trim((string) $this->input('store_name')),
            'currency_symbol' => trim((string) $this->input('currency_symbol')),
        ]);
    }
}
