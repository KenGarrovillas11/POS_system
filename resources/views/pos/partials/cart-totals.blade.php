<div id="cart-totals-area">
    <dl class="row mb-2 small">
        <dt class="col-7 text-body-secondary fw-normal">Subtotal ({{ $totals['quantity'] }} item(s))</dt>
        <dd class="col-5 text-end money">{{ \App\Models\Setting::money($totals['subtotal']) }}</dd>

        @if ($totals['discount_amount'] > 0)
            <dt class="col-7 text-body-secondary fw-normal">
                Discount
                <span class="badge text-bg-success ms-1">
                    {{ $totals['discount_type'] === 'percentage'
                        ? rtrim(rtrim(number_format($totals['discount_value'], 2, '.', ''), '0'), '.') . '%'
                        : \App\Models\Setting::money($totals['discount_value']) }}
                </span>
            </dt>
            <dd class="col-5 text-end money text-success">- {{ \App\Models\Setting::money($totals['discount_amount']) }}</dd>
        @endif

        @if ($totals['tax_rate'] > 0)
            <dt class="col-7 text-body-secondary fw-normal">Tax ({{ rtrim(rtrim(number_format($totals['tax_rate'], 2, '.', ''), '0'), '.') }}%)</dt>
            <dd class="col-5 text-end money">{{ \App\Models\Setting::money($totals['tax_amount']) }}</dd>
        @endif
    </dl>

    <div class="d-flex justify-content-between align-items-center border-top pt-2 mb-3">
        <span class="fw-semibold">Total</span>
        <span class="fs-5 fw-bold money">{{ \App\Models\Setting::money($totals['total']) }}</span>
    </div>

    <div class="row g-2 mb-3">
        <div class="col-5">
            <select class="form-select form-select-sm" id="discount_type" aria-label="Discount type">
                @foreach ($discountTypes as $value => $label)
                    <option value="{{ $value }}" @selected($totals['discount_type'] === $value)>{{ $label }}</option>
                @endforeach
            </select>
        </div>
        <div class="col-4">
            <input type="number" min="0" step="0.01" value="{{ $totals['discount_value'] }}"
                   class="form-control form-control-sm" id="discount_value" placeholder="0.00"
                   aria-label="Discount value">
        </div>
        <div class="col-3">
            <button type="button" class="btn btn-sm btn-outline-primary w-100" id="apply-discount">Apply</button>
        </div>
    </div>

    <button type="button" class="btn btn-success btn-lg w-100" id="open-checkout">
        <i class="bi bi-cash-coin me-1"></i>Take Payment
    </button>
</div>
