<?php

namespace App\Models;

use App\Enums\PaymentMethod;
use App\Enums\RefundStatus;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Refund extends Model
{
    use HasFactory;

    /**
     * @var list<string>
     */
    protected $fillable = [
        'refund_number',
        'order_id',
        'user_id',
        'status',
        'amount',
        'method',
        'reason',
        'note',
        'refunded_at',
    ];

    /**
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'status' => RefundStatus::class,
            'method' => PaymentMethod::class,
            'amount' => 'decimal:2',
            'refunded_at' => 'datetime',
        ];
    }

    /**
     * The original sale this refund is tied to.
     */
    public function order(): BelongsTo
    {
        return $this->belongsTo(Order::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function items(): HasMany
    {
        return $this->hasMany(RefundItem::class);
    }

    public function getProcessedByAttribute(): string
    {
        return $this->user?->name ?? 'System';
    }

    public static function generateRefundNumber(): string
    {
        do {
            $number = 'REF-'.now()->format('Ymd').'-'.strtoupper(bin2hex(random_bytes(3)));
        } while (static::where('refund_number', $number)->exists());

        return $number;
    }
}
