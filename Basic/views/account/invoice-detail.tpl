{extends file='layouts/invoice.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/invoice-detail.css'}">
{/block}

{block name=scripts}
    <script src="{asset path='js/invoice-detail.js'}" defer
            data-lib-h2c="{asset path='js/libs/html2canvas-pro/html2canvas-pro.min.js'}"
            data-lib-jspdf="{asset path='js/libs/jspdf/jspdf.umd.min.js'}"
            data-txt-pdf-error="{lang key='website/invoices/detail/pdf-error'}"></script>
    {if $inv.payable && !$inv.sub_locked}<script src="{asset path='js/invoice-pay.js'}" defer></script>{/if}
{/block}

{block name=content}
<div class="container invoice-wrap py-4 py-lg-5">

    {hook name='ui:client.invoice_detail.top'}
    <div class="invoice-pagehead mb-4">
        <div>
            {if !$sharing}<a class="invoice-back" href="{$back_link}"><i class="bi bi-arrow-left me-1"></i>{lang key='website/invoices/detail/back'}</a>{/if}
        </div>
        <div class="d-flex flex-wrap gap-2">
            {if $permission_share}
            <div class="dropdown">
                <button type="button" class="btn btn-soft btn-sm dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"><i class="bi bi-share me-1"></i>{lang key='website/invoices/detail/share'}</button>
                <div class="dropdown-menu dropdown-menu-end invoice-share-menu p-3">
                    <label class="form-label fs-8 fw-semibold text-body-secondary mb-1" for="inv-share-link">{lang key='website/invoices/detail/share-label'}</label>
                    <div class="input-group input-group-sm">
                        <input type="text" class="form-control" id="inv-share-link" value="{$share_url}" readonly data-role="share-link">
                        <button class="btn btn-primary" type="button" data-action="copy" data-copy-text="{$share_url}" data-bs-toggle="tooltip" title="{lang key='website/invoices/detail/share-copy'}"><i class="bi bi-clipboard"></i></button>
                    </div>
                    <p class="form-text fs-8 mb-0 mt-2">{lang key='website/invoices/detail/share-hint'}</p>
                </div>
            </div>
            {/if}
            <button type="button" class="btn btn-soft btn-sm" data-action="print-invoice"><i class="bi bi-printer me-1"></i>{lang key='website/invoices/detail/print'}</button>
            <button type="button" class="btn btn-soft btn-sm" data-action="download-pdf" data-busy-text="{lang key='website/invoices/detail/preparing'}"><i class="bi bi-download me-1"></i>{lang key='website/invoices/detail/download-pdf'}</button>
        </div>
    </div>

    {if $pay_result == 'success' && !$inv.payable}
    <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
        <i class="bi bi-check-circle me-2" aria-hidden="true"></i>
        <div>{lang key='website/invoices/pay/result-success'}</div>
    </div>
    {elseif ($pay_result == 'partial' || $pay_result == 'success') && $inv.payable}
    <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
        <i class="bi bi-check-circle me-2" aria-hidden="true"></i>
        <div>{lang key='website/invoices/pay/result-partial'}</div>
    </div>
    {elseif $pay_result == 'bank'}
    <div class="alert alert-info d-flex align-items-center mb-4" role="alert">
        <i class="bi bi-bank me-2" aria-hidden="true"></i>
        <div>{lang key='website/invoices/pay/result-bank'}</div>
    </div>
    {elseif $pay_result == 'failed'}
    <div class="alert alert-danger text-start mb-4" role="alert">
        <div class="d-flex align-items-center">
            <i class="bi bi-exclamation-circle me-2 flex-shrink-0" aria-hidden="true"></i>
            <span>{lang key='website/invoices/pay/result-failed'}</span>
        </div>
        {if $pay_error}
        <div class="mt-2 pt-2 border-top border-danger-subtle fs-8">
            <span class="fw-semibold">{lang key='website/invoices/pay/result-failed-reason'}</span> {$pay_error}
        </div>
        {/if}
    </div>
    {/if}

    <div class="card invoice-card" id="inv-doc">
        <div class="card-body p-4 p-lg-5">

            <div class="invoice-doc-head">
                <span class="site-brand invoice-doc-brand{if !$invoice_logo_light_link && !$invoice_logo_dark_link} brand-no-logo{/if}">
                    {if $invoice_logo_light_link}<img src="{$invoice_logo_light_link}" alt="{$company_name}" class="site-logo site-logo-light">{/if}
                    {if $invoice_logo_dark_link}<img src="{$invoice_logo_dark_link}" alt="{$company_name}" class="site-logo site-logo-dark">{/if}
                    <span class="site-brand-text">{$company_name}</span>
                </span>
                <div class="invoice-doc-meta">
                    {if $inv.payable && !$inv.sub_locked}
                    <div class="invoice-doc-action d-print-none">
                        <button type="button" class="btn btn-primary btn-sm invoice-doc-pay" data-action="jump-to-payment"><i class="bi bi-credit-card me-1"></i>{lang key='website/invoices/pay-now'}</button>
                    </div>
                    {/if}
                    <div class="invoice-doc-stack">
                        <span class="invoice-doc-label">{lang key='website/invoices/detail/invoice-label'}</span>
                        <span class="invoice-doc-no num-tabular">{$inv.number}</span>
                        {if $inv.badge == 'paid'}<span class="badge bg-success-subtle text-success-emphasis fw-semibold"><i class="bi bi-check-circle me-1"></i>{lang key='website/invoices/st-paid'}</span>
                        {elseif $inv.badge == 'overdue'}<span class="badge bg-danger-subtle text-danger-emphasis fw-semibold"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/invoices/st-overdue'}</span>
                        {elseif $inv.badge == 'refunded'}<span class="badge bg-info-subtle text-info-emphasis fw-semibold"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/invoices/st-refunded'}</span>
                        {elseif $inv.badge == 'cancelled'}<span class="badge bg-secondary-subtle text-secondary-emphasis fw-semibold"><i class="bi bi-x-circle me-1"></i>{lang key='website/invoices/st-cancelled'}</span>
                        {elseif $inv.badge == 'waiting'}<span class="badge bg-info-subtle text-info-emphasis fw-semibold"><i class="bi bi-clock me-1"></i>{lang key='website/invoices/st-waiting'}</span>
                        {else}<span class="badge bg-warning-subtle text-warning-emphasis fw-semibold"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/invoices/st-unpaid'}</span>{/if}
                    </div>
                </div>
            </div>

            <dl class="invoice-facts">
                <div class="invoice-fact">
                    <dt>{lang key='website/invoices/detail/fact-invoice-date'}</dt>
                    <dd class="num-tabular">{$inv.issued_date}</dd>
                </div>
                {if $inv.due_date}
                <div class="invoice-fact">
                    <dt>{lang key='website/invoices/detail/fact-due-date'}</dt>
                    <dd class="num-tabular">{$inv.due_date}</dd>
                </div>
                {/if}
                <div class="invoice-fact">
                    <dt>{lang key='website/invoices/detail/fact-amount-due'}</dt>
                    <dd class="num-tabular invoice-fact-due">{$inv.amount_due}</dd>
                </div>
            </dl>

            {if $censored}
            <p class="invoice-censored-note fs-8 text-body-tertiary mb-2"><i class="bi bi-eye-slash me-1"></i>{lang key='website/invoices/detail/censored-info'}</p>
            {/if}

            <div class="invoice-parties">
                <div class="invoice-party">
                    <span class="invoice-party-label">{lang key='website/invoices/detail/from'}</span>
                    {if $parties.from.name}<span class="invoice-party-name">{$parties.from.name}</span>{/if}
                    {foreach $parties.from.lines as $l}<span class="invoice-party-line">{$l}</span>{/foreach}
                </div>
                <div class="invoice-party">
                    <span class="invoice-party-label">{lang key='website/invoices/detail/bill-to'}</span>
                    {if $parties.to.name}<span class="invoice-party-name">{$parties.to.name}</span>{/if}
                    {if $parties.to.contact}<span class="invoice-party-line">{$parties.to.contact}</span>{/if}
                    {foreach $parties.to.lines as $l}<span class="invoice-party-line">{$l}</span>{/foreach}
                    {if $parties.to.email}<span class="invoice-party-line">{$parties.to.email}</span>{/if}
                    {if $parties.to.tax}<span class="invoice-party-line">{lang key='website/invoices/detail/vat-reg'} {$parties.to.tax}</span>{/if}
                    {if $parties.to.identity}<span class="invoice-party-line">{lang key='website/invoices/detail/identity'} {$parties.to.identity}</span>{/if}
                    {foreach $custom_fields as $cf}<span class="invoice-party-line">{$cf.name}: {$cf.value}</span>{/foreach}
                </div>
            </div>

            <div class="table-responsive">
                <table class="table invoice-table align-middle mb-0">
                    <thead>
                        <tr>
                            <th scope="col">{lang key='website/invoices/detail/th-description'}</th>
                            <th scope="col" class="text-center">{lang key='website/invoices/detail/th-qty'}</th>
                            <th scope="col" class="text-end">{lang key='website/invoices/detail/th-unit'}</th>
                            <th scope="col" class="text-end">{lang key='website/invoices/detail/th-amount'}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $items as $it}
                        <tr>
                            <td{if $it.is_addon} class="invoice-item-addon"{/if}>
                                <span class="invoice-item-name">{if $it.is_addon}<i class="bi bi-arrow-return-right me-1 text-body-tertiary"></i>{/if}{$it.description}</span>
                                {if $it.sub}<span class="invoice-item-sub">{$it.sub}</span>{/if}
                            </td>
                            <td class="text-center num-tabular">{$it.qty}</td>
                            <td class="text-end num-tabular">{$it.unit_fmt}</td>
                            <td class="text-end num-tabular">{$it.amount_fmt}</td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
            {hook name='ui:client.invoice_detail.items_after'}

            <div class="invoice-summary">
                {if $inv.payable && !$inv.sub_locked && $coupon_open}
                <div class="invoice-coupon">
                    <label class="form-label" for="inv-coupon">{lang key='website/invoices/pay/coupon-title'}</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="inv-coupon" placeholder="{lang key='website/invoices/pay/coupon-placeholder'}" autocomplete="off" data-role="coupon-input">
                        <button class="btn btn-soft" type="button" data-action="apply-coupon" data-busy-text="{lang key='website/invoices/pay/coupon-applying'}">{lang key='website/invoices/pay/coupon-apply'}</button>
                    </div>
                    <div class="form-text fs-8" data-role="coupon-feedback">{lang key='website/invoices/pay/coupon-hint'}</div>
                </div>
                {/if}
                <div class="invoice-totals">
                    <div class="order-summary-line">
                        <span class="summary-label">{lang key='website/invoices/detail/subtotal'}</span>
                        <span class="summary-value num-tabular">{$summary.subtotal_fmt}</span>
                    </div>
                    {if $summary.reseller_show}
                    <div class="order-summary-line">
                        <span class="summary-label text-success-emphasis"><i class="bi bi-shop-window me-1"></i>{lang key='website/invoices/detail/reseller-discount'}</span>
                        <span class="summary-value num-tabular text-success-emphasis">-{$summary.reseller_fmt}</span>
                    </div>
                    {/if}
                    {if $summary.coupon_show}
                    <div class="order-summary-line">
                        <span class="summary-label text-success-emphasis"><i class="bi bi-tag me-1"></i>{lang key='website/invoices/detail/promo'}{if $summary.coupon_code} ({$summary.coupon_code}){/if}</span>
                        <span class="summary-value num-tabular text-success-emphasis">-{$summary.coupon_fmt}</span>
                    </div>
                    {/if}
                    {if $summary.service_show}
                    <div class="order-summary-line">
                        <span class="summary-label text-success-emphasis"><i class="bi bi-percent me-1"></i>{lang key='website/invoices/detail/service-discount'}</span>
                        <span class="summary-value num-tabular text-success-emphasis">-{$summary.service_fmt}</span>
                    </div>
                    {/if}
                    {if $summary.group_show}
                    <div class="order-summary-line">
                        <span class="summary-label text-success-emphasis"><i class="bi bi-people me-1"></i>{lang key='website/invoices/detail/group-discount'}</span>
                        <span class="summary-value num-tabular text-success-emphasis">-{$summary.group_fmt}</span>
                    </div>
                    {/if}
                    {if $summary.tax_show}
                    <div class="order-summary-line">
                        <span class="summary-label">{lang key='website/invoices/detail/vat'} ({$summary.tax_rate}%)</span>
                        <span class="summary-value num-tabular">{$summary.tax_fmt}</span>
                    </div>
                    {/if}
                    {if $summary.fee_show}
                    <div class="order-summary-line">
                        <span class="summary-label">{lang key='website/invoices/pay/fee-label'}{if $summary.fee_rate > 0} ({$summary.fee_rate}%){/if}</span>
                        <span class="summary-value num-tabular">{$summary.fee_fmt}</span>
                    </div>
                    {/if}
                    {if $summary.inst_show}
                    <div class="order-summary-line">
                        <span class="summary-label">{lang key='website/invoices/pay/installment-label' count=$summary.inst_count}</span>
                        <span class="summary-value num-tabular">{$summary.inst_fmt}</span>
                    </div>
                    {/if}
                    <div class="order-summary-line">
                        <span class="summary-label">{lang key='website/invoices/detail/total'}</span>
                        <span class="summary-value num-tabular">{$summary.total_fmt}</span>
                    </div>
                    {if $summary.paid_show}
                    <div class="order-summary-line">
                        <span class="summary-label">{lang key='website/invoices/detail/paid'}</span>
                        <span class="summary-value num-tabular text-success-emphasis">-{$summary.paid_fmt}</span>
                    </div>
                    {/if}
                    <div class="order-summary-line order-summary-total mb-0">
                        <span class="summary-label">{lang key='website/invoices/detail/balance-due'}</span>
                        <span class="summary-value num-tabular">{$summary.balance_fmt}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    {if $inv.badge == 'paid'}
    <div class="card invoice-pay-card invoice-status-card mt-4">
        <div class="card-body p-4">
            <div class="invoice-status-lead">
                <span class="icon-disc invoice-status-disc-success"><i class="bi bi-check-circle-fill"></i></span>
                <div class="me-auto">
                    <h3 class="h6 fw-semibold mb-0">{lang key='website/invoices/detail/status-paid-title'}</h3>
                    {if $inv.paid_date}<p class="fs-8 text-body-secondary mb-0">{lang key='website/invoices/detail/status-paid-on' date=$inv.paid_date}</p>{/if}
                </div>
                {if $taxed_download_url}<a href="{$taxed_download_url}" class="btn btn-soft btn-sm text-nowrap" download><i class="bi bi-file-earmark-pdf me-1"></i>{lang key='website/invoices/detail/taxed-download'}</a>{/if}
            </div>
        </div>
    </div>
    {elseif $inv.badge == 'refunded'}
    <div class="card invoice-pay-card invoice-status-card mt-4">
        <div class="card-body p-4">
            <div class="invoice-status-lead">
                <span class="icon-disc invoice-status-disc-info"><i class="bi bi-arrow-counterclockwise"></i></span>
                <div class="me-auto">
                    <h3 class="h6 fw-semibold mb-0">{lang key='website/invoices/detail/status-refunded-title'}</h3>
                    <p class="fs-8 text-body-secondary mb-0">{lang key='website/invoices/detail/status-refunded-desc'}</p>
                </div>
            </div>
        </div>
    </div>
    {elseif $inv.badge == 'cancelled'}
    <div class="card invoice-pay-card invoice-status-card mt-4">
        <div class="card-body p-4">
            <div class="invoice-status-lead">
                <span class="icon-disc invoice-status-disc-secondary"><i class="bi bi-x-circle"></i></span>
                <div class="me-auto">
                    <h3 class="h6 fw-semibold mb-0">{lang key='website/invoices/detail/status-cancelled-title'}</h3>
                    <p class="fs-8 text-body-secondary mb-0">{lang key='website/invoices/detail/status-cancelled-desc'}</p>
                </div>
            </div>
        </div>
    </div>
    {elseif $inv.badge == 'waiting'}
    <div class="card invoice-pay-card invoice-status-card mt-4">
        <div class="card-body p-4">
            <div class="invoice-status-lead">
                <span class="icon-disc invoice-status-disc-info"><i class="bi bi-clock"></i></span>
                <div class="me-auto">
                    <h3 class="h6 fw-semibold mb-0">{lang key='website/invoices/pay/status-waiting-title'}</h3>
                    <p class="fs-8 text-body-secondary mb-0">{lang key='website/invoices/pay/status-waiting-desc'}</p>
                    {if $bank_info}
                    <p class="fs-8 text-body-secondary mb-0 mt-1">
                        {if $bank_info.sender_name}{lang key='website/invoices/pay/bank-sender-label'}: <span class="fw-semibold">{$bank_info.sender_name}</span>{/if}
                        {if $bank_info.bank_name} · {$bank_info.bank_name}{/if}
                        {if $bank_info.rce} · {lang key='website/invoices/pay/bank-reference'}: <span class="num-tabular">{$bank_info.rce}</span>{/if}
                    </p>
                    {/if}
                </div>
            </div>
        </div>
    </div>
    {elseif $inv.payable && $inv.sub_locked}
    <div class="card invoice-pay-card invoice-status-card mt-4">
        <div class="card-body p-4">
            <div class="invoice-status-lead">
                <span class="icon-disc invoice-status-disc-info"><i class="bi bi-arrow-repeat"></i></span>
                <div class="me-auto">
                    <h3 class="h6 fw-semibold mb-0">{lang key='website/invoices/pay/status-subscription-title'}</h3>
                    <p class="fs-8 text-body-secondary mb-0">{lang key='website/invoices/pay/status-subscription-desc'}</p>
                </div>
                <a href="{$subscriptions_link}" class="btn btn-soft btn-sm text-nowrap"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/invoices/pay/status-subscription-link'}</a>
            </div>
        </div>
    </div>
    {elseif $inv.payable}
    <form data-invoice-pay{if $sharing} data-share-token="{$share_token}"{/if} action="{link route='invoices'}" method="post" novalidate
          data-txt-error="{lang key='website/invoices/pay/error-generic'}"
          data-txt-pay="{lang key='website/invoices/pay/pay-button'}"
          data-txt-pay-bank="{lang key='website/invoices/pay/bank-button'}"
          data-txt-pay-base="{lang key='website/invoices/detail/balance-due'}"
          data-txt-pay-base-partial="{lang key='website/invoices/pay/partial-label'}">
        <input type="hidden" name="id" value="{$inv.id}">
        {if $sharing}{csrf form='invoice-share'}{else}{csrf form='invoice-pay'}{/if}
        <div class="card invoice-pay-card mt-4" id="inv-pay">
            <div class="card-body p-4">
                <div class="invoice-pay-head">
                    <span class="icon-disc"><i class="bi bi-credit-card"></i></span>
                    <div>
                        <h3 class="h6 fw-semibold mb-0">{lang key='website/invoices/detail/pay-title'}</h3>
                        <p class="fs-8 text-body-secondary mb-0">{lang key='website/invoices/pay/pay-sub'}</p>
                    </div>
                </div>

                {if $payment_methods}
                {include file='components/payment-methods.tpl'}
                {include file='components/invoice-pay-footer.tpl'}
                {else}
                <div class="alert alert-warning d-flex align-items-center mb-0" role="alert">
                    <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                    <div>{lang key='website/invoices/pay/no-methods'}</div>
                </div>
                {/if}
            </div>
        </div>
    </form>
    {/if}

    {if $transactions}
    <div class="card invoice-txns-card mt-4">
        <div class="card-body">
            <button class="invoice-txns-toggle collapsed" type="button" data-wui-toggle data-wui-target="#invTxns" aria-expanded="false" aria-controls="invTxns">
                <span class="fw-semibold"><i class="bi bi-clock-history me-2"></i>{lang key='website/invoices/detail/transactions'}</span>
                <i class="bi bi-chevron-down invoice-txns-caret" aria-hidden="true"></i>
            </button>
            <div class="wui-collapse" id="invTxns">
                <div class="wui-collapse-inner">
                    <ul class="invoice-txns pt-3 mb-0">
                        {foreach $transactions as $t}
                        <li class="invoice-txn">
                            <span class="invoice-txn-ico {if $t.refund}invoice-txn-ico-info{else}invoice-txn-ico-success{/if}"><i class="bi {if $t.refund}bi-arrow-counterclockwise{else}bi-check-circle{/if}"></i></span>
                            <div class="invoice-txn-body">
                                <span class="invoice-txn-method">{$t.method}</span>
                                {if $t.date || $t.ref || $t.installments}<span class="invoice-txn-meta num-tabular">{$t.date}{if $t.ref} · {lang key='website/invoices/detail/ref'} {$t.ref}{/if}{if $t.installments} · {lang key='website/invoices/detail/txn-installments' n=$t.installments}{/if}</span>{/if}
                            </div>
                            {if $t.refund}<span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/invoices/detail/txn-refund'}</span>
                            {else}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/invoices/detail/txn-completed'}</span>{/if}
                            <span class="invoice-txn-amount num-tabular">{$t.amount_fmt}</span>
                        </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>
    </div>
    {hook name='ui:client.invoice_detail.transactions.after'}
    {/if}

    {if $notes}
    <div class="card invoice-message mt-4">
        <div class="card-body d-flex gap-3">
            <span class="icon-disc flex-shrink-0"><i class="bi bi-info-circle"></i></span>
            <div>
                <h3 class="h6 fw-semibold mb-1">{lang key='website/invoices/detail/message-title'}</h3>
                <p class="fs-7 text-body-secondary mb-0">{$notes|escape:'html'|nl2br nofilter}</p>
            </div>
        </div>
    </div>
    {/if}

    {if $special_note}
    <div class="mt-4 pt-3 border-top text-center">
        <p class="fs-7 text-body-secondary mb-0">{$special_note|escape:'html'|nl2br nofilter}</p>
    </div>
    {/if}

    {if $show_support}<p class="invoice-help">{lang key='website/invoices/detail/help-question'} <a href="{$support_link}">{lang key='website/invoices/detail/contact-support'}</a>.</p>{/if}

    {hook name='ui:client.invoice_detail.bottom'}
</div>
{/block}
