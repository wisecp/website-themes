{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/dashboard.css'}">
    <link rel="stylesheet" href="{asset path='css/dashboard-alt.css'}">
    <script src="{asset path='js/dashboard.js'}" defer></script>
{/block}

{block name=content}
<div class="dash" data-l10n='{$dash_l10n nofilter}'>
    <section class="pt-3 pb-4 pt-lg-3 pb-lg-5">
        <div class="container">
            {hook name='ui:client.dashboard.top'}
            <div class="row g-4">

                <div class="col-lg-3">
                    <aside class="dashx-rail dash-rise" aria-label="{lang key='website/dashboard/rail-aria'}">

                        <div class="dashx-card dashx-identity">
                            <span class="account-avatar-lg-wrap"><span class="account-avatar-lg">{if $account_info.avatar}<img class="account-avatar-img" src="{$account_info.avatar}" alt="">{elseif $account_info.initials}{$account_info.initials}{else}<i class="bi bi-person"></i>{/if}</span>{if $account_info.two_factor}<a class="account-avatar-shop" href="{link route='info'}#two-factor" data-bs-toggle="tooltip" title="{lang key='website/index/account-2fa-enabled'}" aria-label="{lang key='website/index/account-2fa-enabled'}"><i class="bi bi-shield-fill-check"></i></a>{/if}</span>
                            <span class="dashx-identity-name">{$account_info.full_name}</span>
                            <span class="dashx-identity-email">{$account_info.email}</span>
                            <a class="dashx-identity-link" href="{link route='info'}"><i class="bi bi-gear me-1" aria-hidden="true"></i>{lang key='website/index/account-settings'}</a>
                        </div>

                        {if $dash_balance}<div class="dashx-card dashx-balance">
                            <div class="dashx-balance-head">
                                <span class="dashx-balance-ico bg-primary-subtle text-primary-emphasis"><i class="bi bi-wallet2" aria-hidden="true"></i></span>
                                <div class="dashx-balance-text">
                                    <span class="dashx-balance-label">{lang key='website/dashboard/balance-label'}</span>
                                    <span class="dashx-balance-value num-tabular">{$dash_balance}</span>
                                </div>
                            </div>
                            <a class="btn btn-primary" href="{link route='balance'}#add-funds"><i class="bi bi-plus-lg me-1" aria-hidden="true"></i>{lang key='website/dashboard/balance-add'}</a>
                        </div>{/if}

                        {if $order_service_link || !empty($show_domains) || !empty($show_support) || !empty($show_invoices)}
                        <nav class="dashx-card dashx-quick" aria-label="{lang key='website/dashboard/quick-title'}">
                            <span class="dashx-quick-title">{lang key='website/dashboard/quick-title'}</span>
                            {if $order_service_link}<a class="dashx-quick-item" href="{$order_service_link}">
                                <span class="dashx-quick-ico bg-primary-subtle text-primary-emphasis"><i class="bi bi-plus-lg" aria-hidden="true"></i></span>
                                <span class="dashx-quick-label">{lang key='website/dashboard/quick-order'}</span>
                                <i class="bi bi-chevron-right dashx-quick-caret" aria-hidden="true"></i>
                            </a>{/if}
                            {if !empty($show_domains)}<a class="dashx-quick-item" href="{link route='domain'}">
                                <span class="dashx-quick-ico bg-info-subtle text-info-emphasis"><i class="bi bi-search" aria-hidden="true"></i></span>
                                <span class="dashx-quick-label">{lang key='website/dashboard/quick-domain'}</span>
                                <i class="bi bi-chevron-right dashx-quick-caret" aria-hidden="true"></i>
                            </a>{/if}
                            {if !empty($show_support)}<a class="dashx-quick-item" href="{link route='ticket-create'}">
                                <span class="dashx-quick-ico bg-success-subtle text-success-emphasis"><i class="bi bi-life-preserver" aria-hidden="true"></i></span>
                                <span class="dashx-quick-label">{lang key='website/dashboard/quick-ticket'}</span>
                                <i class="bi bi-chevron-right dashx-quick-caret" aria-hidden="true"></i>
                            </a>{/if}
                            {if !empty($show_invoices)}<a class="dashx-quick-item" href="{link route='invoices'}">
                                <span class="dashx-quick-ico bg-warning-subtle text-warning-emphasis"><i class="bi bi-receipt" aria-hidden="true"></i></span>
                                <span class="dashx-quick-label">{lang key='website/dashboard/quick-invoices'}</span>
                                <i class="bi bi-chevron-right dashx-quick-caret" aria-hidden="true"></i>
                            </a>{/if}
                        </nav>{/if}

                    </aside>
                </div>

                <div class="col-lg-9">
                    <div class="dashx-main">

                        <header class="dashx-head dash-rise dash-rise-1">
                            <div class="dashx-head-lead">
                                <span class="dash-eyebrow">{lang key='website/dashboard/eyebrow'}</span>
                                <h1 class="dashx-greeting">{$dash_greeting}</h1>
                            </div>
                            <p class="dash-health">
                                {if $dash_health}<span class="dash-pulse dash-pulse-{$dash_health.tone}" aria-hidden="true"></span>{$dash_health.text}{else}<span class="dash-pulse" aria-hidden="true"></span>{lang key='website/dashboard/health-ok'}{/if}
                            </p>
                        </header>

                        {if $dash_stats}
                        <div class="dashx-kpis">
                            {if !empty($show_services)}<a class="dashx-kpi" href="{link route='services'}">
                                <i class="bi bi-hdd-stack dash-stat-watermark text-primary-emphasis" aria-hidden="true"></i>
                                <span class="dashx-kpi-top">
                                    <span class="dashx-kpi-ico bg-primary-subtle text-primary-emphasis"><i class="bi bi-hdd-stack" aria-hidden="true"></i></span>
                                    <span class="dashx-kpi-label">{lang key='website/dashboard/kpi-services'}</span>
                                </span>
                                <span class="dashx-kpi-value num-tabular">{$dash_stats.services.active}</span>
                                {if $dash_stats.services.inactive > 0}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-dash-circle me-1"></i>{$dash_stats.services.inactive_label}</span>
                                {else}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/dashboard/kpi-all-active'}</span>{/if}
                            </a>{/if}
                            {if !empty($show_domains)}<a class="dashx-kpi" href="{link route='domains'}">
                                <i class="bi bi-globe2 dash-stat-watermark text-info-emphasis" aria-hidden="true"></i>
                                <span class="dashx-kpi-top">
                                    <span class="dashx-kpi-ico bg-info-subtle text-info-emphasis"><i class="bi bi-globe2" aria-hidden="true"></i></span>
                                    <span class="dashx-kpi-label">{lang key='website/dashboard/kpi-domains'}</span>
                                </span>
                                <span class="dashx-kpi-value num-tabular">{$dash_stats.domains.total}</span>
                                {if $dash_stats.domains.expiring > 0}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-exclamation-triangle me-1"></i>{$dash_stats.domains.expiring_label}</span>
                                {else}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/dashboard/kpi-all-active'}</span>{/if}
                            </a>{/if}
                            {if !empty($show_invoices)}<a class="dashx-kpi" href="{link route='invoices'}">
                                <i class="bi bi-receipt dash-stat-watermark text-warning-emphasis" aria-hidden="true"></i>
                                <span class="dashx-kpi-top">
                                    <span class="dashx-kpi-ico bg-warning-subtle text-warning-emphasis"><i class="bi bi-receipt" aria-hidden="true"></i></span>
                                    <span class="dashx-kpi-label">{lang key='website/dashboard/kpi-invoices'}</span>
                                </span>
                                <span class="dashx-kpi-value num-tabular">{$dash_stats.invoices.unpaid_fmt}</span>
                                {if $dash_stats.invoices.state == 'overdue'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-exclamation-circle me-1"></i>{$dash_stats.invoices.label}</span>
                                {elseif $dash_stats.invoices.state == 'unpaid'}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{$dash_stats.invoices.label}</span>
                                {else}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/dashboard/kpi-all-paid'}</span>{/if}
                            </a>{/if}
                            {if !empty($show_support)}<a class="dashx-kpi" href="{link route='tickets'}">
                                <i class="bi bi-life-preserver dash-stat-watermark text-success-emphasis" aria-hidden="true"></i>
                                <span class="dashx-kpi-top">
                                    <span class="dashx-kpi-ico bg-success-subtle text-success-emphasis"><i class="bi bi-life-preserver" aria-hidden="true"></i></span>
                                    <span class="dashx-kpi-label">{lang key='website/dashboard/kpi-tickets'}</span>
                                </span>
                                <span class="dashx-kpi-value num-tabular">{$dash_stats.tickets.open}</span>
                                <span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-collection me-1"></i>{$dash_stats.tickets.total_label}</span>
                            </a>{/if}
                        </div>
                        {/if}

                        {include file='components/dash-alerts.tpl'}

                        {if !empty($show_services)}<section class="dash-panel dash-rise dash-rise-3" aria-label="{lang key='website/dashboard/panel-services'}">
                            {include file='components/dash-services-panel.tpl' manage=true}
                        </section>{/if}

                        {if !empty($show_domains)}<section class="dash-panel dash-rise dash-rise-4" aria-label="{lang key='website/dashboard/panel-domains'}">
                            {include file='components/dash-domains-panel.tpl' manage=true}
                        </section>{/if}

                        {if !empty($show_invoices) || !empty($show_support)}<div class="dashx-subgrid dash-rise dash-rise-5">
                            {if !empty($show_invoices)}<section class="dash-panel" aria-label="{lang key='website/dashboard/panel-invoices'}">
                                {include file='components/dash-invoices-panel.tpl'}
                            </section>{/if}
                            {if !empty($show_support)}<section class="dash-panel" aria-label="{lang key='website/dashboard/panel-tickets'}">
                                {include file='components/dash-tickets-panel.tpl'}
                            </section>{/if}
                        </div>{/if}

                        {if !empty($show_activity)}<section class="dash-panel dash-rise dash-rise-6" aria-label="{lang key='website/dashboard/panel-activity'}">
                            {include file='components/dash-activity-panel.tpl'}
                        </section>{/if}

                        {hook name='ui:client.dashboard.panels.after'}

                    </div>
                </div>

            </div>
            {hook name='ui:client.dashboard.bottom'}
        </div>
    </section>
</div>
{/block}

{block name=body_end}{include file='components/dash-verify-modal.tpl'}{include file='components/dash-twofa-modal.tpl'}{include file='components/dash-password-modal.tpl'}{/block}
