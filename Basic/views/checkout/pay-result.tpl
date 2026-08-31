{extends file='layouts/checkout.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/checkout.css'}">
{/block}

{block name=body_class} checkout-shell-centered{/block}

{block name=content}

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-12 col-md-10 col-lg-8 col-xl-7">

                <div class="card">
                    <div class="card-body p-4 p-sm-5 text-center">
                        {if $pay_guest_error}
                        <i class="bi bi-exclamation-circle text-warning checkout-result-icon" aria-hidden="true"></i>
                        <h1 class="h3 tracking-tight mt-3 mb-3">{lang key='website/payment/result-guest-error-title'}</h1>
                        <p class="text-body-secondary mb-4">{lang key='website/payment/result-guest-error-body'}</p>
                        {elseif $pay_success}
                        <i class="bi bi-check-circle text-success checkout-result-icon" aria-hidden="true"></i>
                        <h1 class="h3 tracking-tight mt-3 mb-3">{lang key='website/payment/result-success-title'}</h1>
                        <p class="text-body-secondary mb-4">{lang key='website/payment/result-success-body'}</p>
                        {else}
                        <i class="bi bi-x-circle text-danger checkout-result-icon" aria-hidden="true"></i>
                        <h1 class="h3 tracking-tight mt-3 mb-3">{lang key='website/payment/result-failed-title'}</h1>
                        <p class="text-body-secondary mb-4">{lang key='website/payment/result-failed-body'}</p>
                        {/if}

                        {if $pay_amount_fmt}
                        <div class="pay-detail-list mb-4">
                            <div class="pay-detail">
                                <span class="pay-detail-label">{if $pay_success}{lang key='website/payment/amount-paid'}{else}{lang key='website/payment/amount-due'}{/if}</span>
                                <span class="pay-detail-value ms-auto num-tabular">{$pay_amount_fmt}</span>
                            </div>
                            {if $pay_reference}
                            <div class="pay-detail">
                                <span class="pay-detail-label">{lang key='website/payment/reference-no'}</span>
                                <span class="pay-detail-value ms-auto num-tabular" data-pay-reference>#{$pay_reference}</span>
                            </div>
                            {/if}
                        </div>
                        {/if}

                        <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                            {if $pay_guest_error}
                            <a class="btn btn-primary" href="{link route='sign-in'}"><i class="bi bi-box-arrow-in-right me-2"></i>{lang key='website/payment/result-guest-error-login'}</a>
                            {else}
                            {if !$pay_success && $pay_retry_link}
                            <a class="btn btn-primary" href="{$pay_retry_link}"><i class="bi bi-arrow-clockwise me-2"></i>{lang key='website/payment/retry-payment'}</a>
                            {/if}
                            {if $pay_order_link}
                            <a class="btn {if $pay_success}btn-primary{else}btn-soft{/if}" href="{$pay_order_link}"><i class="bi bi-receipt me-2"></i>{lang key='website/payment/view-order'}</a>
                            {/if}
                            <a class="btn btn-soft" href="{link route='my-account'}"><i class="bi bi-speedometer2 me-2"></i>{lang key='website/checkout/complete/go-dashboard'}</a>
                            {/if}
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

{/block}
