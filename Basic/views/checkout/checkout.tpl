{extends file='layouts/checkout.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='js/libs/tom-select/tom-select.bootstrap5.min.css'}">
<link rel="stylesheet" href="{asset path='js/libs/intl-tel-input/css/intlTelInput.min.css'}">
    <link rel="stylesheet" href="{asset path='css/checkout.css'}">
<script src="{asset path='js/libs/tom-select/tom-select.complete.min.js'}" defer></script>
{/block}

{block name=scripts}
    <script src="{asset path='js/checkout.js'}" defer></script>
{/block}

{block name=content}

    <span class="d-none" data-signin-token>{csrf form='sign-in'}</span>
    {if !$is_member && $passkey_enabled}<span class="d-none" data-passkey-token>{csrf form='passkey'}</span>{/if}
    {if !$is_member && $jetpass_enabled}<span class="d-none" data-jetpass-token>{csrf form='jetpass'}</span>{/if}

    <form method="post" novalidate data-checkout id="checkout-form"
          data-checkout-url="{link route='checkout'}"
          data-currency="{$currency}"
          data-signin-url="{link route='sign-in'}"
          data-txt-error="{lang key='website/checkout/error-generic'}"
          data-txt-login-first="{lang key='website/checkout/error-login-first'}"
          data-txt-logging-in="{lang key='website/checkout/logging-in'}"
          data-txt-sending-code="{lang key='website/checkout/sending-code'}"
          data-txt-tax="{lang key='website/cart/summary-tax'}">
        <div class="checkout-split">
            <div class="checkout-split-main">
                <div class="checkout-split-main-inner">

                    <div class="mb-4">
                        <span class="eyebrow">{lang key='website/checkout/eyebrow'}</span>
                        <h1 class="tracking-tight mt-1 mb-0">{lang key='website/checkout/title'}</h1>
                    </div>

                    {csrf form='checkout'}

                    {hook name='ui:client.checkout.cards.top'}

                    <div class="d-flex flex-column gap-4">

                        <div class="card">
                            <div class="card-body p-4">
                                <div class="checkout-head">
                                    <span class="icon-disc"><i class="bi bi-person"></i></span>
                                    <div>
                                        <h2 class="h6 fw-semibold mb-0">{lang key='website/checkout/account-title'}</h2>
                                        <p class="fs-8 text-body-secondary mb-0">{if $is_member}{lang key='website/checkout/account-sub'}{else}{lang key='website/checkout/account-sub-guest'}{/if}</p>
                                    </div>
                                </div>

                                {if $is_member}
                                <div class="wui-collapse wui-show" data-account-live>
                                    <div class="wui-collapse-inner">
                                        <div data-account-live-body>
                                            {include file='views/checkout/section-account.tpl'}
                                        </div>
                                    </div>
                                </div>
                                {else}
                                <input type="hidden" name="account_mode" value="{if $login_enabled}login{else}create{/if}" data-account-mode>

                                <div class="wui-collapse wui-show" data-account-guest>
                                    <div class="wui-collapse-inner">
                                        <div class="row g-4">
                                            <div class="{if $passkey_enabled || $jetpass_enabled || $social_providers}col-lg-7{else}col-12{/if}">

                                {if $login_enabled}
                                <div class="wui-collapse wui-show" data-account-login>
                                    <div class="wui-collapse-inner">
                                        <div>
                                            <div class="row g-3">
                                                <div class="col-12">
                                                    <label for="co-login-email" class="form-label">{lang key='website/sign/email-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                                                    <input type="email" class="form-control" id="co-login-email" autocomplete="email">
                                                    <div class="invalid-feedback">{lang key='website/checkout/error-login-email'}</div>
                                                </div>
                                                <div class="col-12">
                                                    <label for="co-login-password" class="form-label">{lang key='website/sign/password-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                                                    <input type="password" class="form-control" id="co-login-password" autocomplete="current-password">
                                                    <div class="invalid-feedback">{lang key='website/checkout/error-login-password'}</div>
                                                </div>
                                            </div>
                                            <div class="mt-3" data-login-captcha>{captcha area='sign-in'}</div>
                                            <div class="alert alert-danger d-flex align-items-center d-none mt-3 mb-0" role="alert" data-login-error>
                                                <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                                                <div data-role="login-error-text"></div>
                                            </div>
                                            <div class="d-flex flex-wrap align-items-center gap-3 mt-3">
                                                <button class="btn btn-primary" type="button" data-action="checkout-login"><i class="bi bi-box-arrow-in-right me-2"></i>{lang key='website/sign/login-submit'}</button>
                                                <a class="fs-7 text-decoration-none fw-semibold" href="{link route='sign-forget'}">{lang key='website/sign/login-forgot'}</a>
                                            </div>
                                            <p class="fs-7 text-body-secondary mt-3 mb-0">{lang key='website/checkout/need-account'} <button class="btn btn-link p-0 ms-1 align-baseline text-decoration-none fw-semibold" type="button" data-account-switch="create">{lang key='website/checkout/create-one'}</button></p>
                                        </div>
                                    </div>
                                </div>
                                {/if}

                                <div class="wui-collapse{if !$login_enabled} wui-show{/if}" data-account-create>
                                    <div class="wui-collapse-inner">
                                        <div>
                                            <div class="row g-3">
                                                <div class="col-12">
                                                    <label for="co-email" class="form-label">{lang key='website/sign/email-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                                                    <input type="email" class="form-control" id="co-email" name="email" placeholder="you@example.com" autocomplete="email" required>
                                                    <div class="invalid-feedback">{lang key='website/checkout/error-create-email'}</div>
                                                </div>
                                                <div class="col-12" data-password-field>
                                                    <label for="co-password" class="form-label">{lang key='website/sign/password-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                                                    <div class="input-group">
                                                        <input type="password" class="form-control" id="co-password" name="password" autocomplete="new-password" required>
                                                        <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/sign/password-show'}"><i class="bi bi-eye"></i></button>
                                                        <button class="btn btn-soft" type="button" data-action="password-generate" data-bs-toggle="tooltip" title="{lang key='website/sign/password-generate'}"><i class="bi bi-stars"></i></button>
                                                        <button class="btn btn-soft" type="button" data-action="password-copy" data-bs-toggle="tooltip" title="{lang key='website/sign/password-copy'}"><i class="bi bi-clipboard"></i></button>
                                                    </div>
                                                    <div class="basic-password-strength" data-strength="0" data-labels="|{lang key='website/sign/password-strength-weak'}|{lang key='website/sign/password-strength-fair'}|{lang key='website/sign/password-strength-good'}|{lang key='website/sign/password-strength-strong'}">
                                                        <span class="strength-bar"></span><span class="strength-bar"></span>
                                                        <span class="strength-bar"></span><span class="strength-bar"></span>
                                                    </div>
                                                    <small class="text-body-secondary" data-role="strength-label"></small>
                                                    <div class="invalid-feedback">{lang key='website/checkout/error-create-password'}</div>
                                                </div>
                                                {if $reg_identity_visible}
                                                <div class="col-12">
                                                    <label for="co-national-id" class="form-label">{lang key='website/sign/register-national-id'} {if $reg_identity_required}<span class="text-danger" aria-hidden="true">*</span>{else}<span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span>{/if}</label>
                                                    <input type="text" class="form-control" id="co-national-id" name="identity" autocomplete="off"{if $reg_identity_required} required{/if}>
                                                    <div class="invalid-feedback">{lang key='website/checkout/error-national-id'}</div>
                                                </div>
                                                {/if}
                                            </div>
                                            <div class="mt-3" data-create-captcha>{captcha area='sign-up'}</div>
                                            <p class="fs-8 text-body-secondary mt-3 mb-0"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/create-note'}</p>

                                            {if $login_enabled}
                                            <p class="fs-7 text-body-secondary mt-3 mb-0">{lang key='website/sign/register-have-account'} <button class="btn btn-link p-0 ms-1 align-baseline text-decoration-none fw-semibold" type="button" data-account-switch="login">{lang key='website/sign/register-login'}</button></p>
                                            {/if}
                                        </div>
                                    </div>
                                </div>

                                            </div>
                                            {if $passkey_enabled || $jetpass_enabled || $social_providers}
                                            <div class="col-lg-5">
                                                <span class="fs-8 fw-semibold text-body-secondary text-uppercase d-block mb-2">{lang key='website/checkout/or-continue'}</span>
                                                <div class="d-grid gap-2">
                                                    {foreach $social_providers as $p}{$p.button nofilter}{/foreach}
                                                    {if $passkey_enabled}
                                                    <button class="btn btn-soft d-inline-flex align-items-center justify-content-center" type="button" data-action="checkout-passkey"><i class="bi bi-fingerprint me-2"></i>{lang key='website/sign/login-passkey-cta'}</button>
                                                    {/if}
                                                    {if $jetpass_enabled}
                                                    <button class="btn btn-soft d-inline-flex align-items-center justify-content-center" type="button" data-action="checkout-jetpass"><i class="bi bi-lightning-charge me-2"></i>{lang key='website/sign/login-otc-cta'}</button>
                                                    {/if}
                                                </div>
                                                {if $jetpass_enabled}
                                                <p class="fs-8 text-body-secondary text-center mt-2 mb-0">{lang key='website/sign/login-otc-hint'}</p>
                                                <div class="mt-2" data-jetpass-captcha>{captcha area='jetpass'}</div>
                                                {/if}
                                            </div>
                                            {/if}
                                        </div>
                                    </div>
                                </div>

                                <div class="wui-collapse" data-account-live>
                                    <div class="wui-collapse-inner">
                                        <div data-account-live-body></div>
                                    </div>
                                </div>

                                {if $jetpass_enabled}
                                <div class="wui-collapse" data-account-codelogin>
                                    <div class="wui-collapse-inner">
                                        <div class="pt-1 checkout-codelogin">
                                            <div class="text-center mb-3">
                                                <i class="bi bi-envelope-paper fs-2 text-primary-emphasis lh-1" aria-hidden="true"></i>
                                                <h3 class="h6 fw-semibold mt-2 mb-1">{lang key='website/sign/codelogin-heading'}</h3>
                                                <p class="fs-8 text-body-secondary mb-0">{lang key='website/sign/codelogin-subtitle'} <span class="fw-semibold" data-role="codelogin-email"></span></p>
                                            </div>
                                            <fieldset class="mb-0">
                                                <legend class="visually-hidden">{lang key='website/sign/codelogin-legend'}</legend>
                                                <div class="otp-group" dir="ltr" data-checkout-otp>
                                                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="one-time-code" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 1">
                                                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 2">
                                                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 3">
                                                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 4">
                                                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 5">
                                                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 6">
                                                </div>
                                                <div class="invalid-feedback text-center mt-2" data-role="otp-feedback" data-msg-empty="{lang key='website/sign/codelogin-empty'}" data-msg-wrong="{lang key='website/sign/codelogin-invalid'}">{lang key='website/sign/codelogin-empty'}</div>
                                                <div class="valid-feedback text-center mt-2" data-role="otp-valid">{lang key='website/sign/otp-valid'}</div>
                                            </fieldset>
                                            <button class="btn btn-primary w-100 mt-3" type="button" data-action="checkout-otp-verify">{lang key='website/sign/codelogin-submit'}</button>
                                            <p class="fs-8 text-body-secondary text-center mt-3 mb-0"><button class="btn btn-link btn-sm p-0 fs-8 fw-semibold text-decoration-none align-baseline" type="button" data-action="checkout-otp-resend" disabled>{lang key='website/sign/otp-resend'}</button><span class="num-tabular" data-role="resend-timer"></span></p>
                                            <p class="fs-8 text-success fw-semibold text-center d-none mt-1 mb-0" data-role="resend-confirm"><i class="bi bi-check-circle me-1"></i>{lang key='website/sign/otp-resent'}</p>
                                            <p class="text-center fs-8 text-body-secondary mt-2 mb-0"><button class="btn btn-link btn-sm p-0 fs-8 fw-semibold text-decoration-none align-baseline" type="button" data-account-codelogin-back>{lang key='website/checkout/use-different'}</button></p>
                                        </div>
                                    </div>
                                </div>
                                {/if}
                                {/if}
                            </div>
                        </div>

                        <div>
                        <div class="card">
                            <div class="card-body p-4">
                                <div class="checkout-head">
                                    <span class="icon-disc"><i class="bi bi-geo-alt"></i></span>
                                    <div>
                                        <h2 class="h6 fw-semibold mb-0">{lang key='website/checkout/billing-title'}</h2>
                                        <p class="fs-8 text-body-secondary mb-0">{lang key='website/checkout/billing-sub'}</p>
                                    </div>
                                </div>

                                {if !$is_member}
                                <div class="wui-collapse{if $login_enabled} wui-show{/if}" data-billing-lock>
                                    <div class="wui-collapse-inner">
                                        <div class="pay-locked">
                                            <div class="pay-locked-blur" aria-hidden="true">
                                                <div class="row g-3 mb-3">
                                                    <div class="col-sm-6"><span class="basic-skeleton d-block mb-2" style="height:.8rem;width:35%"></span><span class="basic-skeleton d-block rounded" style="height:2.4rem"></span></div>
                                                    <div class="col-sm-6"><span class="basic-skeleton d-block mb-2" style="height:.8rem;width:35%"></span><span class="basic-skeleton d-block rounded" style="height:2.4rem"></span></div>
                                                </div>
                                                <span class="basic-skeleton d-block mb-2" style="height:.8rem;width:25%"></span>
                                                <span class="basic-skeleton d-block rounded mb-3" style="height:2.4rem"></span>
                                                <div class="row g-3 mb-3">
                                                    <div class="col-sm-6"><span class="basic-skeleton d-block mb-2" style="height:.8rem;width:35%"></span><span class="basic-skeleton d-block rounded" style="height:2.4rem"></span></div>
                                                    <div class="col-sm-6"><span class="basic-skeleton d-block mb-2" style="height:.8rem;width:35%"></span><span class="basic-skeleton d-block rounded" style="height:2.4rem"></span></div>
                                                </div>
                                                <div class="row g-3">
                                                    <div class="col-sm-6"><span class="basic-skeleton d-block mb-2" style="height:.8rem;width:35%"></span><span class="basic-skeleton d-block rounded" style="height:2.4rem"></span></div>
                                                    <div class="col-sm-6"><span class="basic-skeleton d-block mb-2" style="height:.8rem;width:35%"></span><span class="basic-skeleton d-block rounded" style="height:2.4rem"></span></div>
                                                </div>
                                            </div>
                                            <div class="pay-locked-overlay">
                                                <div class="pay-locked-card text-center">
                                                    <i class="bi bi-person-lock pay-locked-icon" aria-hidden="true"></i>
                                                    <p class="fw-semibold mb-1">{lang key='website/checkout/locked-title'}</p>
                                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/checkout/locked-body'}</p>
                                                    <button class="btn btn-primary" type="button" data-pay-locked-cta><i class="bi bi-box-arrow-in-right me-2"></i>{lang key='website/checkout/locked-login'}</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {/if}

                                <div class="wui-collapse{if $is_member || !$login_enabled} wui-show{/if}" data-billing-live>
                                    <div class="wui-collapse-inner">
                                        <div data-billing-live-body>
                                            {include file='views/checkout/section-billing.tpl'}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        {hook name='ui:client.checkout.billing.after'}

                        <div class="wui-collapse{if $is_member || !$login_enabled} wui-show{/if}" data-payment-live>
                            <div class="wui-collapse-inner">
                                <div class="pt-4" data-payment-live-body>
                                    {include file='views/checkout/section-payment.tpl'}
                                </div>
                            </div>
                        </div>
                        </div>

                    </div>
                </div>
            </div>
                <aside class="checkout-split-aside">
                    <div class="checkout-split-aside-inner">
                        <div class="order-summary">
                            <div class="card-body p-4">
                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <h2 class="h6 fw-semibold mb-0">{lang key='website/configure/order-summary'}</h2>
                                    <a class="fs-8 fw-semibold text-decoration-none" href="{link route='cart'}"><i class="bi bi-pencil me-1"></i>{lang key='website/checkout/edit-cart'}</a>
                                </div>

                                <div class="order-summary-items">
                                    {include file='views/checkout/section-rail-items.tpl'}
                                </div>

                                <hr class="summary-rule">
                                <div class="order-summary-line">
                                    <span class="summary-label">{lang key='website/cart/subtotal'}</span>
                                    <span class="summary-value num-tabular" data-role="subtotal">{$checkout_summary.subtotal_fmt}</span>
                                </div>

                                {if $checkout_summary.discounts.any}
                                {if $checkout_summary.discounts.promotions.rows}
                                <div class="order-summary-line">
                                    <span class="summary-label text-success-emphasis"><i class="bi bi-tags me-1"></i>{lang key='website/cart/summary-promotions'}</span>
                                    <span class="summary-value num-tabular text-success-emphasis">-{$checkout_summary.discounts.promotions.total_fmt}</span>
                                </div>
                                {/if}
                                {if $checkout_summary.discounts.reseller.rows}
                                <div class="order-summary-line">
                                    <span class="summary-label text-success-emphasis"><i class="bi bi-shop-window me-1"></i>{lang key='website/cart/summary-reseller'}</span>
                                    <span class="summary-value num-tabular text-success-emphasis">-{$checkout_summary.discounts.reseller.total_fmt}</span>
                                </div>
                                {/if}
                                {if $checkout_summary.discounts.group.rows}
                                <div class="order-summary-line">
                                    <span class="summary-label text-success-emphasis"><i class="bi bi-people me-1"></i>{lang key='website/cart/summary-group'}</span>
                                    <span class="summary-value num-tabular text-success-emphasis">-{$checkout_summary.discounts.group.total_fmt}</span>
                                </div>
                                {/if}
                                {foreach $checkout_summary.discounts.coupons as $c}
                                <div class="order-summary-line">
                                    <span class="summary-label text-success-emphasis"><i class="bi bi-tag me-1"></i>{$c.code}{if $c.rate_fmt} <span class="opacity-75">{$c.rate_fmt}</span>{/if}</span>
                                    <span class="summary-value num-tabular text-success-emphasis">-{$c.amount_fmt}</span>
                                </div>
                                {/foreach}
                                {/if}

                                <div class="wui-collapse{if $checkout_summary.tax_lines} wui-show{/if}" data-tax-group>
                                    <div class="wui-collapse-inner">
                                    {foreach $checkout_summary.tax_lines as $t}
                                    <div class="order-summary-line" data-tax-row>
                                        <span class="summary-label"><span data-role="row-label">{if $t.name}{$t.name}{else}{lang key='website/cart/summary-tax'}{/if}</span> <span class="opacity-75" data-role="tax-row-rate">{$t.rate_fmt}</span></span>
                                        <span class="summary-value num-tabular" data-role="tax-row-value">{$t.amount_fmt}</span>
                                    </div>
                                    {/foreach}
                                    </div>
                                </div>
                                <div class="wui-collapse" data-role="fee-collapse">
                                    <div class="wui-collapse-inner">
                                    <div class="order-summary-line" data-role="fee-line">
                                        <span class="summary-label">{lang key='website/checkout/payment-fee'} <span class="text-body-secondary" data-role="fee-label"></span></span>
                                        <span class="summary-value num-tabular" data-role="fee-value"></span>
                                    </div>
                                    </div>
                                </div>
                                <div class="wui-collapse" data-role="credit-collapse">
                                    <div class="wui-collapse-inner">
                                    <div class="order-summary-line" data-role="credit-line">
                                        <span class="summary-label text-success-emphasis"><i class="bi bi-wallet2 me-1"></i>{lang key='website/checkout/account-credit'}</span>
                                        <span class="summary-value num-tabular text-success-emphasis" data-role="credit-value"></span>
                                    </div>
                                    </div>
                                </div>
                                <div class="wui-collapse" data-role="installment-collapse">
                                    <div class="wui-collapse-inner">
                                    <div class="order-summary-line" data-role="installment-line">
                                        <span class="summary-label">{lang key='website/checkout/installment-fee'} <span class="text-body-secondary" data-role="installment-label"></span></span>
                                        <span class="summary-value num-tabular" data-role="installment-value"></span>
                                    </div>
                                    </div>
                                </div>

                                <hr class="summary-rule">
                                <div class="order-summary-line order-summary-total mb-0">
                                    <span class="summary-label">{lang key='website/configure/total-due'}</span>
                                    <span class="summary-value num-tabular" data-role="grand-total" data-base-total="{$checkout_summary.total_raw}">{$checkout_summary.total_fmt}</span>
                                </div>

                                <p class="fs-8 text-body-secondary mt-3 mb-0"><i class="bi bi-shield-lock me-1"></i>{lang key='website/checkout/secure-note'}</p>

                                {hook name='ui:client.checkout.summary.bottom'}
                            </div>
                        </div>
                    </div>
                </aside>
        </div>
    </form>

<template data-tpl="tax-row">
    <div class="order-summary-line" data-tax-row>
        <span class="summary-label"><span data-role="row-label"></span> <span class="opacity-75" data-role="tax-row-rate"></span></span>
        <span class="summary-value num-tabular" data-role="tax-row-value"></span>
    </div>
</template>

<div class="checkout-actionbar{if !$is_member && $login_enabled} d-none{/if}" data-checkout-actionbar>
    <div class="checkout-actionbar-inner">
        <span class="checkout-actionbar-total">
            <span class="checkout-actionbar-label">{lang key='website/configure/total-due'}</span>
            <span class="checkout-actionbar-value num-tabular" data-role="actionbar-total">{$checkout_summary.total_fmt}</span>
        </span>
        <button class="btn btn-primary checkout-actionbar-cta" type="submit" form="checkout-form"><i class="bi bi-lock-fill me-2"></i>{lang key='website/checkout/place-order'}</button>
    </div>
</div>

{/block}

{block name=body_end}{include file='components/dash-verify-modal.tpl'}{/block}
