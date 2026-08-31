<div class="dash-panel-head">
    <h2 class="dash-panel-title">{lang key='website/dashboard/panel-invoices'}</h2>
    <a class="dash-panel-link" href="{link route='invoices'}">{lang key='website/dashboard/view-all'}<i class="bi bi-arrow-right" aria-hidden="true"></i></a>
</div>
{if $dash_invoices}
<div data-dash-filled>
    {foreach $dash_invoices as $inv}
    <div class="dash-row">
        <div class="dash-row-main">
            <a class="dash-row-title" href="{$inv.link}">{$inv.number_label}</a>
            <span class="dash-row-sub num-tabular">{$inv.date_fmt} · {$inv.amount_fmt}</span>
        </div>
        {if $inv.badge == 'overdue'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/dashboard/inv-overdue'}</span>
        {elseif $inv.badge == 'unpaid'}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/dashboard/inv-unpaid'}</span>
        {elseif $inv.badge == 'refunded'}<span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/dashboard/inv-refunded'}</span>
        {elseif $inv.badge == 'cancelled'}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/dashboard/inv-cancelled'}</span>
        {else}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/dashboard/inv-paid'}</span>{/if}
        <a class="btn btn-sm btn-soft flex-shrink-0" href="{$inv.link}">{if !empty($inv.pay)}{lang key='website/dashboard/pay'}{else}{lang key='website/dashboard/view'}{/if}</a>
    </div>
    {/foreach}
</div>
{else}
<div class="dash-empty" data-dash-empty>
    <span class="dash-empty-ico"><i class="bi bi-receipt" aria-hidden="true"></i></span>
    <span class="dash-empty-title">{lang key='website/dashboard/empty-invoices-title'}</span>
    <span class="dash-empty-text">{lang key='website/dashboard/empty-invoices-text'}</span>
</div>
{/if}
