# POS System

A point-of-sale and inventory management application built with Laravel 12, Bootstrap 5 and vanilla JavaScript. It covers the till, the product catalogue, stock movements, refunds, sales reporting, user roles and an audit trail.

## Features

- **Till** - name/description search, cart with quantity edits, percentage or fixed discounts, cash/card/mobile payments, change calculation and printable receipts.
- **Orders** - searchable history with status and payment filters. Staff only ever see their own sales; admins see everything.
- **Inventory** - stock-in, stock-out and absolute adjustments, a filterable movement log, low-stock and out-of-stock alerts, CSV export.
- **Refunds and cancellations** - partial or full refunds per line item, restocking of returned units, and order cancellation with automatic restock.
- **Reports** - sales, revenue and inventory reports with date ranges, previous-period comparison, per-day/payment-method/cashier breakdowns and CSV exports.
- **Administration** - product and category CRUD, staff accounts, store settings (currency, tax rate, receipt footer) and a searchable audit log.
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

# 4. Schema plus demo data
php artisan migrate:fresh --seed
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
| Refunds         | `app/Services/RefundService.php` - per-line refunds, restock, order status roll-up      |
| Authorisation   | `App\Http\Middleware\EnsureUserHasRole` + per-order checks in `OrderController`          |
| Audit trail     | `App\Support\AuditLogger` - `audit_logs` rows for sensitive actions and denied access   |
| Settings        | `App\Models\Setting` - cached key/value store for currency, tax rate and receipt options |
| Driver SQL      | `App\Support\SqlDate` - date bucketing that works on both MySQL and SQLite               |

Stock is never written directly from a controller: it always goes through `InventoryService`, which records before/after values and the responsible user.

The buying price is frozen onto each sold line (`order_items.unit_cost`) at the moment of sale, so editing a product's cost later never rewrites historic profit. Reports and the dashboard's "sold" view use that frozen figure; the dashboard's "current stock" view uses today's prices.

## Testing

The suite uses in-memory SQLite and `RefreshDatabase`:

```bash
php artisan test
```

95 feature tests / 440 assertions cover login, the till and checkout, stock adjustments, refunds, cancellations, catalogue CRUD, reports and exports, settings, user management and role enforcement.

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
