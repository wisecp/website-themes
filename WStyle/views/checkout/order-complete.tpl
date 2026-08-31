{extends file='layouts/checkout.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/checkout.css'}">
{/block}

{block name=body_class} checkout-shell-centered{/block}

{block name=content}

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-12 col-md-10 col-lg-8 col-xl-7">

                {if $complete_state == 'paid'}
                <div data-result="paid">
                    <div class="card">
                        <div class="card-body p-4 p-sm-5 text-center">
                            <i class="bi bi-check-circle text-success checkout-result-icon" aria-hidden="true"></i>
                            <h1 class="h3 tracking-tight mt-3 mb-3">{lang key='website/checkout/complete/paid-title'}</h1>
                            <p class="text-body-secondary mb-4">{lang key='website/checkout/complete/paid-body' email=$account_email number=$order_number}</p>
                            {if !empty($ordering_for)}
                            <p class="fs-8 fw-semibold text-warning-emphasis mb-4"><i class="bi bi-people-fill me-1"></i>{lang key='website/checkout/ordered-for' account=$ordering_for.name}</p>
                            {/if}


                            <div class="pay-detail-list mb-4">
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/checkout/complete/order-number'}</span>
                                    <span class="pay-detail-value ms-auto num-tabular">#{$order_number}</span>
                                </div>
                                {if $paid_method_name}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/checkout/complete/payment-method'}</span>
                                    <span class="pay-detail-value ms-auto">{$paid_method_name}</span>
                                </div>
                                {/if}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/checkout/complete/total-paid'}</span>
                                    <span class="pay-detail-value ms-auto num-tabular">{$order_total_fmt}</span>
                                </div>

                                {hook name='ui:client.order_complete.paid.details.end'}
                            </div>

                            <p class="fs-7 text-body-secondary mb-4"><i class="bi bi-rocket-takeoff me-1"></i>{lang key='website/checkout/complete/provisioning-note'}</p>

                            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                                <a class="btn btn-primary" href="{link route='my-account'}"><i class="bi bi-speedometer2 me-2"></i>{lang key='website/checkout/complete/go-dashboard'}</a>
                                {if $invoice_id}
                                <a class="btn btn-soft" href="{link route='invoice-detail' p1=$invoice_id}"><i class="bi bi-receipt me-2"></i>{lang key='website/checkout/complete/view-invoice'}</a>
                                {/if}
                            </div>

                            {hook name='ui:client.order_complete.paid.after'}
                        </div>
                    </div>
                </div>

                {elseif $complete_state == 'bank'}
                <div data-result="bank-transfer">
                    <div class="card">
                        <div class="card-body p-4 p-sm-5 text-center">
                            <i class="bi bi-hourglass-split text-warning checkout-result-icon" aria-hidden="true"></i>
                            <h1 class="h3 tracking-tight mt-3 mb-2">{lang key='website/checkout/complete/title'}</h1>
                            <p class="text-body-secondary mb-4">{lang key='website/checkout/complete/bank-body' number=$order_number}</p>

                            <div class="d-inline-flex align-items-baseline gap-2 mb-4">
                                <span class="text-body-secondary fs-7">{lang key='website/checkout/complete/amount-due'}</span>
                                <span class="h4 fw-bold num-tabular mb-0">{$order_total_fmt}</span>
                            </div>

                            {if $bank_accounts}
                            <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                                <span class="fs-8 fw-semibold text-body-secondary text-uppercase">{lang key='website/checkout/complete/transfer-details'}</span>
                                <span class="bank-reference">
                                    <span class="bank-reference-label">{lang key='website/checkout/complete/reference'}</span>
                                    <span class="bank-reference-value num-tabular">{$bank_reference}</span>
                                    <button class="btn btn-link p-0 text-decoration-none lh-1" type="button" data-action="copy" data-copy-text="{$bank_reference}" data-bs-toggle="tooltip" title="{lang key='website/checkout/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </span>
                            </div>
                            {/if}
                            {foreach $bank_accounts as $b}
                            <div class="pay-detail-list mb-4">
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/checkout/complete/bank'}</span>
                                    <span class="pay-detail-value">{$b.name}</span>
                                    <button class="btn btn-ghost btn-sm ms-auto" type="button" data-action="copy" data-copy-text="{$b.name}" data-bs-toggle="tooltip" title="{lang key='website/checkout/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </div>
                                {if $b.buyer_name}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/checkout/bank-holder'}</span>
                                    <span class="pay-detail-value">{$b.buyer_name}</span>
                                    <button class="btn btn-ghost btn-sm ms-auto" type="button" data-action="copy" data-copy-text="{$b.buyer_name}" data-bs-toggle="tooltip" title="{lang key='website/checkout/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </div>
                                {/if}
                                {if $b.iban}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">IBAN</span>
                                    <span class="pay-detail-value num-tabular">{$b.iban}</span>
                                    <button class="btn btn-ghost btn-sm ms-auto" type="button" data-action="copy" data-copy-text="{$b.iban}" data-bs-toggle="tooltip" title="{lang key='website/checkout/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </div>
                                {/if}
                                {if $b.account_number}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/checkout/bank-account-no'}</span>
                                    <span class="pay-detail-value num-tabular">{$b.account_number}</span>
                                    <button class="btn btn-ghost btn-sm ms-auto" type="button" data-action="copy" data-copy-text="{$b.account_number}" data-bs-toggle="tooltip" title="{lang key='website/checkout/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </div>
                                {/if}
                                {if $b.swift}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">SWIFT / BIC</span>
                                    <span class="pay-detail-value num-tabular">{$b.swift}</span>
                                    <button class="btn btn-ghost btn-sm ms-auto" type="button" data-action="copy" data-copy-text="{$b.swift}" data-bs-toggle="tooltip" title="{lang key='website/checkout/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </div>
                                {/if}
                            </div>
                            {/foreach}

                            <p class="fs-8 text-body-secondary text-start mb-4"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/complete/bank-note'}</p>

                            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                                <a class="btn btn-primary" href="{link route='my-account'}"><i class="bi bi-speedometer2 me-2"></i>{lang key='website/checkout/complete/go-dashboard'}</a>
                                {if $invoice_id}
                                <a class="btn btn-soft" href="{link route='invoice-detail' p1=$invoice_id}"><i class="bi bi-receipt me-2"></i>{lang key='website/checkout/complete/view-invoice'}</a>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>

                {else}
                <div data-result="received">
                    <div class="card">
                        <div class="card-body p-4 p-sm-5 text-center">
                            <i class="bi bi-hourglass-split text-warning checkout-result-icon" aria-hidden="true"></i>
                            <h1 class="h3 tracking-tight mt-3 mb-3">{lang key='website/checkout/complete/title'}</h1>
                            <p class="text-body-secondary mb-4">{lang key='website/checkout/complete/body' email=$account_email number=$order_number}</p>
                            {if !empty($ordering_for)}
                            <p class="fs-8 fw-semibold text-warning-emphasis mb-4"><i class="bi bi-people-fill me-1"></i>{lang key='website/checkout/ordered-for' account=$ordering_for.name}</p>
                            {/if}


                            {if $pay_failed}
                            <div class="alert alert-danger d-flex align-items-center text-start mb-4" role="alert">
                                <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                                <div>{lang key='website/checkout/complete/pay-failed-note'}</div>
                            </div>
                            {/if}

                            <div class="pay-detail-list mb-4">
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/checkout/complete/order-number'}</span>
                                    <span class="pay-detail-value ms-auto num-tabular">#{$order_number}</span>
                                </div>
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/checkout/complete/amount-due'}</span>
                                    <span class="pay-detail-value ms-auto num-tabular">{$order_total_fmt}</span>
                                </div>
                            </div>

                            <p class="fs-7 text-body-secondary mb-4"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/complete/pending-note'}</p>

                            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                                {if $resume_pay_link}
                                <a class="btn btn-primary" href="{$resume_pay_link}"><i class="bi bi-credit-card me-2"></i>{lang key='website/checkout/complete/complete-payment'}</a>
                                <a class="btn btn-soft" href="{link route='my-account'}"><i class="bi bi-speedometer2 me-2"></i>{lang key='website/checkout/complete/go-dashboard'}</a>
                                {else}
                                <a class="btn btn-primary" href="{link route='my-account'}"><i class="bi bi-speedometer2 me-2"></i>{lang key='website/checkout/complete/go-dashboard'}</a>
                                {/if}
                                {if $invoice_id}
                                <a class="btn btn-soft" href="{link route='invoice-detail' p1=$invoice_id}"><i class="bi bi-receipt me-2"></i>{lang key='website/checkout/complete/view-invoice'}</a>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
                {/if}

                {hook name='ui:client.order_complete.body.bottom'}

            </div>
        </div>
    </div>

{/block}
