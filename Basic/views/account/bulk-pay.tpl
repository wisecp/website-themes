{extends file='layouts/invoice.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/invoice-detail.css'}">
{/block}

{block name=scripts}
    {if $bulk_rows}<script src="{asset path='js/invoice-pay.js'}" defer></script>{/if}
{/block}

{block name=content}
<div class="container invoice-wrap py-4 py-lg-5">

    <div class="invoice-pagehead mb-4 align-items-center">
        <a class="site-brand d-flex align-items-center{if $brand_no_logo} brand-no-logo{/if}" href="{link route='my-account'}">
            {if $light_logo_link}<img src="{$light_logo_link}" alt="{$company_name}" class="site-logo site-logo-light">{/if}
            {if $dark_logo_link}<img src="{$dark_logo_link}" alt="{$company_name}" class="site-logo site-logo-dark">{/if}
            <span class="site-brand-text">{$brand_wordmark}</span>
        </a>
        <a class="invoice-back" href="{$back_link}"><i class="bi bi-arrow-left me-1"></i>{lang key='website/invoices/bulk/back'}</a>
    </div>

    {if $pay_result == 'success'}
    <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
        <i class="bi bi-check-circle me-2" aria-hidden="true"></i>
        <div>{lang key='website/invoices/pay/result-success'}</div>
    </div>
    {elseif $pay_result == 'bank'}
    <div class="alert alert-info d-flex align-items-center mb-4" role="alert">
        <i class="bi bi-bank me-2" aria-hidden="true"></i>
        <div>{lang key='website/invoices/bulk/result-bank'}</div>
    </div>
    {elseif $pay_result == 'failed'}
    <div class="alert alert-danger d-flex align-items-center mb-4" role="alert">
        <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
        <div>{lang key='website/invoices/pay/result-failed'}</div>
    </div>
    {/if}

    {hook name='ui:client.bulk_pay.top'}

    {if $bulk_rows}
    <form data-invoice-pay data-bulk-pay action="{link route='invoices'}" method="post" novalidate
          data-txt-error="{lang key='website/invoices/pay/error-generic'}"
          data-txt-pay="{lang key='website/invoices/bulk/pay-button'}"
          data-txt-pay-bank="{lang key='website/invoices/pay/bank-button'}"
          data-txt-pay-base="{lang key='website/invoices/bulk/total-label'}"
          data-txt-count="{lang key='website/invoices/bulk/count'}"
          data-txt-count-one="{lang key='website/invoices/bulk/count-one'}"
          data-txt-zero-total="{$bulk_zero_fmt}">
        {csrf form='bulk-pay'}

        <div class="card" id="bulk-select">
            <div class="card-body p-4">
                <div class="invoice-pay-head">
                    <span class="icon-disc"><i class="bi bi-receipt-cutoff"></i></span>
                    <div>
                        <h2 class="h5 fw-semibold mb-0">{lang key='website/invoices/bulk/title'}</h2>
                        <p class="fs-8 text-body-secondary mb-0">{lang key='website/invoices/bulk/select-sub'}</p>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table invoice-table invoice-table-select align-middle mb-0">
                        <thead>
                            <tr>
                                <th scope="col"><span class="visually-hidden">{lang key='website/invoices/bulk/th-select'}</span></th>
                                <th scope="col">{lang key='website/invoices/bulk/th-invoice'}</th>
                                <th scope="col">{lang key='website/invoices/bulk/th-due'}</th>
                                <th scope="col" class="text-end">{lang key='website/invoices/bulk/th-amount'}</th>
                            </tr>
                        </thead>
                        <tbody data-bulk-invoices>
                            {foreach $bulk_rows as $row}
                            <tr>
                                <td><input class="form-check-input" type="checkbox" name="pay_invoice[]" value="{$row.id}" data-bulk-invoice data-amount="{$row.amount_raw}"{if $row.credit} data-credit="1"{/if}{if $row.selectable} checked{else} disabled{/if} aria-label="{lang key='website/invoices/bulk/aria-pay' number=$row.number}"></td>
                                <td>
                                    <a class="invoice-item-name text-decoration-none" href="{$row.link}">{$row.number}</a>
                                    {if $row.badge == 'overdue'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/invoices/st-overdue'}</span>
                                    {else}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/invoices/st-unpaid'}</span>{/if}
                                    {if !$row.selectable}<span class="fs-8 text-body-secondary d-block mt-1"><i class="bi bi-info-circle me-1"></i>{lang key='website/invoices/bulk/other-currency'}</span>{/if}
                                </td>
                                <td class="num-tabular">{$row.due_line}</td>
                                <td class="text-end num-tabular">{$row.amount_fmt}</td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>

                <div class="invoice-summary">
                    <div class="invoice-totals">
                        <div class="order-summary-line order-summary-total mb-0">
                            <span class="summary-label">{lang key='website/invoices/bulk/total-label'} (<span data-role="bulk-count">{$bulk_count_text}</span>)</span>
                            <span class="summary-value num-tabular" data-role="bulk-total">{$bulk_total_fmt}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card invoice-pay-card mt-4" id="bulk-pay">
            <div class="card-body p-4">
                <div class="invoice-pay-head">
                    <span class="icon-disc"><i class="bi bi-credit-card"></i></span>
                    <div>
                        <h3 class="h6 fw-semibold mb-0">{lang key='website/invoices/bulk/pay-title'}</h3>
                        <p class="fs-8 text-body-secondary mb-0">{lang key='website/invoices/pay/pay-sub'}</p>
                    </div>
                </div>

                {if $payment_methods}
                {include file='components/payment-methods.tpl'}
                {include file='components/invoice-pay-footer.tpl' show_partial=false}
                {else}
                <div class="alert alert-warning d-flex align-items-center mb-0" role="alert">
                    <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                    <div>{lang key='website/invoices/pay/no-methods'}</div>
                </div>
                {/if}
            </div>
        </div>
    </form>
    {else}
    <div class="basic-empty-state">
        <i class="bi bi-receipt" aria-hidden="true"></i>
        <span class="fw-semibold">{lang key='website/invoices/bulk/empty-title'}</span>
        <span class="fs-7">{lang key='website/invoices/bulk/empty-text'}</span>
        <a class="btn btn-primary btn-sm mt-1" href="{$back_link}"><i class="bi bi-arrow-left me-1"></i>{lang key='website/invoices/bulk/back'}</a>
    </div>
    {/if}

    {if $show_support}<p class="invoice-help">{lang key='website/invoices/bulk/help-question'} <a href="{$support_link}">{lang key='website/invoices/detail/contact-support'}</a>.</p>{/if}

</div>
{/block}
