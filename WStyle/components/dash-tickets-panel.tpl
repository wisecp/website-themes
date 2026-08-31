<div class="dash-panel-head">
    <h2 class="dash-panel-title">{lang key='website/dashboard/panel-tickets'}</h2>
    <div class="d-flex align-items-center gap-3">
        <a class="dash-panel-link dash-link-new" href="{link route='ticket-create'}"><i class="bi bi-plus-lg"></i>{lang key='website/dashboard/new'}</a>
        <a class="dash-panel-link" href="{link route='tickets'}">{lang key='website/dashboard/view-all'}<i class="bi bi-arrow-right" aria-hidden="true"></i></a>
    </div>
</div>
{if $dash_tickets}
<div data-dash-filled>
    {foreach $dash_tickets as $t}
    <div class="dash-row{if !empty($t.unread)} is-unread{/if}">
        <div class="dash-row-main">
            <a class="dash-row-title" href="{$t.link}">{$t.subject}</a>
            <span class="dash-row-sub">{$t.time_ago}</span>
        </div>
        {if $t.badge == 'answered'}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-chat-left-text me-1"></i>{lang key='website/dashboard/tk-answered'}</span>
        {elseif $t.badge == 'awaiting'}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/dashboard/tk-awaiting'}</span>
        {elseif $t.badge == 'closed'}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-lock me-1"></i>{lang key='website/dashboard/tk-closed'}</span>
        {else}<span class="badge bg-primary-subtle text-primary-emphasis"><i class="bi bi-envelope-open me-1"></i>{lang key='website/dashboard/tk-open'}</span>{/if}
    </div>
    {/foreach}
</div>
{else}
<div class="dash-empty" data-dash-empty>
    <span class="dash-empty-ico"><i class="bi bi-check2-circle" aria-hidden="true"></i></span>
    <span class="dash-empty-title">{lang key='website/dashboard/empty-tickets-title'}</span>
    <span class="dash-empty-text">{lang key='website/dashboard/empty-tickets-text'}</span>
</div>
{/if}
