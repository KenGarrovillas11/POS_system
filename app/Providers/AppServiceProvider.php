<?php

namespace App\Providers;

use Illuminate\Pagination\Paginator;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // This app is styled with Bootstrap 5, but Laravel's default paginator
        // ships Tailwind markup, which renders as unstyled text here. Point the
        // paginator at the Bootstrap views the framework already provides so all
        // listings get working controls without passing links() a view name.
        Paginator::defaultView('pagination::bootstrap-5');
        Paginator::defaultSimpleView('pagination::simple-bootstrap-5');
    }
}
