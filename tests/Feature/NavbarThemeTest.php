<?php

namespace Tests\Feature;

use App\Models\Product;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class NavbarThemeTest extends TestCase
{
    use RefreshDatabase;

    private function css(): string
    {
        return (string) file_get_contents(public_path('css/app.css'));
    }

    /**
     * The stylesheet with comments removed, so documentation text is never
     * mistaken for a live declaration.
     */
    private function cssRules(): string
    {
        return (string) preg_replace('#/\*.*?\*/#s', '', $this->css());
    }

    public function test_the_shell_is_tagged_with_the_signed_in_role(): void
    {
        $this->actingAs(User::factory()->admin()->create())
            ->get(route('admin.dashboard'))
            ->assertOk()
            ->assertSee('data-role="admin"', false);

        $this->actingAs(User::factory()->staff()->create())
            ->get(route('pos.index'))
            ->assertOk()
            ->assertSee('data-role="staff"', false);
    }

    public function test_each_role_gets_its_own_sidebar_palette(): void
    {
        $css = $this->css();

        // A default (admin) block and a staff override keyed off data-role.
        $this->assertMatchesRegularExpression('/\.app-shell\s*\{[^}]*--pos-accent:\s*#\w+;/s', $css);
        $this->assertMatchesRegularExpression('/\.app-shell\[data-role="staff"\]\s*\{[^}]*--pos-accent:\s*#\w+;/s', $css);

        // The two accents must actually differ, otherwise the roles look alike.
        preg_match('/\.app-shell\s*\{[^}]*--pos-accent:\s*(#\w+);/s', $css, $admin);
        preg_match('/\[data-role="staff"\]\s*\{[^}]*--pos-accent:\s*(#\w+);/s', $css, $staff);

        $this->assertNotSame($admin[1] ?? null, $staff[1] ?? null, 'Admin and staff accents must be distinguishable.');
    }

    public function test_the_stylesheet_only_uses_variables_that_are_defined(): void
    {
        $css = $this->css();

        preg_match_all('/var\((--pos-[a-z-]+)\)/', $css, $used);
        preg_match_all('/^\s*(--pos-[a-z-]+):/m', $css, $defined);

        $undefined = array_diff(array_unique($used[1]), array_unique($defined[1]));

        $this->assertSame([], array_values($undefined), 'Every --pos-* variable used in the CSS must be defined.');
    }

    public function test_sidebar_text_meets_contrast_requirements(): void
    {
        // The old section-header colour was 3.3:1 on the sidebar, below the 4.5:1
        // WCAG AA threshold for small text. Pin the accessible token instead.
        $this->assertStringNotContainsString('#64748b', $this->cssRules());
        $this->assertMatchesRegularExpression('/--pos-nav-muted:\s*#a3b1c2;/', $this->cssRules());

        $this->assertGreaterThanOrEqual(
            4.5,
            $this->contrast('#94a3b8', '#1b2430'),
            'Section headers on the admin sidebar must be readable.'
        );
        $this->assertGreaterThanOrEqual(
            4.5,
            $this->contrast('#94a3b8', '#142b33'),
            'Section headers on the staff sidebar must be readable.'
        );
    }

    public function test_light_surface_badges_stay_dark_inked(): void
    {
        $css = $this->cssRules();

        // product-thumb sits on a light chip, so it must not use the sidebar's
        // light muted tone.
        $this->assertStringContainsString('#475569', $css);
        $this->assertGreaterThanOrEqual(4.5, $this->contrast('#475569', '#eef2f7'));
    }

    public function test_the_role_badge_uses_the_accent(): void
    {
        $css = $this->css();

        $this->assertMatchesRegularExpression('/\.role-badge\s*\{[^}]*var\(--pos-accent\)/s', $css);

        $this->actingAs(User::factory()->admin()->create())
            ->get(route('admin.dashboard'))
            ->assertOk()
            ->assertSee('role-badge', false)
            ->assertSee('Administrator', false);

        $this->actingAs(User::factory()->staff()->create())
            ->get(route('pos.index'))
            ->assertOk()
            ->assertSee('role-badge', false);
    }

    public function test_the_navbar_is_legible_even_if_the_stylesheet_fails_to_load(): void
    {
        $html = $this->actingAs(User::factory()->admin()->create())
            ->get(route('admin.dashboard'))
            ->assertOk()
            ->getContent();

        // The critical rules must be inlined, and must come *before* app.css so
        // the real stylesheet still wins when it is available.
        $this->assertMatchesRegularExpression(
            '#<style>.*\.app-sidebar\s*\{[^}]*background-color[^}]*\}.*</style>\s*<link[^>]+app\.css#s',
            $html,
            'Critical navbar CSS must be inlined ahead of app.css.'
        );

        // Every piece of navbar text carries its own colour rather than relying
        // on inheritance, because the sidebar is dark and text is light.
        $critical = $this->criticalCss($html);

        foreach ([
            '.app-sidebar' => 'background-color',
            '.sidebar-nav .sidebar-link' => 'color',
            '.sidebar-nav .sidebar-link.active' => 'color',
            '.sidebar-header' => 'color',
            '.avatar' => 'color',
            '.role-badge' => 'color',
        ] as $selector => $property) {
            $this->assertTrue(
                $this->ruleDeclares($critical, $selector, $property),
                "{$selector} must declare {$property} in the critical CSS."
            );
        }

        // Light text on a dark surface, not the reverse.
        $this->assertMatchesRegularExpression('/\.app-sidebar\s*\{[^}]*background-color:\s*var\(--pos-sidebar-bg,\s*#1b2430\)/s', $critical);
        // Selector lists are allowed: the header shares a rule with the profile role.
        $this->assertMatchesRegularExpression('/\.sidebar-header[^{]*\{[^}]*color:\s*var\(--pos-nav-muted,\s*#a3b1c2\)/s', $critical);
    }

    public function test_the_role_chip_and_brand_are_not_white_on_white(): void
    {
        $admin = User::factory()->admin()->create();

        $html = $this->actingAs($admin)->get(route('admin.dashboard'))->assertOk()->getContent();
        $critical = $this->criticalCss($html);

        // The brand uses Bootstrap's text-white, so the critical CSS has to paint
        // the surface behind it or the store name disappears.
        $this->assertStringContainsString('class="text-decoration-none text-white"', $html);
        $this->assertTrue(
            $this->ruleDeclares($critical, '.app-sidebar .offcanvas-header', 'background-color'),
            'The sidebar header needs an explicit dark background for the white brand text.'
        );

        // The role chip lost its text-bg-* class when it was themed, so it must
        // get both a background and white text from the critical CSS.
        $this->assertStringContainsString('role-badge', $html);
        $this->assertStringNotContainsString('text-bg-primary', $html);
        $this->assertMatchesRegularExpression('/\.role-badge\s*\{[^}]*color:\s*#fff\s*!important/s', $critical);
    }

    /**
     * The inlined critical stylesheet from a rendered page.
     */
    private function criticalCss(string $html): string
    {
        preg_match('#<style>(.*?)</style>#s', $html, $m);

        return $m[1] ?? '';
    }

    /**
     * Whether a rule for the selector declares the given property.
     */
    private function ruleDeclares(string $css, string $selector, string $property): bool
    {
        $quoted = preg_quote($selector, '#');

        return (bool) preg_match(
            '#'.str_replace('\\\\', '\\\\', $quoted).'\s*(?:,[^{]*)?\{[^}]*'.preg_quote($property, '#').'\s*:#s',
            $css
        );
    }

    public function test_the_ui_font_is_loaded_and_applied_to_the_sidebar(): void
    {
        $html = $this->actingAs(User::factory()->admin()->create())
            ->get(route('admin.dashboard'))
            ->assertOk()
            ->getContent();

        $this->assertStringContainsString('fonts.googleapis.com/css2?family=Inter', $html);
        $this->assertStringContainsString('rel="preconnect" href="https://fonts.gstatic.com"', $html);

        $css = $this->cssRules();
        $critical = $this->criticalCss($html);

        // Declared once as a token, then applied to the body and the sidebar.
        $this->assertMatchesRegularExpression('/--pos-font-sans:\s*"Inter"/', $css);
        $this->assertTrue($this->ruleDeclares($css, 'body', 'font-family'));
        $this->assertTrue($this->ruleDeclares($css, '.app-sidebar', 'font-family'));
        $this->assertStringContainsString('font-family: var(--pos-font-sans)', $css);

        // The sidebar must stay in the UI font even if app.css is unavailable.
        $this->assertStringContainsString('"Inter", system-ui', $critical);
    }

    public function test_inactive_nav_items_use_a_solid_readable_colour(): void
    {
        $css = $this->cssRules();

        // A faint grey is what made the nav unreadable; the token must be a
        // solid slate that clears AA on both sidebar backgrounds.
        $this->assertMatchesRegularExpression('/--pos-nav-text:\s*#e2e8f0;/', $css);
        $this->assertMatchesRegularExpression('/--pos-nav-muted:\s*#a3b1c2;/', $css);
        $this->assertStringNotContainsString('#cbd5e1', $css);

        $this->assertGreaterThanOrEqual(4.5, $this->contrast('#e2e8f0', '#1b2430'), 'Admin nav text');
        $this->assertGreaterThanOrEqual(4.5, $this->contrast('#e2e8f0', '#142b33'), 'Staff nav text');
        $this->assertGreaterThanOrEqual(4.5, $this->contrast('#a3b1c2', '#1b2430'), 'Admin section header');
        $this->assertGreaterThanOrEqual(4.5, $this->contrast('#a3b1c2', '#142b33'), 'Staff section header');
    }

    public function test_icons_follow_the_state_of_their_link(): void
    {
        $css = $this->cssRules();
        $critical = $this->criticalCss(
            $this->actingAs(User::factory()->admin()->create())->get(route('admin.dashboard'))->getContent()
        );

        // Dim while inactive, full strength on hover and active.
        $this->assertTrue($this->ruleDeclares($css, '.sidebar-nav .sidebar-link i', 'color'));
        $this->assertMatchesRegularExpression(
            '/\.sidebar-nav \.sidebar-link i\s*\{[^}]*color:\s*var\(--pos-nav-muted\)/s',
            $css
        );
        $this->assertMatchesRegularExpression('/\.sidebar-nav \.sidebar-link:hover i\s*\{[^}]*color:\s*var\(--pos-nav-hover-text\)/s', $css);
        $this->assertMatchesRegularExpression('/\.sidebar-nav \.sidebar-link\.active i\s*\{[^}]*color:\s*#fff/s', $css);

        // And the same in the critical CSS, so icons do not vanish either.
        $this->assertMatchesRegularExpression('/\.sidebar-nav \.sidebar-link i\s*\{[^}]*color:/s', $critical);
        $this->assertMatchesRegularExpression('/\.sidebar-nav \.sidebar-link\.active i\s*\{[^}]*color:\s*#fff/s', $critical);
    }

    public function test_the_section_header_is_tracked_out_and_readable(): void
    {
        $css = $this->cssRules();

        preg_match('/\.sidebar-header\s*\{([^}]*)\}/s', $css, $m);
        $rule = $m[1] ?? '';

        $this->assertStringContainsString('text-transform: uppercase', $rule);
        $this->assertStringContainsString('font-weight: 700', $rule);
        $this->assertMatchesRegularExpression('/letter-spacing:\s*0\.1[0-9]em/', $rule);
        $this->assertStringContainsString('var(--pos-nav-muted)', $rule);
        $this->assertStringNotContainsString('0.09em', $rule);
    }

    public function test_the_profile_block_sits_at_the_top_of_the_sidebar(): void
    {
        $html = $this->actingAs(User::factory()->admin()->create(['name' => 'Store Administrator']))
            ->get(route('admin.dashboard'))
            ->assertOk()
            ->getContent();

        $sidebar = $this->sidebarMarkup($html);

        $this->assertSame(1, substr_count($sidebar, 'sidebar-profile'), 'The profile block must appear exactly once.');

        // Above the nav list, and the old bottom block is gone.
        $this->assertLessThan(
            strpos($sidebar, 'sidebar-nav'),
            strpos($sidebar, 'sidebar-profile'),
            'The profile block must come before the navigation list.'
        );
        $this->assertStringNotContainsString('mt-auto p-3 border-top border-secondary-subtle', $sidebar);
        $this->assertStringContainsString('profile-name', $sidebar);
        $this->assertStringContainsString('profile-role', $sidebar);
    }

    public function test_the_profile_role_label_is_not_bootstrap_grey(): void
    {
        $html = $this->actingAs(User::factory()->staff()->create())
            ->get(route('pos.index'))
            ->assertOk()
            ->getContent();

        // text-secondary on the dark sidebar was 3.3:1, which is why the role
        // label looked washed out.
        $this->assertStringNotContainsString('text-secondary', $this->sidebarMarkup($html));

        $css = $this->cssRules();
        $this->assertMatchesRegularExpression('/\.sidebar-profile \.profile-name\s*\{[^}]*color:\s*#fff/s', $css);
        $this->assertMatchesRegularExpression('/\.sidebar-profile \.profile-role\s*\{[^}]*color:\s*var\(--pos-nav-muted\)/s', $css);
    }

    /**
     * Just the sidebar partial's output from a rendered page.
     */
    private function sidebarMarkup(string $html): string
    {
        preg_match('#<div class="offcanvas-lg.*?<main#s', $html, $m);

        return $m[0] ?? '';
    }

    public function test_the_till_page_still_renders_its_product_grid(): void
    {
        $this->actingAs(User::factory()->staff()->create());
        Product::factory()->create(['name' => 'Themed Item']);

        $this->get(route('pos.index'))
            ->assertOk()
            ->assertSee('pos-grid', false)
            ->assertSee('Themed Item');
    }

    /**
     * WCAG relative-contrast ratio between two hex colours.
     */
    private function contrast(string $foreground, string $background): float
    {
        $luminance = function (string $hex): float {
            $hex = ltrim($hex, '#');
            $channels = [];

            foreach ([0, 2, 4] as $i) {
                $value = hexdec(substr($hex, $i, 2)) / 255;
                $channels[] = $value <= 0.03928
                    ? $value / 12.92
                    : (($value + 0.055) / 1.055) ** 2.4;
            }

            return 0.2126 * $channels[0] + 0.7152 * $channels[1] + 0.0722 * $channels[2];
        };

        $a = $luminance($foreground);
        $b = $luminance($background);

        return (max($a, $b) + 0.05) / (min($a, $b) + 0.05);
    }
}
