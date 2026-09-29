<div id="cart-totals-area">
    <dl class="row mb-2 small">
        @if ($totals['tax_rate'] > 0)
            <dt class="col-7 text-body-secondary fw-normal">Tax ({{ rtrim(rtrim(number_format($totals['tax_rate'], 2, '.', ''), '0'), '.') }}%)</dt>
            <dd class="col-5 text-end money">{{ \App\Models\Setting::money($totals['tax_amount']) }}</dd>
        @endif
    </dl>

    <div class="d-flex justify-content-between align-items-center border-top pt-2">
        <span class="fw-semibold">Total</span>
        <span class="fs-5 fw-bold money">{{ \App\Models\Setting::money($totals['total']) }}</span>
    </div>
</div>
