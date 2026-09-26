<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cache;

class Setting extends Model
{
    use HasFactory;

    /**
     * @var list<string>
     */
    protected $fillable = [
        'key',
        'value',
        'type',
        'group',
    ];

    /**
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'value' => 'string',
        ];
    }

    protected static function booted(): void
    {
        static::saved(fn () => self::flushCache());
        static::deleted(fn () => self::flushCache());
    }

    public static function flushCache(): void
    {
        Cache::forget('pos.settings');
    }

    /**
     * All settings as a key => value map, cached per request/short window.
     *
     * @return array<string, mixed>
     */
    public static function all_as_array(): array
    {
        return Cache::rememberForever('pos.settings', function () {
            return static::query()->pluck('value', 'key')->all();
        });
    }

    public static function get(string $key, mixed $default = null): mixed
    {
        return static::all_as_array()[$key] ?? $default;
    }

    /**
     * @param  array<string, string|null>  $values
     */
    public static function setMany(array $values, string $group = 'general'): void
    {
        foreach ($values as $key => $value) {
            static::updateOrCreate(
                ['key' => $key],
                ['value' => $value === null ? null : (string) $value, 'group' => $group],
            );
        }

        self::flushCache();
    }

    public static function currency(): string
    {
        return (string) static::get('currency_symbol', '₱');
    }

    public static function taxRate(): float
    {
        return (float) static::get('tax_rate', 0);
    }

    /**
     * Format an amount using the configured currency symbol.
     */
    public static function money(float|int|string|null $amount): string
    {
        return static::currency().number_format((float) $amount, 2);
    }
}
