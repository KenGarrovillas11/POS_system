<?php

namespace Tests\Feature;

use App\Enums\InventoryMovementType;
use App\Enums\PaymentMethod;
use App\Models\Order;
use App\Models\Product;
use App\Models\Refund;
use App\Models\Setting;
use App\Models\User;
use App\Support\AuditLogger;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class RefundTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Ring up a simple two-line sale and return the order.
     */
    private function placeOrder(User $cashier, Product $first, Product $second, int $firstQty = 2, int $secondQty = 1): Order
    {
        Setting::setMany(['currency_symbol' => '$', 'tax_rate' => '0']);
        Setting::flushCache();

        $this->actingAs($cashier)->postJson(route('pos.cart.store'), [
            'product_id' => $first->id,
            'quantity' => $firstQty,
        ]);
        $this->actingAs($cashier)->postJson(route('pos.cart.store'), [
            'product_id' => $second->id,
            'quantity' => $secondQty,
        ]);
        $this->actingAs($cashier)->post(route('pos.checkout'), [
            'payment_method' => PaymentMethod::Cash->value,
            'paid_amount' => 1000,
        ]);

        return Order::with('items')->latest()->first();
    }

    public function test_a_partial_refund_restocks_only_the_returned_units(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap, firstQty: 2);

        $this->assertSame(8, $cola->fresh()->stock);
        $this->assertSame(3, $soap->fresh()->stock);

        $colaLine = $order->items->firstWhere('product_id', $cola->id);

        $this->actingAs($admin)
            ->post(route('admin.refunds.store', $order), [
                'reason' => 'Customer returned one can',
                'method' => PaymentMethod::Cash->value,
                'note' => 'Rested one unit',
                'items' => [$colaLine->id => 1],
            ])
            ->assertRedirect();

        $refund = Refund::sole();

        $this->assertSame('completed', $refund->status->value);
        $this->assertEquals(2.00, (float) $refund->amount);
        $this->assertSame($admin->id, $refund->user_id);

        $this->assertSame(9, $cola->fresh()->stock);
        $this->assertSame(3, $soap->fresh()->stock);

        $order->refresh();
        $this->assertEquals(2.00, (float) $order->refunded_amount);
        $this->assertFalse($order->isFullyRefunded());

        $this->assertDatabaseHas('refund_items', [
            'refund_id' => $refund->id,
            'order_item_id' => $colaLine->id,
            'quantity' => 1,
            'amount' => 2.00,
        ]);

        $this->assertDatabaseHas('inventory_movements', [
            'product_id' => $cola->id,
            'type' => InventoryMovementType::ReturnRestock->value,
            'quantity' => 1,
        ]);

        $this->assertDatabaseHas('audit_logs', ['action' => AuditLogger::REFUND_CREATED]);
    }

    public function test_a_full_refund_marks_the_order_as_fully_refunded(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap);

        $quantities = $order->items->mapWithKeys(fn ($item) => [$item->id => $item->quantity])->all();

        $this->actingAs($admin)
            ->post(route('admin.refunds.store', $order), [
                'reason' => 'Whole order returned',
                'method' => PaymentMethod::Card->value,
                'items' => $quantities,
            ])
            ->assertRedirect();

        $order->refresh();

        $this->assertTrue($order->isFullyRefunded());
        $this->assertEquals(0.0, $order->netRevenue());
        $this->assertSame(10, $cola->fresh()->stock);
        $this->assertSame(4, $soap->fresh()->stock);
    }

    public function test_refunding_more_than_was_sold_is_rejected(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap, firstQty: 2);
        $colaLine = $order->items->firstWhere('product_id', $cola->id);

        $this->actingAs($admin)
            ->post(route('admin.refunds.store', $order), [
                'reason' => 'Too many',
                'method' => PaymentMethod::Cash->value,
                'items' => [$colaLine->id => 5],
            ])
            ->assertSessionHasErrors("items.{$colaLine->id}");

        $this->assertSame(0, Refund::count());
        $this->assertSame(8, $cola->fresh()->stock);
    }

    public function test_a_refund_needs_at_least_one_item(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap);

        $this->actingAs($admin)
            ->post(route('admin.refunds.store', $order), [
                'reason' => 'Nothing selected',
                'method' => PaymentMethod::Cash->value,
                'items' => [],
            ])
            ->assertSessionHasErrors('items');
    }

    public function test_staff_cannot_refund(): void
    {
        $cashier = User::factory()->staff()->create();
        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap);

        $this->actingAs($cashier)
            ->get(route('admin.refunds.create', $order))
            ->assertRedirect(route('pos.index'));

        $this->assertSame(0, Refund::count());
    }

    public function test_a_fully_refunded_order_cannot_be_refunded_again(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap);
        $line = $order->items->firstWhere('product_id', $cola->id);

        $this->actingAs($admin)->post(route('admin.refunds.store', $order), [
            'reason' => 'Returned',
            'method' => PaymentMethod::Cash->value,
            'items' => [$line->id => $line->quantity],
        ]);

        $this->actingAs($admin)->post(route('admin.refunds.store', $order), [
            'reason' => 'Again',
            'method' => PaymentMethod::Cash->value,
            'items' => [$line->id => 1],
        ])->assertSessionHasErrors();

        $this->assertSame(1, Refund::count());
    }

    public function test_refund_pages_render_for_admins(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap);
        $line = $order->items->firstWhere('product_id', $cola->id);

        $this->actingAs($admin)->get(route('admin.refunds.create', $order))->assertOk();

        $this->actingAs($admin)->post(route('admin.refunds.store', $order), [
            'reason' => 'Damaged item',
            'method' => PaymentMethod::Cash->value,
            'items' => [$line->id => 1],
        ]);

        $refund = Refund::sole();

        $this->actingAs($admin)
            ->get(route('admin.refunds.index'))
            ->assertOk()
            ->assertSee($refund->refund_number)
            ->assertSee('Damaged item');

        $this->actingAs($admin)
            ->get(route('admin.refunds.show', $refund))
            ->assertOk()
            ->assertSee($refund->refund_number)
            ->assertSee($order->order_number);
    }

    public function test_a_cashier_can_refund_their_own_sale(): void
    {
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap, firstQty: 2);
        $this->assertSame(8, $cola->fresh()->stock);

        $this->actingAs($cashier)
            ->get(route('refunds.create', $order))
            ->assertOk();

        $line = $order->items->firstWhere('product_id', $cola->id);

        $this->actingAs($cashier)
            ->post(route('refunds.store', $order), [
                'reason' => 'Customer returned one can',
                'method' => PaymentMethod::Cash->value,
                'items' => [$line->id => 1],
            ])
            ->assertRedirect(route('refunds.show', Refund::sole()));

        $refund = Refund::sole();

        $this->assertSame($cashier->id, $refund->user_id);
        $this->assertEquals(2.00, (float) $refund->amount);
        $this->assertSame(9, $cola->fresh()->stock);

        $this->actingAs($cashier)
            ->get(route('refunds.show', $refund))
            ->assertOk()
            ->assertSee($refund->refund_number);
    }

    public function test_a_cashier_cannot_refund_another_cashiers_sale(): void
    {
        $cashier = User::factory()->staff()->create();
        $other = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($other, $cola, $soap);
        $line = $order->items->firstWhere('product_id', $cola->id);

        $this->actingAs($cashier)
            ->get(route('refunds.create', $order))
            ->assertForbidden();

        $this->actingAs($cashier)
            ->post(route('refunds.store', $order), [
                'reason' => 'Not my sale',
                'method' => PaymentMethod::Cash->value,
                'items' => [$line->id => 1],
            ])
            ->assertForbidden();

        $this->assertSame(0, Refund::count());
        $this->assertSame(8, $cola->fresh()->stock);
    }

    public function test_a_cashier_cannot_read_a_refund_raised_against_another_sale(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();
        $other = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($other, $cola, $soap);
        $line = $order->items->firstWhere('product_id', $cola->id);

        $this->actingAs($admin)->post(route('refunds.store', $order), [
            'reason' => 'Damaged item',
            'method' => PaymentMethod::Cash->value,
            'items' => [$line->id => 1],
        ]);

        $refund = Refund::sole();

        $this->actingAs($cashier)
            ->get(route('refunds.show', $refund))
            ->assertForbidden();
    }

    public function test_a_cashier_cannot_reach_the_refund_oversight_screens(): void
    {
        $cashier = User::factory()->staff()->create();

        $this->actingAs($cashier)
            ->get(route('admin.refunds.index'))
            ->assertRedirect(route('pos.index'));
    }

    public function test_the_refund_button_shows_on_a_cashiers_own_order_and_receipt(): void
    {
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap);

        $this->actingAs($cashier)
            ->get(route('orders.show', $order))
            ->assertOk()
            ->assertSee(route('refunds.create', $order), escape: false);

        $this->actingAs($cashier)
            ->get(route('orders.receipt', $order))
            ->assertOk()
            ->assertSee(route('refunds.create', $order), escape: false);
    }

    public function test_the_refund_form_offers_cash_card_and_mobile_only(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap);

        $this->actingAs($admin)
            ->get(route('refunds.create', $order))
            ->assertOk()
            ->assertSee('Cash')
            ->assertSee('Card')
            ->assertSee('Mobile / E-Wallet')
            ->assertDontSee('>Other<', escape: false);
    }

    public function test_a_withdrawn_refund_method_cannot_be_submitted(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap);
        $line = $order->items->firstWhere('product_id', $cola->id);
        $stockBefore = $cola->fresh()->stock;

        $this->actingAs($admin)
            ->post(route('refunds.store', $order), [
                'reason' => 'Customer returned it',
                'method' => 'other',
                'items' => [$line->id => 1],
            ])
            ->assertSessionHasErrors('method');

        // Nothing refunded and nothing restocked.
        $this->assertSame(0, Refund::count());
        $this->assertSame($stockBefore, $cola->fresh()->stock);
        $this->assertEquals(0.0, (float) $order->fresh()->refunded_amount);
    }

    public function test_a_card_refund_is_still_accepted(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap);
        $line = $order->items->firstWhere('product_id', $cola->id);

        // Historical card sales must still be returnable by card.
        $this->actingAs($admin)
            ->post(route('refunds.store', $order), [
                'reason' => 'Returned to the card',
                'method' => PaymentMethod::Card->value,
                'items' => [$line->id => 1],
            ])
            ->assertSessionHasNoErrors();

        $this->assertSame(PaymentMethod::Card, Refund::sole()->method);
    }

    /**
     * Ring up a sale of a single product and return the order.
     */
    private function placeSingleProductOrder(User $cashier, Product $product, int $qty = 3): Order
    {
        Setting::setMany(['currency_symbol' => '$', 'tax_rate' => '0']);
        Setting::flushCache();

        $this->actingAs($cashier)->postJson(route('pos.cart.store'), [
            'product_id' => $product->id,
            'quantity' => $qty,
        ]);
        $this->actingAs($cashier)->post(route('pos.checkout'), [
            'payment_method' => PaymentMethod::Cash->value,
            'paid_amount' => 1000,
        ]);

        return Order::with('items')->latest()->first();
    }

    public function test_an_order_with_a_single_product_can_be_refunded_in_full(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();
        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);

        $order = $this->placeSingleProductOrder($cashier, $cola);

        $this->assertCount(1, $order->items);
        $this->assertSame(7, $cola->fresh()->stock);

        $line = $order->items->first();

        $this->actingAs($admin)->get(route('refunds.create', $order))->assertOk();

        $this->actingAs($admin)
            ->post(route('refunds.store', $order), [
                'reason' => 'Customer returned it',
                'method' => PaymentMethod::Cash->value,
                'items' => [$line->id => 3],
            ])
            ->assertRedirect();

        $refund = Refund::sole();

        $this->assertCount(1, $refund->items);
        $this->assertEquals(6.00, (float) $refund->amount);
        $this->assertSame(10, $cola->fresh()->stock);
        $this->assertTrue($order->fresh()->isFullyRefunded());
    }

    public function test_one_unit_of_a_single_product_order_can_be_refunded(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();
        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);

        $order = $this->placeSingleProductOrder($cashier, $cola);
        $line = $order->items->first();

        $this->actingAs($admin)
            ->post(route('refunds.store', $order), [
                'reason' => 'One can was damaged',
                'method' => PaymentMethod::Cash->value,
                'items' => [$line->id => 1],
            ])
            ->assertRedirect();

        $this->assertEquals(2.00, (float) Refund::sole()->amount);
        $this->assertSame(8, $cola->fresh()->stock);
        $this->assertFalse($order->fresh()->isFullyRefunded());

        // The rest of the line stays refundable afterwards.
        $this->actingAs($admin)->get(route('refunds.create', $order->fresh()))->assertOk();
    }

    public function test_a_single_product_order_whose_quantity_is_left_at_zero_is_rejected(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();
        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);

        $order = $this->placeSingleProductOrder($cashier, $cola);
        $line = $order->items->first();

        // The form posts every line, so an untouched single-row form sends a 0.
        $this->actingAs($admin)
            ->post(route('refunds.store', $order), [
                'reason' => 'Nothing selected',
                'method' => PaymentMethod::Cash->value,
                'items' => [$line->id => 0],
            ])
            ->assertSessionHasErrors();

        $this->assertSame(0, Refund::count());
        $this->assertSame(7, $cola->fresh()->stock);
    }

    public function test_refunding_one_product_works_although_the_untouched_lines_post_zero(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap, firstQty: 2);
        $colaLine = $order->items->firstWhere('product_id', $cola->id);
        $soapLine = $order->items->firstWhere('product_id', $soap->id);

        // The form carries a box per line, so picking one product still submits
        // the others as 0. Those rows must not be treated as invalid input.
        $this->actingAs($admin)
            ->post(route('refunds.store', $order), [
                'reason' => 'Returned one can',
                'method' => PaymentMethod::Cash->value,
                'items' => [$colaLine->id => 1, $soapLine->id => 0],
            ])
            ->assertSessionHasNoErrors();

        $refund = Refund::sole();

        $this->assertCount(1, $refund->items);
        $this->assertEquals(2.00, (float) $refund->amount);
        $this->assertSame(9, $cola->fresh()->stock);
        $this->assertSame(3, $soap->fresh()->stock);
    }

    public function test_a_payload_of_nothing_but_zeros_is_still_rejected(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap, firstQty: 2);
        $colaLine = $order->items->firstWhere('product_id', $cola->id);
        $soapLine = $order->items->firstWhere('product_id', $soap->id);

        $this->actingAs($admin)
            ->post(route('refunds.store', $order), [
                'reason' => 'Nothing actually picked',
                'method' => PaymentMethod::Cash->value,
                'items' => [$colaLine->id => 0, $soapLine->id => 0],
            ])
            ->assertSessionHasErrors('items');

        $this->assertSame(0, Refund::count());
        $this->assertSame(8, $cola->fresh()->stock);
    }

    public function test_cancelling_an_order_puts_the_units_back_and_blocks_a_second_cancel(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap, firstQty: 3);
        $this->assertSame(7, $cola->fresh()->stock);

        $this->actingAs($admin)
            ->post(route('orders.cancel', $order), ['reason' => 'Customer changed mind'])
            ->assertRedirect();

        $order->refresh();

        $this->assertTrue($order->isCancelled());
        $this->assertSame(10, $cola->fresh()->stock);
        $this->assertDatabaseHas('inventory_movements', [
            'product_id' => $cola->id,
            'type' => InventoryMovementType::SaleCancellation->value,
            'quantity' => 3,
        ]);
        $this->assertDatabaseHas('audit_logs', ['action' => AuditLogger::ORDER_CANCELLED]);

        $this->actingAs($admin)
            ->post(route('orders.cancel', $order), ['reason' => 'Again'])
            ->assertSessionHas('error');

        $this->assertSame(10, $cola->fresh()->stock);
    }

    public function test_a_refunded_order_cannot_be_cancelled(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();

        $cola = Product::factory()->priced(1, 2)->create(['stock' => 10]);
        $soap = Product::factory()->priced(3, 5)->create(['stock' => 4]);

        $order = $this->placeOrder($cashier, $cola, $soap);
        $line = $order->items->firstWhere('product_id', $cola->id);

        $this->actingAs($admin)->post(route('admin.refunds.store', $order), [
            'reason' => 'Returned',
            'method' => PaymentMethod::Cash->value,
            'items' => [$line->id => $line->quantity],
        ]);

        $this->actingAs($admin)
            ->post(route('orders.cancel', $order), ['reason' => 'Nope'])
            ->assertSessionHas('error');

        $this->assertFalse($order->fresh()->isCancelled());
    }

    public function test_staff_only_see_their_own_orders(): void
    {
        $admin = User::factory()->admin()->create();
        $alice = User::factory()->staff()->create(['name' => 'Alice']);
        $bruno = User::factory()->staff()->create(['name' => 'Bruno']);

        $product = Product::factory()->priced(1, 2)->create(['stock' => 50]);

        $this->placeOrder($alice, $product, $product);
        $this->placeOrder($bruno, $product, $product);

        $this->assertSame(2, Order::count());

        $this->actingAs($alice)
            ->get(route('orders.index'))
            ->assertOk()
            ->assertSee('Sales (1)')
            ->assertDontSee('Mine only')
            ->assertDontSee('Sales (2)');

        $this->actingAs($admin)
            ->get(route('orders.index'))
            ->assertOk()
            ->assertSee('Sales (2)');

        $brunoOrder = Order::where('user_id', $bruno->id)->sole();

        $this->actingAs($alice)
            ->get(route('orders.show', $brunoOrder))
            ->assertForbidden();
    }

    public function test_order_history_can_be_filtered_by_status_and_method(): void
    {
        $admin = User::factory()->admin()->create();
        $cashier = User::factory()->staff()->create();
        $product = Product::factory()->priced(1, 2)->create(['stock' => 50]);

        $this->placeOrder($cashier, $product, $product);

        $order = Order::sole();
        $order->forceFill(['payment_method' => PaymentMethod::Card])->save();

        $this->actingAs($admin)
            ->get(route('orders.index', ['status' => 'completed']))
            ->assertOk()
            ->assertSee($order->order_number);

        $this->actingAs($admin)
            ->get(route('orders.index', ['payment_method' => PaymentMethod::Cash->value]))
            ->assertOk()
            ->assertDontSee($order->order_number);

        $this->actingAs($admin)
            ->get(route('orders.index', ['payment_method' => PaymentMethod::Card->value]))
            ->assertOk()
            ->assertSee($order->order_number);
    }
}
