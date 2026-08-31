<div class="d-flex flex-column gap-2" data-payment-methods
     data-txt-balance-shortfall="{lang key='website/checkout/balance-shortfall'}"
     data-txt-balance-available="{lang key='website/checkout/balance-available'}">
    {foreach $payment_methods as $m}
    <div class="payment-option"{if $m.kind == 'balance'} data-balance-option{/if}>
        <label class="payment-option-head">
            <input class="form-check-input" type="radio" name="pmethod" value="{$m.name}" data-fee-rate="{$m.fee_rate}"{if $m.kind == 'balance'} data-balance="{$m.balance_raw}"{/if}{if $m.name == $payment_default} checked{/if}>
            <span class="option-media">
                {if $m.icon_type == 'font'}<i class="{$m.icon}"></i>
                {elseif $m.icon_type == 'image'}<img src="{$m.icon}" alt="">
                {elseif $m.kind == 'paypal'}<i class="fa-brands fa-paypal"></i>
                {elseif $m.kind == 'bank'}<i class="bi bi-bank"></i>
                {elseif $m.kind == 'balance'}<i class="bi bi-wallet2"></i>
                {elseif $m.kind == 'card'}<i class="bi bi-credit-card-2-front"></i>
                {else}<i class="bi bi-globe2"></i>{/if}
            </span>
            <span class="me-auto">
                <span class="fw-semibold d-block">{$m.title}</span>
                {if $m.desc}<span class="fs-8 text-body-secondary">{$m.desc}</span>{/if}
            </span>
            {if $m.kind == 'card'}<span class="checkout-pay-icons" aria-hidden="true"><i class="fa-brands fa-cc-visa"></i><i class="fa-brands fa-cc-mastercard"></i><i class="fa-brands fa-cc-amex"></i></span>{/if}
            {if $m.kind == 'balance'}<span class="price-chip fw-semibold" data-role="balance-chip">{$m.balance_fmt}</span>
            {elseif $m.fee_rate > 0}<span class="price-chip fw-normal">+{$m.fee_rate}% {lang key='website/checkout/fee-suffix'}</span>{/if}
        </label>
        {if $m.kind == 'balance'}
        <div class="payment-option-foot" data-balance-foot>
            <span class="fs-8 text-body-secondary"><i class="bi bi-exclamation-circle me-1"></i><span data-role="balance-shortfall"></span></span>
            {if !empty($balance_addfunds_link)}<a class="btn btn-soft btn-sm ms-auto" href="{$balance_addfunds_link}"><i class="bi bi-plus-circle me-1"></i>{lang key='website/invoices/pay/add-funds'}</a>{/if}
        </div>
        {/if}
        <div class="wui-collapse{if $m.name == $payment_default} wui-show{/if}" data-method-panel="{$m.name}">
            <div class="wui-collapse-inner">
                <div class="payment-option-body">
                    {if $m.kind == 'bank'}
                    {if !empty($bank_reference)}
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                        <span class="form-label mb-0">{lang key='website/checkout/bank-accounts-label'}</span>
                        <span class="bank-reference">
                            <span class="bank-reference-label">{lang key='website/invoices/pay/bank-reference'}</span>
                            <span class="bank-reference-value num-tabular">{$bank_reference}</span>
                        </span>
                    </div>
                    {else}
                    <span class="form-label d-block mb-2">{lang key='website/checkout/bank-accounts-label'}</span>
                    {/if}
                    <div class="bank-account-grid" data-bank-accounts>
                        {foreach $m.bank_accounts as $b}
                        <div class="card bank-account">
                            <div class="bank-account-head">
                                {if $b.image}<img class="bank-logo" src="{$b.image}" alt="">{/if}
                                <span class="bank-account-name">{$b.name}</span>
                            </div>
                            {if $b.buyer_name}
                            <div class="bank-line">
                                <span class="bank-line-label">{lang key='website/checkout/bank-holder'}</span>
                                <span class="bank-line-value">{$b.buyer_name}</span>
                            </div>
                            {/if}
                            {if $b.iban}
                            <div class="bank-line">
                                <span class="bank-line-label">IBAN</span>
                                <span class="bank-line-value num-tabular">{$b.iban}</span>
                            </div>
                            {/if}
                            {if $b.account_number}
                            <div class="bank-line">
                                <span class="bank-line-label">{lang key='website/checkout/bank-account-no'}</span>
                                <span class="bank-line-value num-tabular">{$b.account_number}</span>
                            </div>
                            {/if}
                            {if $b.swift}
                            <div class="bank-line">
                                <span class="bank-line-label">SWIFT / BIC</span>
                                <span class="bank-line-value num-tabular">{$b.swift}</span>
                            </div>
                            {/if}
                        </div>
                        {/foreach}
                    </div>
                    {if !empty($bank_reference)}
                    <div class="row g-3 mt-1" data-bank-notify>
                        {if $m.bank_accounts}
                        <div class="col-sm-6">
                            <label class="form-label" for="inv-bank-account">{lang key='website/invoices/pay/bank-account-label'}</label>
                            <select class="form-select" id="inv-bank-account" data-role="bank-account">
                                {foreach $m.bank_accounts as $b}<option value="{$b.id}">{$b.name}</option>{/foreach}
                            </select>
                        </div>
                        {/if}
                        <div class="col-sm-6">
                            <label class="form-label" for="inv-bank-sender">{lang key='website/invoices/pay/bank-sender-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                            <input type="text" class="form-control" id="inv-bank-sender" data-role="bank-sender" autocomplete="name" placeholder="{lang key='website/invoices/pay/bank-sender-ph'}">
                            <div class="invalid-feedback">{lang key='website/invoices/pay/error-bank-sender'}</div>
                        </div>
                    </div>
                    {/if}
                    <p class="fs-8 text-body-secondary mt-3 mb-0"><i class="bi bi-info-circle me-1"></i>{if !empty($bank_note)}{$bank_note}{elseif !empty($bank_reference)}{lang key='website/invoices/pay/bank-note'}{else}{lang key='website/checkout/bank-note'}{/if}</p>
                    {elseif $m.kind == 'balance'}
                    <p class="fs-8 text-body-secondary mb-0" data-role="balance-note"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/balance-note'}</p>
                    {elseif $m.name == 'CreditCard' && $checkout_card && $checkout_card.inline}
                    <div data-card-pane
                         data-has-installments="{if $checkout_card.has_installments}1{else}0{/if}"
                         data-txt-paying="{lang key='website/payment/paying'}"
                         data-txt-error="{lang key='website/payment/error-generic'}">
                        {if $checkout_card.cards}
                        <div class="d-flex flex-column gap-2 mb-3" data-saved-cards id="coSavedCards">
                            <span class="form-label mb-0">{lang key='website/payment/saved-cards'}</span>
                            {foreach $checkout_card.cards as $c}
                            <div>
                                <label class="option-card option-card-radio option-card-sm d-flex align-items-center gap-3">
                                    <input class="form-check-input" type="radio" name="stored_card" value="{$c.id}"{if $c@first} checked{/if}>
                                    <span class="option-media">
                                        {if $c.schema == 'visa'}<i class="fa-brands fa-cc-visa"></i>
                                        {elseif $c.schema == 'mastercard'}<i class="fa-brands fa-cc-mastercard"></i>
                                        {elseif $c.schema == 'amex'}<i class="fa-brands fa-cc-amex"></i>
                                        {else}<i class="bi bi-credit-card-2-front"></i>{/if}
                                    </span>
                                    <span class="me-auto">
                                        <span class="fw-semibold d-block">{if $c.brand}{$c.brand} {/if}•••• {$c.ln4}</span>
                                        <span class="fs-8 text-body-secondary">{$c.name}{if $c.expiry} · {$c.expiry}{/if}</span>
                                    </span>
                                </label>
                                {if $checkout_card.can_autopay}
                                <div class="wui-collapse{if $c@first} wui-show{/if}" data-card-autopay="{$c.id}" data-wui-parent="#coSavedCards">
                                    <div class="wui-collapse-inner">
                                        <div class="form-check pt-2 card-autopay-check">
                                            <input class="form-check-input" type="checkbox" id="co-autopay-{$c.id}" value="1" data-stored-autopay{if $c.auto_pay} checked{/if}>
                                            <label class="form-check-label fs-7" for="co-autopay-{$c.id}">{lang key='website/payment/auto-pay'}</label>
                                        </div>
                                    </div>
                                </div>
                                {/if}
                            </div>
                            {/foreach}
                            <label class="option-card option-card-radio option-card-sm d-flex align-items-center gap-3">
                                <input class="form-check-input" type="radio" name="stored_card" value="new"{if !$checkout_card.cards} checked{/if}>
                                <span class="option-media"><i class="bi bi-plus-lg"></i></span>
                                <span class="fw-semibold">{lang key='website/payment/use-new-card'}</span>
                            </label>
                        </div>
                        {/if}
                        <div class="wui-collapse{if !$checkout_card.cards} wui-show{/if}" data-new-card>
                            <div class="wui-collapse-inner">
                                <div class="pt-1">
                                    {include file='components/checkout-card-fields.tpl' prefix='unified' can_store=$checkout_card.can_store can_autopay=$checkout_card.can_autopay}
                                </div>
                            </div>
                        </div>
                        {if $checkout_card.has_installments}
                        {include file='components/checkout-installments.tpl'}
                        {/if}
                        <div class="alert alert-danger d-flex align-items-center d-none mt-3 mb-0" role="alert" data-card-error>
                            <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                            <div data-role="card-error-text"></div>
                        </div>
                    </div>
                    {elseif $m.flow == 'merchant'}
                    <div data-card-pane
                         data-has-installments="{if $m.has_installments}1{else}0{/if}"
                         data-txt-paying="{lang key='website/payment/paying'}"
                         data-txt-error="{lang key='website/payment/error-generic'}">
                        {include file='components/checkout-card-fields.tpl' prefix=$m.name can_store=false can_autopay=false}
                        {if $m.has_installments}
                        {include file='components/checkout-installments.tpl'}
                        {/if}
                        <div class="alert alert-danger d-flex align-items-center d-none mt-3 mb-0" role="alert" data-card-error>
                            <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                            <div data-role="card-error-text"></div>
                        </div>
                    </div>
                    {elseif ($m.flow == 'area' || $m.flow == 'legacy') && !$m.embed}
                    <p class="fs-8 text-body-secondary mb-0"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/gateway-note'}</p>
                    {elseif $m.flow == 'area' || $m.flow == 'legacy'}
                    <div data-area-pane
                         data-txt-error="{lang key='website/checkout/area-error'}">
                        <div class="text-center py-3" data-role="area-loading">
                            <span class="spinner-border spinner-border-sm me-2 align-middle" role="status" aria-hidden="true"></span>
                            <span class="fs-8 text-body-secondary align-middle">{lang key='website/checkout/area-loading'}</span>
                        </div>
                        <div class="wui-collapse" data-role="area-content">
                            <div class="wui-collapse-inner">
                                <div class="pt-1" data-role="area-content-body"></div>
                            </div>
                        </div>
                        <p class="fs-8 text-body-secondary d-none mb-0" data-role="area-fallback"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/gateway-note'}</p>
                        <div class="alert alert-warning d-flex align-items-center d-none mb-0" role="alert" data-area-error>
                            <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                            <div data-role="area-error-text"></div>
                        </div>
                        {if !empty($terms_implied_html)}<p class="fs-8 text-body-secondary text-center d-none mt-3 mb-0" data-role="area-terms"><i class="bi bi-shield-check me-1"></i>{$terms_implied_html nofilter}</p>{/if}
                    </div>
                    {elseif $m.kind == 'card'}
                    <p class="fs-8 text-body-secondary mb-0"><i class="bi bi-shield-lock me-1"></i>{lang key='website/checkout/card-note'}</p>
                    {elseif $m.kind == 'paypal'}
                    <p class="fs-8 text-body-secondary mb-0"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/paypal-note'}</p>
                    {else}
                    <p class="fs-8 text-body-secondary mb-0"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/gateway-note'}</p>
                    {/if}
                </div>
            </div>
        </div>
    </div>
    {/foreach}

    {hook name='ui:client.checkout.methods.after'}
</div>

<template data-tpl="installment-row">
    <label class="option-card option-card-radio option-card-sm d-flex align-items-center gap-3">
        <input class="form-check-input" type="radio" name="installment">
        <span class="me-auto">
            <span class="fw-semibold d-block" data-role="inst-title"></span>
            <span class="badge bg-success-subtle text-success-emphasis d-none" data-role="inst-free"><i class="bi bi-check-circle me-1"></i>{lang key='website/payment/inst-free'}</span>
            <span class="fs-8 text-body-secondary d-none" data-role="inst-rate"></span>
        </span>
        <span class="inst-amounts">
            <span class="inst-col">
                <span class="fw-semibold num-tabular d-block" data-role="inst-monthly"></span>
                <span class="inst-col-label" data-role="inst-monthly-label"></span>
            </span>
            <span class="inst-col">
                <span class="num-tabular d-block text-body-secondary" data-role="inst-total"></span>
                <span class="inst-col-label" data-role="inst-total-label"></span>
            </span>
        </span>
    </label>
</template>
