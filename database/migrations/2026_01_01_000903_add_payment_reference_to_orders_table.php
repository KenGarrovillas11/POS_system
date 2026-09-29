<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * The sender's reference for a mobile / e-wallet sale.
 *
 * Cash and card settle on the spot, but an e-wallet transfer has to be checked
 * against the customer's receipt before the sale is counted as paid. Storing
 * the reference makes that check auditable after the fact, and gives support
 * something to quote if the two sides disagree.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            // Nullable: only mobile sales need one, so existing rows are untouched.
            $table->string('payment_reference', 100)->nullable()->after('payment_method');
        });
    }

    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn('payment_reference');
        });
    }
};
