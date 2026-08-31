<header class="checkout-shell-header">
    <div class="container checkout-shell-bar">
        <div class="checkout-shell-zone">
            <a class="site-brand d-inline-flex align-items-center{if $brand_no_logo} brand-no-logo{/if}" href="{link route='home'}">
                {if $light_logo_link}<img src="{$light_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-light">{/if}
                {if $dark_logo_link}<img src="{$dark_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-dark">{/if}
                <span class="site-brand-text">{$brand_wordmark}</span>
            </a>
        </div>
        <div class="checkout-shell-zone checkout-shell-zone-center">
            {if empty($result_back_link)}
            <div class="checkout-steps">
                <span class="checkout-step {if $checkout_step > 1}is-done{else}is-active{/if}"><span class="checkout-step-num">{if $checkout_step > 1}<i class="bi bi-check-lg"></i>{else}1{/if}</span>{lang key='website/index/checkout-step-configure'}</span>
                <span class="checkout-step-sep" aria-hidden="true"></span>
                <span class="checkout-step {if $checkout_step > 2}is-done{elseif $checkout_step == 2}is-active{/if}"><span class="checkout-step-num">{if $checkout_step > 2}<i class="bi bi-check-lg"></i>{else}2{/if}</span>{lang key='website/index/checkout-step-cart'}</span>
                <span class="checkout-step-sep" aria-hidden="true"></span>
                <span class="checkout-step {if $checkout_step > 3}is-done{elseif $checkout_step == 3}is-active{/if}"><span class="checkout-step-num">{if $checkout_step > 3}<i class="bi bi-check-lg"></i>{else}3{/if}</span>{lang key='website/index/checkout-step-checkout'}</span>
            </div>
            {/if}
        </div>
        <div class="checkout-shell-zone checkout-shell-zone-end">
            {if !empty($result_back_link)}<a class="checkout-shell-back d-inline-flex align-items-center" href="{$result_back_link}"><i class="bi bi-arrow-left me-1"></i>{$result_back_label|default:''}</a>{/if}
            {hook name='ui:client.checkout.header.end'}
        </div>
    </div>
</header>
