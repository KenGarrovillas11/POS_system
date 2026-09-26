# POS System

A point-of-sale and inventory management application built with Laravel 12, Bootstrap 5 and vanilla JavaScript. It covers the till, the product catalogue, stock movements, refunds, sales reporting, user roles and an audit trail.

## Features

- **Till** - name/description search, cart with quantity edits, percentage or fixed discounts, cash/card/mobile payments, change calculation and printable receipts.
- **Orders** - searchable history with status and payment filters. Staff only ever see their own sales; admins see everything.
- **Inventory** - stock-in, stock-out and absolute adjustments, a filterable movement log, low-stock and out-of-stock alerts, CSV export.
- **Batch expiry dates** - stock is held as delivery lots, each with its own expiration date and optional batch number. Sales draw first-expiry-first-out and never touch a lapsed lot; cancelling or refunding puts units back on the exact lots they left. Expired and expiring-soon warnings appear on the till, the inventory list, the product page, the dashboard and the reports.
- **Refunds and cancellations** - partial or full refunds per line item, restocking of returned units, and order cancellation with automatic restock.
- **Reports** - sales, revenue and inventory reports with date ranges, previous-period comparison, per-day/payment-method/cashier breakdowns and CSV exports.
- **Administration** - product and category CRUD, product photos, staff accounts, store settings (currency, tax rate, receipt footer) and a searchable audit log.
- **Local time** - every timestamp is stored and printed in the store's own timezone (`APP_TIMEZONE`), so receipts, reports and the dashboard show the wall-clock time a sale actually happened.
- **Roles** - `admin` and `staff`, enforced by the `role:admin` middleware, which records every denied attempt.
- **Profit tracking** - the dashboard breaks down every product by cost price, selling price, quantity and total profit (`(selling - cost) x quantity`), with total cost, total sales, profit margin and a red loss treatment for anything sold below cost. Two views are shown: what the selected period actually earned, and what the current stock would earn.

## Requirements

- PHP 8.2+ (developed against XAMPP PHP)
- Composer 2
- MySQL 5.7+ or MariaDB 10.3+ (the test suite runs on SQLite)
- Node.js and Vite are not used. Styles come from `public/css/app.css` plus the Bootstrap 5 CDN, and each page's JavaScript lives inline in its Blade template. The untouched `resources/js`, `resources/css`, `vite.config.js` and `package.json` files are Laravel skeleton leftovers and are unreferenced.

## Installation

```bash
# 1. PHP dependencies
composer install

# 2. Environment
cp .env.example .env
php artisan key:generate

# 3. Point .env at your database
#    DB_CONNECTION=mysql
#    DB_HOST=127.0.0.1
#    DB_PORT=3306
#    DB_DATABASE=pos_system
#    DB_USERNAME=root
#    DB_PASSWORD=
#
# 4. Set the store's timezone so receipts and reports show local time
#    APP_TIMEZONE=Asia/Manila

# 5. Create the schema and demo data
php artisan migrate:fresh --seed

# 6. Expose uploaded product images over HTTP
php artisan storage:link
```

Serve it from the XAMPP document root (`http://localhost/Pos`) or run:

```bash
php artisan serve
```

## Demo accounts

All seeded accounts use the password `password`.

| Role  | Email            | Landing page    |
|-------|------------------|-----------------|
| Admin | `admin@pos.test` | Dashboard       |
| Staff | `alice@pos.test` | Till            |
| Staff | `bruno@pos.test` | Till            |
| Staff | `carla@pos.test` | Till (inactive) |

The seeders create 25 products across 6 categories, about 30 days of demo sales, and a restocking pass that leaves a few low-stock items on the dashboard.

## Roles

| Capability                        | Admin | Staff |
|-----------------------------------|:-----:|:-----:|
| Sell, search, print receipts      |  yes  |  yes  |
| View own sales history            |  yes  |  yes  |
| View all sales history            |  yes  |  no   |
| Browse products and stock levels  |  yes  |  yes  |
| Manage products and categories    |  yes  |  no   |
| Adjust stock, log movements       |  yes  |  no   |
| Refund or cancel orders           |  yes  |  no   |
| Reports, users, settings, logs    |  yes  |  no   |

The last active administrator cannot be demoted, deactivated or deleted, and an admin cannot delete their own account.

## Architecture notes

| Area            | Where                                                                                  |
|-----------------|----------------------------------------------------------------------------------------|
| Checkout        | `app/Services/CheckoutService.php` - pricing, discounts, tax, stock decrement in a transaction |
| Stock           | `app/Services/InventoryService.php` - every quantity change writes an `inventory_movements` row |
| Batch expiry    | `app/Models/ProductBatch.php` + `InventoryService` - lots, FEFO sale allocation, exact-lot returns |
| Refunds         | `app/Services/RefundService.php` - per-line refunds, restock, order status roll-up      |
| Authorisation   | `App\Http\Middleware\EnsureUserHasRole` + per-order checks in `OrderController`          |
| Audit trail     | `App\Support\AuditLogger` - `audit_logs` rows for sensitive actions and denied access   |
| Settings        | `App\Models\Setting` - cached key/value store for currency, tax rate and receipt options |
| Driver SQL      | `App\Support\SqlDate` - date bucketing that works on both MySQL and SQLite               |

Stock is never written directly from a controller: it always goes through `InventoryService`, which records before/after values and the responsible user.

The buying price is frozen onto each sold line (`order_items.unit_cost`) at the moment of sale, so editing a product's cost later never rewrites historic profit. Reports and the dashboard's "sold" view use that frozen figure; the dashboard's "current stock" view uses today's prices.

### How stock and expiry fit together

Stock is **not** a single number on the product any more. It lives in `product_batches`, one row per delivery:

| Table                 | Holds                                                                     |
|-----------------------|---------------------------------------------------------------------------|
| `product_batches`     | `product_id`, `batch_no`, `expiry_date`, `quantity` - the actual stock     |
| `products.stock`      | a **cached sum** of the lots above, written only by `InventoryService`     |
| `order_item_batches`  | which lot each sold line came from and how much of it is still out        |
| `inventory_movements` | `batch_id` plus an `expiry_date` snapshot, so the log stands on its own    |

Three rules govern movement, all enforced in `InventoryService`:

1. **Sales are first-expiry-first-out.** A decrease with no lot named is spread across the sellable lots in expiry order. Undated lots sort last, so they are only used once every dated lot is gone. Expired lots are skipped entirely, and a lot is good *through* its expiry date.
2. **Expired stock cannot be sold.** It is still counted in `products.stock` (it is physically on the shelf) but never in `sellableStock()`. The till refuses to add a wholly-expired product to the cart, and checkout rejects any line that exceeds the sellable total.
3. **Returns go back where they came from.** `order_item_batches` records the exact split of every sale, so a cancellation or a partial refund unwinds the consumption order rather than guessing a lot. Units whose lot has since been deleted fall back to the undated general bucket.

Because `products.stock` is a cached sum it could in principle drift, so `BatchExpiryTest` asserts `stock === SUM(lots)` after every kind of movement, and the `000900` migration adopts any pre-existing flat stock as one undated lot.

Receiving stock requires an expiry date (or an explicit existing lot) so a delivery can never be recorded in a way that makes it impossible to flag later. Writing off lapsed goods is a stock-out against a named lot, which is why the adjust screen lets you pick one.

## Testing

The suite uses in-memory SQLite and `RefreshDatabase`:

```bash
php artisan test
```

203 feature tests / 1133 assertions cover login, the till and checkout, stock adjustments, batch expiry and FEFO allocation, refunds, cancellations, catalogue CRUD, reports and exports, settings, user management, role enforcement and page rendering.

To exercise the same suite against MySQL (recommended after touching raw SQL):

```bash
mysql -u root -e "CREATE DATABASE IF NOT EXISTS pos_system_test"
DB_CONNECTION=mysql DB_DATABASE=pos_system_test php artisan test
```

## Useful commands

```bash
php artisan migrate:fresh --seed   # rebuild the demo database
php artisan view:cache             # pre-compile Blade templates
php artisan route:list             # review the 58 application routes
```
