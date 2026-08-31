{extends file='layouts/checkout.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/cart.css'}">
{/block}

{block name=scripts}
    <script src="{asset path='js/cart.js'}" defer></script>
{/block}

{block name=content}

    <div data-cart-page
         data-cart-url="{link route='cart'}"
         data-txt-update-failed="{lang key='website/cart/update-failed'}"
         data-txt-gate="{lang key='website/cart/checkout-gated'}"
         data-txt-promo-empty="{lang key='website/cart/error-coupon-empty'}"
         data-txt-tax="{lang key='website/cart/summary-tax'}">

    <div data-cart-filled{if !$cart_items} class="d-none"{/if}>
        <div class="checkout-split">
            <div class="checkout-split-main">
                <div class="checkout-split-main-inner">

                    <div class="mb-4">
                        <span class="eyebrow">{lang key='website/cart/eyebrow'}</span>
                        <h1 class="tracking-tight mt-1 mb-0">{lang key='website/cart/title'}</h1>
                    </div>

                    <span class="d-none" data-cart-token>{csrf form='cart'}</span>

                    {hook name='ui:client.cart.items.top'}

                    <div class="d-flex flex-column gap-3" data-cart-items>

                            {foreach $cart_items as $item}
                            <div class="card cart-item{if $item.child} cart-item-deal cart-item-child{/if}" data-cart-item data-key="{$item.key}" data-name="{$item.title}" data-amount="{$item.total_raw}"{if $item.child} data-promo-of="{$item.promo_of}"{/if}{if $item.config_required} data-config-required data-configured="false"{/if}>
                                {if $item.free}<span class="cart-deal-bubble" data-bubble-fixed><i class="bi bi-gift-fill me-1"></i>{lang key='website/cart/free'}</span>{/if}
                                <div class="card-body p-4">
                                    <div class="d-flex flex-column flex-sm-row gap-3">
                                        <span class="icon-disc flex-shrink-0{if $item.icon.kind == 'logo'} is-logo{/if}" aria-hidden="true">{if $item.icon.kind == 'logo'}<img src="{$item.icon.src}" alt="">{else}<i class="{$item.icon.class|default:'bi bi-box'}"></i>{/if}</span>
                                        <div class="flex-grow-1">
                                            <div class="d-flex flex-wrap align-items-start gap-3">
                                                <div class="me-auto">
                                                    <h3 class="h6 mb-1">{$item.title}</h3>
                                                    {if $item.child}
                                                    <span class="cart-promo-of"><i class="bi bi-link-45deg"></i>{lang key='website/cart/promo-of' parent=$item.promo_of}</span>
                                                    {/if}
                                                    <ul class="cart-item-specs">
                                                        {foreach $item.specs as $spec}
                                                        <li{if $spec.role|default:''} data-role="{$spec.role}"{/if}><i class="bi {$spec.icon}"></i>{$spec.text}</li>
                                                        {/foreach}
                                                    </ul>
                                                </div>
                                                {if $item.qty.allowed}
                                                <div class="cart-item-control align-self-center">
                                                    <label class="form-label fs-8 text-body-secondary mb-1 d-block" for="qty-{$item.key}">{lang key='website/cart/quantity'}</label>
                                                    <div class="input-group input-group-sm cart-qty">
                                                        <button class="btn btn-soft" type="button" data-cart-qty-step="-1" aria-label="{lang key='website/cart/qty-decrease'}"><i class="bi bi-dash-lg"></i></button>
                                                        <input type="number" class="form-control text-center num-tabular" id="qty-{$item.key}" data-cart-qty value="{$item.qty.value}" min="1" max="{$item.qty.max}" inputmode="numeric" aria-label="{lang key='website/cart/quantity'}">
                                                        <button class="btn btn-soft" type="button" data-cart-qty-step="1" aria-label="{lang key='website/cart/qty-increase'}"><i class="bi bi-plus-lg"></i></button>
                                                    </div>
                                                </div>
                                                {elseif $item.term}
                                                <div class="cart-item-control align-self-center">
                                                    <label class="form-label fs-8 text-body-secondary mb-1 d-block" for="term-{$item.key}">{lang key='website/cart/term'}</label>
                                                    <select class="form-select form-select-sm" id="term-{$item.key}" data-cart-period aria-label="{lang key='website/cart/term'}">
                                                        {foreach $item.term as $opt}
                                                        <option value="{$opt.years}"{if $opt.selected} selected{/if}>{$opt.label}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                                {/if}
                                                <div class="cart-item-end">
                                                    <div class="cart-item-tools">
                                                        {if $item.config_required}
                                                        <a class="cart-config-btn" href="{$item.edit_link}" data-role="config-btn" data-bs-toggle="tooltip" title="{lang key='website/cart/config-required-tip'}"><i class="bi bi-exclamation-circle"></i>{lang key='website/cart/config-required'}</a>
                                                        {elseif $item.edit_link && !$item.child}
                                                        <a class="btn btn-ghost btn-sm text-body-secondary" href="{$item.edit_link}" data-bs-toggle="tooltip" title="{lang key='website/cart/edit'}"><i class="bi bi-pencil"></i></a>
                                                        {/if}
                                                        <button class="btn btn-ghost btn-sm text-danger" type="button" data-cart-remove data-bs-toggle="tooltip" title="{lang key='website/cart/remove'}"><i class="bi bi-trash3"></i></button>
                                                    </div>
                                                    {if $item.was_fmt}<del class="fs-7 text-body-secondary num-tabular d-block">{$item.was_fmt}</del>{/if}
                                                    <div class="cart-item-price{if $item.free} text-success-emphasis{/if}" data-role="item-price">{$item.total_fmt}</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="cart-item-section">
                                        <button class="cart-item-section-toggle collapsed" type="button" data-wui-toggle data-wui-target="#cartDetails-{$item.key}" aria-expanded="false" aria-controls="cartDetails-{$item.key}">
                                            <span class="fs-8 fw-semibold text-uppercase"><i class="bi bi-receipt me-2"></i>{lang key='website/cart/order-details'}</span>
                                            <i class="bi bi-chevron-down cart-section-caret"></i>
                                        </button>
                                        <div class="wui-collapse" id="cartDetails-{$item.key}">
                                            <div class="wui-collapse-inner">
                                            <div class="cart-item-details">
                                                {if $item.chips}
                                                <p class="fs-8 fw-semibold text-body-secondary text-uppercase mb-2">{lang key='website/cart/settings'}</p>
                                                <div class="cart-chips mb-3">
                                                    {foreach $item.chips as $chip}
                                                    <span class="cart-chip"><i class="bi {$chip.icon}"></i>{$chip.text}</span>
                                                    {/foreach}
                                                </div>
                                                {/if}
                                                <p class="fs-8 fw-semibold text-body-secondary text-uppercase mb-2">{lang key='website/cart/price-breakdown'}</p>
                                                <div class="cart-breakdown">
                                                    {foreach $item.breakdown as $row}
                                                    <div class="cart-breakdown-row{if $row.cls} {$row.cls}{/if}"><span>{if $row.icon}<i class="bi {$row.icon} me-1"></i>{/if}{$row.label}</span><span class="num-tabular">{$row.value}</span></div>
                                                    {/foreach}
                                                    {if $item.qty.allowed && $item.qty.value > 1}
                                                    <div class="cart-breakdown-row"><span>{lang key='website/cart/quantity'}</span><span class="num-tabular">× {$item.qty.value}</span></div>
                                                    {/if}
                                                    <div class="cart-breakdown-row cart-breakdown-total"><span>{lang key='website/cart/item-total'}</span><span class="num-tabular{if $item.free} text-success-emphasis{/if}" data-role="item-total">{$item.total_fmt}</span></div>
                                                </div>
                                            </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            {/foreach}

                        </div>
                    </div>
                </div>
                <aside class="checkout-split-aside">
                    <div class="checkout-split-aside-inner">
                        <div class="order-summary">
                            <div class="card-body p-4">
                                <h2 class="h6 fw-semibold mb-3">{lang key='website/configure/order-summary'}</h2>

                                <div class="order-summary-line">
                                    <span class="summary-label">{lang key='website/cart/subtotal'}</span>
                                    <span class="summary-value num-tabular" data-role="summary-subtotal">{$cart_subtotal}</span>
                                </div>

                                <button class="summary-group-toggle collapsed" type="button" data-wui-toggle data-wui-target="#summaryDiscounts" aria-expanded="false" aria-controls="summaryDiscounts" data-role="discounts-label"{if !$cart_summary.discounts.any} hidden{/if}>
                                    <span>{lang key='website/cart/summary-discounts'}</span>
                                    <i class="bi bi-chevron-down summary-disc-caret"></i>
                                </button>
                                <div class="wui-collapse" id="summaryDiscounts">
                                <div class="wui-collapse-inner">
                                <div class="summary-discounts-body" data-role="discounts-body">

                                    <div class="order-summary-line summary-addon" data-role="summary-promo-line"{if !$cart_summary.discounts.promotions.rows} hidden{/if}>
                                        <span class="summary-label text-success-emphasis"><i class="bi bi-tags me-1"></i>{lang key='website/cart/summary-promotions'}</span>
                                        <span class="summary-value num-tabular text-success-emphasis" data-role="summary-promo">-{$cart_summary.discounts.promotions.total_fmt}</span>
                                    </div>
                                    {foreach $cart_summary.discounts.promotions.rows as $r}
                                    <div class="order-summary-line summary-subline summary-addon" data-promo-row>
                                        <span class="summary-sub"><i class="bi bi-tag me-1"></i><span data-role="row-label">{$r.code}</span> <span class="opacity-75 ms-1" data-role="promo-row-rate">{$r.rate_fmt}</span></span>
                                        <span class="summary-value num-tabular text-body-secondary" data-role="promo-row-value">-{$r.amount_fmt}</span>
                                    </div>
                                    {/foreach}

                                    <div class="order-summary-line summary-addon" data-role="summary-reseller-line"{if !$cart_summary.discounts.reseller.rows} hidden{/if}>
                                        <span class="summary-label text-success-emphasis"><i class="bi bi-shop-window me-1"></i>{lang key='website/cart/summary-reseller'} <span class="cart-auto-tag">{lang key='website/cart/summary-auto'}</span></span>
                                        <span class="summary-value num-tabular text-success-emphasis" data-role="summary-reseller">-{$cart_summary.discounts.reseller.total_fmt}</span>
                                    </div>
                                    {foreach $cart_summary.discounts.reseller.rows as $r}
                                    <div class="order-summary-line summary-subline summary-addon" data-reseller-group-row>
                                        <span class="summary-sub"><i class="bi bi-collection me-1"></i><span data-role="row-label">{$r.name}</span> <span class="opacity-75 ms-1" data-role="reseller-group-rate">{$r.rate_fmt}</span></span>
                                        <span class="summary-value num-tabular text-body-secondary" data-role="reseller-group-value">-{$r.amount_fmt}</span>
                                    </div>
                                    {/foreach}

                                    <div class="order-summary-line summary-addon" data-role="summary-group-line"{if !$cart_summary.discounts.group.rows} hidden{/if}>
                                        <span class="summary-label text-success-emphasis"><i class="bi bi-people me-1"></i>{lang key='website/cart/summary-group'} <span class="cart-auto-tag">{lang key='website/cart/summary-auto'}</span></span>
                                        <span class="summary-value num-tabular text-success-emphasis" data-role="summary-group">-{$cart_summary.discounts.group.total_fmt}</span>
                                    </div>
                                    {foreach $cart_summary.discounts.group.rows as $r}
                                    <div class="order-summary-line summary-subline summary-addon" data-group-row>
                                        <span class="summary-sub"><i class="bi bi-collection me-1"></i><span data-role="row-label">{$r.name}</span> <span class="opacity-75 ms-1" data-role="group-row-rate">{$r.rate_fmt}</span></span>
                                        <span class="summary-value num-tabular text-body-secondary" data-role="group-row-value">-{$r.amount_fmt}</span>
                                    </div>
                                    {/foreach}

                                    {foreach $cart_summary.discounts.coupons as $c}
                                    <div class="order-summary-line summary-addon" data-coupon-line data-coupon-id="{$c.id}">
                                        <span class="summary-label text-success-emphasis"><i class="bi bi-tag me-1"></i><span data-role="summary-coupon-code">{$c.code}</span> <span class="opacity-75 ms-1" data-role="coupon-row-rate">{$c.rate_fmt}</span><button class="cart-coupon-remove" type="button" data-cart-promo-remove aria-label="{lang key='website/cart/promo-remove-aria'}"><i class="bi bi-x-lg"></i></button></span>
                                        <span class="summary-value num-tabular text-success-emphasis" data-role="summary-coupon">-{$c.amount_fmt}</span>
                                    </div>
                                    {/foreach}

                                </div>
                                </div>
                                </div>

                                <div class="order-summary-savings summary-addon" data-role="summary-savings-line"{if $cart_summary.savings_raw <= 0} hidden{/if}>
                                    <span><i class="bi bi-cash-coin me-1"></i>{lang key='website/cart/summary-you-save'}</span>
                                    <span class="num-tabular" data-role="summary-savings">{$cart_summary.savings_fmt}</span>
                                </div>

                                <div class="wui-collapse{if $cart_summary.tax_lines} wui-show{/if}" data-tax-group>
                                    <div class="wui-collapse-inner">
                                    {foreach $cart_summary.tax_lines as $t}
                                    <div class="order-summary-line" data-tax-row>
                                        <span class="summary-label"><span data-role="row-label">{if $t.name}{$t.name}{else}{lang key='website/cart/summary-tax'}{/if}</span> <span class="opacity-75" data-role="tax-row-rate">{$t.rate_fmt}</span></span>
                                        <span class="summary-value num-tabular" data-role="tax-row-value">{$t.amount_fmt}</span>
                                    </div>
                                    {/foreach}
                                    </div>
                                </div>

                                <hr class="summary-rule">
                                <div class="order-summary-line order-summary-total mb-3">
                                    <span class="summary-label">{lang key='website/configure/total-due'}</span>
                                    <span class="summary-value num-tabular" data-role="summary-total">{$cart_total}</span>
                                </div>

                                {if $coupon_enabled}
                                <div class="wui-collapse{if !$cart_summary.discounts.coupons} wui-show{/if}" id="promoEntry" data-role="promo-entry">
                                    <div class="wui-collapse-inner">
                                        <div class="pb-3">
                                            <button class="btn btn-soft btn-sm w-100" type="button" data-wui-toggle data-wui-target="#cartPromo" aria-expanded="false" aria-controls="cartPromo">
                                                <i class="bi bi-tag me-1"></i>{lang key='website/cart/promo-add'}
                                            </button>
                                            <div class="wui-collapse" id="cartPromo">
                                                <div class="wui-collapse-inner">
                                                    <div class="pt-2">
                                                        <label for="cart-promo-input" class="form-label visually-hidden">{lang key='website/cart/promo-label'}</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" id="cart-promo-input" placeholder="{lang key='website/cart/promo-placeholder'}" autocomplete="off" data-role="promo-input">
                                                            <button class="btn btn-primary" type="button" data-cart-promo-apply>{lang key='website/cart/promo-apply'}</button>
                                                        </div>
                                                        <div class="invalid-feedback" data-role="promo-feedback"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {/if}

                                <div class="d-grid">
                                    <a class="btn btn-primary{if $cart_has_unconfigured} cart-proceed-gated{/if}" href="{link route='checkout'}" data-checkout-proceed{if $cart_has_unconfigured} data-checkout-gated data-bs-toggle="tooltip" title="{lang key='website/cart/checkout-gated'}"{/if}>{lang key='website/cart/proceed'}<i class="bi bi-arrow-right ms-2"></i></a>
                                </div>
                                <p class="fs-8 text-body-secondary text-center mt-3 mb-0"><i class="bi bi-shield-lock me-1"></i>{lang key='website/cart/secure'}</p>

                                {hook name='ui:client.cart.summary.bottom'}
                            </div>
                        </div>
                    </div>
                </aside>
            </div>
        </div>

    <div data-cart-empty{if $cart_items} class="d-none"{/if}>
        <div class="checkout-split">
            <div class="checkout-split-main">
                <div class="checkout-split-main-inner">
                    <div class="mb-4">
                        <span class="eyebrow">{lang key='website/cart/eyebrow'}</span>
                        <h1 class="tracking-tight mt-1 mb-0">{lang key='website/cart/title'}</h1>
                    </div>
                    <div class="card">
                        <div class="card-body basic-empty-state py-5">
                            <i class="bi bi-cart-x"></i>
                            <p class="mb-1 fw-semibold">{lang key='website/cart/empty-title'}</p>
                            <p class="fs-7 text-body-secondary mb-0">{lang key='website/cart/empty-desc'}</p>
                            <a class="btn btn-primary btn-sm" href="{link route='home'}"><i class="bi bi-grid me-1"></i>{lang key='website/cart/empty-browse'}</a>
                        </div>
                    </div>

                    {hook name='ui:client.cart.empty.after'}

                    {if $popular_cards}
                    <div class="mt-4">
                        <h2 class="h6 fw-semibold mb-3">{lang key='website/cart/popular-title'}</h2>
                        <div class="card-flow">
                            {foreach $popular_cards as $card}
                            <a class="product-card hover-lift" href="{$card.link}">
                                <span class="icon-disc">{if $card.icon.type == 'image'}<img src="{$card.icon.value}" alt="">{else}<i class="{$card.icon.value}"></i>{/if}</span>
                                <span class="h5 mb-0">{$card.title}</span>
                                {if $card.subtitle}<span class="fs-7 text-body-secondary">{$card.subtitle}</span>{/if}
                                {if $card.price}<span class="product-price">{lang key='website/index/card-price-from'} <strong class="num-tabular">{$card.price}</strong></span>{/if}
                                <span class="link-arrow fs-7">{if $card.domain|default:false}{lang key='website/cart/popular-domains-arrow'}{else}{lang key='website/index/card-explore-plans'}{/if}<i class="bi bi-arrow-right"></i></span>
                            </a>
                            {/foreach}
                        </div>
                    </div>
                    {/if}
                </div>
            </div>
            <aside class="checkout-split-aside">
                <div class="checkout-split-aside-inner">
                    <div class="order-summary">
                        <div class="card-body p-4">
                            <h2 class="h6 fw-semibold mb-3">{lang key='website/configure/order-summary'}</h2>
                            <div class="order-summary-line">
                                <span class="summary-label">{lang key='website/cart/subtotal'}</span>
                                <span class="summary-value num-tabular" data-role="summary-subtotal">{$cart_subtotal}</span>
                            </div>
                            <hr class="summary-rule">
                            <div class="order-summary-line order-summary-total mb-3">
                                <span class="summary-label">{lang key='website/configure/total-due'}</span>
                                <span class="summary-value num-tabular" data-role="summary-total">{$cart_total}</span>
                            </div>
                            <div class="d-grid">
                                <button class="btn btn-primary" type="button" disabled>{lang key='website/cart/proceed'}<i class="bi bi-arrow-right ms-2"></i></button>
                            </div>
                            <p class="fs-8 text-body-secondary text-center mt-3 mb-0"><i class="bi bi-shield-lock me-1"></i>{lang key='website/cart/secure'}</p>
                        </div>
                    </div>
                </div>
            </aside>
        </div>
    </div>

    <template data-tpl="promo-row">
        <div class="order-summary-line summary-subline summary-addon" data-promo-row>
            <span class="summary-sub"><i class="bi bi-tag me-1"></i><span data-role="row-label"></span> <span class="opacity-75 ms-1" data-role="promo-row-rate"></span></span>
            <span class="summary-value num-tabular text-body-secondary" data-role="promo-row-value"></span>
        </div>
    </template>
    <template data-tpl="reseller-row">
        <div class="order-summary-line summary-subline summary-addon" data-reseller-group-row>
            <span class="summary-sub"><i class="bi bi-collection me-1"></i><span data-role="row-label"></span> <span class="opacity-75 ms-1" data-role="reseller-group-rate"></span></span>
            <span class="summary-value num-tabular text-body-secondary" data-role="reseller-group-value"></span>
        </div>
    </template>
    <template data-tpl="group-row">
        <div class="order-summary-line summary-subline summary-addon" data-group-row>
            <span class="summary-sub"><i class="bi bi-collection me-1"></i><span data-role="row-label"></span> <span class="opacity-75 ms-1" data-role="group-row-rate"></span></span>
            <span class="summary-value num-tabular text-body-secondary" data-role="group-row-value"></span>
        </div>
    </template>
    <template data-tpl="coupon-line">
        <div class="order-summary-line summary-addon" data-coupon-line>
            <span class="summary-label text-success-emphasis"><i class="bi bi-tag me-1"></i><span data-role="summary-coupon-code"></span> <span class="opacity-75 ms-1" data-role="coupon-row-rate"></span><button class="cart-coupon-remove" type="button" data-cart-promo-remove aria-label="{lang key='website/cart/promo-remove-aria'}"><i class="bi bi-x-lg"></i></button></span>
            <span class="summary-value num-tabular text-success-emphasis" data-role="summary-coupon"></span>
        </div>
    </template>
    <template data-tpl="tax-row">
        <div class="order-summary-line" data-tax-row>
            <span class="summary-label"><span data-role="row-label"></span> <span class="opacity-75" data-role="tax-row-rate"></span></span>
            <span class="summary-value num-tabular" data-role="tax-row-value"></span>
        </div>
    </template>

    </div>

{/block}

{block name=body_end}
<div class="checkout-actionbar" data-checkout-actionbar>
    <div class="checkout-actionbar-inner">
        <span class="checkout-actionbar-total">
            <span class="checkout-actionbar-label">{lang key='website/configure/total-due'}</span>
            <span class="checkout-actionbar-value num-tabular" data-role="actionbar-total">{$cart_total}</span>
        </span>
        {if $cart_items}
        <a class="btn btn-primary checkout-actionbar-cta{if $cart_has_unconfigured} cart-proceed-gated{/if}" href="{link route='checkout'}" data-checkout-proceed{if $cart_has_unconfigured} data-checkout-gated{/if}>{lang key='website/cart/proceed'}<i class="bi bi-arrow-right ms-2"></i></a>
        {else}
        <button class="btn btn-primary checkout-actionbar-cta" type="button" disabled>{lang key='website/cart/proceed'}<i class="bi bi-arrow-right ms-2"></i></button>
        {/if}
    </div>
</div>
{/block}
