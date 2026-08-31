{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/dashboard.css'}">
    <script src="{asset path='js/dashboard.js'}" defer></script>
{/block}

{block name=content}
<div class="dash" data-l10n='{$dash_l10n nofilter}'>
    <section class="pt-3 pb-4 pt-lg-3 pb-lg-5">
        <div class="container">

            {hook name='ui:client.dashboard.top'}
            <div class="dash-hero dash-rise">
                <div class="dash-hero-inner">
                    <div class="dash-hero-lead">
                        <span class="dash-eyebrow">{lang key='website/dashboard/eyebrow'}</span>
                        <h1 class="dash-greeting">{$dash_greeting}</h1>
                        <p class="dash-health">
                            {if $dash_health}<span class="dash-pulse dash-pulse-{$dash_health.tone}" aria-hidden="true"></span>{$dash_health.text}{else}<span class="dash-pulse" aria-hidden="true"></span>{lang key='website/dashboard/health-ok'}{/if}
                        </p>
                        <div class="dash-hero-actions">
                            {if !empty($show_domains)}<a class="dash-btn-glass" href="{link route='domain'}"><i class="bi bi-search" aria-hidden="true"></i>{lang key='website/dashboard/act-register-domain'}</a>{/if}
                            {if $order_service_link}<a class="dash-btn-light" href="{$order_service_link}"><i class="bi bi-plus-lg" aria-hidden="true"></i>{lang key='website/dashboard/act-order-service'}</a>{/if}
                        </div>
                    </div>
                    {if $dash_balance}<div class="dash-balance-card">
                        <div class="dash-balance-main">
                            <span class="dash-balance-label">{lang key='website/dashboard/balance-label'}</span>
                            <span class="dash-balance-value num-tabular">{$dash_balance}</span>
                            <span class="dash-balance-note">{lang key='website/dashboard/balance-note'}</span>
                        </div>
                        <a class="dash-btn-light" href="{link route='balance'}#add-funds"><i class="bi bi-wallet2" aria-hidden="true"></i>{lang key='website/dashboard/balance-add'}</a>
                    </div>{/if}
                </div>
            </div>

            {if $dash_stats}
            <div class="dash-stats">
                {if !empty($show_services)}<a class="dash-stat dash-rise dash-rise-1" href="{link route='services'}">
                    <i class="bi bi-hdd-stack dash-stat-watermark text-primary-emphasis" aria-hidden="true"></i>
                    <div class="dash-stat-top">
                        <span class="dash-stat-ico bg-primary-subtle text-primary-emphasis"><i class="bi bi-hdd-stack" aria-hidden="true"></i></span>
                        <span class="dash-stat-label">{lang key='website/dashboard/kpi-services'}</span>
                    </div>
                    <span class="dash-stat-value num-tabular">{$dash_stats.services.active}</span>
                    <span class="dash-stat-foot">
                        {if $dash_stats.services.inactive > 0}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-dash-circle me-1"></i>{$dash_stats.services.inactive_label}</span>
                        {else}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/dashboard/kpi-all-active'}</span>{/if}
                    </span>
                </a>{/if}
                {if !empty($show_domains)}<a class="dash-stat dash-rise dash-rise-2" href="{link route='domains'}">
                    <i class="bi bi-globe2 dash-stat-watermark text-info-emphasis" aria-hidden="true"></i>
                    <div class="dash-stat-top">
                        <span class="dash-stat-ico bg-info-subtle text-info-emphasis"><i class="bi bi-globe2" aria-hidden="true"></i></span>
                        <span class="dash-stat-label">{lang key='website/dashboard/kpi-domains'}</span>
                    </div>
                    <span class="dash-stat-value num-tabular">{$dash_stats.domains.total}</span>
                    <span class="dash-stat-foot">
                        {if $dash_stats.domains.expiring > 0}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-exclamation-triangle me-1"></i>{$dash_stats.domains.expiring_label}</span>
                        {else}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/dashboard/kpi-all-active'}</span>{/if}
                    </span>
                </a>{/if}
                {if !empty($show_invoices)}<a class="dash-stat dash-rise dash-rise-3" href="{link route='invoices'}">
                    <i class="bi bi-receipt dash-stat-watermark text-warning-emphasis" aria-hidden="true"></i>
                    <div class="dash-stat-top">
                        <span class="dash-stat-ico bg-warning-subtle text-warning-emphasis"><i class="bi bi-receipt" aria-hidden="true"></i></span>
                        <span class="dash-stat-label">{lang key='website/dashboard/kpi-invoices'}</span>
                    </div>
                    <span class="dash-stat-value num-tabular">{$dash_stats.invoices.unpaid_fmt}</span>
                    <span class="dash-stat-foot">
                        {if $dash_stats.invoices.state == 'overdue'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-exclamation-circle me-1"></i>{$dash_stats.invoices.label}</span>
                        {elseif $dash_stats.invoices.state == 'unpaid'}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{$dash_stats.invoices.label}</span>
                        {else}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/dashboard/kpi-all-paid'}</span>{/if}
                    </span>
                </a>{/if}
                {if !empty($show_support)}<a class="dash-stat dash-rise dash-rise-4" href="{link route='tickets'}">
                    <i class="bi bi-life-preserver dash-stat-watermark text-success-emphasis" aria-hidden="true"></i>
                    <div class="dash-stat-top">
                        <span class="dash-stat-ico bg-success-subtle text-success-emphasis"><i class="bi bi-life-preserver" aria-hidden="true"></i></span>
                        <span class="dash-stat-label">{lang key='website/dashboard/kpi-tickets'}</span>
                    </div>
                    <span class="dash-stat-value num-tabular">{$dash_stats.tickets.open}</span>
                    <span class="dash-stat-foot">
                        <span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-collection me-1"></i>{$dash_stats.tickets.total_label}</span>
                    </span>
                </a>{/if}
            </div>
            {/if}

            {include file='components/dash-alerts.tpl'}

            <div class="dash-bento">
                {if !empty($show_services)}<section class="dash-panel b-md-8 b-lg-8 dash-rise dash-rise-1" aria-label="{lang key='website/dashboard/panel-services'}">
                    {include file='components/dash-services-panel.tpl' manage=false}
                </section>{/if}
                {if !empty($show_domains)}<section class="dash-panel b-md-4 b-lg-4 dash-rise dash-rise-2" aria-label="{lang key='website/dashboard/panel-domains'}">
                    {include file='components/dash-domains-panel.tpl' manage=false}
                </section>{/if}
                {if !empty($show_support)}<section class="dash-panel b-md-6 b-lg-5 dash-rise dash-rise-3" aria-label="{lang key='website/dashboard/panel-tickets'}">
                    {include file='components/dash-tickets-panel.tpl'}
                </section>{/if}
                {if !empty($show_invoices)}<section class="dash-panel b-lg-3 dash-rise dash-rise-4" aria-label="{lang key='website/dashboard/panel-invoices'}">
                    {include file='components/dash-invoices-panel.tpl'}
                </section>{/if}
                {if !empty($show_activity)}<section class="dash-panel b-md-6 b-lg-4 dash-rise dash-rise-5" aria-label="{lang key='website/dashboard/panel-activity'}">
                    {include file='components/dash-activity-panel.tpl'}
                </section>{/if}
                {hook name='ui:client.dashboard.panels.after'}
            </div>

            {hook name='ui:client.dashboard.bottom'}
        </div>
    </section>
</div>
{/block}

{block name=body_end}{include file='components/dash-verify-modal.tpl'}{include file='components/dash-twofa-modal.tpl'}{include file='components/dash-password-modal.tpl'}{/block}
