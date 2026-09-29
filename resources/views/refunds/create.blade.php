@extends('layouts.app')

@section('title', 'Refund '.$order->order_number)
@section('page-title', 'Create Refund')
@section('page-subtitle', 'Order '.$order->order_number.' — '.\App\Models\Setting::money($order->total))

@section('content')
<div class="d-flex gap-2 mb-3">
    <a href="{{ route('orders.show', $order) }}" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-arrow-left me-1"></i>Back to Order
    </a>
    @if ($refundTotal > 0)
        <span class="badge text-bg-warning align-self-center">
            {{ \App\Models\Setting::money($refundTotal) }} already refunded
        </span>
    @endif
</div>

@if ($refundableItems->isEmpty())
    <div class="alert alert-warning">
        <i class="bi bi-exclamation-triangle me-1"></i>
        Every item on this order has already been refunded.
    </div>
@else
    <form method="POST" action="{{ route('refunds.store', $order) }}" id="refund-form"
          data-currency="{{ \App\Models\Setting::currency() }}">
        @csrf

        <div class="row g-3">
            <div class="col-lg-8">
                <div class="card mb-3">
                    <div class="card-header">Select items to refund</div>
                    <div class="table-responsive">
                        <table class="table mb-0">
                            <thead>
                            <tr>
                                <th>Product</th>
                                <th class="text-end">Unit price</th>
                                <th class="text-center">Sold</th>
                                <th class="text-center">Refunded</th>
                                <th class="text-center">Available</th>
                                <th class="text-center" style="width: 140px;">Refund qty</th>
                                <th class="text-end">Amount</th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach ($refundableItems as $item)
                                <tr>
                                    <td>
                                        <div class="fw-semibold">{{ $item->product_name }}</div>
                                        @if ($item->product && ! $item->product->is_active)
                                            <div class="text-body-secondary small">product inactive</div>
                                        @endif
                                    </td>
                                    <td class="text-end money">{{ \App\Models\Setting::money($item->unit_price) }}</td>
                                    <td class="text-center">{{ $item->quantity }}</td>
                                    <td class="text-center">{{ $item->refunded_quantity }}</td>
                                    <td class="text-center">
                                        <span class="badge text-bg-light text-body-secondary">{{ $item->refundable_quantity }}</span>
                                    </td>
                                    <td class="text-center">
                                        <input type="number" class="form-control form-control-sm text-center js-qty"
                                               name="items[{{ $item->id }}]" value="0" min="0"
                                               max="{{ $item->refundable_quantity }}" step="1"
                                               data-price="{{ $item->unit_price }}">
                                    </td>
                                    <td class="text-end money js-line-total" data-base="{{ $item->refundable_quantity }}">
                                        {{ \App\Models\Setting::money(0) }}
                                    </td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer d-flex flex-wrap gap-2 align-items-center">
                        <button type="button" class="btn btn-sm btn-outline-primary js-max-all">
                            <i class="bi bi-check2-all me-1"></i>Refund everything
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-secondary js-clear-all">Clear</button>
                        <span class="ms-auto fw-semibold">
                            Refund total: <span class="js-total money">{{ \App\Models\Setting::money(0) }}</span>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card">
                    <div class="card-header">Refund details</div>
                    <div class="card-body">
                        @error('items')<div class="alert alert-danger py-2 small">{{ $message }}</div>@enderror
                        @error('items.*')<div class="alert alert-danger py-2 small">{{ $message }}</div>@enderror

                        <div class="mb-3">
                            <label for="reason" class="form-label">Reason <span class="text-danger">*</span></label>
                            <input type="text" class="form-control @error('reason') is-invalid @enderror" id="reason" name="reason"
                                   value="{{ old('reason') }}" required maxlength="255"
                                   placeholder="e.g. customer returned damaged item">
                            @error('reason')<div class="invalid-feedback">{{ $message }}</div>@enderror
                        </div>

                        <div class="mb-3">
                            <label for="method" class="form-label">Refund method <span class="text-danger">*</span></label>
                            <select class="form-select @error('method') is-invalid @enderror" id="method" name="method" required>
                                @foreach (\App\Enums\PaymentMethod::selectable() as $value => $label)
                                    <option value="{{ $value }}" @selected(old('method', \App\Enums\PaymentMethod::Cash->value) === $value)>
                                        {{ $label }}
                                    </option>
                                @endforeach
                            </select>
                            @error('method')<div class="invalid-feedback">{{ $message }}</div>@enderror
                        </div>

                        <div class="mb-3">
                            <label for="note" class="form-label">Internal note</label>
                            <textarea class="form-control @error('note') is-invalid @enderror" id="note" name="note"
                                      rows="3" maxlength="1000">{{ old('note') }}</textarea>
                            @error('note')<div class="invalid-feedback">{{ $message }}</div>@enderror
                        </div>

                        <div class="alert alert-light border small mb-3">
                            <i class="bi bi-box-arrow-in-down me-1"></i>
                            Refunded units are returned to stock automatically and logged as a
                            <code>refund</code> inventory movement.
                        </div>

                        <button type="submit" class="btn btn-warning w-100">
                            <i class="bi bi-arrow-counterclockwise me-1"></i>Process Refund
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </form>
@endif
@endsection

@push('scripts')
<script>
(function () {
    'use strict';

    const form = document.getElementById('refund-form');
    if (!form) return;

    const currency = form.dataset.currency;
    const inputs = Array.from(form.querySelectorAll('.js-qty'));
    const totalEl = form.querySelector('.js-total');

    const money = (value) => currency + Number(value).toFixed(2);

    function recalculate() {
        let total = 0;

        inputs.forEach((input) => {
            const row = input.closest('tr');
            const lineEl = row.querySelector('.js-line-total');
            const price = parseFloat(input.dataset.price || '0');
            const qty = Math.max(0, Math.min(parseInt(input.value || '0', 10) || 0, parseInt(input.max, 10) || 0));
            const line = price * qty;

            total += line;
            lineEl.textContent = money(line);
        });

        totalEl.textContent = money(total);
    }

    inputs.forEach((input) => {
        input.addEventListener('input', () => {
            if (parseInt(input.value, 10) > parseInt(input.max, 10)) {
                input.value = input.max;
            }
            recalculate();
        });
    });

    form.querySelector('.js-max-all').addEventListener('click', () => {
        inputs.forEach((input) => { input.value = input.max; });
        recalculate();
    });

    form.querySelector('.js-clear-all').addEventListener('click', () => {
        inputs.forEach((input) => { input.value = 0; });
        recalculate();
    });

    form.addEventListener('submit', (event) => {
        const hasItems = inputs.some((input) => parseInt(input.value || '0', 10) > 0);

        if (!hasItems) {
            event.preventDefault();
            alert('Select at least one item to refund.');
            return;
        }

        // Only the chosen lines travel. The rest stay in the DOM so the
        // cashier can still adjust them, but a disabled input is not submitted,
        // so untouched rows cannot turn into validation errors.
        inputs.forEach((input) => {
            input.disabled = parseInt(input.value || '0', 10) < 1;
        });
    });

    recalculate();
})();
</script>
@endpush
