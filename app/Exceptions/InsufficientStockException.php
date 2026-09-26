<?php

namespace App\Exceptions;

use App\Models\Product;
use RuntimeException;

class InsufficientStockException extends RuntimeException
{
    public function __construct(
        public readonly Product $product,
        public readonly int $requested,
    ) {
        parent::__construct(sprintf(
            'Insufficient stock for "%s". Available: %d, requested: %d.',
            $product->name,
            $product->stock,
            $requested,
        ));
    }
}
