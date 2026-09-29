@extends('layouts.app')

@section('title', 'Point of Sale')
@section('page-title', 'Point of Sale')
@section('page-subtitle', 'Ring up a sale')

@section('content')
<div class="row g-3">
    {{-- ================= Product picker ================= --}}
    <div class="col-lg-7 col-xl-8">
        <div class="card mb-3">
            <div class="card-body">
                <form method="GET" action="{{ route('pos.index') }}" class="row g-2 align-items-end">
                    <div class="col-md-6">
                        <label for="q" class="form-label small fw-semibold">Search</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input type="search" class="form-control" id="q" name="q"
                                   value="{{ request('q') }}" placeholder="Product name…">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label for="category_id" class="form-label small fw-semibold">Category</label>
                        <select class="form-select" id="category_id" name="category_id">
                            <option value="">All categories</option>
                            @foreach ($categories as $category)
                                <option value="{{ $category->id }}" @selected(request('category_id') == $category->id)>
                                    {{ $category->name }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100"><i class="bi bi-funnel"></i> Filter</button>
                    </div>
                </form>
            </div>
        </div>

        @if ($products->isEmpty())
            <div class="card">
                <div class="card-body text-center py-5 text-body-secondary">
                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                    No products match your search.
                </div>
            </div>
        @else
            <div class="row row-cols-2 row-cols-md-3 row-cols-xl-4 g-3 pos-grid">
                @foreach ($products as $product)
                    @php
                        $sellable = $product->sellableStock();
                        $expired = $product->expiredQuantity();
                        $expiryStatus = $product->expiryStatus();
                        $soonest = $product->batches
                            ->filter(fn ($b) => $b->hasExpiryDate() && (int) $b->quantity > 0)
                            ->sortBy(fn ($b) => $b->expiry_date->timestamp)
                            ->first();
                        $blocked = $sellable <= 0;
                    @endphp
                    <div class="col">
                        {{-- A product whose every lot has lapsed cannot be sold,
                             even though stock is still counted. --}}
                        <div class="card pos-product-card {{ $blocked ? 'disabled' : '' }}"
                             data-product-id="{{ $product->id }}"
                             data-stock="{{ $sellable }}"
                             role="button" tabindex="0"
                             aria-disabled="{{ $blocked ? 'true' : 'false' }}">
                            <div class="card-body p-2 text-center">
                                @if ($product->hasImage())
                                    <img src="{{ $product->imageUrl() }}" alt="{{ $product->name }}" loading="lazy"
                                         class="rounded-2 mb-2" style="width:44px;height:44px;object-fit:cover;">
                                @else
                                    <span class="product-thumb mb-2" style="width:44px;height:44px;">
                                        {{ strtoupper(mb_substr($product->name, 0, 2)) }}
                                    </span>
                                @endif
                                <div class="small fw-semibold text-truncate" title="{{ $product->name }}">{{ $product->name }}</div>
                                <div class="fw-bold mt-1 money">{{ \App\Models\Setting::money($product->selling_price) }}</div>

                                @if ($blocked)
                                    <span class="badge text-bg-danger mt-1">Expired</span>
                                @elseif ($expiryStatus === 'expiring')
                                    <span class="badge text-bg-warning mt-1">
                                        {{ $soonest?->expiry_date->format('M j') }}
                                    </span>
                                    <div class="small text-warning-emphasis">Expiring soon</div>
                                @elseif ($expired > 0)
                                    <span class="badge text-bg-warning mt-1">{{ $sellable }} sellable</span>
                                @elseif ($sellable <= $product->low_stock_threshold)
                                    <span class="badge text-bg-warning mt-1">{{ $sellable }} left</span>
                                @else
                                    <span class="badge text-bg-light text-body-secondary mt-1">{{ $sellable }} in stock</span>
                                @endif
                            </div>
                        </div>
                    </div>
                @endforeach
            </div>
        @endif
    </div>

    {{-- ================= Cart ================= --}}
    <div class="col-lg-5 col-xl-4">
        <div class="card pos-cart">
            <div class="card-header d-flex align-items-center">
                <i class="bi bi-cart3 me-2"></i>Current Sale
                <span class="badge text-bg-secondary ms-2" id="cart-count">{{ $totals['item_count'] }} item(s)</span>
                <button type="button" class="btn btn-sm btn-link text-danger ms-auto p-0 text-decoration-none"
                        id="clear-cart">Clear</button>
            </div>

            <div class="card-body pos-cart-body" id="cart-items">
                @include('pos.partials.cart-items')
            </div>

            <div class="card-footer bg-body-tertiary">
                @include('pos.partials.cart-totals')

                {{-- Kept outside #cart-totals-area: that block is re-rendered on
                     every cart change, which would detach this button and drop
                     its click handler. --}}
                <button type="button" class="btn btn-success btn-lg w-100 mt-3" id="open-checkout">
                    <i class="bi bi-cash-coin me-1"></i>Take Payment
                </button>
            </div>
        </div>
    </div>
</div>

{{-- ================= Checkout modal ================= --}}
<div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <form class="modal-content" method="POST" action="{{ route('pos.checkout') }}" id="checkout-form">
            @csrf
            <div class="modal-header">
                <h5 class="modal-title" id="checkoutModalLabel">Take Payment</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="d-flex justify-content-between align-items-center border rounded p-3 mb-3 bg-body-tertiary">
                    <span class="text-body-secondary">Amount Due</span>
                    <span class="fs-3 fw-bold money" id="due-amount">{{ \App\Models\Setting::money($totals['total']) }}</span>
                </div>

                <div class="mb-3">
                    <label for="payment_method" class="form-label">Payment Method <span class="text-danger">*</span></label>
                    <select class="form-select @error('payment_method') is-invalid @enderror" id="payment_method" name="payment_method" required>
                        @foreach (\App\Enums\PaymentMethod::selectable() as $value => $label)
                            <option value="{{ $value }}" @selected(old('payment_method', 'cash') === $value)>{{ $label }}</option>
                        @endforeach
                    </select>
                    @error('payment_method')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>

                {{-- An e-wallet transfer has to be matched against the customer's
                     own receipt, so the sale is held until the cashier records
                     the reference and ticks the box. --}}
                <div class="border rounded p-3 mb-3 bg-body-tertiary d-none" id="mobile-verify">
                    <div class="fw-semibold small mb-2">
                        <i class="bi bi-phone me-1"></i>Verify the e-wallet payment
                    </div>
                    <label for="payment_reference" class="form-label small">Reference number <span class="text-danger">*</span></label>
                    <input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="100" autocomplete="off"
                           class="form-control form-control-sm @error('payment_reference') is-invalid @enderror"
                           id="payment_reference" name="payment_reference"
                           placeholder="numbers only"
                           value="{{ old('payment_reference') }}">
                    @error('payment_reference')<div class="invalid-feedback">{{ $message }}</div>@enderror

                    <div class="form-check mt-3">
                        <input class="form-check-input @error('payment_verified') is-invalid @enderror"
                               type="checkbox" value="1" id="payment_verified" name="payment_verified"
                               @checked(old('payment_verified'))>
                        <label class="form-check-label small" for="payment_verified">
                            I confirm the payment was received in the e-wallet account.
                        </label>
                        @error('payment_verified')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>
                </div>

                <div class="mb-3">
                    <label for="paid_amount" class="form-label">Amount Received <span class="text-danger">*</span></label>
                    <div class="input-group input-group-lg">
                        <span class="input-group-text">{{ \App\Models\Setting::currency() }}</span>
                    <input type="number" step="0.01" min="0" inputmode="decimal"
                           class="form-control @error('paid_amount') is-invalid @enderror"
                           id="paid_amount" name="paid_amount" required
                           placeholder="0.00"
                           value="{{ old('paid_amount') }}">
                        @error('paid_amount')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>
                    <div class="small text-danger mt-1 d-none" id="balance-due">
                        <i class="bi bi-exclamation-triangle me-1"></i>
                        Still owed: <span class="money fw-semibold" id="balance-due-amount"></span>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center border rounded p-3 mb-3 bg-body-tertiary">
                    <span class="text-body-secondary">Change Due</span>
                    <span class="fs-5 fw-bold money text-success" id="change-amount">
                        {{ \App\Models\Setting::money(0) }}
                    </span>
                </div>

                <div class="mb-3">
                    <label for="note" class="form-label">Note <span class="text-body-secondary small">(optional)</span></label>
                    <input type="text" class="form-control" id="note" name="note"
                           maxlength="255" value="{{ old('note') }}" placeholder="e.g. take-away, special request">
                    @error('note')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-success btn-lg" id="confirm-sale">
                    <i class="bi bi-check2-circle me-1"></i>Complete Sale
                </button>
            </div>
        </form>
    </div>
</div>
@endsection

@push('scripts')
<script>
(function () {
    'use strict';

    const csrf = document.querySelector('meta[name="csrf-token"]').content;
    const currency = @json(\App\Models\Setting::currency());
    const cartUrl = @json(url('pos/cart'));

    const money = (value) => currency + Number(value || 0).toFixed(2);

    const cartItemsEl = document.getElementById('cart-items');
    const totalsEl = document.getElementById('cart-totals-area');
    const cartCountEl = document.getElementById('cart-count');
    const dueAmountEl = document.getElementById('due-amount');
    const changeAmountEl = document.getElementById('change-amount');
    const paidInput = document.getElementById('paid_amount');
    const methodSelect = document.getElementById('payment_method');
    const mobileVerifyEl = document.getElementById('mobile-verify');
    const referenceInput = document.getElementById('payment_reference');
    const verifiedInput = document.getElementById('payment_verified');
    const balanceEl = document.getElementById('balance-due');
    const balanceAmountEl = document.getElementById('balance-due-amount');
    const checkoutForm = document.getElementById('checkout-form');
    const confirmBtn = document.getElementById('confirm-sale');

    const checkoutModalEl = document.getElementById('checkoutModal');
    const checkoutModal = new bootstrap.Modal(checkoutModalEl);

    let totals = @json($totals);

    /** POST/PATCH/DELETE helper that surfaces server-side messages. */
    async function request(url, method, body = {}) {
        const options = {
            method: method,
            headers: {
                'X-CSRF-TOKEN': csrf,
                'X-Requested-With': 'XMLHttpRequest',
                'Accept': 'application/json',
            },
        };

        if (method !== 'GET') {
            options.headers['Content-Type'] = 'application/json';
            options.body = JSON.stringify(body);
        }

        const response = await fetch(url, options);

        if (response.status === 419) {
            window.location.reload();
            return null;
        }

        const data = await response.json().catch(() => ({}));

        if (!response.ok) {
            alert(data.message || data.errors?.paid_amount?.[0] || 'Something went wrong. Please try again.');
            return null;
        }

        return data;
    }

    function applyTotals(next, totalsHtml = null) {
        totals = next;

        cartCountEl.textContent = `${next.item_count} item(s)`;
        dueAmountEl.textContent = money(next.total);

        // The footer subtotal/tax/total block is rendered server-side, so swap
        // in the fresh copy or it keeps showing the figures from page load.
        if (totalsHtml && totalsEl) {
            totalsEl.innerHTML = totalsHtml;
        }

        updateChange();
    }

    function updateChange() {
        if (!paidInput || !changeAmountEl) return;
        const paid = parseFloat(paidInput.value || '0');
        const change = paid - Number(totals.total || 0);
        const short = change < -0.005;

        changeAmountEl.textContent = money(change > 0 ? change : 0);
        changeAmountEl.classList.toggle('text-success', change > 0);
        changeAmountEl.classList.toggle('text-danger', short);

        // An amount received below the total is never a valid sale, so say how
        // much is still outstanding and hold the confirm button down.
        if (balanceEl && balanceAmountEl) {
            balanceEl.classList.toggle('d-none', !short);
            balanceAmountEl.textContent = short ? money(Math.abs(change)) : '';
        }

        refreshCheckoutButton();
    }

    // Enable the checkout button only when the cart has something in it, the
    // tendered amount covers the total, and an e-wallet sale has been verified.
    function refreshCheckoutButton() {
        if (!confirmBtn) return;
        const short = paidInput && parseFloat(paidInput.value || '0') + 0.005 < Number(totals.total || 0);
        confirmBtn.disabled = totals.item_count === 0 || short || !eWalletVerified();
    }

    /**
     * True unless the method is an e-wallet that is still unverified.
     */
    function eWalletVerified() {
        if (methodSelect?.value !== 'mobile') return true;
        return Boolean(referenceInput?.value.trim()) && Boolean(verifiedInput?.checked);
    }

    function syncEWalletFields() {
        const mobile = methodSelect?.value === 'mobile';

        if (mobileVerifyEl) mobileVerifyEl.classList.toggle('d-none', !mobile);

        if (!mobile && referenceInput && verifiedInput) {
            // Stale values would otherwise ride along on a cash sale and be
            // saved against it.
            referenceInput.value = '';
            verifiedInput.checked = false;
        }

        refreshCheckoutButton();
    }

    /** The most of this product that can actually be sold, or null if unknown. */
    function maxFor(input) {
        return input.dataset.max === '' ? null : parseInt(input.dataset.max, 10);
    }

    function stockWarning(input, max) {
        return `Only ${max} of "${input.dataset.name || 'this product'}" is in stock and can be sold.`;
    }

    /**
     * The -/+ buttons. Stepping past the ceiling keeps the value where it is and
     * says so, rather than quietly walking it back.
     */
    function bumpQty(input, delta) {
        const max = maxFor(input);
        const next = (parseInt(input.value || '0', 10) || 0) + delta;

        if (max !== null && next > max) {
            input.value = max;
            alert(stockWarning(input, max));
            return;
        }

        input.value = Math.max(0, next);
        input.dispatchEvent(new Event('change'));
    }

    function renderCart(html) {
        cartItemsEl.innerHTML = html;
        bindCartControls();
    }

    function bindCartControls() {
        cartItemsEl.querySelectorAll('[data-cart-step]').forEach((button) => {
            button.addEventListener('click', () => {
                const up = button.dataset.cartStep === '1';
                const input = up ? button.previousElementSibling : button.nextElementSibling;

                bumpQty(input, up ? 1 : -1);
            });
        });

        cartItemsEl.querySelectorAll('input[data-cart-qty]').forEach((input) => {
            input.addEventListener('change', async () => {
                const productId = input.dataset.cartQty;
                const max = maxFor(input);
                const wanted = parseInt(input.value || '0', 10);

                // A line can never hold more than the stock that can actually be
                // sold. Overtyping is rejected back to a single unit rather than
                // silently clamped, so the cashier sees the box change instead of
                // the request quietly becoming something else.
                if (max !== null && wanted > max) {
                    alert(stockWarning(input, max));
                }

                const quantity = max !== null && wanted > max ? 1 : wanted;

                const data = await request(`${cartUrl}/${productId}`, 'PATCH', { quantity });

                if (data) {
                    renderCart(data.items_html);
                    applyTotals(data.totals, data.totals_html);
                }
            });
        });

        cartItemsEl.querySelectorAll('[data-cart-remove]').forEach((button) => {
            button.addEventListener('click', async () => {
                const data = await request(`${cartUrl}/${button.dataset.cartRemove}`, 'DELETE');
                if (data) {
                    renderCart(data.items_html);
                    applyTotals(data.totals, data.totals_html);
                }
            });
        });
    }

    // --- Product grid: click to add -------------------------------------
    document.querySelectorAll('.pos-product-card').forEach((card) => {
        const add = async () => {
            if (card.getAttribute('aria-disabled') === 'true') {
                alert('This product is out of stock.');
                return;
            }

            const data = await request(cartUrl, 'POST', { product_id: parseInt(card.dataset.productId, 10) });

            if (data) {
                renderCart(data.items_html);
                applyTotals(data.totals, data.totals_html);
            }
        };

        card.addEventListener('click', add);
        card.addEventListener('keydown', (e) => {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                add();
            }
        });
    });

    // --- Clear cart ------------------------------------------------------
    document.getElementById('clear-cart')?.addEventListener('click', async () => {
        if (!confirm('Remove all items from the current sale?')) return;

        const data = await request(cartUrl, 'DELETE');
        if (data) {
            renderCart(data.items_html);
            applyTotals(data.totals, data.totals_html);
        }
    });

    // --- Payment ---------------------------------------------------------
    paidInput?.addEventListener('input', updateChange);
    methodSelect?.addEventListener('change', syncEWalletFields);

    // Keep the box to digits as it is typed, so the cashier never sees a value
    // that the server is going to reject. The rule is still enforced server
    // side; this is only the friendlier half.
    referenceInput?.addEventListener('input', () => {
        const digits = referenceInput.value.replace(/\D/g, '');

        if (digits !== referenceInput.value) {
            referenceInput.value = digits;
        }

        refreshCheckoutButton();
    });

    verifiedInput?.addEventListener('change', refreshCheckoutButton);

    document.getElementById('open-checkout')?.addEventListener('click', () => {
        if (totals.item_count === 0) {
            alert('Add at least one product before taking payment.');
            return;
        }
        checkoutModal.show();
    });

    checkoutForm?.addEventListener('submit', () => {
        confirmBtn.disabled = true;
        confirmBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Processing…';
    });

    updateChange();
    syncEWalletFields();
    const observer = new MutationObserver(refreshCheckoutButton);
    observer.observe(cartCountEl, { childList: true, subtree: true, characterData: true });

    bindCartControls();
})();
</script>
@endpush
