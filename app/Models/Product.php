<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Storage;

class Product extends Model
{
    use HasFactory;

    /**
     * @var list<string>
     */
    protected $fillable = [
        'category_id',
        'name',
        'image_path',
        'description',
        'cost_price',
        'selling_price',
        'stock',
        'low_stock_threshold',
        'unit',
        'is_active',
    ];

    /**
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'cost_price' => 'decimal:2',
            'selling_price' => 'decimal:2',
            'stock' => 'integer',
            'low_stock_threshold' => 'integer',
            'is_active' => 'boolean',
        ];
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function orderItems(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public function inventoryMovements(): HasMany
    {
        return $this->hasMany(InventoryMovement::class);
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('is_active', true);
    }

    public function scopeInStock(Builder $query): Builder
    {
        return $query->whereColumn('stock', '>', 0);
    }

    public function scopeLowStock(Builder $query): Builder
    {
        return $query
            ->whereColumn('stock', '<=', 'low_stock_threshold')
            ->where('is_active', true);
    }

    public function scopeSearch(Builder $query, ?string $term): Builder
    {
        if (blank($term)) {
            return $query;
        }

        $like = '%'.str_replace(['%', '_'], ['\%', '\_'], $term).'%';

        return $query->where(function (Builder $q) use ($like) {
            $q->where('name', 'like', $like)
                ->orWhere('description', 'like', $like);
        });
    }

    public function isLowStock(): bool
    {
        return $this->stock <= $this->low_stock_threshold;
    }

    public function isOutOfStock(): bool
    {
        return $this->stock <= 0;
    }

    public function hasImage(): bool
    {
        return filled($this->image_path);
    }

    /**
     * Public URL of the product photo, or null when none has been uploaded.
     *
     * Built from the current request root rather than the disk's configured
     * APP_URL, so photos resolve whether the app is served by Apache or by
     * `php artisan serve` on a different host and port.
     */
    public function imageUrl(): ?string
    {
        if (! $this->hasImage()) {
            return null;
        }

        return asset('storage/'.$this->image_path);
    }

    /**
     * Delete the stored photo, if any. Safe to call twice.
     */
    public function deleteImage(): void
    {
        if (! $this->hasImage()) {
            return;
        }

        Storage::disk('public')->delete($this->image_path);

        $this->forceFill(['image_path' => null])->save();
    }

    public function getMarginAttribute(): float
    {
        return (float) $this->selling_price - (float) $this->cost_price;
    }

    public function getStockValueAttribute(): float
    {
        return (float) $this->cost_price * (int) $this->stock;
    }
}
