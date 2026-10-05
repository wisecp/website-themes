<footer class="site-footer chrome-dark">
    {if $show_powered_by}
    <div class="footer-powered-band">
        <div class="container">
            <span class="fs-8">{lang key='website/index/footer-powered-by'} <a class="footer-link d-inline fw-semibold" href="https://www.wisecp.com">WISECP</a></span>
        </div>
    </div>
    {/if}
    <div class="container">
        <div class="footer-top">
            <div class="footer-brand">
                <a class="site-brand d-inline-flex align-items-center mb-3{if $brand_no_logo} brand-no-logo{/if}" href="{link route='home'}">
                    {if $light_logo_link}<img src="{$light_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-light">{/if}
                    {if $dark_logo_link}<img src="{$dark_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-dark">{/if}
                    <span class="site-brand-text">{$brand_wordmark}</span>
                </a>
                <p class="fs-7 footer-brand-desc mb-3">{lang key='website/index/footer-tagline'}</p>
                {if $contact_phone}
                <a class="footer-phone num-tabular d-inline-flex align-items-center gap-2 mb-3" href="tel:{$contact_phone|regex_replace:'/[^+0-9]/':''}"><i class="bi bi-telephone"></i><span dir="ltr">{$contact_phone}</span></a>
                {/if}
                <div class="footer-controls mb-3">
                    {include file='components/locale-switcher.tpl' idsuffix='' wrapclass='dropup footer-locale' toggleclass='btn btn-ghost btn-sm locale-toggle' menuclass='dropdown-menu locale-menu' caret=true}
                    <div class="footer-appearance" role="group" aria-label="{lang key='website/account/display-mode'}">
                        <button type="button" class="footer-appearance-btn" data-action="set-theme" data-theme-option data-theme="light" data-bs-toggle="tooltip" title="{lang key='website/account/theme-light'}" aria-label="{lang key='website/account/theme-light'}"><i class="bi bi-sun"></i></button>
                        <button type="button" class="footer-appearance-btn" data-action="set-theme" data-theme-option data-theme="dark" data-bs-toggle="tooltip" title="{lang key='website/account/theme-dark'}" aria-label="{lang key='website/account/theme-dark'}"><i class="bi bi-moon-stars"></i></button>
                        <button type="button" class="footer-appearance-btn" data-action="set-theme" data-theme-option data-theme="auto" data-bs-toggle="tooltip" title="{lang key='website/account/theme-auto'}" aria-label="{lang key='website/account/theme-auto'}"><i class="bi bi-display"></i></button>
                    </div>
                </div>
                {if $social_links}
                <div class="d-flex gap-1">
                    {foreach $social_links as $social}
                    <a class="btn btn-ghost btn-sm" href="{$social.url}" data-bs-toggle="tooltip" title="{$social.name}"><i class="{$social.icon}"></i></a>
                    {/foreach}
                </div>
                {/if}
            </div>
            <nav class="footer-nav" aria-label="{lang key='footer_nav_aria'}">
                {foreach $footer_menu as $column}
                <div class="footer-col">
                    <h2 class="footer-heading">{$column.title}</h2>
                    {foreach $column.children as $link}
                    <a class="footer-link"{if $link.link} href="{$link.link}"{/if}>{$link.title}</a>
                    {/foreach}
                </div>
                {/foreach}
                {hook name='ui:client.footer.columns'}
            </nav>
        </div>
        <div class="footer-base">
            <span class="fs-8">© {$current_year} {$company_name} {lang key='website/index/footer-rights'}</span>
            {if $cookie_notice}<a class="footer-link d-inline fs-8" href="#" data-cookie-open>{lang key='website/index/cookie-settings'}</a>{/if}
            {hook name='ui:client.footer.bottom'}
            <div class="footer-base-end">
                <a class="footer-status fs-8" href="{if $setting.status_url}{$setting.status_url}{else}{link route='news'}{/if}"><span class="status-dot"></span>{lang key='footer_status'}</a>
                <span class="visually-hidden">{lang key='website/index/footer-payment-methods'}</span>
                <div class="d-flex align-items-center gap-2 fs-4" aria-hidden="true">
                    <i class="fa-brands fa-cc-visa"></i>
                    <i class="fa-brands fa-cc-mastercard"></i>
                    <i class="fa-brands fa-cc-paypal"></i>
                    <i class="fa-brands fa-cc-stripe"></i>
                </div>
            </div>
        </div>
    </div>
</footer>
<button class="btn btn-primary scroll-top" type="button" data-action="scroll-top" aria-label="{lang key='website/index/scroll-top-aria'}"><i class="bi bi-arrow-up"></i></button>
