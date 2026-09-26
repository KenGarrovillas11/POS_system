@extends('layouts.app')

@section('title', 'Refunds')
@section('page-title', 'Refunds')
@section('page-subtitle', $refundCount.' refund(s) totalling '.\App\Models\Setting::money($totalRefunded))

@section('content')
<div class="card mb-3">
    <div class="card-body">
        <form method="GET" action="{{ route('admin.refunds.index') }}" class="row g-2 align-items-end">
            <div class="col-md-6">
                <label for="q" class="form-label small fw-semibold">Search</label>
                <input type="search" class="form-control" id="q" name="q" value="{{ $filters['q'] ?? '' }}"
                       placeholder="Refund #, order # or reason…">
            </div>
            <div class="col-md-2">
                <label for="from" class="form-label small fw-semibold">From</label>
                <input type="date" class="form-control" id="from" name="from" value="{{ $filters['from'] ?? '' }}">
            </div>
            <div class="col-md-2">
                <label for="to" class="form-label small fw-semibold">To</label>
                <input type="date" class="form-control" id="to" name="to" value="{{ $filters['to'] ?? '' }}">
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100"><i class="bi bi-funnel me-1"></i>Filter</button>
            </div>
        </form>
    </div>
</div>

<div class="card">
    <div class="card-header">Refund History ({{ $refunds->total() }})</div>
    <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead>
            <tr>
                <th>Refund #</th>
                <th>Date</th>
                <th>Order</th>
                <th>Items</th>
                <th>Method</th>
                <th>Reason</th>
                <th>Processed By</th>
                <th class="text-end">Amount</th>
                <th>Status</th>
                <th class="text-end"></th>
            </tr>
            </thead>
            <tbody>
            @forelse ($refunds as $refund)
                <tr>
                    <td class="fw-semibold">{{ $refund->refund_number }}</td>
                    <td class="text-nowrap">{{ $refund->created_at->format('d/m/Y H:i') }}</td>
                    <td>
                        <a href="{{ route('orders.show', $refund->order) }}" class="text-decoration-none">
                            {{ $refund->order->order_number }}
                        </a>
                    </td>
                    <td class="text-center">{{ $refund->items->sum('quantity') }}</td>
                    <td class="small">{{ $refund->method->label() }}</td>
                    <td class="small text-body-secondary">{{ $refund->reason }}</td>
                    <td class="small">{{ $refund->processed_by }}</td>
                    <td class="text-end money fw-semibold">{{ \App\Models\Setting::money($refund->amount) }}</td>
                    <td><span class="badge {{ $refund->status->badgeClass() }}">{{ $refund->status->label() }}</span></td>
                    <td class="text-end">
                        <a href="{{ route('admin.refunds.show', $refund) }}" class="btn btn-sm btn-outline-secondary">
                            <i class="bi bi-eye"></i>
                        </a>
                    </td>
                </tr>
            @empty
                <tr>
                    <td colspan="10" class="text-center text-body-secondary py-4">
                        <i class="bi bi-arrow-counterclockwise fs-3 d-block mb-2"></i>
                        No refunds recorded yet.
                    </td>
                </tr>
            @endforelse
            </tbody>
            @if ($refunds->isNotEmpty())
                <tfoot class="table-group-divider">
                <tr class="fw-semibold">
                    <td colspan="7">Total</td>
                    <td class="text-end money">{{ \App\Models\Setting::money($refunds->sum('amount')) }}</td>
                    <td colspan="2"></td>
                </tr>
                </tfoot>
            @endif
        </table>
    </div>

    @if ($refunds->hasPages())
        <div class="card-footer">{{ $refunds->links() }}</div>
    @endif
</div>
@endsection
