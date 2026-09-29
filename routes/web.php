<?php

use App\Http\Controllers\AuditLogController;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\BatchController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\InventoryController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\PosController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\RefundController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Guest routes
|--------------------------------------------------------------------------
*/
Route::middleware('guest')->group(function () {
    Route::get('login', [LoginController::class, 'create'])->name('login');
    Route::post('login', [LoginController::class, 'store'])->name('login.store');
});

Route::post('logout', [LoginController::class, 'destroy'])
    ->middleware('auth')
    ->name('logout');

/*
|--------------------------------------------------------------------------
| Authenticated routes - shared by admin and staff
|--------------------------------------------------------------------------
*/
Route::middleware('auth')->group(function () {
    // Root sends each role to its own home screen.
    Route::get('/', function (Request $request) {
        return $request->user()->isAdmin()
            ? redirect()->route('admin.dashboard')
            : redirect()->route('pos.index');
    })->name('home');

    // Profile
    Route::get('profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::put('profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::get('profile/password', [ProfileController::class, 'editPassword'])->name('profile.password.edit');
    Route::put('profile/password', [ProfileController::class, 'updatePassword'])->name('profile.password.update');

    /*
    |----------------------------------------------------------------------
    | Point of sale - cashiers only
    |----------------------------------------------------------------------
    | Selling is a cashier responsibility: an administrator who can ring up
    | sales can also edit the products, prices and stock behind them, which
    | makes the cashier attribution on reports meaningless. Admins keep
    | full oversight through orders, inventory and the reports instead.
    */
    Route::middleware('role:staff')->prefix('pos')->name('pos.')->group(function () {
        Route::get('/', [PosController::class, 'index'])->name('index');
        Route::get('search', [PosController::class, 'search'])->name('search');
        Route::post('cart', [PosController::class, 'store'])->name('cart.store');
        Route::patch('cart/{product}', [PosController::class, 'update'])->name('cart.update');
        Route::delete('cart/{product}', [PosController::class, 'destroy'])->name('cart.destroy');
        Route::delete('cart', [PosController::class, 'clear'])->name('cart.clear');
        Route::post('checkout', [PosController::class, 'checkout'])->name('checkout');
    });

    /*
    |----------------------------------------------------------------------
    | Orders & sales history
    |   Staff are scoped to their own orders inside the controller.
    |----------------------------------------------------------------------
    */
    Route::get('orders', [OrderController::class, 'index'])->name('orders.index');
    Route::get('orders/{order}', [OrderController::class, 'show'])->name('orders.show');
    Route::get('orders/{order}/receipt', [OrderController::class, 'receipt'])->name('orders.receipt');
    Route::put('orders/{order}', [OrderController::class, 'update'])->name('orders.update');
    Route::post('orders/{order}/cancel', [OrderController::class, 'cancel'])->name('orders.cancel');

    /*
    |----------------------------------------------------------------------
    | Refunds & returns
    |   Staff may return the sales they rang up themselves; RefundController
    |   scopes them to their own orders, admins may return anything. The
    |   admin-prefixed equivalents further down stay for the oversight screens.
    |----------------------------------------------------------------------
    */
    Route::get('orders/{order}/refund', [RefundController::class, 'create'])->name('refunds.create');
    Route::post('orders/{order}/refund', [RefundController::class, 'store'])->name('refunds.store');
    Route::get('refunds/{refund}', [RefundController::class, 'show'])->name('refunds.show');

    /*
    |----------------------------------------------------------------------
    | Catalog browsing - read-only for staff, CRUD for admin
    |----------------------------------------------------------------------
    */
    Route::get('products', [ProductController::class, 'index'])->name('products.index');
    Route::get('products/{product}', [ProductController::class, 'show'])->name('products.show');

    // Inventory levels are read-only for everyone; the adjustment log and
    // stock edits below are admin-only.
    Route::get('inventory', [InventoryController::class, 'index'])->name('inventory.index');
});

/*
|--------------------------------------------------------------------------
| Admin-only routes
|--------------------------------------------------------------------------
*/
Route::middleware(['auth', 'role:admin'])->prefix('admin')->name('admin.')->group(function () {
    // Dashboard
    Route::get('dashboard', [DashboardController::class, 'index'])->name('dashboard');

    // Staff / user management
    Route::resource('users', UserController::class)->except(['show']);

    // Products (admin gets full CRUD on top of the shared read routes)
    Route::get('products/create', [ProductController::class, 'create'])->name('products.create');
    Route::post('products', [ProductController::class, 'store'])->name('products.store');
    Route::get('products/{product}/edit', [ProductController::class, 'edit'])->name('products.edit');
    Route::put('products/{product}', [ProductController::class, 'update'])->name('products.update');
    Route::delete('products/{product}', [ProductController::class, 'destroy'])->name('products.destroy');

    // Categories
    Route::resource('categories', CategoryController::class)->except(['show']);

    // Inventory management
    Route::get('inventory/movements', [InventoryController::class, 'movements'])->name('inventory.movements');
    Route::get('products/{product}/stock', [InventoryController::class, 'create'])->name('inventory.create');
    Route::post('products/{product}/stock', [InventoryController::class, 'store'])->name('inventory.store');

    // Delivery lots and their expiry dates
    Route::get('products/{product}/batches', [BatchController::class, 'index'])->name('batches.index');
    Route::post('products/{product}/batches', [BatchController::class, 'store'])->name('batches.store');
    Route::put('batches/{batch}', [BatchController::class, 'update'])->name('batches.update');
    Route::delete('batches/{batch}', [BatchController::class, 'destroy'])->name('batches.destroy');

    // Refunds / returns
    Route::get('refunds', [RefundController::class, 'index'])->name('refunds.index');
    Route::get('orders/{order}/refund', [RefundController::class, 'create'])->name('refunds.create');
    Route::post('orders/{order}/refund', [RefundController::class, 'store'])->name('refunds.store');
    Route::get('refunds/{refund}', [RefundController::class, 'show'])->name('refunds.show');

    // Reports
    Route::get('reports', [ReportController::class, 'index'])->name('reports.index');
    Route::get('reports/sales', [ReportController::class, 'sales'])->name('reports.sales');
    Route::get('reports/revenue', [ReportController::class, 'revenue'])->name('reports.revenue');
    Route::get('reports/inventory', [ReportController::class, 'inventory'])->name('reports.inventory');

    // Settings
    Route::get('settings', [SettingController::class, 'edit'])->name('settings.edit');
    Route::put('settings', [SettingController::class, 'update'])->name('settings.update');

    // Audit logs
    Route::get('audit-logs', [AuditLogController::class, 'index'])->name('audit-logs.index');
    Route::get('audit-logs/{auditLog}', [AuditLogController::class, 'show'])->name('audit-logs.show');
});
