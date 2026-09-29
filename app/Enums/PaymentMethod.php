<?php

namespace App\Enums;

enum PaymentMethod: string
{
    case Cash = 'cash';
    case Card = 'card';
    case Mobile = 'mobile';

    /**
     * Withdrawn from the till. The case stays so any historic row that still
     * carries it keeps casting instead of blowing up.
     */
    case Other = 'other';

    public function label(): string
    {
        return match ($this) {
            self::Cash => 'Cash',
            self::Card => 'Card',
            self::Mobile => 'Mobile / E-Wallet',
            self::Other => 'Other',
        };
    }

    /**
     * @return array<string, string>
     */
    public static function options(): array
    {
        $options = [];

        foreach (self::cases() as $case) {
            $options[$case->value] = $case->label();
        }

        return $options;
    }

    /**
     * Methods a cashier may actually choose today.
     *
     * @return array<string, string>
     */
    public static function selectable(): array
    {
        return [
            self::Cash->value => self::Cash->label(),
            self::Card->value => self::Card->label(),
            self::Mobile->value => self::Mobile->label(),
        ];
    }
}
