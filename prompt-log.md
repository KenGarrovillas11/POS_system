# Prompt log

Raw user prompts and the resulting change summary, per `rules.md`.

---

## 2026-09-26 — Batch expiry dates for stock + sidenav contrast

### Raw prompts

**Prompt 1**

```
add recording expiration dates for stocks e.g. add new product/stock adjustments 
fix the ff issues
sidenav text contrast 
```

**Prompt 2** (answer to "what do you mean by the ff issues?")

```
ff meant following so ignore it
```

**Prompt 3** (answer to "how should expiry be modelled?")

```
Per product batch gets their own expiration date + expiry warnings
```

**Prompt 4** (answer to "which approach for the sidenav contrast fix?")

```
sidenav font colors are too light making them invisible, so no light colors.
```

**Prompt 5** (answer to "light sidebar, dark ink, or only fix the real bug?")

```
Light sidebar, dark ink (Recommended)
```

**Prompt 6**

```
implement
```

### Raw sum output

`git diff --shortstat HEAD -- app resources routes database public tests README.md`

```
 36 files changed, 1718 insertions(+), 213 deletions(-)
```

New files, by line count:

```
155 app/Http/Controllers/BatchController.php
 91 app/Http/Requests/BatchRequest.php
 44 app/Models/OrderItemBatch.php
227 app/Models/ProductBatch.php
 58 database/migrations/2026_01_01_000900_create_product_batches_table.php
 37 database/migrations/2026_01_01_000901_add_batch_tracking_to_inventory_movements.php
 40 database/migrations/2026_01_01_000902_create_order_item_batches_table.php
232 resources/views/batches/index.blade.php
720 tests/Feature/BatchExpiryTest.php
162 tests/Feature/PageRenderSmokeTest.php
```

New-file total: 1766 lines. Combined with the tracked diff:
**3484 insertions, 213 deletions across 46 files.**

### Verification

```
php artisan test          ->  203 passed (1133 assertions)
vendor/bin/pint --test    ->  {"tool":"pint","result":"passed"}
php artisan migrate:fresh --seed  ->  all 4 seeders clean on MySQL
```

Invariant checks against the seeded MySQL database:

```
drifted products (stock != SUM(lots)): 0
order_item_batches rows: 274
negative usage rows: 0
usage+refund exceeding sold quantity: 0
```

### What changed

**Per-batch expiry dates.** Stock moved from a flat `products.stock` integer
into `product_batches`, one row per delivery with its own `expiry_date` and
optional `batch_no`. `products.stock` stays as the cached sum, written only by
`InventoryService`. The `000900` migration adopts existing flat stock as one
undated lot.

Sales are first-expiry-first-out across sellable lots, skipping lapsed ones and
sorting undated lots last. Expired stock stays in the product total (it is
physically on the shelf) but is excluded from `sellableStock()`, and the till
refuses it. Cancelling or refunding unwinds the exact split recorded in
`order_item_batches`, so units go back on the lot they left with its date intact.

Warnings surface on the till grid and cart, the inventory list (new
`expiring`/`expired` filters, expiry column, stat card, banner), the product page,
a new Batches & Expiry screen, the dashboard and the inventory report and its CSV.

**Sidenav.** Root cause of the "invisible" text: the sidebar root also carries
Bootstrap's `offcanvas-lg`, and inside `@media (min-width: 992px)` Bootstrap ships
`.offcanvas-lg { background-color: transparent !important }` and
`.offcanvas-lg .offcanvas-header { display: none }`. Those load from the CDN
before `public/css/app.css`, so the dark surface never painted and the store name
vanished on desktop. Per the requested direction, the sidebar is now a light
surface with dark ink: `#f8fafc` / `#f0fdfa` backgrounds, `#0f172a` nav text
(17.1:1), `#475569` muted (7.2:1), and `!important` on the surface and header
rules so the offcanvas utility cannot win. The same palette is mirrored into the
inlined critical `<style>` block.
