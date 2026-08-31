{extends file='layouts/checkout.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/checkout.css'}">
{/block}

{block name=scripts}
    <script src="{asset path='js/pay.js'}" defer></script>
{/block}

{block name=body_class} checkout-shell-centered{/block}

{block name=content}

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-12 col-md-10 col-lg-8 col-xl-7">

                {hook name='ui:client.pay.body.top'}

                <div class="text-center mb-4">
                    <span class="eyebrow">{lang key='website/payment/pay-eyebrow'}</span>
                    <h1 class="h3 tracking-tight mt-1 mb-2">{lang key='website/payment/pay-title'}</h1>
                </div>

                {if $pay_failed && $pay_mode != 'error'}
                <div class="alert alert-warning d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle me-2" aria-hidden="true"></i>
                    <div>{lang key='website/payment/pay-failed-note'}</div>
                </div>
                {/if}

                {if $pay_mode == 'error'}
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                    <div>{if $pay_error}{$pay_error}{else}{lang key='website/payment/error-generic'}{/if}</div>
                </div>

                {elseif $pay_mode == 'card'}
                <form class="card" novalidate data-pay-card
                      data-capture-url="{$pay_capture_url}"
                      data-bin-url="{$pay_bin_url}"
                      data-chid="{$pay_chid}"
                      data-has-installments="{if $pay_has_installments}1{else}0{/if}"
                      data-txt-error="{lang key='website/payment/error-generic'}"
                      data-txt-paying="{lang key='website/payment/paying'}"
                      data-txt-inst-single="{lang key='website/payment/inst-single'}"
                      data-txt-inst-months="{lang key='website/payment/inst-months'}"
                      data-txt-inst-once="{lang key='website/payment/inst-once'}"
                      data-txt-inst-monthly="{lang key='website/payment/inst-monthly'}"
                      data-txt-inst-total="{lang key='website/payment/inst-total'}"
                      data-txt-inst-interest="{lang key='website/payment/inst-interest'}">
                    <div class="card-body p-4">
                        {csrf form='pay'}

                        {if $pay_stored_cards}
                        <div class="d-flex flex-column gap-2 mb-3" data-saved-cards id="paySavedCards">
                            <span class="form-label mb-0">{lang key='website/payment/saved-cards'}</span>
                            {foreach $pay_stored_cards as $c}
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
                            {/foreach}
                            <label class="option-card option-card-radio option-card-sm d-flex align-items-center gap-3">
                                <input class="form-check-input" type="radio" name="stored_card" value="new" data-new-card-trigger{if !$pay_stored_cards} checked{/if}>
                                <span class="option-media"><i class="bi bi-plus-lg"></i></span>
                                <span class="fw-semibold">{lang key='website/payment/use-new-card'}</span>
                            </label>
                        </div>
                        {/if}

                        <div class="wui-collapse{if !$pay_stored_cards} wui-show{/if}" data-new-card>
                            <div class="wui-collapse-inner">
                                <div class="pt-1">
                                    <div class="row g-4">
                                        <div class="col-lg-8">
                                            <div class="row g-3">
                                                <div class="col-12">
                                                    <label for="pay-card-number" class="form-label">{lang key='website/payment/card-number'} <span class="text-danger" aria-hidden="true">*</span></label>
                                                    <div class="input-group card-number-group">
                                                        <span class="input-group-text"><i class="bi bi-credit-card"></i></span>
                                                        <input type="text" class="form-control num-tabular" id="pay-card-number" name="number" inputmode="numeric" autocomplete="cc-number" placeholder="1234 5678 9012 3456" required>
                                                        <i class="fa-brands card-scheme-icon" data-role="card-scheme" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="invalid-feedback">{lang key='website/payment/error-card-number'}</div>
                                                </div>
                                                <div class="col-6">
                                                    <label for="pay-card-exp" class="form-label">{lang key='website/payment/card-expiry'} <span class="text-danger" aria-hidden="true">*</span></label>
                                                    <input type="text" class="form-control num-tabular" id="pay-card-exp" name="card_expiry" inputmode="numeric" autocomplete="cc-exp" placeholder="MM / YY" required>
                                                    <div class="invalid-feedback">{lang key='website/payment/error-card-expiry'}</div>
                                                </div>
                                                <div class="col-6">
                                                    <label for="pay-card-cvc" class="form-label">CVC <span class="text-danger" aria-hidden="true">*</span></label>
                                                    <input type="text" class="form-control num-tabular" id="pay-card-cvc" name="cvc" inputmode="numeric" autocomplete="cc-csc" placeholder="123" required>
                                                    <div class="invalid-feedback">{lang key='website/payment/error-card-cvc'}</div>
                                                </div>
                                                <div class="col-12">
                                                    <label for="pay-card-name" class="form-label">{lang key='website/payment/card-holder'} <span class="text-danger" aria-hidden="true">*</span></label>
                                                    <input type="text" class="form-control" id="pay-card-name" name="holder_name" autocomplete="cc-name" required>
                                                    <div class="invalid-feedback">{lang key='website/payment/error-card-holder'}</div>
                                                </div>
                                                {if $pay_can_store}
                                                <div class="col-12">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" id="pay-save-card" name="save_card" value="1">
                                                        <label class="form-check-label fs-7" for="pay-save-card">{lang key='website/payment/save-card'}</label>
                                                    </div>
                                                    {if $pay_can_autopay}
                                                    <div class="form-check mt-2">
                                                        <input class="form-check-input" type="checkbox" id="pay-autopay" name="auto_pay" value="1">
                                                        <label class="form-check-label fs-7" for="pay-autopay">{lang key='website/payment/auto-pay'}</label>
                                                    </div>
                                                    {/if}
                                                </div>
                                                {/if}
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="checkout-secure-cover">
                                                <i class="bi bi-shield-lock checkout-secure-cover-icon" aria-hidden="true"></i>
                                                <p class="fw-semibold mb-0">{lang key='website/payment/secure-title'}</p>
                                                <p class="fs-8 text-body-secondary mb-0">{lang key='website/payment/secure-sub'}</p>
                                                <ul class="checkout-secure-points">
                                                    <li><i class="bi bi-check2"></i>{lang key='website/payment/secure-point1'}</li>
                                                    <li><i class="bi bi-check2"></i>{lang key='website/payment/secure-point2'}</li>
                                                    <li><i class="bi bi-check2"></i>{lang key='website/payment/secure-point3'}</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="wui-collapse" data-installments>
                            <div class="wui-collapse-inner">
                                <div class="pt-2">
                                    <span class="form-label d-block mb-2">{lang key='website/payment/installments'}</span>
                                    <div class="d-flex flex-column gap-2" data-installment-list></div>
                                </div>
                            </div>
                        </div>

                        <div class="alert alert-danger d-flex align-items-center d-none mt-3 mb-0" role="alert" data-pay-error>
                            <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                            <div data-role="pay-error-text"></div>
                        </div>

                        <div class="d-grid mt-4">
                            <button class="btn btn-primary btn-lg" type="submit" data-pay-submit><i class="bi bi-lock-fill me-2"></i>{lang key='website/payment/pay-now'}<span class="checkout-pay-btn-amount num-tabular" data-role="pay-amount">{$pay_total_fmt}</span></button>
                        </div>
                        <p class="fs-8 text-body-secondary text-center mt-3 mb-0"><i class="bi bi-shield-lock me-1"></i>{lang key='website/checkout/secure-note'}</p>
                    </div>
                </form>

                {hook name='ui:client.pay.card.after'}

                {elseif $pay_mode == 'choices'}
                <div class="card">
                    <div class="card-body p-4 p-sm-5 text-center">
                        {include file='views/checkout/pay-choices.tpl'}
                    </div>
                </div>

                {else}
                <div class="card">
                    <div class="card-body p-4">
                        {$pay_html nofilter}
                    </div>
                </div>
                {/if}

                <p class="text-center mt-4 mb-0">
                    <a class="fs-7 fw-semibold text-decoration-none" href="{$pay_back_link}"><i class="bi bi-arrow-left me-1"></i>{lang key='website/payment/back-link'}</a>
                </p>

                {hook name='ui:client.pay.body.bottom'}

            </div>
        </div>
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

{/block}
