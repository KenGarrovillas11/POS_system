<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Validator;

class ProductRequest extends FormRequest
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
            'category_id' => ['nullable', 'integer', Rule::exists('categories', 'id')],
            'name' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string', 'max:2000'],
            'cost_price' => ['required', 'numeric', 'min:0', 'max:99999999'],
            'selling_price' => ['required', 'numeric', 'min:0', 'max:99999999'],
            'stock' => ['required', 'integer', 'min:0', 'max:1000000'],
            'low_stock_threshold' => ['required', 'integer', 'min:0', 'max:1000000'],
            'unit' => ['required', 'string', 'max:20'],
            'is_active' => ['nullable', 'boolean'],
        ];
    }

    public function withValidator(Validator $validator): void
    {
        $validator->after(function (Validator $validator) {
            if ((float) $this->input('selling_price') < (float) $this->input('cost_price')) {
                $validator->errors()->add(
                    'selling_price',
                    'The selling price is below the cost price. Please confirm this is intended.',
                );
            }
        });
    }

    public function attributes(): array
    {
        return [
            'category_id' => 'category',
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'category_id' => ($categoryId = $this->input('category_id')) !== '' ? $categoryId : null,
            'is_active' => $this->boolean('is_active'),
        ]);
    }
}
