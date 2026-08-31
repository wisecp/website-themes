{extends file='layouts/checkout.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/checkout.css'}">
{/block}

{block name=body_class} checkout-shell-centered{/block}

{block name=content}

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-12 col-md-10 col-lg-8 col-xl-7">

                {if $complete_state == 'bank'}
                <div data-result="bank-transfer">
                    <div class="card">
                        <div class="card-body p-4 p-sm-5 text-center">
                            <i class="bi bi-hourglass-split text-warning checkout-result-icon" aria-hidden="true"></i>
                            <h1 class="h3 tracking-tight mt-3 mb-2">{lang key='website/invoices/complete/bank-title'}</h1>
                            <p class="text-body-secondary mb-4">{lang key='website/invoices/complete/bank-body' number=$invoice_number}</p>

                            <div class="d-inline-flex align-items-baseline gap-2 mb-4">
                                <span class="text-body-secondary fs-7">{lang key='website/invoices/complete/amount-due'}</span>
                                <span class="h4 fw-bold num-tabular mb-0">{$amount_due_fmt}</span>
                            </div>

                            {if $bank_accounts}
                            <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                                <span class="fs-8 fw-semibold text-body-secondary text-uppercase">{lang key='website/invoices/complete/transfer-details'}</span>
                                <span class="bank-reference">
                                    <span class="bank-reference-label">{lang key='website/invoices/complete/reference'}</span>
                                    <span class="bank-reference-value num-tabular">{$bank_reference}</span>
                                    <button class="btn btn-link p-0 text-decoration-none lh-1" type="button" data-action="copy" data-copy-text="{$bank_reference}" data-bs-toggle="tooltip" title="{lang key='website/invoices/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </span>
                            </div>
                            {/if}
                            {foreach $bank_accounts as $b}
                            <div class="pay-detail-list mb-4">
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/invoices/complete/bank'}</span>
                                    <span class="pay-detail-value">{$b.name}</span>
                                    <button class="btn btn-ghost btn-sm ms-auto" type="button" data-action="copy" data-copy-text="{$b.name}" data-bs-toggle="tooltip" title="{lang key='website/invoices/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </div>
                                {if $b.buyer_name}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/checkout/bank-holder'}</span>
                                    <span class="pay-detail-value">{$b.buyer_name}</span>
                                    <button class="btn btn-ghost btn-sm ms-auto" type="button" data-action="copy" data-copy-text="{$b.buyer_name}" data-bs-toggle="tooltip" title="{lang key='website/invoices/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </div>
                                {/if}
                                {if $b.iban}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">IBAN</span>
                                    <span class="pay-detail-value num-tabular">{$b.iban}</span>
                                    <button class="btn btn-ghost btn-sm ms-auto" type="button" data-action="copy" data-copy-text="{$b.iban}" data-bs-toggle="tooltip" title="{lang key='website/invoices/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </div>
                                {/if}
                                {if $b.account_number}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/checkout/bank-account-no'}</span>
                                    <span class="pay-detail-value num-tabular">{$b.account_number}</span>
                                    <button class="btn btn-ghost btn-sm ms-auto" type="button" data-action="copy" data-copy-text="{$b.account_number}" data-bs-toggle="tooltip" title="{lang key='website/invoices/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </div>
                                {/if}
                                {if $b.swift}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">SWIFT / BIC</span>
                                    <span class="pay-detail-value num-tabular">{$b.swift}</span>
                                    <button class="btn btn-ghost btn-sm ms-auto" type="button" data-action="copy" data-copy-text="{$b.swift}" data-bs-toggle="tooltip" title="{lang key='website/invoices/complete/copy'}"><i class="bi bi-clipboard"></i></button>
                                </div>
                                {/if}
                            </div>
                            {/foreach}

                            <p class="fs-8 text-body-secondary text-start mb-4"><i class="bi bi-info-circle me-1"></i>{lang key='website/invoices/complete/bank-note'}</p>

                            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                                <a class="btn btn-primary" href="{link route='invoice-detail' p1=$invoice_id}"><i class="bi bi-receipt me-2"></i>{lang key='website/invoices/complete/view-invoice'}</a>
                                <a class="btn btn-soft" href="{$invoices_link}"><i class="bi bi-arrow-left me-2"></i>{lang key='website/invoices/complete/back-invoices'}</a>
                            </div>
                        </div>
                    </div>
                </div>

                {else}
                <div data-result="success">
                    <div class="card">
                        <div class="card-body p-4 p-sm-5 text-center">
                            <i class="bi bi-check-circle text-success checkout-result-icon" aria-hidden="true"></i>
                            <h1 class="h3 tracking-tight mt-3 mb-3">{lang key='website/invoices/complete/paid-title'}</h1>
                            <p class="text-body-secondary mb-4">{lang key='website/invoices/complete/paid-body' number=$invoice_number email=$account_email}</p>

                            <div class="pay-detail-list mb-4">
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/invoices/complete/invoice-number'}</span>
                                    <span class="pay-detail-value ms-auto num-tabular">{$invoice_number}</span>
                                </div>
                                {if $paid_method_name}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/invoices/complete/payment-method'}</span>
                                    <span class="pay-detail-value ms-auto">{$paid_method_name}</span>
                                </div>
                                {/if}
                                <div class="pay-detail">
                                    <span class="pay-detail-label">{lang key='website/invoices/complete/amount-paid'}</span>
                                    <span class="pay-detail-value ms-auto num-tabular">{$amount_paid_fmt}</span>
                                </div>
                            </div>

                            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                                <a class="btn btn-primary" href="{link route='invoice-detail' p1=$invoice_id}"><i class="bi bi-receipt me-2"></i>{lang key='website/invoices/complete/view-invoice'}</a>
                                <a class="btn btn-soft" href="{$invoices_link}"><i class="bi bi-arrow-left me-2"></i>{lang key='website/invoices/complete/back-invoices'}</a>
                            </div>
                        </div>
                    </div>
                </div>
                {/if}

            </div>
        </div>
    </div>

{/block}
