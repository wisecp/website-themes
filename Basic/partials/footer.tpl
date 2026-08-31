<footer class="site-footer">
    <div class="container">
        {if $show_powered_by}
        <div class="border-bottom py-2 text-center">
            <span class="fs-8 text-body-secondary">{lang key='website/index/footer-powered-by'} <a class="text-body-secondary text-decoration-none fw-semibold" href="https://www.wisecp.com">WISECP</a></span>
        </div>
        {/if}
        <div class="row g-4 py-5">
            <div class="col-lg-4 pe-lg-5">
                <a class="site-brand d-inline-flex align-items-center mb-3{if $brand_no_logo} brand-no-logo{/if}" href="{if $only_client_panel}{link route='my-account'}{else}{link route='home'}{/if}">
                    {if $light_logo_link}<img src="{$light_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-light">{/if}
                    {if $dark_logo_link}<img src="{$dark_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-dark">{/if}
                    <span class="site-brand-text">{$brand_wordmark}</span>
                </a>
                <p class="fs-7 text-body-secondary mb-3">{lang key='website/index/footer-tagline'}</p>
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
            {foreach $footer_menu as $column}
            <div class="col-6 col-md-3 col-lg-2">
                <h2 class="footer-heading">{$column.title}</h2>
                {foreach $column.children as $link}
                <a class="footer-link"{if $link.link} href="{$link.link}"{/if}>{$link.title}</a>
                {/foreach}
            </div>
            {/foreach}
            {hook name='ui:client.footer.columns'}
        </div>
        <div class="border-top py-3 d-flex flex-wrap align-items-center gap-3">
            <span class="fs-8 text-body-secondary">© {$current_year} {$company_name} {lang key='website/index/footer-rights'}</span>
            {if $cookie_notice}<a class="footer-link d-inline fs-8" href="#" data-cookie-open>{lang key='website/index/cookie-settings'}</a>{/if}
            {hook name='ui:client.footer.bottom'}
            <span class="visually-hidden">{lang key='website/index/footer-payment-methods'}</span>
            <div class="d-flex align-items-center gap-2 ms-auto fs-4 text-body-secondary" aria-hidden="true">
                <i class="fa-brands fa-cc-visa"></i>
                <i class="fa-brands fa-cc-mastercard"></i>
                <i class="fa-brands fa-cc-paypal"></i>
                <i class="fa-brands fa-cc-stripe"></i>
            </div>
        </div>
    </div>
</footer>
