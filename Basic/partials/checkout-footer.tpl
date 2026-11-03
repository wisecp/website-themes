<footer class="checkout-shell-footer">
    <div class="container">
        <div class="checkout-shell-footer-inner">
            <div class="checkout-shell-footer-text">
                {if $checkout_legal}
                <nav class="checkout-shell-legal" aria-label="{lang key='website/index/checkout-legal-aria'}">
                    {foreach $checkout_legal as $legal}
                    <a href="{$legal.link}">{$legal.title}</a>
                    {/foreach}
                </nav>
                {/if}
                <span class="checkout-shell-copy">© {$current_year} {$company_name} {lang key='website/index/footer-rights'}</span>
            </div>
            <div class="checkout-shell-footer-mark ms-md-auto">
                {if $setting.footer_payment_logos|default:''}
                <span class="visually-hidden">{lang key='website/index/footer-payment-methods'}</span>
                <span class="checkout-shell-pay flex-wrap" aria-hidden="true">
                    {foreach $setting.footer_payment_logos as $pay_logo}
                    <i class="fa-brands fa-{$pay_logo}"></i>
                    {/foreach}
                </span>
                {/if}
                {if $show_powered_by}
                    <span class="checkout-shell-powered">{lang key='website/index/footer-powered-by'} <a class="text-body-secondary text-decoration-none fw-semibold" href="https://www.wisecp.com">WISECP</a></span>
                {/if}
            </div>
            {hook name='ui:client.checkout.footer.end'}
        </div>
    </div>
</footer>
