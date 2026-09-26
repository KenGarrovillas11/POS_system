@extends('layouts.app')

@section('title', 'Products')
@section('page-title', 'Products')
@section('page-subtitle', auth()->user()->isAdmin() ? 'Manage your catalog' : 'Browse the product catalog')

@section('content')
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
    <div class="text-body-secondary small">
        {{ $products->total() }} product(s) found
        @unless (auth()->user()->isAdmin())
            <span class="badge text-bg-light text-body-secondary ms-1">Read-only</span>
        @endunless
    </div>

    @if (auth()->user()->isAdmin())
        <div class="d-flex gap-2">
            <a href="{{ route('admin.categories.index') }}" class="btn btn-outline-secondary btn-sm">
                <i class="bi bi-tags me-1"></i>Categories
            </a>
            <a href="{{ route('admin.products.create') }}" class="btn btn-primary btn-sm">
                <i class="bi bi-plus-lg me-1"></i>New Product
            </a>
        </div>
    @endif
</div>

<div class="card mb-3">
    <div class="card-body">
        <form method="GET" action="{{ route('products.index') }}" class="row g-2 align-items-end">
            <div class="col-md-4">
                <label for="q" class="form-label small fw-semibold">Search</label>
                <input type="search" class="form-control" id="q" name="q" value="{{ $filters['q'] ?? '' }}"
                       placeholder="Name or description…">
            </div>
            <div class="col-md-3">
                <label for="category_id" class="form-label small fw-semibold">Category</label>
                <select class="form-select" id="category_id" name="category_id">
                    <option value="">All categories</option>
                    @foreach ($categories as $category)
                        <option value="{{ $category->id }}" @selected(($filters['category_id'] ?? '') == $category->id)>
                            {{ $category->name }}
                        </option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <label for="status" class="form-label small fw-semibold">Status</label>
                <select class="form-select" id="status" name="status">
                    <option value="">All</option>
                    @foreach (['active' => 'Active', 'inactive' => 'Inactive', 'low' => 'Low stock', 'out' => 'Out of stock'] as $value => $label)
                        <option value="{{ $value }}" @selected(($filters['status'] ?? '') === $value)>{{ $label }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-3">
                <label for="sort" class="form-label small fw-semibold">Sort By</label>
                <div class="input-group">
                    <select class="form-select" id="sort" name="sort">
                        @foreach (['name' => 'Name', 'stock' => 'Stock', 'price' => 'Price', 'created_at' => 'Newest'] as $value => $label)
                            <option value="{{ $value }}" @selected(($filters['sort'] ?? 'name') === $value)>{{ $label }}</option>
                        @endforeach
                    </select>
                    <select class="form-select" name="direction" style="max-width:110px;">
                        <option value="asc" @selected(($filters['direction'] ?? 'asc') === 'asc')>Asc</option>
                        <option value="desc" @selected(($filters['direction'] ?? 'asc') === 'desc')>Desc</option>
                    </select>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="card">
    <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead>
            <tr>
                <th>Product</th>
                <th>Category</th>
                <th class="text-end">Cost</th>
                <th class="text-end">Price</th>
                <th class="text-center">Stock</th>
                <th>Status</th>
                @if (auth()->user()->isAdmin())
                    <th class="text-end">Actions</th>
                @endif
            </tr>
            </thead>
            <tbody>
            @forelse ($products as $product)
                <tr>
                    <td>
                        <div class="d-flex align-items-center gap-2">
                            @if ($product->hasImage())
                                <img src="{{ $product->imageUrl() }}" alt="{{ $product->name }}" loading="lazy"
                                     class="product-thumb rounded-2"
                                     style="width:36px;height:36px;object-fit:cover;">
                            @else
                                <span class="product-thumb">{{ strtoupper(mb_substr($product->name, 0, 2)) }}</span>
                            @endif
                            <div class="min-w-0">
                                <a href="{{ route('products.show', $product) }}" class="fw-semibold text-decoration-none d-block text-truncate">
                                    {{ $product->name }}
                                </a>
                            </div>
                        </div>
                    </td>
                    <td>{{ $product->category?->name ?? '—' }}</td>
                    <td class="text-end money">{{ \App\Models\Setting::money($product->cost_price) }}</td>
                    <td class="text-end money fw-semibold">{{ \App\Models\Setting::money($product->selling_price) }}</td>
                    <td class="text-center">
                        <span class="badge {{ $product->isOutOfStock() ? 'text-bg-danger' : ($product->isLowStock() ? 'text-bg-warning' : 'text-bg-success') }}">
                            {{ $product->stock }}
                        </span>
                        <div class="text-body-secondary" style="font-size:0.7rem;">min {{ $product->low_stock_threshold }}</div>
                    </td>
                    <td>
                        @if ($product->is_active)
                            <span class="badge text-bg-success">Active</span>
                        @else
                            <span class="badge text-bg-secondary">Inactive</span>
                        @endif
                    </td>
                    @if (auth()->user()->isAdmin())
                        <td class="text-end text-nowrap">
                            <a href="{{ route('admin.inventory.create', $product) }}" class="btn btn-sm btn-outline-secondary" title="Adjust stock">
                                <i class="bi bi-boxes"></i>
                            </a>
                            <a href="{{ route('admin.products.edit', $product) }}" class="btn btn-sm btn-outline-primary ms-1" title="Edit">
                                <i class="bi bi-pencil"></i>
                            </a>
                            <form method="POST" action="{{ route('admin.products.destroy', $product) }}"
                                  class="d-inline ms-1"
                                  onsubmit="return confirm('Delete {{ addslashes($product->name) }}? This cannot be undone.')">
                                @csrf
                                @method('DELETE')
                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </td>
                    @endif
                </tr>
            @empty
                <tr>
                    <td colspan="{{ auth()->user()->isAdmin() ? 7 : 6 }}" class="text-center text-body-secondary py-4">
                        <i class="bi bi-inbox fs-3 d-block mb-2"></i>
                        No products match your filters.
                    </td>
                </tr>
            @endforelse
            </tbody>
        </table>
    </div>

    @if ($products->hasPages())
        <div class="card-footer">{{ $products->links() }}</div>
    @endif
</div>
@endsection
