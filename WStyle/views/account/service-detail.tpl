{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/service-detail.css'}">
    {if $service.type == 'software'}<link rel="stylesheet" href="{asset path='css/service-detail-software.css'}">{/if}
    {if $service.can_manage}<link rel="stylesheet" href="{asset path='css/service-management.css'}">{/if}
{/block}

{block name=scripts}
    {if $metering.show}<script src="{$sadress}assets/plugins/apexcharts/js/apexcharts.min.js" defer></script>{/if}
    <script src="{asset path='js/service-detail.js'}" defer></script>
    <script src="{asset path='js/service-transfer.js'}" defer></script>
    {if $service.can_manage}
        <script>window.resources_url="{$sadress}";window.themeDarkMode=(document.documentElement.getAttribute('data-bs-theme')==='dark');</script>
        <script src="{$badress}templates/admin/js/code-editor.js" defer></script>
        <script src="{asset path='js/libs/wcp-table/table.js'}" defer></script>
        <script src="{asset path='js/service-management.js'}" defer></script>
    {/if}
{/block}

{block name=content}
{assign var=s value=$service}
<section class="pt-4 pb-5">
    <div class="container" data-service-detail data-id="{$s.id}" data-op-url="{link route='services'}"
        data-cart-url="{$cart_op_url}" data-addons-currency="{$addons_currency}"
        data-txt-days-left="{lang key='website/services/days-left'}" data-txt-day-left="{lang key='website/services/days-left-one'}"
        data-txt-on="{lang key='website/services/on'}" data-txt-off="{lang key='website/services/off'}"
        data-txt-bill-default="{lang key='website/services/bill-profile-default'}"
        data-txt-cancel="{lang key='website/services/btn-cancel'}"
        data-sm-confirm-title="{lang key='website/services/sm-confirm-title'}"
        data-sm-sure-title="{lang key='website/services/sm-sure-title'}"
        data-sm-confirm="{lang key='website/services/sm-confirm'}"
        data-sm-delete="{lang key='website/services/sm-delete'}"
        data-txt-view-cart="{lang key='website/services/addon-view-cart'}"
        data-txt-addon-cancel-t="{lang key='website/services/addon-cancel-title'}"
        data-txt-addon-cancel-x="{lang key='website/services/addon-cancel-msg'}"
        data-txt-addon-cancel-ok="{lang key='website/services/addon-cancel-ok'}"
        data-txt-addon-revoke-t="{lang key='website/services/addon-revoke-title'}"
        data-txt-addon-revoke-x="{lang key='website/services/addon-revoke-msg'}"
        data-txt-addon-revoke-ok="{lang key='website/services/addon-revoke-ok'}"
        data-txt-addon-renews="{lang key='website/services/addon-renews-at'}"
        data-txt-renew-t="{lang key='website/services/renew-confirm-title'}"
        data-txt-renew-x="{lang key='website/services/renew-confirm-msg'}"
        data-txt-renew-ok="{lang key='website/services/renew-confirm-ok'}"
        data-txt-lt-cancel-t="{lang key='website/services/lt/cancel-confirm-title'}"
        data-txt-lt-cancel-x="{lang key='website/services/lt/cancel-confirm-msg'}"
        data-txt-lt-cancel-ok="{lang key='website/services/lt/btn-cancel'}"
        data-txt-reissue-t="{lang key='website/services/sw/reissue-confirm-title'}"
        data-txt-reissue-x="{lang key='website/services/sw/reissue-confirm-msg'}"
        data-txt-reissue-ok="{lang key='website/services/sw/reissue-confirm-ok'}"
        data-txt-mgmt-empty="{lang key='website/services/mgmt-empty'}"
        data-txt-mgmt-error="{lang key='website/services/mgmt-error'}">
        {csrf form='services'}

        <nav aria-label="{lang key='website/services/breadcrumb-aria'}">
            <ol class="breadcrumb mb-3">
                <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                <li class="breadcrumb-item"><a href="{link route='services'}">{lang key='website/services/title'}</a></li>
                <li class="breadcrumb-item active" aria-current="page">{$s.name}</li>
            </ol>
        </nav>

        {if $cancel.show}
        <div class="sd-alert sd-alert-danger{if !$cancel.open} d-none{/if}" data-role="service-request-alert" role="status">
            <span class="sd-alert-ico"><i class="bi bi-hourglass-split"></i></span>
            <div class="sd-alert-body">
                <span class="sd-alert-title" data-role="sreq-title">{if $cancel.state == 'approved'}{lang key='website/services/cancel/alert-t-scheduled'}{else}{lang key='website/services/cancel/alert-t-pending'}{/if}</span>
                <span class="sd-alert-text" data-role="sreq-text">{if $cancel.open}{if $cancel.urgency == 'now'}{lang key='website/services/cancel/desc-now'}{elseif $cancel.state == 'approved'}{lang key='website/services/cancel/desc-scheduled' date=$cancel.due}{else}{lang key='website/services/cancel/desc-pending' date=$cancel.due}{/if}{/if}</span>
            </div>
            <button type="button" class="btn btn-sm btn-outline-danger" data-action="show-tab" data-tab="sd-cancel-tab"><i class="bi bi-eye me-1"></i>{lang key='website/services/cancel/alert-review'}</button>
        </div>
        {/if}

        <header class="sd-hero">
            <div class="sd-hero-main">
                <div class="sd-hero-lead">
                    <span class="sd-hero-ico{if $s.icon.kind == 'logo'} sd-hero-ico-logo{/if}">
                        {if $s.icon.kind == 'logo'}<img src="{$s.icon.src}" alt="{$s.group_label}">{else}<i class="{$s.icon.class}"></i>{/if}
                    </span>
                    <div class="sd-hero-id">
                        <div class="sd-hero-titlerow">
                            <h1 class="sd-hero-title">{$s.name}</h1>
                            {if $s.badge == 'pending'}<span class="sd-status sd-status-pending"><i class="bi bi-clock"></i>{$s.status_label}</span>
                            {elseif $s.badge == 'suspended'}<span class="sd-status sd-status-suspended"><i class="bi bi-pause-circle"></i>{$s.status_label}</span>
                            {elseif $s.badge == 'expired'}<span class="sd-status sd-status-expired"><i class="bi bi-calendar-x"></i>{$s.status_label}</span>
                            {elseif $s.badge == 'cancelled'}<span class="sd-status sd-status-cancelled"><i class="bi bi-x-circle"></i>{$s.status_label}</span>
                            {else}<span class="sd-status sd-status-active"><i class="bi bi-check-circle"></i>{$s.status_label}</span>{/if}
                        </div>
                        <div class="sd-hero-meta">
                            {if $s.visit_link}
                            <a class="sd-hero-domain" href="{$s.visit_link}" target="_blank" rel="noopener">{$s.host}<i class="bi bi-box-arrow-up-right" aria-hidden="true"></i></a>
                            <span class="sd-dot" aria-hidden="true"></span>
                            {/if}
                            {if $s.order_id}
                            <span class="sd-hero-orderid num-tabular">{lang key='website/services/order-no'} #{$s.order_number}</span>
                            <span class="sd-dot" aria-hidden="true"></span>
                            {/if}
                            <span class="list-chip"><i class="{$s.type_icon}"></i>{$s.group_label}</span>
                        </div>
                    </div>
                </div>
                {if $s.renew_ok || $s.has_management || $updown.visible || $lt.visible || $serviceTransferTab || $cancel.show}
                <div class="sd-hero-actions">
                    {if $s.has_management}
                    <button type="button" class="btn btn-primary btn-sm" data-action="show-tab" data-tab="sd-management-tab"><i class="bi bi-gear me-1"></i>{lang key='website/services/manage'}</button>
                    {/if}
                    {if $s.renew_ok}
                        {if $s.renew_open_invoice}
                        <button type="button" class="btn btn-secondary btn-sm" data-action="renew-service" data-id="{$s.id}" data-open-invoice="{$s.renew_open_invoice}"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/services/renew'}</button>
                        {elseif $s.renew_cycles}
                        <div class="dropdown">
                            <button type="button" class="btn btn-secondary btn-sm dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/services/renew'}</button>
                            <ul class="dropdown-menu dropdown-menu-end sd-menu sd-renew-menu">
                                <li><h6 class="dropdown-header">{lang key='website/services/renew-for'}</h6></li>
                                {foreach $s.renew_cycles as $rc}
                                <li><button type="button" class="dropdown-item sd-renew-opt" data-action="renew-period" data-id="{$s.id}" data-period="{$rc.period}" data-period-time="{$rc.period_time}" data-label="{$rc.label}" data-price="{$rc.price_fmt}"><span class="sd-renew-opt-label">{$rc.label}{if $rc.save_text}<span class="sd-renew-save">{$rc.save_text}</span>{/if}</span><span class="sd-renew-opt-price num-tabular">{if $rc.gross_fmt}<s class="text-body-secondary me-1">{$rc.gross_fmt}</s>{/if}{$rc.price_fmt}</span></button></li>
                                {/foreach}
                                {if $s.tax_inclusive}<li><span class="dropdown-item-text fs-8 text-body-secondary" data-tax-incl>{lang key='website/services/updown/pc-tax-included'}</span></li>{/if}
                            </ul>
                        </div>
                        {/if}
                    {/if}
                    {if $updown.visible || $lt.visible || $serviceTransferTab || $cancel.show}
                    <div class="dropdown">
                        <button class="btn btn-soft btn-sm" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/services/more-actions'}"><i class="bi bi-three-dots"></i></button>
                        <ul class="dropdown-menu dropdown-menu-end sd-menu">
                            {if $updown.visible}<li><button type="button" class="dropdown-item" data-action="show-tab" data-tab="sd-upgrade-tab"><i class="bi bi-arrow-down-up"></i>{lang key='website/services/updown/tab'}</button></li>{/if}
                            {if $lt.visible}<li><button type="button" class="dropdown-item" data-action="show-tab" data-tab="sd-transfer-tab"><i class="bi bi-arrow-left-right"></i>{lang key='website/services/lt/tab'}</button></li>{/if}
                            {if $serviceTransferTab}<li><button type="button" class="dropdown-item" data-action="show-tab" data-tab="sd-service-transfer-tab"><i class="bi bi-people"></i>{lang key='website/services/service-transfer/tab'}</button></li>{/if}
                            {if $cancel.show}{if $updown.visible || $lt.visible || $serviceTransferTab}<li><hr class="dropdown-divider"></li>{/if}<li><button type="button" class="dropdown-item text-danger" data-action="show-tab" data-tab="sd-cancel-tab"><i class="bi bi-x-circle"></i>{lang key='website/services/cancel/tab'}</button></li>{/if}
                        </ul>
                    </div>
                    {/if}
                    {hook name='ui:client.service_detail.hero.actions.end'}
                </div>
                {/if}
            </div>
            <div class="sd-hero-foot">
                <dl class="sd-facts">
                    <div class="sd-fact">
                        <dt>{lang key='website/services/f-price'}</dt>
                        <dd class="num-tabular">{if $s.renew_skipped}-{else}{$s.amount}{if $s.cycle_short}<span class="sd-fact-unit">/{$s.cycle_short}</span>{/if}{if $s.tax_inclusive}<span class="sd-fact-unit d-block" data-tax-incl>{lang key='website/services/updown/pc-tax-included'}</span>{/if}{/if}</dd>
                    </div>
                    {if $s.cycle}
                    <div class="sd-fact">
                        <dt>{lang key='website/services/f-cycle'}</dt>
                        <dd>{$s.cycle}</dd>
                    </div>
                    {/if}
                    <div class="sd-fact">
                        <dt>{lang key='website/services/f-created'}</dt>
                        <dd class="num-tabular">{if $s.created}{$s.created}{else}-{/if}</dd>
                    </div>
                    <div class="sd-fact">
                        <dt>{lang key='website/services/f-autorenew'}</dt>
                        <dd>
                            {if $s.sub_blocked}
                            <a href="{$s.subscriptions_link}" class="badge bg-success-subtle text-success-emphasis text-decoration-none" title="{lang key='website/services/autorenew-subscription-note'}"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/services/autorenew-subscription'}</a>
                            {elseif $s.actionable && $s.account_autopay}
                            <div class="form-check form-switch sd-switch-inline m-0" data-bs-toggle="tooltip" title="{lang key='website/account/autorenew-locked-account'}">
                                <input class="form-check-input" type="checkbox" role="switch" id="sd-autorenew-hero" checked disabled aria-label="{lang key='website/services/autorenew-aria'}">
                                <span class="sd-switch-state">{lang key='website/services/on'}</span>
                            </div>
                            {elseif $s.actionable}
                            <div class="form-check form-switch sd-switch-inline m-0">
                                <input class="form-check-input" type="checkbox" role="switch" id="sd-autorenew-hero" data-action="toggle-autorenew" data-id="{$s.id}" aria-label="{lang key='website/services/autorenew-aria'}"{if $s.autorenew} checked{/if}>
                                <span class="sd-switch-state" data-role="autorenew-state">{if $s.autorenew}{lang key='website/services/on'}{else}{lang key='website/services/off'}{/if}</span>
                            </div>
                            {else}
                            <span class="badge {if $s.autorenew}bg-success-subtle text-success-emphasis{else}bg-secondary-subtle text-secondary-emphasis{/if}"><i class="bi {if $s.autorenew}bi-arrow-repeat{else}bi-dash-circle{/if} me-1"></i>{if $s.autorenew}{lang key='website/services/on'}{else}{lang key='website/services/off'}{/if}</span>
                            {/if}
                        </dd>
                    </div>
                </dl>
                {if $s.due_iso && $s.start_iso}
                <div class="sd-renew" data-start="{$s.start_iso}" data-due="{$s.due_iso}" data-today="{$s.today_iso}">
                    <div class="sd-renew-head">
                        <span class="sd-renew-label"><i class="bi bi-calendar-check me-1"></i>{lang key='website/services/renews-on'} {$s.expires}</span>
                        <span class="sd-renew-rem num-tabular" data-role="renew-rem"></span>
                    </div>
                    <div class="progress progress-thin" role="progressbar" aria-label="{lang key='website/services/term-elapsed-aria'}" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                        <div class="progress-bar" data-role="renew-bar"></div>
                    </div>
                </div>
                {/if}
            </div>
        </header>

        <div class="card sd-tabcard">
            <div class="card-header sd-tabbar" data-scroll-prev="{lang key='needs/tabs-scroll-prev'}" data-scroll-next="{lang key='needs/tabs-scroll-next'}">
                <ul class="nav sd-segtabs" role="tablist" data-wstyle-tabs="service-detail">
                    <li class="nav-item" role="presentation"><button class="nav-link active" id="sd-overview-tab" data-tab-hash="overview" data-bs-toggle="tab" data-bs-target="#sd-overview" type="button" role="tab" aria-controls="sd-overview" aria-selected="true"><i class="bi bi-grid-1x2 me-1"></i>{lang key='website/services/tab-overview'}</button></li>
                    {if $s.has_management}<li class="nav-item" role="presentation"><button class="nav-link" id="sd-management-tab" data-tab-hash="management" data-bs-toggle="tab" data-bs-target="#sd-management" type="button" role="tab" aria-controls="sd-management" aria-selected="false"><i class="bi bi-hdd-stack me-1"></i>{lang key='website/services/tab-management'}</button></li>{/if}
                    {if $lt.visible}<li class="nav-item" role="presentation"><button class="nav-link" id="sd-transfer-tab" data-tab-hash="license-transfer" data-bs-toggle="tab" data-bs-target="#sd-transfer" type="button" role="tab" aria-controls="sd-transfer" aria-selected="false"><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/services/lt/tab'}</button></li>{/if}
                    {if $s.blocks}<li class="nav-item" role="presentation"><button class="nav-link" id="sd-extra-tab" data-tab-hash="extra" data-bs-toggle="tab" data-bs-target="#sd-extra" type="button" role="tab" aria-controls="sd-extra" aria-selected="false"><i class="bi bi-info-square me-1"></i>{lang key='website/services/tab-extra'}</button></li>{/if}
                    {if $addons_owned || $addons_available}<li class="nav-item" role="presentation"><button class="nav-link" id="sd-addons-tab" data-tab-hash="addons" data-bs-toggle="tab" data-bs-target="#sd-addons" type="button" role="tab" aria-controls="sd-addons" aria-selected="false"><i class="bi bi-puzzle me-1"></i>{lang key='website/services/tab-addons'}</button></li>{/if}
                    {if $req_config || $req_details}<li class="nav-item" role="presentation"><button class="nav-link" id="sd-requirements-tab" data-tab-hash="requirements" data-bs-toggle="tab" data-bs-target="#sd-requirements" type="button" role="tab" aria-controls="sd-requirements" aria-selected="false"><i class="bi bi-card-checklist me-1"></i>{lang key='website/services/tab-requirements'}</button></li>{/if}
                    {if $updown.visible}<li class="nav-item" role="presentation"><button class="nav-link" id="sd-upgrade-tab" data-tab-hash="upgrade" data-bs-toggle="tab" data-bs-target="#sd-upgrade" type="button" role="tab" aria-controls="sd-upgrade" aria-selected="false"><i class="bi bi-arrow-down-up me-1"></i>{lang key='website/services/updown/tab'}</button></li>{/if}
                    <li class="nav-item" role="presentation"><button class="nav-link" id="sd-billing-tab" data-tab-hash="billing" data-bs-toggle="tab" data-bs-target="#sd-billing" type="button" role="tab" aria-controls="sd-billing" aria-selected="false"><i class="bi bi-receipt me-1"></i>{lang key='website/services/tab-billing'}</button></li>
                    {if $metering.show}<li class="nav-item" role="presentation"><button class="nav-link" id="sd-metering-tab" data-tab-hash="metrics" data-bs-toggle="tab" data-bs-target="#sd-metering" type="button" role="tab" aria-controls="sd-metering" aria-selected="false"><i class="bi bi-speedometer2 me-1"></i>{lang key='website/services/metering/tab'}</button></li>{/if}
                    {if $serviceTransferTab}<li class="nav-item" role="presentation"><button class="nav-link" id="sd-service-transfer-tab" data-tab-hash="service-transfer" data-bs-toggle="tab" data-bs-target="#sd-service-transfer" type="button" role="tab" aria-controls="sd-service-transfer" aria-selected="false"><i class="bi bi-people me-1"></i>{lang key='website/services/service-transfer/tab'}</button></li>{/if}
                    <li class="nav-item" role="presentation"><button class="nav-link" id="sd-activity-tab" data-tab-hash="activity" data-bs-toggle="tab" data-bs-target="#sd-activity" type="button" role="tab" aria-controls="sd-activity" aria-selected="false"><i class="bi bi-clock-history me-1"></i>{lang key='website/services/tab-activity'}</button></li>
                    {if $cancel.show}<li class="nav-item" role="presentation"><button class="nav-link" id="sd-cancel-tab" data-tab-hash="cancel" data-bs-toggle="tab" data-bs-target="#sd-cancel" type="button" role="tab" aria-controls="sd-cancel" aria-selected="false"><i class="bi bi-x-circle me-1"></i>{lang key='website/services/cancel/tab'}</button></li>{/if}
                    {hook name='ui:client.service_detail.tabs.end'}
                </ul>
            </div>
            <div class="card-body sd-panes">
                <div class="tab-content">

                    <div class="tab-pane fade show active" id="sd-overview" role="tabpanel" aria-labelledby="sd-overview-tab" tabindex="0">
                        {hook name='ui:client.service_detail.overview.before'}
                        {if $s.type == 'software'}
                        {if $s.metrics}
                        <div class="sd-metrics mb-3">
                            {foreach $s.metrics as $m}
                            <div class="sd-metric" data-used="{$m.used}" data-limit="{$m.total}">
                                <div class="sd-gauge" data-role="gauge">
                                    <svg class="sd-gauge-svg" viewBox="0 0 40 23" aria-hidden="true">
                                        <path class="sd-gauge-track" d="M4 20 A16 16 0 0 1 36 20"></path>
                                        <path class="sd-gauge-fill" d="M4 20 A16 16 0 0 1 36 20" data-role="gauge-fill"></path>
                                        <text class="sd-gauge-val" x="20" y="17.5" text-anchor="middle" data-role="gauge-pct">0%</text>
                                    </svg>
                                </div>
                                <div class="sd-metric-body">
                                    <span class="sd-metric-label">{$m.label}</span>
                                    <span class="sd-metric-val num-tabular"><span class="sd-used">{$m.used_text}</span><span class="sd-limit"> / {$m.total_text}</span></span>
                                </div>
                            </div>
                            {/foreach}
                        </div>
                        {hook name='ui:client.service_detail.overview.gauges.after'}
                        {/if}
                        <div class="row g-3">
                            <div class="col-lg-7">
                                <section class="sd-panel h-100 d-flex flex-column">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-key me-1"></i>{lang key='website/services/sw/license'}</h2>
                                        {if $lt.visible}<button type="button" class="btn btn-soft btn-sm" data-action="show-tab" data-tab="sd-transfer-tab"><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/services/sw/transfer-ownership'}</button>{/if}
                                    </div>
                                    <div class="sd-fields">
                                        {if $s.sw.code}
                                        <div class="sd-field sd-field-wide">
                                            <span class="sd-field-label">{lang key='website/services/sw/license-key'}</span>
                                            <div class="sd-field-val">
                                                <span class="sd-mono num-tabular" data-role="license-key" data-key="{$s.sw.code}">&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;</span>
                                                <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="license-toggle" aria-label="{lang key='website/services/sw/show-key'}" data-bs-toggle="tooltip" title="{lang key='website/services/sw/show-key'}"><i class="bi bi-eye"></i></button>
                                                <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="copy" data-copy-text="{$s.sw.code}" aria-label="{lang key='website/services/copy'}" data-bs-toggle="tooltip" title="{lang key='website/services/copy'}"><i class="bi bi-clipboard"></i></button>
                                            </div>
                                        </div>
                                        {/if}
                                        {if $s.sw.domain || $s.sw.can_change_domain}
                                        <div class="sd-field{if !$s.sw.code} sd-field-wide{/if}">
                                            <span class="sd-field-label">{lang key='website/services/sw/license-domain'}</span>
                                            <div class="sd-field-val">
                                                {if $s.sw.domain}<a class="sd-field-link" href="https://{$s.sw.domain}" target="_blank" rel="noopener" data-role="license-domain">{$s.sw.domain}<i class="bi bi-box-arrow-up-right" aria-hidden="true"></i></a>{else}<span class="text-body-secondary">-</span>{/if}
                                                {if $s.sw.can_change_domain}
                                                <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="change-domain" aria-label="{lang key='website/services/sw/change-domain'}" data-bs-toggle="tooltip" title="{lang key='website/services/sw/change-domain'}"><i class="bi bi-pencil"></i></button>
                                                {/if}
                                            </div>
                                        </div>
                                        {/if}
                                        <div class="sd-field">
                                            <span class="sd-field-label">{lang key='website/services/sw/status'}</span>
                                            <div class="sd-field-val">
                                                {if $s.sw.expired}
                                                <span class="badge bg-danger-subtle text-danger-emphasis" data-role="license-status"><i class="bi bi-calendar-x me-1"></i>{lang key='website/services/sw/status-expired'}</span>
                                                {else}
                                                <span class="badge bg-success-subtle text-success-emphasis" data-role="license-status"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/sw/status-valid'}</span>
                                                {/if}
                                            </div>
                                        </div>
                                        <div class="sd-field">
                                            <span class="sd-field-label">{lang key='website/services/sw/license-type'}</span>
                                            <div class="sd-field-val">{$s.sw.type_label}</div>
                                        </div>
                                        {if $s.sw.version}
                                        <div class="sd-field">
                                            <span class="sd-field-label">{lang key='website/services/sw/license-version'}</span>
                                            <div class="sd-field-val">{if $s.sw.store_link}<a class="sd-field-link num-tabular" href="{$s.sw.store_link}" data-bs-toggle="tooltip" title="{lang key='website/services/sw/view-store'}">{$s.sw.version}<i class="bi bi-chevron-right" aria-hidden="true"></i></a>{else}<span class="num-tabular">{$s.sw.version}</span>{/if}</div>
                                        </div>
                                        {/if}
                                        {if $s.sw.until_show}
                                        <div class="sd-field">
                                            <span class="sd-field-label" data-role="license-until-label">{if $s.sw.until_ended}{lang key='website/services/sw/until-ended'}{else}{lang key='website/services/sw/until'}{/if}</span>
                                            <div class="sd-field-val num-tabular{if $s.sw.until_ended && $s.sw.until} text-danger{/if}" data-role="license-until">{if $s.sw.until}{$s.sw.until}{elseif $s.sw.until_cta}<button type="button" class="sd-field-link" data-action="show-tab" data-tab="sd-addons-tab">{lang key='website/services/sw/until-buy'}<i class="bi bi-chevron-right" aria-hidden="true"></i></button>{else}-{/if}</div>
                                        </div>
                                        {/if}
                                        {foreach $s.sw.params as $p}
                                        <div class="sd-field">
                                            <span class="sd-field-label">{$p.label}</span>
                                            <div class="sd-field-val"><span class="sd-mono">{$p.value}</span></div>
                                        </div>
                                        {/foreach}
                                    </div>
                                    <div class="mt-auto pt-3">
                                        {if $s.sw.expired}
                                        <div class="sd-alert sd-alert-danger mb-3" role="status">
                                            <span class="sd-alert-ico"><i class="bi bi-calendar-x"></i></span>
                                            <div class="sd-alert-body">
                                                <span class="sd-alert-title">{lang key='website/services/sw/expired-title'}</span>
                                                <span class="sd-alert-text">{lang key='website/services/sw/expired-text'}</span>
                                            </div>
                                            {if $s.renew_ok}
                                            <button type="button" class="btn btn-sm btn-outline-danger" data-action="renew-service" data-id="{$s.id}"
                                                data-cycle="{$s.cycle}" data-price="{$s.renew_price}"{if $s.renew_open_invoice} data-open-invoice="{$s.renew_open_invoice}"{/if}><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/services/sw/renew-license'}</button>
                                            {/if}
                                        </div>
                                        {/if}
                                        {if $s.sw.can_reissue}
                                        <div class="sw-reissue">
                                            <span class="sw-reissue-ico"><i class="bi bi-arrow-repeat"></i></span>
                                            <div class="sw-reissue-text">
                                                <span class="sw-reissue-title">{lang key='website/services/sw/reissue-title'}</span>
                                                <span class="sw-reissue-desc">{lang key='website/services/sw/reissue-desc'}</span>
                                            </div>
                                            <button type="button" class="btn btn-soft" data-action="reissue-license" data-id="{$s.id}">{lang key='website/services/sw/reissue-btn'}</button>
                                        </div>
                                        {/if}
                                    </div>
                                </section>
                            </div>
                            <div class="col-lg-5">
                                <section class="sd-panel h-100 d-flex flex-column">
                                    <h2 class="sd-panel-title"><i class="bi bi-download me-1"></i>{lang key='website/services/sw/download'}</h2>
                                    <div class="sd-dl-main">
                                        <div class="sd-dl-media">
                                            <span class="sd-dl-art">{if $s.sw.image}<img src="{$s.sw.image}" alt="{$s.sw.product_name}">{elseif $s.icon.kind == 'logo' && $s.icon.src}<img src="{$s.icon.src}" alt="{$s.sw.product_name}">{else}<i class="{$s.icon.class|default:'bi bi-box-seam'}" aria-hidden="true"></i>{/if}</span>
                                            <div class="sd-dl-info">
                                                <span class="sd-dl-name">{$s.sw.product_name}</span>
                                                {if $s.sw.released}<span class="sd-dl-meta num-tabular">{lang key='website/services/sw/released' date=$s.sw.released}</span>{/if}
                                            </div>
                                        </div>
                                        {if $s.sw.can_download}
                                        <a class="btn btn-primary align-self-center" href="{$s.sw.download_link}">
                                            <i class="bi bi-download me-1"></i>{if $s.sw.download_label|default:''}{$s.sw.download_label}{else}{lang key='website/services/sw/download-latest'}{/if}{if $s.sw.latest_version} <span class="fw-normal opacity-75 ms-1">v{$s.sw.latest_version}</span>{/if}
                                        </a>
                                        {else}
                                        <span class="fs-7 text-body-secondary align-self-center">{lang key='website/services/sw/no-download'}</span>
                                        {/if}
                                    </div>
                                    {if $s.sw.docs}
                                    <ul class="sd-dl-links">
                                        {foreach $s.sw.docs as $d}
                                        <li><a href="{$d.link}"><i class="{$d.icon}"></i>{$d.label}</a></li>
                                        {/foreach}
                                    </ul>
                                    {/if}
                                </section>
                            </div>
                        </div>
                        <section class="sd-panel mt-3">
                            <h2 class="sd-panel-title"><i class="bi bi-hdd-stack me-1"></i>{lang key='website/services/sw/installation'}</h2>
                            <p class="text-body-secondary fs-7 mb-3">
                                <i class="bi bi-info-circle me-1" aria-hidden="true"></i>{lang key='website/services/sw/installation-note'}
                            </p>
                            <div class="sd-fields{if !$s.sw.registered} d-none{/if}" data-installs>
                                {if $s.sw.install_domain}
                                <div class="sd-field">
                                    <span class="sd-field-label">{lang key='website/services/sw/install-domain'}</span>
                                    <div class="sd-field-val">
                                        <span class="sd-mono">{$s.sw.install_domain}</span>
                                        <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="copy" data-copy-text="{$s.sw.install_domain}" aria-label="{lang key='website/services/copy'}" data-bs-toggle="tooltip" title="{lang key='website/services/copy'}"><i class="bi bi-clipboard"></i></button>
                                    </div>
                                </div>
                                {/if}
                                {if $s.sw.install_dir}
                                <div class="sd-field">
                                    <span class="sd-field-label">{lang key='website/services/sw/directory'}</span>
                                    <div class="sd-field-val">
                                        <span class="sd-mono">{$s.sw.install_dir}</span>
                                        <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="copy" data-copy-text="{$s.sw.install_dir}" aria-label="{lang key='website/services/copy'}" data-bs-toggle="tooltip" title="{lang key='website/services/copy'}"><i class="bi bi-clipboard"></i></button>
                                    </div>
                                </div>
                                {/if}
                                {if $s.sw.install_ip}
                                <div class="sd-field">
                                    <span class="sd-field-label">{lang key='website/services/sw/ip-address'}</span>
                                    <div class="sd-field-val">
                                        <span class="sd-mono num-tabular">{$s.sw.install_ip}</span>
                                        <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="copy" data-copy-text="{$s.sw.install_ip}" aria-label="{lang key='website/services/copy'}" data-bs-toggle="tooltip" title="{lang key='website/services/copy'}"><i class="bi bi-clipboard"></i></button>
                                    </div>
                                </div>
                                {/if}
                            </div>
                            <div class="wstyle-empty-state{if $s.sw.registered} d-none{/if}" data-installs-empty>
                                <i class="bi bi-hdd-stack" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/services/sw/not-registered'}</span>
                                <span class="fs-7">{lang key='website/services/sw/not-registered-text'}</span>
                            </div>
                        </section>
                        {elseif $s.show_delivery}
                        <div class="row g-3">
                            <div class="col-lg-5">
                                <section class="sd-panel h-100 d-flex flex-column">
                                    <h2 class="sd-panel-title"><i class="bi bi-box-seam me-1"></i>{lang key='website/services/delivery/service'}</h2>
                                    <div class="sd-cu-art">
                                        {if $s.cu_image}<img src="{$s.cu_image}" alt="{$s.name}">{else}<i class="{$s.type_icon}" aria-hidden="true"></i>{/if}
                                    </div>
                                    <div class="sd-fields">
                                        {if $s.host}
                                        <div class="sd-field">
                                            <span class="sd-field-label">{lang key='website/services/primary-domain'}</span>
                                            <div class="sd-field-val">
                                                <a class="sd-field-link" href="{$s.visit_link}" target="_blank" rel="noopener">{$s.host}<i class="bi bi-box-arrow-up-right" aria-hidden="true"></i></a>
                                            </div>
                                        </div>
                                        {/if}
                                        <div class="sd-field">
                                            <span class="sd-field-label">{lang key='website/services/status'}</span>
                                            <div class="sd-field-val"><span class="badge {if $s.badge == 'active' || $s.badge == 'expiring'}bg-success-subtle text-success-emphasis{elseif $s.badge == 'suspended'}bg-danger-subtle text-danger-emphasis{else}bg-secondary-subtle text-secondary-emphasis{/if}"><i class="bi {if $s.badge == 'active' || $s.badge == 'expiring'}bi-check-circle{elseif $s.badge == 'suspended'}bi-pause-circle{else}bi-x-circle{/if} me-1"></i>{$s.status_label}</span></div>
                                        </div>
                                    </div>
                                </section>
                            </div>
                            <div class="col-lg-7">
                                <section class="sd-panel h-100 d-flex flex-column">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-box-arrow-down me-1"></i>{lang key='website/services/delivery/head'}</h2>
                                        {if $s.delivery.delivered}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/delivery/delivered'}</span>{/if}
                                    </div>
                                    {if $s.delivery.delivered}
                                        {if $s.delivery.title}<h3 class="h6 mb-1">{$s.delivery.title}</h3>{/if}
                                        {if $s.delivery.description}<p class="text-body-secondary mb-3" style="white-space:pre-line">{$s.delivery.description}</p>{/if}
                                        {if $s.delivery.file_link}
                                        <div class="sd-cu-file">
                                            <span class="sd-cu-file-ico"><i class="bi bi-file-earmark-arrow-down"></i></span>
                                            <div class="sd-cu-file-body">
                                                <span class="sd-cu-file-name">{$s.delivery.file_name}</span>
                                                {if $s.delivery.delivered_at}<span class="sd-cu-file-meta num-tabular">{lang key='website/services/delivery/delivered-on'} {$s.delivery.delivered_at}</span>{/if}
                                            </div>
                                            <a class="btn btn-primary btn-sm" href="{$s.delivery.file_link}"><i class="bi bi-download me-1"></i>{lang key='website/services/delivery/download'}</a>
                                        </div>
                                        {/if}
                                        <p class="fs-7 text-body-secondary mb-0 mt-auto pt-3"><i class="bi bi-info-circle me-1"></i>{lang key='website/services/delivery/note'} {if $show_support}<a href="{link route='ticket-create'}?service={$s.id}">{lang key='website/services/delivery/open-ticket'}</a>{/if}</p>
                                    {else}
                                        <div class="wstyle-empty-state my-auto">
                                            <i class="bi bi-inbox" aria-hidden="true"></i>
                                            <span class="fw-semibold">{lang key='website/services/delivery/empty-title'}</span>
                                            <span class="fs-7">{lang key='website/services/delivery/empty-text'}</span>
                                        </div>
                                    {/if}
                                </section>
                            </div>
                        </div>
                        {else}
                        {if $s.metrics}
                        <div class="sd-metrics">
                            {foreach $s.metrics as $m}
                            <div class="sd-metric" data-used="{$m.used}" data-limit="{$m.total}">
                                <div class="sd-gauge" data-role="gauge">
                                    <svg class="sd-gauge-svg" viewBox="0 0 40 23" aria-hidden="true">
                                        <path class="sd-gauge-track" d="M4 20 A16 16 0 0 1 36 20"></path>
                                        <path class="sd-gauge-fill" d="M4 20 A16 16 0 0 1 36 20" data-role="gauge-fill"></path>
                                        <text class="sd-gauge-val" x="20" y="17.5" text-anchor="middle" data-role="gauge-pct">0%</text>
                                    </svg>
                                </div>
                                <div class="sd-metric-body">
                                    <span class="sd-metric-label">{$m.label}</span>
                                    <span class="sd-metric-val num-tabular"><span class="sd-used">{$m.used_text}</span><span class="sd-limit"> / {$m.total_text}</span></span>
                                </div>
                            </div>
                            {/foreach}
                        </div>
                        {hook name='ui:client.service_detail.overview.gauges.after'}
                        {/if}
                        <div class="row g-3">
                            <div class="col-lg-7">
                                <section class="sd-panel">
                                    {if $s.info_status || ($s.can_change_password && !$s.chpass_in_field)}
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-info-circle me-1"></i>{lang key='website/services/service-information'}</h2>
                                        <div class="d-flex align-items-center gap-2">
                                            {if $s.info_status}<span class="badge bg-{$s.info_status.badge_color}-subtle text-{$s.info_status.badge_color}-emphasis" data-bs-toggle="tooltip" title="{$s.info_status.label}"><i class="{$s.info_status.badge_icon} me-1"></i>{$s.info_status.value}</span>{/if}
                                            {if $s.can_change_password && !$s.chpass_in_field}<button type="button" class="btn btn-soft btn-sm" data-action="sd-chpass"><i class="bi bi-key me-1"></i>{lang key='website/services/chpass-btn'}</button>{/if}
                                        </div>
                                    </div>
                                    {else}
                                    <h2 class="sd-panel-title"><i class="bi bi-info-circle me-1"></i>{lang key='website/services/service-information'}</h2>
                                    {/if}
                                    {if $s.info}
                                    <div class="sd-fields">
                                        {foreach $s.info as $f}
                                        <div class="sd-field{if $f.wide} sd-field-wide{/if}">
                                            <span class="sd-field-label">{$f.label}</span>
                                            <div class="sd-field-val">
                                                {if $f.logo|default:''}<img src="{$f.logo}" alt="" width="16" height="16" class="me-1 align-text-bottom">{/if}
                                                {if $f.kind == 'link'}
                                                    <a class="sd-field-link" href="https://{$f.value}" target="_blank" rel="noopener">{$f.value}<i class="bi bi-box-arrow-up-right" aria-hidden="true"></i></a>
                                                {elseif $f.kind == 'email'}
                                                    <a class="sd-field-link" href="mailto:{$f.value}">{$f.value}</a>
                                                {elseif $f.kind == 'badge'}
                                                    <span class="badge bg-{$f.badge_color}-subtle text-{$f.badge_color}-emphasis"><i class="{$f.badge_icon} me-1"></i>{$f.value}</span>
                                                {elseif $f.kind == 'password'}
                                                    <span class="sd-mono" data-role="pass-text">&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;</span>
                                                    <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="sd-pass-toggle" data-pass="{$f.value}" aria-label="{lang key='website/services/show-password'}" data-bs-toggle="tooltip" title="{lang key='website/services/show-password'}"><i class="bi bi-eye"></i></button>
                                                    <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="copy" data-copy-text="{$f.value}" aria-label="{lang key='website/services/copy'}" data-bs-toggle="tooltip" title="{lang key='website/services/copy'}"><i class="bi bi-clipboard"></i></button>
                                                    {if $f.chpass|default:false}<button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="sd-chpass" aria-label="{lang key='website/services/chpass-btn'}" data-bs-toggle="tooltip" title="{lang key='website/services/chpass-btn'}"><i class="bi bi-key"></i></button>{/if}
                                                {elseif $f.kind == 'copy'}
                                                    <span class="sd-mono">{$f.value}</span>
                                                    <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="copy" data-copy-text="{$f.value}" aria-label="{lang key='website/services/copy'}" data-bs-toggle="tooltip" title="{lang key='website/services/copy'}"><i class="bi bi-clipboard"></i></button>
                                                {elseif $f.kind == 'mono'}
                                                    <span class="sd-mono">{$f.value}</span>
                                                {else}
                                                    {$f.value}
                                                {/if}
                                            </div>
                                        </div>
                                        {/foreach}
                                    </div>
                                    {else}
                                    <p class="fs-7 text-body-secondary mb-0">{lang key='website/services/no-service-info'}</p>
                                    {/if}
                                </section>
                            </div>
                            <div class="col-lg-5">
                                <section class="sd-panel h-100 d-flex flex-column">
                                    <h2 class="sd-panel-title"><i class="bi bi-box me-1"></i>{lang key='website/services/plan'}</h2>
                                    <div class="sd-plan-summary">
                                        <span class="sd-plan-tier">{$s.plan_tier}</span>
                                        <span class="sd-plan-amount num-tabular">{$s.amount}{if $s.cycle_short}<span class="sd-fact-unit">/{$s.cycle_short}</span>{/if}</span>
                                    </div>
                                    {if $s.specs}
                                    {assign var='sd_spec_visible' value=6}
                                    <ul class="sd-spec-list sd-spec-list-rich">
                                        {foreach $s.specs as $sp}
                                        {if $sp@iteration == $sd_spec_visible + 1}
                                        </ul>
                                        <div class="wui-collapse" id="sd-spec-more">
                                            <div class="wui-collapse-inner">
                                                <ul class="sd-spec-list sd-spec-list-rich">
                                        {/if}
                                        <li{if $sp.used !== '' && $sp.total !== ''} data-used="{$sp.used}" data-limit="{$sp.total}"{/if}>
                                            <span class="sd-spec-ico"><i class="{$sp.icon}"></i></span>
                                            <span>{$sp.label}</span>
                                            <b class="num-tabular"><span class="sd-used">{$sp.used_text}</span>{if $sp.total_text !== ''}<span class="sd-limit"> / {$sp.total_text}</span>{/if}</b>
                                        </li>
                                        {/foreach}
                                        {if $s.specs|@count > $sd_spec_visible}
                                                </ul>
                                            </div>
                                        </div>
                                        <button type="button" class="btn btn-soft btn-sm sd-spec-more-btn mt-auto" data-wui-toggle data-wui-target="#sd-spec-more" aria-expanded="false" aria-controls="sd-spec-more">
                                            <span class="sd-spec-more-open">{lang key='website/services/spec-show-more'}</span>
                                            <span class="sd-spec-more-close">{lang key='website/services/spec-show-less'}</span>
                                            <i class="bi bi-chevron-down wui-collapse-caret"></i>
                                        </button>
                                        {else}
                                        </ul>
                                        {/if}
                                    {else}
                                    <dl class="sd-info mb-0 mt-2">
                                        {if $s.cycle}<div class="sd-info-row"><dt>{lang key='website/services/f-cycle'}</dt><dd>{$s.cycle}</dd></div>{/if}
                                        <div class="sd-info-row"><dt>{lang key='website/services/f-created'}</dt><dd class="num-tabular">{if $s.created}{$s.created}{else}-{/if}</dd></div>
                                        {if $s.expires}<div class="sd-info-row"><dt>{lang key='website/services/next-due'}</dt><dd class="num-tabular">{$s.expires}</dd></div>{/if}
                                    </dl>
                                    {/if}
                                    {if $updown.visible}
                                    <div class="mt-auto pt-3">
                                        <button type="button" class="btn btn-primary btn-sm w-100" data-action="show-tab" data-tab="sd-upgrade-tab"><i class="bi bi-arrow-down-up me-1"></i>{lang key='website/services/updown/cta-plan'}</button>
                                    </div>
                                    {/if}
                                </section>
                            </div>
                        </div>

                        {if $s.can_manage && ($s.quick_actions || $s.has_sso)}
                        <section class="sd-panel mt-3" data-role="manage-panel">
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-lightning-charge me-1"></i>{lang key='website/services/quick-actions'}</h2>
                                {if $s.has_sso}
                                <button type="button" class="btn btn-soft btn-sm sd-cp-launch" data-action="sso-launch" data-redirect-target="_blank" data-busy-text="{lang key='website/services/working'}">
                                    {if $s.logo|default:''}<img class="sd-cp-logo" src="{$s.logo}" alt="{$s.group_label}">{/if}
                                    {lang key='website/services/open-control-panel'}
                                    <i class="bi bi-box-arrow-up-right"></i>
                                </button>
                                {hook name='ui:client.service_detail.overview.sso.after'}
                                {/if}
                            </div>
                            {if $s.quick_actions}
                            {hook name='ui:client.service_detail.overview.quick_actions.before'}
                            <div class="sd-quick-grid">
                                {foreach $s.quick_actions as $qa}
                                <a class="sd-quick" href="{if $qa.url}{$qa.url}{else}#{/if}"{if !$qa.url} data-action="quick-tool" data-tool="{$qa.key}"{if $qa.action} data-type="action" data-method="{$qa.method}"{/if}{/if}>
                                    <span class="sd-quick-ico">{if $qa.img}<img src="{$qa.img}" alt="">{else}<i class="{$qa.icon}"></i>{/if}</span>
                                    <span class="sd-quick-label">{$qa.label}</span>
                                </a>
                                {/foreach}
                            </div>
                            {hook name='ui:client.service_detail.overview.quick_actions.after'}
                            {/if}
                        </section>
                        {/if}
                        {/if}
                        {hook name='ui:client.service_detail.overview.after'}
                    </div>

                    {if $s.has_management}
                    <div class="tab-pane fade" id="sd-management" role="tabpanel" aria-labelledby="sd-management-tab" tabindex="0">
                        {if $s.has_sso}
                        <div class="sd-mgmt-cta">
                            {if $s.logo|default:''}<span class="sd-mgmt-cta-logo"><img src="{$s.logo}" alt="{$s.group_label}"></span>{/if}
                            <div class="sd-mgmt-cta-body">
                                <h2 class="sd-mgmt-cta-title">{if $s.panel_name}{$s.panel_name}{else}{lang key='website/services/control-panel'}{/if}</h2>
                                <p class="sd-mgmt-cta-text">{lang key='website/services/sso-desc'}</p>
                            </div>
                            <div class="sd-mgmt-cta-actions">
                                <button type="button" class="btn btn-soft sd-cp-launch" data-action="sso-launch" data-redirect-target="_blank" data-busy-text="{lang key='website/services/working'}">{lang key='website/services/open-control-panel'}<i class="bi bi-box-arrow-up-right"></i></button>
                            </div>
                        </div>
                        {hook name='ui:client.service_detail.management.sso.after'}
                        {/if}
                        {hook name='ui:client.service_detail.management.top'}
                        <div id="modulePageContent" class="sd-module-surface">
                            <div class="d-flex justify-content-center align-items-center py-5">
                                <div class="spinner-border text-primary" role="status" aria-hidden="true"></div>
                            </div>
                        </div>
                    </div>
                    {/if}

                    {if $lt.visible}
                    <div class="tab-pane fade" id="sd-transfer" role="tabpanel" aria-labelledby="sd-transfer-tab" tabindex="0" data-transfer-mode="{$lt.mode}">
                        {if $lt.pending}
                        <section class="sd-panel" data-transfer-state="pending">
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/services/lt/title-pending'}</h2>
                                <span class="fs-7 text-body-secondary num-tabular">#LT-{$lt.pending.id}</span>
                            </div>
                            <div class="sd-tr-status">
                                <span class="sd-tr-status-ico"><i class="bi bi-hourglass-split"></i></span>
                                <div class="sd-tr-status-body">
                                    <span class="sd-tr-status-title">{lang key='website/services/lt/pending-title'}
                                        <span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{$lt.pending.badge}</span>
                                    </span>
                                    <span class="sd-tr-status-desc">{lang key='website/services/lt/pending-desc-pre'} <span class="num-tabular">{$lt.pending.started}</span>. {if $lt.mode == 'premium'}{lang key='website/services/lt/pending-desc-premium'}{else}{lang key='website/services/lt/pending-desc'}{/if}</span>
                                </div>
                            </div>
                            <div class="sd-party-grid">
                                <div class="sd-party">
                                    <div class="sd-party-head">
                                        <span class="sd-party-avatar">{lang key='website/services/lt/party-you-avatar'}</span>
                                        <div class="sd-party-id">
                                            <span class="sd-party-role">{lang key='website/services/lt/party-current'}</span>
                                            <span class="sd-party-email">{$lt.own_email}</span>
                                        </div>
                                    </div>
                                    <div class="sd-party-foot">
                                        <span class="fs-7 text-body-secondary">{lang key='website/services/lt/verification'}</span>
                                        {if $lt.pending.ver.transferor}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/lt/verified'}</span>
                                        {else}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-clock me-1"></i>{lang key='website/services/lt/ver-pending'}</span>{/if}
                                    </div>
                                </div>
                                <span class="sd-party-arrow" aria-hidden="true"><i class="bi bi-arrow-left-right"></i></span>
                                <div class="sd-party">
                                    <div class="sd-party-head">
                                        <span class="sd-party-avatar">{$lt.pending.to_initials}</span>
                                        <div class="sd-party-id">
                                            <span class="sd-party-role">{lang key='website/services/lt/party-new'}</span>
                                            <span class="sd-party-email" data-role="sd-tr-new-email">{$lt.pending.to_email}</span>
                                        </div>
                                    </div>
                                    <div class="sd-party-foot">
                                        <span class="fs-7 text-body-secondary">{lang key='website/services/lt/verification'}</span>
                                        {if $lt.pending.ver.transferee}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/lt/verified'}</span>
                                        {else}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-clock me-1"></i>{lang key='website/services/lt/ver-pending'}</span>{/if}
                                    </div>
                                </div>
                            </div>
                            <div class="sd-fields" data-fee-only>
                                <div class="sd-field">
                                    <span class="sd-field-label">{lang key='website/services/lt/fee'}</span>
                                    <div class="sd-field-val"><span class="num-tabular">{$lt.pending.fee_fmt}</span>{if $lt.pending.fee_note}<span class="fs-8 text-body-secondary ms-1">{$lt.pending.fee_note}</span>{/if}</div>
                                </div>
                                <div class="sd-field">
                                    <span class="sd-field-label">{lang key='website/services/lt/paid-by'}</span>
                                    <div class="sd-field-val">{if $lt.paid_by == 'transferor'}{lang key='website/services/lt/paid-by-you'}{else}{lang key='website/services/lt/paid-by-new'}{/if}</div>
                                </div>
                                {if $lt.pending.invoice}
                                <div class="sd-field sd-field-wide">
                                    <span class="sd-field-label">{lang key='website/services/lt/invoice'}</span>
                                    <div class="sd-field-val">
                                        {if $lt.pending.invoice.paid}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/lt/inv-paid'}</span>
                                        {else}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/services/lt/inv-unpaid'}</span>{/if}
                                        <a class="sd-field-link num-tabular ms-2" href="{$lt.pending.invoice.link}">{$lt.pending.invoice.number}<i class="bi bi-chevron-right" aria-hidden="true"></i></a>
                                    </div>
                                </div>
                                {/if}
                            </div>
                            <div class="sd-tr-foot"><i class="bi bi-info-circle me-1"></i>{if $lt.mode == 'premium'}{lang key='website/services/lt/pending-foot-premium'}{else}{lang key='website/services/lt/pending-foot'}{/if}</div>
                            <div class="d-flex flex-wrap justify-content-end gap-2 sd-cancel-actions">
                                {if $lt.pending.status == 'pending_verification'}
                                <button type="button" class="btn btn-soft" data-action="resend-transfer-verification"><i class="bi bi-envelope me-1"></i>{lang key='website/services/lt/btn-resend'}</button>
                                {/if}
                                <button type="button" class="btn btn-outline-danger" data-action="cancel-transfer"><i class="bi bi-x-circle me-1"></i>{lang key='website/services/lt/btn-cancel'}</button>
                            </div>
                        </section>
                        {else}
                        <section class="sd-panel" data-transfer-state="start">
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/services/lt/title-start'}</h2>
                                <span class="fs-7 text-body-secondary">{lang key='website/services/lt/subtitle-start'}</span>
                            </div>
                            <ol class="sd-tr-steps">
                                <li class="sd-tr-step">
                                    <span class="sd-tr-step-num" aria-hidden="true"></span>
                                    <span class="sd-tr-step-body"><span class="sd-tr-step-title">{lang key='website/services/lt/step-initiate'}</span><span class="sd-tr-step-desc">{lang key='website/services/lt/step-initiate-d'}</span></span>
                                </li>
                                <li class="sd-tr-step">
                                    <span class="sd-tr-step-num" aria-hidden="true"></span>
                                    <span class="sd-tr-step-body"><span class="sd-tr-step-title">{lang key='website/services/lt/step-verify'}</span><span class="sd-tr-step-desc">{lang key='website/services/lt/step-verify-d'}</span></span>
                                </li>
                                <li class="sd-tr-step sd-tr-step-fee">
                                    <span class="sd-tr-step-num" aria-hidden="true"></span>
                                    <span class="sd-tr-step-body"><span class="sd-tr-step-title">{lang key='website/services/lt/step-invoice'}</span><span class="sd-tr-step-desc">{lang key='website/services/lt/step-invoice-d'}</span></span>
                                </li>
                                <li class="sd-tr-step sd-tr-step-fee">
                                    <span class="sd-tr-step-num" aria-hidden="true"></span>
                                    <span class="sd-tr-step-body"><span class="sd-tr-step-title">{lang key='website/services/lt/step-payment'}</span><span class="sd-tr-step-desc">{lang key='website/services/lt/step-payment-d'}</span></span>
                                </li>
                                <li class="sd-tr-step">
                                    <span class="sd-tr-step-num" aria-hidden="true"></span>
                                    <span class="sd-tr-step-body"><span class="sd-tr-step-title">{lang key='website/services/lt/step-transfer'}</span><span class="sd-tr-step-desc">{lang key='website/services/lt/step-transfer-d'}</span></span>
                                </li>
                            </ol>
                            <div class="mb-3">
                                <label class="form-label" for="sd-tr-email">{lang key='website/services/lt/email-label'} <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="sd-tr-email" placeholder="owner@example.com" autocomplete="off" spellcheck="false">
                                <div class="invalid-feedback" data-role="lt-email-feedback">{lang key='website/services/lt/err-email-invalid'}</div>
                                <div class="form-text"><i class="bi bi-info-circle me-1"></i>{lang key='website/services/lt/email-help'}</div>
                            </div>
                            <div class="sd-fields mb-3" data-fee-only>
                                <div class="sd-field">
                                    <span class="sd-field-label">{lang key='website/services/lt/fee'}</span>
                                    <div class="sd-field-val"><span class="num-tabular fw-semibold">{$lt.fee_fmt|default:''}</span>{if $lt.fee_note|default:''}<span class="fs-8 text-body-secondary ms-1">{$lt.fee_note}</span>{/if}</div>
                                </div>
                                <div class="sd-field">
                                    <span class="sd-field-label">{lang key='website/services/lt/paid-by'}</span>
                                    <div class="sd-field-val fw-semibold">{if $lt.paid_by == 'transferor'}{lang key='website/services/lt/paid-by-you'}{else}{lang key='website/services/lt/paid-by-new'}{/if}</div>
                                </div>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="sd-tr-consent">
                                <label class="form-check-label" for="sd-tr-consent">{if $lt.mode == 'premium'}{lang key='website/services/lt/consent-premium'}{else}{lang key='website/services/lt/consent'}{/if}</label>
                            </div>
                            <div class="wui-collapse" id="sd-tr-confirm">
                                <div class="wui-collapse-inner">
                                    <div class="pt-3">
                                        <label class="form-label" for="sd-tr-password">{lang key='website/services/lt/password-label'}</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="sd-tr-password" autocomplete="current-password" placeholder="{lang key='website/services/lt/password-ph'}">
                                            <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/services/lt/password-show'}"><i class="bi bi-eye"></i></button>
                                            <div class="invalid-feedback" data-role="lt-pw-feedback">{lang key='website/services/lt/err-password'}</div>
                                        </div>
                                        <div class="form-text"><i class="bi bi-shield-check me-1"></i>{lang key='website/services/lt/password-help'}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex flex-wrap justify-content-end gap-2 mt-3">
                                <button type="button" class="btn btn-soft" data-action="show-tab" data-tab="sd-overview-tab"><i class="bi bi-arrow-left me-1"></i>{lang key='website/services/lt/btn-back'}</button>
                                <button type="button" class="btn btn-primary" data-action="start-transfer" disabled><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/services/lt/btn-start'}</button>
                            </div>
                        </section>
                        {/if}
                    </div>
                    {/if}

                    {if $s.blocks}
                    <div class="tab-pane fade" id="sd-extra" role="tabpanel" aria-labelledby="sd-extra-tab" tabindex="0">
                        <section class="sd-panel">
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-info-square me-1"></i>{lang key='website/services/extra-title'}</h2>
                                <span class="fs-7 text-body-secondary">{lang key='website/services/extra-desc'}</span>
                            </div>
                            <div class="sd-extra-grid">
                                {foreach $s.blocks as $b}
                                <article class="sd-extra-card">
                                    {if $b.title}<h3 class="sd-extra-title">{$b.title}</h3>{/if}
                                    {if $b.description}<div class="sd-extra-body">{$b.description}</div>{/if}
                                </article>
                                {/foreach}
                            </div>
                        </section>
                    </div>
                    {/if}

                    {if $addons_owned || $addons_available}
                    <div class="tab-pane fade" id="sd-addons" role="tabpanel" aria-labelledby="sd-addons-tab" tabindex="0">
                        <div class="row g-3">
                            <div class="col-12">
                                <section class="sd-panel">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-check2-square me-1"></i>{lang key='website/services/addons-owned-title'}</h2>
                                        <span class="fs-7 text-body-secondary">{lang key='website/services/addons-owned-desc'}</span>
                                    </div>
                                    {if $addons_owned}
                                    <ul class="sd-addons" data-addons="owned">
                                        {foreach $addons_owned as $a}
                                        <li class="sd-addon{if !in_array($a.status, ['active', 'inprocess'])} is-inactive{/if}">
                                            <span class="sd-addon-ico">{if $a.icon|default:''}{if $a.icon.type == 'image'}<img src="{$a.icon.value}" alt="">{else}<i class="{$a.icon.value}"></i>{/if}{else}<i class="bi bi-puzzle"></i>{/if}</span>
                                            <div class="sd-addon-body">
                                                <span class="sd-addon-head">
                                                    <span class="sd-addon-name">{$a.name}</span>
                                                    {if $a.status == 'active'}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/addon-st-active'}</span>
                                                    {elseif $a.status == 'suspended'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-pause-circle me-1"></i>{lang key='website/services/addon-st-suspended'}</span>
                                                    {elseif $a.status == 'waiting'}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/services/addon-st-waiting'}</span>
                                                    {else}<span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-gear me-1"></i>{lang key='website/services/addon-st-inprocess'}</span>{/if}
                                                    <span class="badge bg-warning-subtle text-warning-emphasis{if !$a.cancel_planned} d-none{/if}" data-role="addon-cancel-badge"><i class="bi bi-calendar-x me-1"></i>{lang key='website/services/addon-cancel-planned'}</span>
                                                </span>
                                                {if $a.option || $a.qty > 1}<span class="sd-addon-note">{$a.option}{if $a.qty > 1} × {$a.qty}{/if}</span>{/if}
                                                {if $a.expires}
                                                <span class="sd-addon-note{if $a.cancel_planned} d-none{/if}" data-role="addon-note-renews">{lang key='website/services/addon-renews-on'} {$a.expires}</span>
                                                <span class="sd-addon-note{if !$a.cancel_planned} d-none{/if}" data-role="addon-note-ends">{lang key='website/services/addon-ends-on'} {$a.expires}</span>
                                                {/if}
                                                {if $a.can_autorenew}
                                                <span class="sd-addon-note">{lang key='website/services/f-autorenew'}:
                                                    {if $s.account_autopay}
                                                    <span class="form-check form-switch sd-switch-inline m-0 d-inline-flex align-middle" data-bs-toggle="tooltip" title="{lang key='website/account/autorenew-locked-account'}">
                                                        <input class="form-check-input" type="checkbox" role="switch" id="sd-addon-autorenew-{$a.id}" checked disabled aria-label="{lang key='website/services/addon-autorenew-aria'}">
                                                        <span class="sd-switch-state">{lang key='website/services/on'}</span>
                                                    </span>
                                                    {else}
                                                    <span class="form-check form-switch sd-switch-inline m-0 d-inline-flex align-middle">
                                                        <input class="form-check-input" type="checkbox" role="switch" id="sd-addon-autorenew-{$a.id}" data-action="toggle-addon-autorenew" data-addon-id="{$a.id}" data-addon-name="{$a.name}" aria-label="{lang key='website/services/addon-autorenew-aria'}"{if $a.autorenew} checked{/if}>
                                                        <span class="sd-switch-state" data-role="addon-autorenew-state">{if $a.autorenew}{lang key='website/services/on'}{else}{lang key='website/services/off'}{/if}</span>
                                                    </span>
                                                    {/if}
                                                </span>
                                                {/if}
                                            </div>
                                            {if $a.price}<span class="sd-addon-price num-tabular">{$a.price}{if $a.cycle_short}<span class="sd-fact-unit">/{$a.cycle_short}</span>{/if}</span>{/if}
                                            {if $a.download_link|default:''}<a class="btn btn-soft btn-sm" href="{$a.download_link}" title="{$a.download_name|default:''}{if $a.download_size|default:''} · {$a.download_size}{/if}"><i class="bi bi-download me-1"></i>{$a.download_label|default:''}</a>{/if}
                                            {if $a.pay_link}
                                            <a class="btn btn-secondary btn-sm" href="{$a.pay_link}"><i class="bi bi-credit-card me-1"></i>{lang key='website/services/addon-pay'}</a>
                                            {elseif $a.cancel_planned || $a.can_cancel}
                                            <button type="button" class="btn btn-soft btn-sm{if !$a.cancel_planned} d-none{/if}" data-action="addon-revoke" data-addon-id="{$a.id}" data-addon-name="{$a.name}" data-busy-text="{lang key='website/services/working'}"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/services/addon-undo'}</button>
                                            <button type="button" class="btn btn-ghost btn-sm sd-addon-remove{if $a.cancel_planned} d-none{/if}" data-action="addon-cancel" data-addon-id="{$a.id}" data-addon-name="{$a.name}" data-addon-due="{$a.expires}" aria-label="{lang key='website/services/addon-remove-aria'}" data-bs-toggle="tooltip" title="{lang key='website/services/addon-remove-tip'}"><i class="bi bi-trash3"></i></button>
                                            {/if}
                                        </li>
                                        {/foreach}
                                    </ul>
                                    {else}
                                    <div class="wstyle-empty-state">
                                        <i class="bi bi-puzzle" aria-hidden="true"></i>
                                        <span class="fw-semibold">{lang key='website/services/addons-empty-owned-t'}</span>
                                        <span class="fs-7">{lang key='website/services/addons-empty-owned-x'}</span>
                                    </div>
                                    {/if}
                                </section>
                            </div>
                            <div class="col-12">
                                <section class="sd-panel">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-bag-plus me-1"></i>{lang key='website/services/addons-avail-title'}</h2>
                                        <span class="fs-7 text-body-secondary">{lang key='website/services/addons-avail-desc'}</span>
                                    </div>
                                    {if $addons_available}
                                    {assign var=addon_tab_count value=$addons_groups|@count}
                                    {if $addon_tab_count > 1}
                                    <ul class="nav store-tabs" role="tablist" aria-label="{lang key='website/services/addons-avail-title'}">
                                        {foreach $addons_groups as $grp}
                                        <li class="nav-item" role="presentation">
                                            <button class="nav-link{if $grp@first} active{/if}" id="sdAddonGrp{$grp.id}-tab" data-bs-toggle="tab" data-bs-target="#sdAddonGrp{$grp.id}" type="button" role="tab" aria-controls="sdAddonGrp{$grp.id}" aria-selected="{if $grp@first}true{else}false{/if}"><span class="store-tab-label" data-short="{$grp.name}"><i class="{$grp.icon|default:'bi bi-grid'}" aria-hidden="true"></i>{$grp.name}</span><span class="store-tab-count num-tabular">{$grp.count}</span></button>
                                        </li>
                                        {/foreach}
                                    </ul>
                                    {/if}
                                    <div data-addons="available"{if $addon_tab_count > 1} class="tab-content"{/if}>
                                    {foreach $addons_groups as $grp}
                                    <div{if $addon_tab_count > 1} class="tab-pane fade{if $grp@first} show active{/if}" id="sdAddonGrp{$grp.id}" role="tabpanel" aria-labelledby="sdAddonGrp{$grp.id}-tab" tabindex="0"{/if}>
                                    <div class="sd-offer-grid">
                                        {foreach $grp.addons as $of}
                                        <div class="sd-offer" data-addon-offer="{$of.id}">
                                            <span class="sd-offer-ico">{if $of.icon}{if $of.icon.type == 'image'}<img src="{$of.icon.value}" alt="">{else}<i class="{$of.icon.value}"></i>{/if}{else}<i class="bi bi-puzzle"></i>{/if}</span>
                                            <div class="sd-offer-body">
                                                <span class="sd-offer-name">{if $of.store_url|default:''}<a class="sd-offer-link" href="{$of.store_url}" target="_blank" rel="noopener">{$of.name}</a>{else}{$of.name}{/if}</span>
                                                {if $of.description}<span class="sd-offer-note">{$of.description nofilter}</span>{/if}
                                            </div>
                                            <div class="sd-offer-foot">
                                                {if $of.sub_locked}
                                                <span class="badge bg-secondary-subtle text-secondary-emphasis" data-bs-toggle="tooltip" title="{lang key='website/services/addon-sub-locked-tip'}"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/services/addon-sub-locked'}</span>
                                                {else}
                                                <span class="sd-offer-price num-tabular">{$of.options[0].unit_fmt}</span>
                                                <button type="button" class="btn btn-success btn-sm{if !$of.in_cart_key} d-none{/if}" data-action="addon-uncart" data-addon-id="{$of.id}" data-item-key="{$of.in_cart_key}" data-busy-text="{lang key='website/services/working'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/services/addon-added'}</button>
                                                {if count($of.options) > 1}
                                                <button type="button" class="btn btn-soft btn-sm{if $of.in_cart_key} d-none{/if}" data-role="addon-open" data-bs-toggle="modal" data-bs-target="#sdAddonModal{$of.id}">{if $of.is_upgrade}<i class="bi bi-arrow-up-circle me-1"></i>{lang key='website/services/addon-upgrade'}{else}<i class="bi bi-plus-lg me-1"></i>{lang key='website/services/addon-add'}{/if}</button>
                                                {else}
                                                <div class="dropdown sd-addon-buy{if $of.in_cart_key} d-none{/if}" data-role="addon-open">
                                                    <button type="button" class="btn btn-soft btn-sm" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">{if $of.is_upgrade}<i class="bi bi-arrow-up-circle me-1"></i>{lang key='website/services/addon-upgrade'}{else}<i class="bi bi-plus-lg me-1"></i>{lang key='website/services/addon-add'}{/if}</button>
                                                    <div class="dropdown-menu dropdown-menu-end sd-addon-pop" data-addon-panel data-addon-id="{$of.id}" data-addon-type="{$of.type}" data-min="{$of.min}" data-max="{$of.max}" data-step="{$of.step}">
                                                        {assign var=opt value=$of.options[0]}
                                                        <label class="option-card option-card-radio">
                                                            <input class="form-check-input" type="radio" name="sdao-{$of.id}" value="{$opt.id}" data-first="{$opt.first_unit}" data-renew="{$opt.renew_unit}" data-aligned="{if $opt.aligned}1{else}0{/if}" data-cycle-word="{$opt.cycle_word}" checked>
                                                            <span class="d-flex align-items-center gap-2">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="fw-semibold">{$opt.name}</span></span>
                                                            {if $opt.description}<span class="fs-8 text-body-secondary d-block my-1">{$opt.description nofilter}</span>{/if}
                                                            <span class="price-chip">{if $opt.free}{lang key='website/services/addon-free'}{else}{$opt.unit_fmt}{/if}</span>
                                                        </label>
                                                        {if $of.type == 'quantity'}
                                                        <div class="range-field pt-2">
                                                            <div class="range-field-head">
                                                                <label class="fw-semibold mb-0 me-auto" for="sd-addon-qty-{$of.id}">{lang key='website/services/addon-qty'}</label>
                                                                <input type="number" class="range-value num-tabular fw-semibold" id="sd-addon-qty-val-{$of.id}" data-qty-display value="{$of.min}" min="{$of.min}" max="{$of.max}" step="{$of.step}" inputmode="numeric" aria-label="{lang key='website/services/addon-qty'}">
                                                            </div>
                                                            <input type="range" class="form-range range-fill" id="sd-addon-qty-{$of.id}" data-role="qty-input" min="{$of.min}" max="{$of.max}" step="{$of.step}" value="{$of.min}">
                                                            <div class="range-ticks" aria-hidden="true"><span>{$of.min}</span><span>{$of.max}</span></div>
                                                        </div>
                                                        {/if}
                                                        <div class="sd-addon-pop-foot">
                                                            <div class="sd-addon-pop-sum">
                                                                <span class="fs-7">{lang key='website/services/addon-first-term'}: <strong class="num-tabular" data-role="addon-first"></strong></span>
                                                                <span class="fs-8 text-body-secondary" data-role="addon-renew"></span>
                                                            </div>
                                                            <button type="button" class="btn btn-secondary btn-sm" data-action="addon-add" data-busy-text="{lang key='website/services/working'}"><i class="bi bi-cart-plus me-1"></i>{lang key='website/services/addon-add-cart'}</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                {/if}
                                                {/if}
                                            </div>
                                        </div>
                                        {/foreach}
                                    </div>
                                    </div>
                                    {/foreach}
                                    </div>
                                    {else}
                                    <div class="wstyle-empty-state">
                                        <i class="bi bi-bag-x" aria-hidden="true"></i>
                                        <span class="fw-semibold">{lang key='website/services/addons-empty-avail-t'}</span>
                                        <span class="fs-7">{lang key='website/services/addons-empty-avail-x'}</span>
                                    </div>
                                    {/if}
                                </section>
                            </div>
                        </div>
                    </div>
                    {/if}

                    {if $req_config || $req_details}
                    <div class="tab-pane fade" id="sd-requirements" role="tabpanel" aria-labelledby="sd-requirements-tab" tabindex="0">
                        <section class="sd-panel">
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-card-checklist me-1"></i>{lang key='website/services/req-title'}</h2>
                                <span class="fs-7 text-body-secondary">{lang key='website/services/req-desc'}</span>
                            </div>

                            {if $req_config}
                            <h3 class="sd-req-group-title">{lang key='website/services/req-group-config'}</h3>
                            <div class="sd-fields">
                                {foreach $req_config as $f}
                                <div class="sd-field">
                                    <span class="sd-field-label">{$f.label}</span>
                                    <div class="sd-field-val">{$f.value}</div>
                                </div>
                                {/foreach}
                            </div>
                            {/if}

                            {if $req_details}
                            <h3 class="sd-req-group-title">{lang key='website/services/req-group-details'}</h3>
                            <div class="sd-fields">
                                {foreach $req_details as $f}
                                <div class="sd-field sd-field-wide">
                                    <span class="sd-field-label">{$f.label}</span>
                                    <div class="sd-field-val{if $f.kind == 'multi'} align-items-start{/if}">
                                        {if $f.kind == 'files'}
                                            <div class="d-flex flex-column gap-1">
                                                {foreach $f.files as $file}
                                                <a class="sd-field-link" href="{$file.link}" target="_blank" rel="noopener"><i class="bi bi-paperclip" aria-hidden="true"></i>{$file.name}{if $file.size} <span class="text-body-secondary fw-normal">({$file.size})</span>{/if}</a>
                                                {/foreach}
                                            </div>
                                        {elseif $f.kind == 'multi'}
                                            <span class="sd-mono sd-req-pre">{$f.display}</span>
                                            <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="copy" data-copy-text="{$f.value}" aria-label="{lang key='website/services/copy'}" data-bs-toggle="tooltip" title="{lang key='website/services/copy'}"><i class="bi bi-clipboard"></i></button>
                                        {elseif $f.kind == 'email'}
                                            <a class="sd-field-link" href="mailto:{$f.value}">{$f.value}</a>
                                        {else}
                                            <span class="sd-mono">{$f.value}</span>
                                            <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="copy" data-copy-text="{$f.value}" aria-label="{lang key='website/services/copy'}" data-bs-toggle="tooltip" title="{lang key='website/services/copy'}"><i class="bi bi-clipboard"></i></button>
                                        {/if}
                                    </div>
                                </div>
                                {/foreach}
                            </div>
                            {/if}

                            <div class="sd-req-foot fs-7 text-body-secondary"><i class="bi bi-lock me-1"></i>{lang key='website/services/req-foot'}</div>
                        </section>
                    </div>
                    {/if}

                    {if $updown.visible}
                    <div class="tab-pane fade" id="sd-upgrade" role="tabpanel" aria-labelledby="sd-upgrade-tab" tabindex="0">
                        <section class="sd-panel" data-updown
                                 data-updown-plans="{$updown.plans_json}"
                                 data-updown-moves="{$updown.move_json}"
                                 data-updown-current-name="{$updown.current.title}"
                                 data-updown-current-price="{$updown.current.price_fmt}{if $updown.current.cycle_short}/{$updown.current.cycle_short}{/if}"
                                 data-updown-credit-days="{$updown.credit.days}"
                                 data-updown-credit-amount="{$updown.credit.amount_fmt}"
                                 data-updown-tax-inclusive="{if $updown.tax_inclusive}1{else}0{/if}"
                                 data-updown-due="{$s.expires}"
                                 data-updown-permo="{$updown.permo_suffix}"
                                 data-updown-zero="{$updown.zero_fmt}"
                                 data-updown-current-id="{$updown.current.id|default:0}"
                                 data-updown-other-locks="{if $updown.sub_locked || $updown.pending}1{else}0{/if}">
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-arrow-down-up me-1"></i>{lang key='website/services/updown/title'}</h2>
                                <div class="d-flex flex-wrap gap-2">
                                    <button type="button" class="btn btn-soft btn-sm" data-bs-toggle="modal" data-bs-target="#sd-upgrade-process"><i class="bi bi-arrow-up-circle me-1 text-success"></i>{lang key='website/services/updown/how-up'}</button>
                                    <button type="button" class="btn btn-soft btn-sm" data-bs-toggle="modal" data-bs-target="#sd-downgrade-process"><i class="bi bi-arrow-down-circle me-1 text-danger"></i>{lang key='website/services/updown/how-down'}</button>
                                </div>
                            </div>
                            <p class="fs-7 text-body-secondary mb-3">{lang key='website/services/updown/subtitle'}</p>

                            {if $updown.pending}
                            <div class="sd-alert sd-alert-info" role="status">
                                <span class="sd-alert-ico"><i class="bi bi-hourglass-split"></i></span>
                                <div class="sd-alert-body">
                                    <span class="sd-alert-title">{lang key='website/services/updown/pending-title'}</span>
                                    <span class="sd-alert-text">{if $updown.pending.plan}{lang key='website/services/updown/pending-text' plan=$updown.pending.plan}{else}{lang key='website/services/updown/pending-text-generic'}{/if}</span>
                                </div>
                                {if $updown.pending.invoice}
                                <a class="btn btn-sm btn-outline-info" href="{$updown.pending.invoice.link}"><i class="bi bi-receipt me-1"></i>{lang key='website/services/updown/pending-pay'}</a>
                                {/if}
                            </div>
                            {/if}

                            {if $updown.sub_locked}
                            <div class="sd-alert sd-alert-info" role="status">
                                <span class="sd-alert-ico"><i class="bi bi-credit-card-2-front"></i></span>
                                <div class="sd-alert-body">
                                    <span class="sd-alert-title">{lang key='website/services/updown/sub-locked-title'}</span>
                                    <span class="sd-alert-text">{lang key='website/services/updown/sub-locked-text'}</span>
                                </div>
                            </div>
                            {/if}

                            <div class="sd-alert sd-alert-info{if !$updown.scheduled} d-none{/if}" data-role="downgrade-scheduled" role="status">
                                <span class="sd-alert-ico"><i class="bi bi-arrow-down-circle"></i></span>
                                <div class="sd-alert-body">
                                    <span class="sd-alert-title" data-role="dg-title">{if $updown.scheduled && $updown.scheduled.is_cycle}{lang key='website/services/updown/scheduled-title-cycle'}{else}{lang key='website/services/updown/scheduled-title'}{/if}</span>
                                    <span class="sd-alert-text" data-role="dg-text">{if $updown.scheduled}{if $updown.scheduled.is_cycle}{lang key='website/services/updown/scheduled-text-cycle' date=$updown.scheduled.date}{else}{lang key='website/services/updown/scheduled-text' plan=$updown.scheduled.plan date=$updown.scheduled.date}{/if}{/if}</span>
                                </div>
                                <button type="button" class="btn btn-sm btn-outline-info{if $updown.scheduled && !$updown.scheduled.cancellable} d-none{/if}" data-action="cancel-downgrade" data-busy-text="{lang key='website/services/updown/cancelling'}"><i class="bi bi-x-lg me-1"></i>{lang key='website/services/updown/cancel-change'}</button>
                            </div>

                            {capture name=updownCurrentCard}
                            <div>
                                <div class="card plan-card sd-plan-current h-100">
                                    <div class="card-body d-flex flex-column gap-3 p-4">
                                        <div>
                                            <div class="d-flex align-items-center flex-wrap gap-2 mb-1">
                                                <h4 class="mb-0">{$updown.current.title}</h4>
                                                <span class="badge bg-primary-subtle text-primary-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/updown/badge-current'}</span>
                                                <span class="badge bg-info-subtle text-info-emphasis{if !$updown.scheduled || $updown.scheduled.target_pid != $updown.current.id} d-none{/if}" data-role="dg-card-badge" data-plan-badge="{$updown.current.id}"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/services/updown/badge-scheduled'}</span>
                                            </div>
                                            <p class="fs-7 text-body-secondary mb-0">{lang key='website/services/updown/current-sub'}</p>
                                        </div>
                                        <div class="plan-price price-band">
                                            <div><span class="price-now num-tabular">{$updown.current.price_fmt}</span>{if $updown.current.cycle_short}<span class="fs-7 text-body-secondary">/{$updown.current.cycle_short}</span>{/if}</div>
                                        </div>
                                        {if $updown.current.features}
                                        <ul class="plan-features fs-7">
                                            {foreach $updown.current.features as $feat}
                                            <li><i class="bi bi-check2"></i>{$feat}</li>
                                            {/foreach}
                                        </ul>
                                        {/if}
                                        {if $updown.current.cycle_change}
                                        <div class="dropdown mt-auto">
                                            <button type="button" class="btn btn-soft w-100 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"{if $updown.locked} disabled{/if}><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/services/updown/current-btn-cycle'}</button>
                                            <ul class="dropdown-menu sd-menu sd-renew-menu w-100">
                                                <li><h6 class="dropdown-header">{lang key='website/services/updown/cycle-menu-header'}</h6></li>
                                                {foreach $updown.current.cycles as $ci => $cc}
                                                <li><button type="button" class="dropdown-item sd-renew-opt" data-action="plan-change" data-plan-id="{$updown.current.id}" data-cycle-idx="{$ci}"{if $updown.locked} disabled{/if}><span class="sd-renew-opt-label">{$cc.label}{if $cc.save_pct > 0} <span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-cash-coin me-1"></i>{lang key='website/products/category-save' pct=$cc.save_pct}</span>{/if}</span><span class="sd-renew-opt-price num-tabular">{$cc.amount_fmt}{if $cc.short}/{$cc.short}{/if}</span></button></li>
                                                {/foreach}
                                            </ul>
                                        </div>
                                        {else}
                                        <button type="button" class="btn btn-soft mt-auto" disabled>{lang key='website/services/updown/current-btn'}</button>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                            {/capture}

                            {if $updown.groups|@count > 1}
                            <ul class="nav nav-pills gap-1 justify-content-center mb-3" role="tablist">
                                {foreach $updown.groups as $g}
                                <li class="nav-item" role="presentation"><button class="nav-link{if $g@first} active{/if}" id="updown-cat-tab-{$g@index}" data-bs-toggle="tab" data-bs-target="#updown-cat-{$g@index}" type="button" role="tab" aria-controls="updown-cat-{$g@index}" aria-selected="{if $g@first}true{else}false{/if}">{if $g.icon.type == 'image'}<img src="{$g.icon.value}" alt="" class="me-1" style="height:1em;vertical-align:-0.125em">{else}<i class="{$g.icon.value} me-1"></i>{/if}{if $g.category}{$g.category}{else}{lang key='website/services/updown/group-other'}{/if}</button></li>
                                {/foreach}
                            </ul>
                            {/if}
                            <div class="tab-content">
                                {foreach $updown.groups as $g}
                                <div class="tab-pane fade{if $g@first} show active{/if}" id="updown-cat-{$g@index}" role="tabpanel" aria-labelledby="updown-cat-tab-{$g@index}" tabindex="0">
                                <div class="plan-grid pt-1">
                                {foreach $g.plans as $p}
                                {if $p.is_current|default:false}
                                {$smarty.capture.updownCurrentCard nofilter}
                                {else}
                                <div>
                                    <div class="card plan-card h-100">
                                        <div class="card-body d-flex flex-column gap-3 p-4">
                                            <div>
                                                <div class="d-flex align-items-center flex-wrap gap-2 mb-1">
                                                    <h4 class="mb-0">{$p.title}</h4>
                                                    <span class="badge bg-info-subtle text-info-emphasis{if !$updown.scheduled || $updown.scheduled.target_pid != $p.id} d-none{/if}" data-role="dg-card-badge" data-plan-badge="{$p.id}"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/services/updown/badge-scheduled'}</span>
                                                </div>
                                                {if $p.tagline}<p class="fs-7 text-body-secondary mb-0">{$p.tagline}</p>{/if}
                                            </div>
                                            <div class="plan-price price-band">
                                                <div><span class="price-now num-tabular">{$p.display.amount_fmt}</span><span class="fs-7 text-body-secondary">{if $p.display.short}/{$p.display.short}{/if}</span></div>
                                            </div>
                                            {if $p.features}
                                            <ul class="plan-features fs-7">
                                                {foreach $p.features as $feat}
                                                <li><i class="bi bi-check2"></i>{$feat}</li>
                                                {/foreach}
                                            </ul>
                                            {/if}
                                            <button type="button" class="btn {if $p.display.direction == 'up'}btn-primary{else}btn-soft{/if} mt-auto" data-action="plan-change" data-plan-id="{$p.id}"{if $updown.locked} disabled{/if}>
                                                <i class="bi {if $p.display.direction == 'up'}bi-arrow-up-circle{else}bi-arrow-down-circle{/if} me-1"></i>{if $p.display.direction == 'up'}{lang key='website/services/updown/cta-upgrade'}{else}{lang key='website/services/updown/cta-downgrade'}{/if}
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                {/if}
                                {/foreach}
                                </div>
                                </div>
                                {/foreach}
                            </div>
                        </section>
                    </div>
                    {/if}

                    <div class="tab-pane fade" id="sd-billing" role="tabpanel" aria-labelledby="sd-billing-tab" tabindex="0">
                        <div class="row g-3">
                            <div class="col-lg-5">
                                <section class="sd-panel">
                                    <h2 class="sd-panel-title"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/services/bill-renewal'}</h2>
                                    <dl class="sd-info mb-3">
                                        <div class="sd-info-row"><dt>{lang key='website/services/bill-next-due'}</dt><dd class="num-tabular">{if $s.expires}{$s.expires}{else}-{/if}</dd></div>
                                        <div class="sd-info-row"><dt>{lang key='website/services/bill-amount'}</dt><dd class="num-tabular">{if $s.renew_skipped}-{else}{$s.amount}{if $s.cycle_short}<span class="sd-fact-unit">/{$s.cycle_short}</span>{/if}{if $s.tax_inclusive}<span class="sd-fact-unit d-block" data-tax-incl>{lang key='website/services/updown/pc-tax-included'}</span>{/if}{/if}</dd></div>
                                        {if $s.cycle}<div class="sd-info-row"><dt>{lang key='website/services/f-cycle'}</dt><dd>{$s.cycle}</dd></div>{/if}
                                        {if $s.pay_method}<div class="sd-info-row"><dt>{lang key='website/services/bill-payment-method'}</dt><dd><span class="sd-card-brand"><i class="bi bi-credit-card-2-front me-1"></i>{$s.pay_method}</span></dd></div>{/if}
                                    </dl>
                                    {if $s.sub_blocked}
                                    <div class="d-flex align-items-center justify-content-between gap-2">
                                        <span class="fs-7">{lang key='website/services/autorenew-subscription-note'}</span>
                                        <a href="{$s.subscriptions_link}" class="badge bg-success-subtle text-success-emphasis text-decoration-none"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/services/autorenew-subscription'}</a>
                                    </div>
                                    {elseif $s.actionable && $s.account_autopay}
                                    <div class="sd-autorenew" data-state="on">
                                        <div class="form-check form-switch m-0" data-bs-toggle="tooltip" title="{lang key='website/account/autorenew-locked-account'}">
                                            <input class="form-check-input" type="checkbox" role="switch" id="sd-autorenew-bill" checked disabled aria-label="{lang key='website/services/autorenew-aria'}">
                                            <label class="form-check-label" for="sd-autorenew-bill">{lang key='website/services/bill-autorenew-label'}</label>
                                        </div>
                                        <p class="fs-7 text-body-secondary m-0">{lang key='website/account/autorenew-locked-account'}</p>
                                    </div>
                                    {elseif $s.actionable}
                                    <div class="sd-autorenew" data-state="{if $s.autorenew}on{else}off{/if}" data-has-payment-source="{if $s.has_pay_source}1{else}0{/if}">
                                        <div class="form-check form-switch m-0">
                                            <input class="form-check-input" type="checkbox" role="switch" id="sd-autorenew-bill" data-action="toggle-autorenew" data-id="{$s.id}" aria-label="{lang key='website/services/autorenew-aria'}"{if $s.autorenew} checked{/if}>
                                            <label class="form-check-label" for="sd-autorenew-bill">{lang key='website/services/bill-autorenew-label'}</label>
                                        </div>
                                        <p class="fs-7 text-body-secondary m-0">{lang key='website/services/bill-autorenew-note'}</p>
                                    </div>
                                    {else}
                                    <div class="d-flex align-items-center justify-content-between gap-2">
                                        <span class="fs-7">{lang key='website/services/bill-autorenew-label'}</span>
                                        <span class="badge {if $s.autorenew}bg-success-subtle text-success-emphasis{else}bg-secondary-subtle text-secondary-emphasis{/if}"><i class="bi {if $s.autorenew}bi-arrow-repeat{else}bi-dash-circle{/if} me-1"></i>{if $s.autorenew}{lang key='website/services/on'}{else}{lang key='website/services/off'}{/if}</span>
                                    </div>
                                    {/if}
                                    {if $updown.visible}
                                    <div class="mt-3">
                                        <button type="button" class="btn btn-soft w-100" data-action="show-tab" data-tab="sd-upgrade-tab"><i class="bi bi-arrow-down-up me-1"></i>{lang key='website/services/updown/tab'}</button>
                                    </div>
                                    {/if}
                                </section>
                            </div>
                            <div class="col-lg-7">
                                {if $is_self}
                                <section class="sd-panel mb-3">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-person-vcard me-1"></i>{lang key='website/services/bill-profile-title'}</h2>
                                        {if $billing_profiles}<button type="button" class="btn btn-soft btn-sm" data-wui-toggle data-wui-target="#sdBillingProfilePicker" aria-expanded="false" aria-controls="sdBillingProfilePicker"><i class="bi bi-pencil me-1"></i>{lang key='website/services/bill-profile-change'}</button>{/if}
                                    </div>
                                    <div class="wui-collapse wui-show" id="sdBillingProfileSummary">
                                        <div class="wui-collapse-inner">
                                            {if $billing_profile}
                                            <div class="sd-bprofile">
                                                <span class="sd-bprofile-ico"><i class="bi bi-person-vcard"></i></span>
                                                <div class="sd-bprofile-body">
                                                    <span class="sd-bprofile-name"><span data-role="assigned-name">{$billing_profile.name}</span>{if $billing_profile.default} <span class="badge bg-primary-subtle text-primary-emphasis ms-1" data-role="assigned-default"><i class="bi bi-star-fill me-1"></i>{lang key='website/services/bill-profile-default'}</span>{/if}</span>
                                                    <span class="sd-bprofile-addr" data-role="assigned-addr">{$billing_profile.address}</span>
                                                </div>
                                            </div>
                                            {else}
                                            <p class="fs-7 text-body-secondary mb-2">{lang key='website/services/bill-profile-none'}</p>
                                            <a href="{link route='info'}#contacts" class="btn btn-soft btn-sm"><i class="bi bi-person-plus me-1"></i>{lang key='website/services/bill-profile-none-cta'}</a>
                                            {/if}
                                        </div>
                                    </div>
                                    {if $billing_profiles}
                                    <div class="wui-collapse" id="sdBillingProfilePicker">
                                        <div class="wui-collapse-inner">
                                            <div class="pt-1">
                                                <div class="input-group">
                                                    <select class="form-select" id="sdBillingProfileSelect" data-role="bprofile-select" aria-label="{lang key='website/services/bill-profile-title'}">
                                                        {foreach $billing_profiles as $bp}
                                                        <option value="{$bp.id}" data-profile-name="{$bp.name}" data-profile-addr="{$bp.address}" data-profile-default="{if $bp.default}1{else}0{/if}"{if $billing_profile && $bp.id == $billing_profile.id} selected{/if}>{$bp.name}{if $bp.place} - {$bp.place}{/if}{if $bp.default} ({lang key='website/services/bill-profile-default'}){/if}</option>
                                                        {/foreach}
                                                    </select>
                                                    <button type="button" class="btn btn-primary" data-action="assign-billing-profile" data-id="{$s.id}" data-busy-text="{lang key='website/services/bill-profile-saving'}">{lang key='website/services/bill-profile-save'}</button>
                                                </div>
                                                <p class="form-text mb-0" data-role="bprofile-preview">{if $billing_profile}{$billing_profile.address}{/if}</p>
                                            </div>
                                        </div>
                                    </div>
                                    {/if}
                                </section>
                                {/if}
                                <section class="sd-panel">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-receipt me-1"></i>{lang key='website/services/bill-invoices-title'}</h2>
                                        {if $related_invoices}<a class="fs-7 fw-semibold sd-seeall" href="{link route='invoices'}">{lang key='website/services/bill-invoices-viewall'}<i class="bi bi-chevron-right ms-1"></i></a>{/if}
                                    </div>
                                    {if $related_invoices}
                                    <ul class="sd-invoices">
                                        {foreach $related_invoices as $inv}
                                        <li class="sd-invoice">
                                            <span class="sd-invoice-ico"><i class="bi bi-receipt"></i></span>
                                            <div class="sd-invoice-body">
                                                <a class="sd-invoice-no num-tabular" href="{$inv.link}">{$inv.number}</a>
                                                {if $inv.badge == 'paid' || $inv.badge == 'refunded'}<span class="sd-invoice-date num-tabular">{lang key='website/services/bill-inv-paid'} {$inv.date}</span>
                                                {elseif $inv.badge == 'cancelled'}<span class="sd-invoice-date num-tabular">{$inv.date}</span>
                                                {else}<span class="sd-invoice-date num-tabular">{lang key='website/services/bill-inv-due'} {if $inv.due}{$inv.due}{else}{$inv.date}{/if}</span>{/if}
                                            </div>
                                            {if $inv.badge == 'paid'}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/inv-st-paid'}</span>
                                            {elseif $inv.badge == 'overdue'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/services/inv-st-overdue'}</span>
                                            {elseif $inv.badge == 'refunded'}<span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/services/inv-st-refunded'}</span>
                                            {elseif $inv.badge == 'cancelled'}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/services/inv-st-cancelled'}</span>
                                            {elseif $inv.badge == 'waiting'}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-clock me-1"></i>{lang key='website/services/inv-st-waiting'}</span>
                                            {else}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/services/inv-st-unpaid'}</span>{/if}
                                            <span class="sd-invoice-amount num-tabular">{$inv.total_fmt}</span>
                                            {if $inv.badge == 'unpaid' || $inv.badge == 'overdue'}
                                            <a class="btn btn-soft btn-sm" href="{$inv.link}"><i class="bi bi-credit-card me-1"></i>{lang key='website/services/bill-invoice-pay'}</a>
                                            {else}
                                            <a class="btn btn-soft btn-sm" href="{$inv.link}"><i class="bi bi-eye me-1"></i>{lang key='website/services/bill-invoice-view'}</a>
                                            {/if}
                                        </li>
                                        {/foreach}
                                    </ul>
                                    {else}
                                    <div class="wstyle-empty-state">
                                        <i class="bi bi-receipt"></i>
                                        <p class="mb-0">{lang key='website/services/bill-invoices-empty'}</p>
                                    </div>
                                    {/if}
                                </section>
                            </div>
                        </div>
                    </div>

                    {if $metering.show}
                    <div class="tab-pane fade" id="sd-metering" role="tabpanel" aria-labelledby="sd-metering-tab" tabindex="0">
                        {if $metering.has_unpaid}
                        <div class="alert alert-warning d-flex align-items-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2"></i>
                            <div class="fs-7">{lang key='website/services/metering/unpaid-note'}</div>
                        </div>
                        {/if}
                        <section class="sd-panel mb-3">
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-speedometer2 me-1"></i>{lang key='website/services/metering/title'}</h2>
                            </div>
                            <div class="alert alert-info d-flex align-items-center" role="alert">
                                <i class="bi bi-info-circle flex-shrink-0 me-2"></i>
                                <div class="fs-7">{lang key='website/services/metering/billing-note'}</div>
                            </div>
                            {if $metering.rows}
                            <ul class="sd-invoices sd-metering-list">
                                {foreach $metering.rows as $m}
                                <li class="sd-invoice" data-metric-row="{$m.key}">
                                    <span class="sd-invoice-ico"><i class="bi bi-speedometer2"></i></span>
                                    <div class="sd-invoice-body">
                                        <span class="fw-semibold">{$m.label}</span>
                                        <span class="sd-invoice-date num-tabular">{lang key='website/services/metering/this-period'}: {if $m.has_usage}{$m.usage}{else}0{/if}{if $m.unit} {$m.unit}{/if} &middot; {lang key='website/services/metering/included'}: {$m.included}{if $m.unit} {$m.unit}{/if}{if $m.has_overage} &middot; <span class="text-warning-emphasis">{lang key='website/services/metering/overage'}: {$m.overage}{if $m.unit} {$m.unit}{/if}</span>{/if}</span>
                                        {if $m.unit_price_fmt}<span class="sd-invoice-date num-tabular">{lang key='website/services/metering/unit-price'}: {$m.unit_price_fmt}{if $m.unit}/{$m.unit}{/if}</span>{/if}
                                        {if $m.auto_disabled}<span class="fs-7 text-danger"><i class="bi bi-exclamation-triangle me-1"></i>{lang key='website/services/metering/auto-off-note'}</span>{/if}
                                    </div>
                                    {if $m.estimate_fmt}
                                    <div class="text-end d-none d-sm-block">
                                        <span class="fs-7 text-body-secondary d-block">{lang key='website/services/metering/estimate'}</span>
                                        <span class="fw-semibold num-tabular">{$m.estimate_fmt}</span>
                                    </div>
                                    {/if}
                                    <button type="button" class="btn btn-soft btn-sm" data-action="metric-chart" data-metric="{$m.key}" data-label="{$m.label}" aria-label="{lang key='website/services/metering/chart'}"><i class="bi bi-graph-up"></i></button>
                                    <button type="button" class="btn btn-soft btn-sm" data-action="metric-invoices" data-metric="{$m.key}" data-label="{$m.label}" aria-label="{lang key='website/services/metering/inv-modal-title'}"><i class="bi bi-receipt"></i></button>
                                    {if $m.locked}
                                    <div class="text-end">
                                        <div class="form-check form-switch m-0 d-inline-block">
                                            <input class="form-check-input" type="checkbox" role="switch" disabled{if $m.enabled} checked{/if} aria-label="{$m.label}">
                                        </div>
                                        <a class="badge bg-danger-subtle text-danger-emphasis text-decoration-none d-block mt-1" href="{$m.unpaid_link}"><i class="bi bi-lock me-1"></i>{lang key='website/services/metering/locked-badge'} {$m.unpaid_no}</a>
                                    </div>
                                    {elseif $metering.can_toggle}
                                    <div class="form-check form-switch m-0">
                                        <input class="form-check-input" type="checkbox" role="switch" data-action="toggle-metric" data-metric="{$m.key}"{if $m.enabled} checked{/if} aria-label="{$m.label}">
                                    </div>
                                    {else}
                                    <span class="badge {if $m.enabled}bg-success-subtle text-success-emphasis{else}bg-secondary-subtle text-secondary-emphasis{/if}"><i class="bi {if $m.enabled}bi-check-circle{else}bi-dash-circle{/if} me-1"></i>{if $m.enabled}{lang key='website/services/on'}{else}{lang key='website/services/off'}{/if}</span>
                                    {/if}
                                </li>
                                {/foreach}
                            </ul>
                            {else}
                            <div class="wstyle-empty-state">
                                <i class="bi bi-speedometer2"></i>
                                <p class="mb-0">{lang key='website/services/metering/empty'}</p>
                            </div>
                            {/if}
                        </section>
                        <section class="sd-panel" data-role="metering-history-panel"
                            data-txt-h-paid="{lang key='website/services/inv-st-paid'}"
                            data-txt-h-unpaid="{lang key='website/services/inv-st-unpaid'}"
                            data-txt-h-cancelled="{lang key='website/services/inv-st-cancelled'}"
                            data-txt-h-pending="{lang key='website/services/metering/h-pending'}"
                            data-txt-h-usage="{lang key='website/services/metering/h-usage'}"
                            data-txt-h-overage="{lang key='website/services/metering/overage'}"
                            data-txt-pay="{lang key='website/services/bill-invoice-pay'}"
                            data-txt-view="{lang key='website/services/bill-invoice-view'}">
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-receipt me-1"></i>{lang key='website/services/metering/history-title'}</h2>
                            </div>
                            {if $metering.history}
                            <ul class="sd-invoices sd-metering-list" data-role="metering-history">
                                {foreach $metering.history as $h}
                                <li class="sd-invoice">
                                    <span class="sd-invoice-ico"><i class="bi bi-calendar3"></i></span>
                                    <div class="sd-invoice-body">
                                        <span class="fw-semibold">{$h.metric}</span>
                                        <span class="sd-invoice-date num-tabular">{$h.period} &middot; {lang key='website/services/metering/h-usage'}: {$h.usage}{if $h.unit} {$h.unit}{/if} &middot; {lang key='website/services/metering/overage'}: {$h.overage}{if $h.unit} {$h.unit}{/if}</span>
                                    </div>
                                    {if $h.state == 'paid'}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/inv-st-paid'}</span>
                                    {elseif $h.state == 'unpaid'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/services/inv-st-unpaid'}</span>
                                    {elseif $h.state == 'cancelled'}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/services/inv-st-cancelled'}</span>
                                    {else}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-clock me-1"></i>{lang key='website/services/metering/h-pending'}</span>{/if}
                                    <span class="sd-invoice-amount num-tabular">{$h.amount}</span>
                                    {if $h.inv_link}
                                    <a class="btn btn-soft btn-sm" href="{$h.inv_link}">{if $h.state == 'unpaid'}<i class="bi bi-credit-card me-1"></i>{lang key='website/services/bill-invoice-pay'}{else}<i class="bi bi-eye me-1"></i>{lang key='website/services/bill-invoice-view'}{/if}</a>
                                    {/if}
                                </li>
                                {/foreach}
                            </ul>
                            {if $metering.history_more}
                            <div class="text-center mt-2">
                                <button type="button" class="btn btn-soft btn-sm" data-action="metering-more" data-offset="10"><i class="bi bi-chevron-down me-1"></i>{lang key='website/services/metering/load-more'}</button>
                            </div>
                            {/if}
                            {else}
                            <div class="wstyle-empty-state">
                                <i class="bi bi-receipt"></i>
                                <p class="mb-0">{lang key='website/services/metering/history-empty'}</p>
                            </div>
                            {/if}
                        </section>
                    </div>
                    {/if}

                    {if $serviceTransferTab}
                    {include file='components/service-transfer.tpl'}
                    {/if}

                    <div class="tab-pane fade" id="sd-activity" role="tabpanel" aria-labelledby="sd-activity-tab" tabindex="0">
                        <section class="sd-panel">
                            <h2 class="sd-panel-title mb-3"><i class="bi bi-clock-history me-1"></i>{lang key='website/services/tab-activity'}</h2>
                            {if $activity}
                            <ol class="sd-timeline">
                                {foreach $activity as $ev}
                                <li class="sd-event">
                                    <span class="sd-event-dot sd-event-{$ev.tone}"><i class="bi {$ev.icon}"></i></span>
                                    <div class="sd-event-body">
                                        <span class="sd-event-text">{$ev.text}</span>
                                        <span class="sd-event-time num-tabular">{$ev.time}</span>
                                    </div>
                                </li>
                                {/foreach}
                            </ol>
                            {else}
                            <div class="wstyle-empty-state">
                                <i class="bi bi-clock-history"></i>
                                <p class="mb-0">{lang key='website/services/act-empty'}</p>
                            </div>
                            {/if}
                        </section>
                    </div>

                    {if $cancel.show}
                    <div class="tab-pane fade" id="sd-cancel" role="tabpanel" aria-labelledby="sd-cancel-tab" tabindex="0"
                        data-txt-cons-stop-now="{lang key='website/services/cancel/cons-stop-now'}"
                        data-txt-cons-data-end="{lang key='website/services/cancel/cons-data-end' date=$cancel.due}"
                        data-txt-cons-data-now="{lang key='website/services/cancel/cons-data-now'}"
                        data-txt-cons-refund-end="{lang key='website/services/cancel/cons-refund-end'}"
                        data-txt-cons-refund-now="{lang key='website/services/cancel/cons-refund-now'}"
                        data-txt-when-end="{lang key='website/services/cancel/req-when-end'}"
                        data-txt-when-now="{lang key='website/services/cancel/req-when-now'}"
                        data-txt-desc-pending="{lang key='website/services/cancel/desc-pending' date=$cancel.due}"
                        data-txt-desc-now="{lang key='website/services/cancel/desc-now'}"
                        data-txt-t-pending="{lang key='website/services/cancel/alert-t-pending'}"
                        data-due-date="{$cancel.due}">

                        <section class="sd-panel{if $cancel.open} d-none{/if}" data-cancel-state="form">
                            <h2 class="sd-panel-title"><i class="bi bi-x-circle me-1"></i>{lang key='website/services/cancel/form-title'}</h2>
                            <p class="fs-7 text-body-secondary mb-4">{lang key='website/services/cancel/form-sub'}</p>
                            <div class="sd-cancel-grid">

                                <div class="sd-cancel-svc">
                                    <span class="sd-cancel-svc-ico"><i class="{$s.type_icon}"></i></span>
                                    <div class="sd-cancel-svc-id">
                                        <span class="sd-cancel-svc-name fw-semibold">{$s.name}
                                            {if $s.badge == 'suspended'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-pause-circle me-1"></i>{$s.status_label}</span>
                                            {elseif $s.badge == 'expired'}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-calendar-x me-1"></i>{$s.status_label}</span>
                                            {else}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{$s.status_label}</span>{/if}
                                        </span>
                                        {if $cancel.due}<span class="fs-7 text-body-secondary">{lang key='website/services/cancel/active-until'} <span class="num-tabular">{$cancel.due}</span></span>{/if}
                                    </div>
                                </div>

                                {if $updown.visible || $show_support}
                                <div class="sd-cancel-alt">
                                    <span class="sd-cancel-alt-label fs-7 fw-semibold text-body-secondary d-block mb-2">{lang key='website/services/cancel/alt-label'}</span>
                                    <div class="sd-cancel-alt-grid sd-offer-grid">
                                        {if $updown.visible}
                                        <div class="sd-offer">
                                            <span class="sd-offer-ico"><i class="bi bi-arrow-down-circle"></i></span>
                                            <div class="sd-offer-body">
                                                <span class="sd-offer-name">{lang key='website/services/cancel/alt-plan-title'}</span>
                                                <span class="sd-offer-note">{lang key='website/services/cancel/alt-plan-note'}</span>
                                            </div>
                                            <div class="sd-offer-foot">
                                                <button type="button" class="btn btn-soft btn-sm" data-action="show-tab" data-tab="sd-upgrade-tab"><i class="bi bi-arrow-down-up me-1"></i>{lang key='website/services/cancel/alt-plan-cta'}</button>
                                            </div>
                                        </div>
                                        {/if}
                                        {if $show_support}
                                        <div class="sd-offer">
                                            <span class="sd-offer-ico"><i class="bi bi-life-preserver"></i></span>
                                            <div class="sd-offer-body">
                                                <span class="sd-offer-name">{lang key='website/services/cancel/alt-support-title'}</span>
                                                <span class="sd-offer-note">{lang key='website/services/cancel/alt-support-note'}</span>
                                            </div>
                                            <div class="sd-offer-foot">
                                                <a class="btn btn-soft btn-sm" href="{link route='ticket-create'}?service={$s.id}"><i class="bi bi-plus-lg me-1"></i>{lang key='website/services/open-ticket'}</a>
                                            </div>
                                        </div>
                                        {/if}
                                    </div>
                                </div>
                                {/if}

                                <div class="sd-cancel-decide">
                                    <div class="sd-cancel-group">
                                        <span class="form-label d-block mb-2">{lang key='website/services/cancel/reason-label'}</span>
                                        <div class="sd-cancel-reasons" role="radiogroup" aria-label="{lang key='website/services/cancel/reason-label'}">
                                            <label class="sd-cancel-chip"><input class="form-check-input visually-hidden" type="radio" name="sd-cancel-reason" value="not-needed" checked><i class="bi bi-box-seam"></i><span>{lang key='website/services/cancel/reason-not-needed'}</span></label>
                                            <label class="sd-cancel-chip"><input class="form-check-input visually-hidden" type="radio" name="sd-cancel-reason" value="too-expensive"><i class="bi bi-cash-coin"></i><span>{lang key='website/services/cancel/reason-too-expensive'}</span></label>
                                            <label class="sd-cancel-chip"><input class="form-check-input visually-hidden" type="radio" name="sd-cancel-reason" value="switching"><i class="bi bi-arrow-left-right"></i><span>{lang key='website/services/cancel/reason-switching'}</span></label>
                                            <label class="sd-cancel-chip"><input class="form-check-input visually-hidden" type="radio" name="sd-cancel-reason" value="missing-features"><i class="bi bi-puzzle"></i><span>{lang key='website/services/cancel/reason-missing-features'}</span></label>
                                            <label class="sd-cancel-chip"><input class="form-check-input visually-hidden" type="radio" name="sd-cancel-reason" value="other"><i class="bi bi-three-dots"></i><span>{lang key='website/services/cancel/reason-other'}</span></label>
                                        </div>
                                        <div class="wui-collapse" id="sd-cancel-other">
                                            <div class="wui-collapse-inner">
                                                <div class="pt-3">
                                                    <label class="form-label fs-7" for="sd-cancel-reason-other">{lang key='website/services/cancel/reason-other-label'}</label>
                                                    <input type="text" class="form-control" id="sd-cancel-reason-other" name="sd-cancel-reason-detail" maxlength="300" placeholder="{lang key='website/services/cancel/reason-other-ph'}">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sd-cancel-group">
                                        <span class="form-label d-block mb-2">{lang key='website/services/cancel/when-label'}</span>
                                        <div class="sd-cancel-when-grid">
                                            {if !$cancel.lifetime}
                                            <label class="sd-cancel-when-card sd-cancel-when--end">
                                                <input class="form-check-input visually-hidden" type="radio" name="sd-cancel-when" id="sd-when-end" value="end" checked>
                                                <span class="sd-cancel-when-ico"><i class="bi bi-calendar-check"></i></span>
                                                <span class="sd-cancel-when-body">
                                                    <span class="sd-cancel-when-title">{lang key='website/services/cancel/when-end-title'} <span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/cancel/when-recommended'}</span></span>
                                                    <span class="sd-cancel-when-desc fs-7 text-body-secondary">{lang key='website/services/cancel/when-end-desc' date=$cancel.due}</span>
                                                </span>
                                            </label>
                                            {/if}
                                            <label class="sd-cancel-when-card sd-cancel-when--now">
                                                <input class="form-check-input visually-hidden" type="radio" name="sd-cancel-when" id="sd-when-now" value="now"{if $cancel.lifetime} checked{/if}>
                                                <span class="sd-cancel-when-ico"><i class="bi bi-stop-circle"></i></span>
                                                <span class="sd-cancel-when-body">
                                                    <span class="sd-cancel-when-title">{lang key='website/services/cancel/when-now-title'}</span>
                                                    <span class="sd-cancel-when-desc fs-7 text-body-secondary">{lang key='website/services/cancel/when-now-desc'}</span>
                                                </span>
                                            </label>
                                        </div>
                                    </div>

                                    <div class="sd-cancel-group sd-cancel-note-group">
                                        <label class="form-label" for="sd-cancel-note"><i class="bi bi-chat-left-text me-1"></i>{lang key='website/services/cancel/note-label'} <span class="fw-normal text-body-secondary">({lang key='website/services/cancel/note-optional'})</span></label>
                                        <textarea class="form-control" id="sd-cancel-note" rows="3" maxlength="500" placeholder="{lang key='website/services/cancel/note-ph'}"></textarea>
                                    </div>
                                </div>

                                <aside class="sd-cancel-aside">
                                    <div class="sd-cancel-cons" data-role="cancel-consequences">
                                        <h3 class="sd-cancel-cons-title"><i class="bi bi-info-circle me-2"></i>{lang key='website/services/cancel/cons-title'}</h3>
                                        <ul class="sd-cancel-cons-list" aria-live="polite">
                                            <li class="sd-cancel-cons-row">
                                                <span class="sd-cancel-cons-ico"><i class="bi bi-calendar-event" data-role="cons-stop-ico"></i></span>
                                                <span class="sd-cancel-cons-cell"><span class="sd-cancel-cons-label">{lang key='website/services/cancel/cons-stop'}</span><span class="sd-cancel-cons-value num-tabular" data-role="cons-stop">{$cancel.due}</span></span>
                                            </li>
                                            <li class="sd-cancel-cons-row">
                                                <span class="sd-cancel-cons-ico"><i class="bi bi-arrow-repeat"></i></span>
                                                <span class="sd-cancel-cons-cell"><span class="sd-cancel-cons-label">{lang key='website/services/cancel/cons-renew'}</span><span class="sd-cancel-cons-value">{lang key='website/services/cancel/cons-renew-off'}</span></span>
                                            </li>
                                            <li class="sd-cancel-cons-row">
                                                <span class="sd-cancel-cons-ico"><i class="bi bi-database" data-role="cons-data-ico"></i></span>
                                                <span class="sd-cancel-cons-cell"><span class="sd-cancel-cons-label">{lang key='website/services/cancel/cons-data'}</span><span class="sd-cancel-cons-value" data-role="cons-data">{lang key='website/services/cancel/cons-data-end' date=$cancel.due}</span></span>
                                            </li>
                                            <li class="sd-cancel-cons-row">
                                                <span class="sd-cancel-cons-ico"><i class="bi bi-cash-coin" data-role="cons-refund-ico"></i></span>
                                                <span class="sd-cancel-cons-cell"><span class="sd-cancel-cons-label">{lang key='website/services/cancel/cons-refund'}</span><span class="sd-cancel-cons-value" data-role="cons-refund">{lang key='website/services/cancel/cons-refund-end'}</span></span>
                                            </li>
                                        </ul>
                                        <div class="sd-cancel-cons-foot fs-7 text-body-secondary"><i class="bi bi-shield-check me-1"></i>{lang key='website/services/cancel/cons-foot'}</div>
                                    </div>
                                </aside>

                                <div class="d-flex flex-wrap justify-content-end gap-2 sd-cancel-actions">
                                    <button type="button" class="btn btn-soft" data-action="show-tab" data-tab="sd-overview-tab"><i class="bi bi-arrow-left me-1"></i>{lang key='website/services/cancel/keep'}</button>
                                    <button type="button" class="btn btn-danger" data-action="cancel-service"><i class="bi bi-x-circle me-1"></i>{lang key='website/services/cancel/request-cta'}</button>
                                </div>

                            </div>
                        </section>

                        <section class="sd-panel{if !$cancel.open} d-none{/if}" data-cancel-state="requested">
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-x-circle me-1"></i>{lang key='website/services/cancel/req-title'}</h2>
                                <span class="fs-7 text-body-secondary num-tabular" data-role="creq-id">{if $cancel.open}#CR-{$cancel.id}{/if}</span>
                            </div>

                            <div class="sd-cancel-status">
                                <span class="sd-cancel-status-ico"><i class="bi bi-hourglass-split"></i></span>
                                <div class="sd-cancel-status-body">
                                    <span class="sd-cancel-status-title"><span data-role="creq-title">{if $cancel.state == 'approved'}{lang key='website/services/cancel/alert-t-scheduled'}{else}{lang key='website/services/cancel/alert-t-pending'}{/if}</span>
                                        <span class="badge bg-danger-subtle text-danger-emphasis{if $cancel.state != 'approved'} d-none{/if}" data-role="creq-badge-scheduled"><i class="bi bi-calendar-check me-1"></i>{lang key='website/services/cancel/badge-scheduled'}</span>
                                        <span class="badge bg-warning-subtle text-warning-emphasis{if $cancel.state == 'approved'} d-none{/if}" data-role="creq-badge-pending"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/services/cancel/badge-pending'}</span>
                                    </span>
                                    <span class="sd-cancel-status-desc text-body-secondary" data-role="creq-desc">{if $cancel.open}{if $cancel.urgency == 'now'}{lang key='website/services/cancel/desc-now'}{elseif $cancel.state == 'approved'}{lang key='website/services/cancel/desc-scheduled' date=$cancel.due}{else}{lang key='website/services/cancel/desc-pending' date=$cancel.due}{/if}{/if}</span>
                                </div>
                            </div>

                            <dl class="sd-cancel-req">
                                <div class="sd-cancel-req-row">
                                    <dt><i class="bi bi-calendar-plus me-1"></i>{lang key='website/services/cancel/req-requested'}</dt>
                                    <dd class="num-tabular" data-role="creq-date">{$cancel.requested}</dd>
                                </div>
                                <div class="sd-cancel-req-row">
                                    <dt><i class="bi bi-calendar-event me-1"></i>{lang key='website/services/cancel/req-stops'}</dt>
                                    <dd><span class="num-tabular" data-role="creq-stop">{if $cancel.urgency == 'now'}{lang key='website/services/cancel/cons-stop-now'}{else}{$cancel.due}{/if}</span> <span class="text-body-secondary fs-7" data-role="creq-when">{if $cancel.urgency == 'now'}{lang key='website/services/cancel/req-when-now'}{else}{lang key='website/services/cancel/req-when-end'}{/if}</span></dd>
                                </div>
                                <div class="sd-cancel-req-row">
                                    <dt><i class="bi bi-chat-square-text me-1"></i>{lang key='website/services/cancel/req-reason'}</dt>
                                    <dd data-role="creq-reason">{$cancel.reason}</dd>
                                </div>
                                <div class="sd-cancel-req-row">
                                    <dt><i class="bi bi-cash-coin me-1"></i>{lang key='website/services/cancel/cons-refund'}</dt>
                                    <dd data-role="creq-refund">{if $cancel.urgency == 'now'}{lang key='website/services/cancel/cons-refund-now'}{else}{lang key='website/services/cancel/cons-refund-end'}{/if}</dd>
                                </div>
                            </dl>

                            <div class="sd-cancel-req-note text-body-secondary"><i class="bi bi-shield-check me-1"></i>{lang key='website/services/cancel/req-note'}</div>

                            <div class="d-flex flex-wrap justify-content-end gap-2 sd-cancel-actions">
                                {if $show_support}<a class="btn btn-soft" href="{link route='ticket-create'}?service={$s.id}"><i class="bi bi-life-preserver me-1"></i>{lang key='website/services/cancel/contact-support'}</a>{/if}
                                <button type="button" class="btn btn-success" data-action="revoke-cancellation" data-busy-text="{lang key='website/services/cancel/revoking'}"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/services/cancel/keep'}</button>
                            </div>
                        </section>
                    </div>
                    {/if}

                    {hook name='ui:client.service_detail.panes.end'}

                </div>
            </div>
        </div>

        {if $show_support}
        <section class="sd-help">
            <div class="sd-help-text">
                <span class="sd-help-ico"><i class="bi bi-life-preserver"></i></span>
                <div>
                    <h2 class="sd-help-title">{lang key='website/services/help-title'}</h2>
                    <p class="sd-help-sub">{lang key='website/services/help-sub'}</p>
                </div>
            </div>
            <div class="sd-help-actions">
                <a class="btn btn-primary btn-sm" href="{link route='ticket-create'}?service={$s.id}"><i class="bi bi-plus-lg me-1"></i>{lang key='website/services/open-ticket'}</a>
            </div>
        </section>
        {/if}

    </div>
</section>
{/block}

{block name=body_end}
{if $s.type == 'software' && $s.sw.can_change_domain}
<div class="modal fade" id="sd-swdomain-modal" tabindex="-1" aria-labelledby="sd-swdomain-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="sd-swdomain-title"><i class="bi bi-globe2 me-1"></i>{lang key='website/services/sw/domain-modal-title'}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/services/btn-cancel'}"></button>
            </div>
            <div class="modal-body">
                <p class="fs-7 text-body-secondary mb-3">{lang key='website/services/sw/domain-modal-desc'}</p>
                <label class="form-label" for="sd-swdomain-input">{lang key='website/services/sw/domain-modal-label'}</label>
                <input type="text" class="form-control" id="sd-swdomain-input" value="{$s.sw.domain}" placeholder="example.com" autocomplete="off">
                <div class="invalid-feedback" data-role="swdomain-feedback"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/services/btn-cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="change-domain-save" data-busy-text="{lang key='website/services/sw/domain-modal-saving'}">{lang key='website/services/sw/domain-modal-save'}</button>
            </div>
        </div>
    </div>
</div>
{/if}
{if $addons_available}
{foreach $addons_available as $of}
{if count($of.options) > 1}
<div class="modal fade" id="sdAddonModal{$of.id}" tabindex="-1" aria-labelledby="sdAddonModal{$of.id}Label" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered{if $of.list_template == 1} modal-lg{/if}">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title d-flex align-items-center gap-2" id="sdAddonModal{$of.id}Label">{if $of.icon}<span class="label-media">{if $of.icon.type == 'image'}<img src="{$of.icon.value}" alt="">{else}<i class="{$of.icon.value}"></i>{/if}</span>{else}<i class="bi bi-puzzle"></i>{/if}{$of.name}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/services/btn-cancel'}"></button>
            </div>
            <div class="modal-body" data-addon-panel data-addon-id="{$of.id}" data-addon-type="{$of.type}" data-min="{$of.min}" data-max="{$of.max}" data-step="{$of.step}">
                {if $of.description}<p class="fs-7 text-body-secondary mb-3">{$of.description nofilter}</p>{/if}
                <div class="{if $of.list_template == 1}row g-2{else}d-grid gap-2{/if}">
                    {foreach $of.options as $opt}
                    {if $of.list_template == 1}<div class="col-12 col-sm-6">{/if}
                    <label class="option-card option-card-radio{if $of.list_template == 1} option-card-sm h-100{/if}">
                        <input class="form-check-input" type="radio" name="sdao-{$of.id}" value="{$opt.id}" data-first="{$opt.first_unit}" data-renew="{$opt.renew_unit}" data-aligned="{if $opt.aligned}1{else}0{/if}" data-cycle-word="{$opt.cycle_word}"{if $opt@first} checked{/if}>
                        <span class="d-flex align-items-center gap-2">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="fw-semibold">{$opt.name}</span></span>
                        {if $opt.description}<span class="fs-8 text-body-secondary d-block my-1">{$opt.description nofilter}</span>{/if}
                        <span class="price-chip">{if $opt.free}{lang key='website/services/addon-free'}{else}{$opt.unit_fmt}{/if}</span>
                    </label>
                    {if $of.list_template == 1}</div>{/if}
                    {/foreach}
                </div>
                {if $of.type == 'quantity'}
                <div class="range-field{if count($of.options) > 1} mt-3{/if}">
                    <div class="range-field-head">
                        <label class="fw-semibold mb-0 me-auto" for="sd-addon-qty-{$of.id}">{lang key='website/services/addon-qty'}</label>
                        <input type="number" class="range-value num-tabular fw-semibold" id="sd-addon-qty-val-{$of.id}" data-qty-display value="{$of.min}" min="{$of.min}" max="{$of.max}" step="{$of.step}" inputmode="numeric" aria-label="{lang key='website/services/addon-qty'}">
                    </div>
                    <input type="range" class="form-range range-fill" id="sd-addon-qty-{$of.id}" data-role="qty-input" min="{$of.min}" max="{$of.max}" step="{$of.step}" value="{$of.min}">
                    <div class="range-ticks" aria-hidden="true"><span>{$of.min}</span><span>{$of.max}</span></div>
                </div>
                {/if}
                <div class="sd-addon-pop-foot">
                    <div class="sd-addon-pop-sum">
                        <span class="fs-7">{lang key='website/services/addon-first-term'}: <strong class="num-tabular" data-role="addon-first"></strong></span>
                        <span class="fs-8 text-body-secondary" data-role="addon-renew"></span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/services/btn-cancel'}</button>
                <button type="button" class="btn btn-secondary" data-action="addon-add" data-busy-text="{lang key='website/services/working'}"><i class="bi bi-cart-plus me-1"></i>{lang key='website/services/addon-add-cart'}</button>
            </div>
        </div>
    </div>
</div>
{/if}
{/foreach}
{/if}

{if $updown.visible}
<div class="modal fade" id="sd-plan-change" tabindex="-1" aria-labelledby="sd-plan-change-title" aria-hidden="true"
     data-txt-title-up="{lang key='website/services/updown/pc-title-up'}"
     data-txt-title-down="{lang key='website/services/updown/pc-title-down'}"
     data-txt-title-cycle="{lang key='website/services/updown/pc-title-cycle'}"
     data-txt-sub-up="{lang key='website/services/updown/pc-sub-up'}"
     data-txt-sub-down="{lang key='website/services/updown/pc-sub-down'}"
     data-txt-note-up="{lang key='website/services/updown/pc-note-up'}"
     data-txt-note-down="{lang key='website/services/updown/pc-note-down'}"
     data-txt-sum-up="{lang key='website/services/updown/pc-sum-up'}"
     data-txt-sum-down="{lang key='website/services/updown/pc-sum-down'}"
     data-txt-credit="{lang key='website/services/updown/pc-credit'}"
     data-txt-credit-1="{lang key='website/services/updown/pc-credit-1'}"
     data-txt-confirm-up="{lang key='website/services/updown/pc-confirm-up'}"
     data-txt-confirm-down="{lang key='website/services/updown/pc-confirm-down'}"
     data-txt-confirm-cycle="{lang key='website/services/updown/pc-confirm-cycle'}"
     data-txt-scheduled-cycle="{lang key='website/services/updown/scheduled-text-cycle'}"
     data-txt-scheduled-title="{lang key='website/services/updown/scheduled-title'}"
     data-txt-scheduled-title-cycle="{lang key='website/services/updown/scheduled-title-cycle'}"
     data-txt-busy-up="{lang key='website/services/updown/pc-busy-up'}"
     data-txt-busy-down="{lang key='website/services/updown/pc-busy-down'}"
     data-txt-move-free="{lang key='website/services/updown/move-free'}"
     data-txt-move-charge="{lang key='website/services/updown/move-charge'}"
     data-txt-move-no-option="{lang key='website/services/updown/move-no-option'}"
     data-txt-done="{lang key='website/services/updown/pc-done'}"
     data-txt-save="{lang key='website/products/category-save'}"
     data-txt-scheduled="{lang key='website/services/updown/pc-scheduled-text'}">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon" data-role="pc-ico"><i class="bi bi-arrow-up-circle"></i></span>
                <div class="modal-titles">
                    <h5 class="modal-title" id="sd-plan-change-title" data-role="pc-title"></h5>
                    <p class="modal-subtitle" data-role="pc-sub"></p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/services/btn-cancel'}"></button>
            </div>
            <div class="modal-body">
                <div class="sd-pc-compare">
                    <div class="sd-pc-plan">
                        <div class="sd-pc-plan-id">
                            <span class="sd-pc-tag">{lang key='website/services/updown/pc-cur-tag'}</span>
                            <span class="sd-pc-name" data-role="pc-cur-name"></span>
                        </div>
                        <div class="sd-pc-rate"><span class="num-tabular" data-role="pc-cur-price"></span></div>
                    </div>
                    <span class="sd-pc-arrow" aria-hidden="true"><i class="bi bi-arrow-right"></i></span>
                    <div class="sd-pc-plan sd-pc-plan-new">
                        <div class="sd-pc-plan-id">
                            <span class="sd-pc-tag">{lang key='website/services/updown/pc-new-tag'}</span>
                            <span class="sd-pc-name" data-role="pc-new-name"></span>
                        </div>
                        <div class="sd-pc-rate"><span class="num-tabular" data-role="pc-new-price"></span></div>
                    </div>
                </div>

                <div class="sd-pc-mid">
                    <div class="sd-pc-col">
                        <span class="sd-pc-collabel">{lang key='website/services/updown/pc-what-changes'}</span>
                        <ul class="sd-pc-deltas" data-role="pc-deltas"></ul>
                        <div class="wui-collapse" id="sd-pc-deltas-more">
                            <div class="wui-collapse-inner">
                                <ul class="sd-pc-deltas" data-role="pc-deltas-more"></ul>
                            </div>
                        </div>
                        <button type="button" class="sd-pc-showall" data-wui-toggle data-wui-target="#sd-pc-deltas-more" aria-expanded="false" aria-controls="sd-pc-deltas-more" data-role="pc-deltas-toggle">
                            <span class="sd-pc-showall-more">{lang key='website/services/updown/pc-show-all-resources'}</span>
                            <span class="sd-pc-showall-less">{lang key='website/services/updown/pc-show-fewer'}</span>
                            <i class="bi bi-chevron-down wui-collapse-caret"></i>
                        </button>
                    </div>
                    <div class="sd-pc-col">
                        <span class="sd-pc-collabel">{lang key='website/services/updown/pc-billing-cycle'}</span>
                        <div class="sd-pc-cycles" role="group" aria-label="{lang key='website/services/updown/pc-billing-cycle'}" data-role="pc-cycles">
                            <div class="wui-collapse" id="sd-pc-cycles-more">
                                <div class="wui-collapse-inner" data-role="pc-cycles-more"></div>
                            </div>
                        </div>
                        <button type="button" class="sd-pc-showall" data-wui-toggle data-wui-target="#sd-pc-cycles-more" aria-expanded="false" aria-controls="sd-pc-cycles-more" data-role="pc-cycles-toggle">
                            <span class="sd-pc-showall-more">{lang key='website/services/updown/pc-show-all-cycles'}</span>
                            <span class="sd-pc-showall-less">{lang key='website/services/updown/pc-show-fewer'}</span>
                            <i class="bi bi-chevron-down wui-collapse-caret"></i>
                        </button>
                    </div>
                </div>

                <div class="alert alert-warning d-flex align-items-start gap-2 d-none" data-role="pc-recreate" role="alert">
                    <i class="bi bi-exclamation-triangle flex-shrink-0 mt-1"></i>
                    <div>
                        <span class="fw-semibold d-block">{lang key='website/services/updown/recreate-title'}</span>
                        <p class="fs-7 mb-2">{lang key='website/services/updown/recreate-text'}</p>
                        <div class="form-check m-0">
                            <input class="form-check-input" type="checkbox" id="sd-pc-recreate-ok" data-role="pc-recreate-ok">
                            <label class="form-check-label fs-7" for="sd-pc-recreate-ok">{lang key='website/services/updown/recreate-confirm'}</label>
                        </div>
                    </div>
                </div>

                {if $updown.addon_note}
                <div class="alert alert-info d-flex align-items-start gap-2" role="note" data-role="pc-addon-note">
                    <i class="bi bi-puzzle flex-shrink-0 mt-1"></i>
                    <div class="fs-7">
                        <span class="fw-semibold d-block">{lang key='website/services/updown/addon-note-title'}</span>
                        {lang key='website/services/updown/addon-note-text'} <span class="fw-semibold">{$updown.addon_note}</span>
                    </div>
                </div>
                {/if}

                {if $updown.move.any}
                <div class="mt-3 d-none" data-role="pc-moves">
                    <span class="fw-semibold d-block mb-1">{lang key='website/services/updown/move-title'}</span>
                    <p class="fs-8 text-body-secondary mb-2">{lang key='website/services/updown/move-desc'}</p>
                    <div class="d-grid gap-2">
                        {foreach $updown.move.items as $mi}
                        <label class="option-card option-card-toggle" data-move-id="{$mi.id}">
                            <span class="option-toggle-body">
                                <span class="fw-semibold d-block">{$mi.label}{if $mi.qty > 1} × {$mi.qty}{/if}</span>
                                <span class="fs-8 text-body-secondary">{$mi.cycle}{if $mi.cycle && $mi.price} · {/if}{$mi.price}</span>
                                <span class="fs-8 d-block{if $mi.state == 'ok'} text-primary-emphasis{else} text-body-secondary{/if}" data-role="mv-note">{if $mi.state == 'sub_locked'}{lang key='website/services/updown/move-sub-locked'}{elseif $mi.state == 'cancel_planned'}{lang key='website/services/updown/move-cancel-planned'}{elseif $mi.state == 'busy'}{lang key='website/services/updown/move-busy'}{/if}</span>
                            </span>
                            <input class="form-check-input flex-shrink-0" type="checkbox" value="{$mi.id}" data-role="mv-check"{if $mi.state != 'ok'} disabled{/if}>
                        </label>
                        {/foreach}
                    </div>
                </div>
                {/if}

                <div class="sd-pc-summary" data-role="pc-summary">
                    <div class="sd-pc-line">
                        <span data-role="pc-sum-label"></span>
                        <span class="num-tabular" data-role="pc-sum-amount"></span>
                    </div>
                    <div class="sd-pc-line" data-role="pc-credit-line">
                        <span data-role="pc-credit-label"></span>
                        <span class="num-tabular text-success-emphasis" data-role="pc-credit"></span>
                    </div>
                    <div class="sd-pc-line" data-role="pc-moves-line" hidden>
                        <span>{lang key='website/services/updown/pc-moves-line'}</span>
                        <span class="num-tabular" data-role="pc-moves-total"></span>
                    </div>
                    <div class="sd-pc-line" data-role="pc-discount-line" hidden>
                        <span>{lang key='website/services/updown/pc-discount'}</span>
                        <span class="num-tabular text-success-emphasis" data-role="pc-discount"></span>
                    </div>
                    <div class="sd-pc-line" data-role="pc-tax-line" hidden>
                        <span>{lang key='website/services/updown/pc-tax'}</span>
                        <span class="num-tabular" data-role="pc-tax"></span>
                    </div>
                    <div class="sd-pc-line" data-role="pc-applies-line" hidden>
                        <span>{lang key='website/services/updown/pc-applies-on'}</span>
                        <span class="num-tabular" data-role="pc-applies-date"></span>
                    </div>
                    <div class="sd-pc-line sd-pc-total">
                        <span data-role="pc-total-label">{lang key='website/services/updown/pc-due-today'}</span>
                        <span class="num-tabular" data-role="pc-total"></span>
                    </div>
                    <p class="fs-8 text-body-secondary mb-0 mt-1 d-none" data-role="pc-tax-incl">{lang key='website/services/updown/pc-tax-included'}</p>
                </div>

                <div class="wui-collapse" id="sd-pc-scheduled">
                    <div class="wui-collapse-inner">
                        <div class="pt-3">
                            <div class="sd-pc-scheduled">
                                <span class="sd-pc-scheduled-ico"><i class="bi bi-calendar-check"></i></span>
                                <div>
                                    <span class="fw-semibold d-block" data-role="pc-scheduled-title">{lang key='website/services/updown/scheduled-title'}</span>
                                    <p class="fs-7 mb-0" data-role="pc-scheduled-text"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <p class="sd-pc-foot-note fs-7 text-body-secondary mb-0" data-role="pc-note"></p>
                <button type="button" class="btn btn-primary" data-action="plan-change-confirm" data-role="pc-confirm"><i class="bi bi-receipt me-1"></i>{lang key='website/services/updown/pc-confirm-up'}</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="sd-upgrade-process" tabindex="-1" aria-labelledby="sd-upgrade-process-title" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon modal-icon--success"><i class="bi bi-arrow-up-circle"></i></span>
                <div class="modal-titles">
                    <h5 class="modal-title" id="sd-upgrade-process-title">{lang key='website/services/updown/how-up'}</h5>
                    <p class="modal-subtitle">{lang key='website/services/updown/proc-up-sub'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/services/btn-cancel'}"></button>
            </div>
            <div class="modal-body">
                <ol class="sd-proc sd-proc--up">
                    {foreach [1, 2, 3, 4, 5, 6] as $step}
                    <li class="sd-proc-step">
                        <span class="sd-proc-num">{$step}</span>
                        <div class="sd-proc-body">
                            <span class="sd-proc-title">{lang key="website/services/updown/proc-up-{$step}t"}</span>
                            <p class="sd-proc-desc">{lang key="website/services/updown/proc-up-{$step}d"}</p>
                        </div>
                    </li>
                    {/foreach}
                </ol>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">{lang key='website/services/updown/proc-got-it'}</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="sd-downgrade-process" tabindex="-1" aria-labelledby="sd-downgrade-process-title" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon modal-icon--danger"><i class="bi bi-arrow-down-circle"></i></span>
                <div class="modal-titles">
                    <h5 class="modal-title" id="sd-downgrade-process-title">{lang key='website/services/updown/how-down'}</h5>
                    <p class="modal-subtitle">{lang key='website/services/updown/proc-down-sub'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/services/btn-cancel'}"></button>
            </div>
            <div class="modal-body">
                <ol class="sd-proc sd-proc--down">
                    {foreach [1, 2, 3, 4, 5] as $step}
                    <li class="sd-proc-step">
                        <span class="sd-proc-num">{$step}</span>
                        <div class="sd-proc-body">
                            <span class="sd-proc-title">{lang key="website/services/updown/proc-down-{$step}t"}</span>
                            <p class="sd-proc-desc">{lang key="website/services/updown/proc-down-{$step}d"}</p>
                        </div>
                    </li>
                    {/foreach}
                </ol>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">{lang key='website/services/updown/proc-got-it'}</button>
            </div>
        </div>
    </div>
</div>
{/if}

{if $cancel.show}
<div class="modal fade" id="sd-cancel-confirm" tabindex="-1" aria-labelledby="sd-cancel-confirm-title" aria-hidden="true"
    data-txt-lead-end="{lang key='website/services/cancel/confirm-lead-end' date=$cancel.due}"
    data-txt-lead-now="{lang key='website/services/cancel/confirm-lead-now'}"
    data-txt-warn-t-end="{lang key='website/services/cancel/confirm-warn-t-end'}"
    data-txt-warn-t-now="{lang key='website/services/cancel/confirm-warn-t-now'}"
    data-txt-warn-x-end="{lang key='website/services/cancel/confirm-warn-x-end' date=$cancel.due}"
    data-txt-warn-x-now="{lang key='website/services/cancel/confirm-warn-x-now'}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon modal-icon--danger"><i class="bi bi-exclamation-octagon"></i></span>
                <div class="modal-titles">
                    <h5 class="modal-title" id="sd-cancel-confirm-title">{lang key='website/services/cancel/confirm-title'}</h5>
                    <p class="modal-subtitle">{$s.name}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/services/btn-cancel'}"></button>
            </div>
            <div class="modal-body">
                <p class="sd-cancel-confirm-lead" data-role="cancel-confirm-lead"></p>
                <div class="sd-cancel-confirm-warn">
                    <i class="bi bi-trash3"></i>
                    <div>
                        <span class="fw-semibold d-block" data-role="cancel-confirm-warn-title"></span>
                        <span class="fs-7" data-role="cancel-confirm-warn-text"></span>
                    </div>
                </div>
                <div class="form-check sd-cancel-confirm-ack">
                    <input class="form-check-input" type="checkbox" id="sd-cancel-ack">
                    <label class="form-check-label" for="sd-cancel-ack">{lang key='website/services/cancel/confirm-ack'}</label>
                </div>
                <div class="wui-collapse" id="sd-cancel-pw">
                    <div class="wui-collapse-inner">
                        <div class="pt-3">
                            <label class="form-label" for="sd-cancel-password">{lang key='website/services/cancel/confirm-pw-label'}</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="sd-cancel-password" autocomplete="current-password" placeholder="{lang key='website/services/cancel/confirm-pw-ph'}">
                                <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/services/cancel/confirm-pw-show'}"><i class="bi bi-eye"></i></button>
                                <div class="invalid-feedback" data-role="cancel-pw-feedback">{lang key='website/services/cancel/err-password'}</div>
                            </div>
                            <div class="form-text"><i class="bi bi-shield-check me-1"></i>{lang key='website/services/cancel/confirm-pw-note'}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal"><i class="bi bi-arrow-left me-1"></i>{lang key='website/services/cancel/keep'}</button>
                <button type="button" class="btn btn-danger" data-role="cancel-confirm-go" data-action="cancel-confirm" data-busy-text="{lang key='website/services/cancel/requesting'}" disabled><i class="bi bi-x-circle me-1"></i>{lang key='website/services/cancel/request-cta'}</button>
            </div>
        </div>
    </div>
</div>
{/if}
{if $metering.show}
<div class="modal fade" id="sd-metric-chart-modal" tabindex="-1" aria-labelledby="sd-mchart-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="sd-mchart-title"><i class="bi bi-graph-up me-1"></i><span data-role="mchart-metric"></span> &middot; {lang key='website/services/metering/chart'}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/services/btn-cancel'}"></button>
            </div>
            <div class="modal-body">
                <div class="d-flex align-items-center mb-3">
                    <select class="form-select form-select-sm w-auto" id="sd-mchart-period" aria-label="{lang key='website/services/metering/chart'}">
                        <option value="current">{lang key='website/services/metering/chart-this-month'}</option>
                        <option value="last">{lang key='website/services/metering/chart-last-month'}</option>
                    </select>
                </div>
                <div class="sd-mchart-box" data-role="mchart-container" data-txt-empty="{lang key='website/services/metering/chart-empty'}"></div>
            </div>
        </div>
    </div>
</div>
{/if}

{if $metering.show}
<div class="modal fade" id="sd-metric-billing-modal" tabindex="-1" aria-labelledby="sd-mmb-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="sd-mmb-title"><i class="bi bi-receipt me-1"></i><span data-role="mmb-metric"></span> &middot; {lang key='website/services/metering/inv-modal-title'}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/services/btn-cancel'}"></button>
            </div>
            <div class="modal-body">
                <div class="text-center py-3 d-none" data-role="mmb-loading"><span class="spinner-border spinner-border-sm" aria-hidden="true"></span></div>
                <ul class="sd-invoices sd-metering-list d-none" data-role="mmb-list"></ul>
                <div class="wstyle-empty-state d-none" data-role="mmb-empty">
                    <i class="bi bi-receipt"></i>
                    <p class="mb-0">{lang key='website/services/metering/history-empty'}</p>
                </div>
                <div class="text-center mt-2 d-none" data-role="mmb-more-wrap">
                    <button type="button" class="btn btn-soft btn-sm" data-action="mmb-more" data-offset="0"><i class="bi bi-chevron-down me-1"></i>{lang key='website/services/metering/load-more'}</button>
                </div>
            </div>
        </div>
    </div>
</div>
{/if}

{if $s.can_change_password}
<div class="modal fade" id="sd-chpass-modal" tabindex="-1" aria-labelledby="sd-chpass-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="sd-chpass-title"><i class="bi bi-key me-1"></i>{lang key='website/services/chpass-title'}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/services/btn-cancel'}"></button>
            </div>
            <div class="modal-body">
                <p class="fs-7 text-body-secondary mb-3">{lang key='website/services/chpass-desc'}</p>
                <div data-password-field>
                    <label class="form-label" for="sd-chpass-new">{lang key='website/services/chpass-new-label'}</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="sd-chpass-new" autocomplete="new-password">
                        <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/services/chpass-show'}"><i class="bi bi-eye"></i></button>
                        <button class="btn btn-soft" type="button" data-action="password-generate" data-bs-toggle="tooltip" title="{lang key='website/services/chpass-generate'}"><i class="bi bi-stars"></i></button>
                        <button class="btn btn-soft" type="button" data-action="password-copy" data-bs-toggle="tooltip" title="{lang key='website/services/chpass-copy'}"><i class="bi bi-clipboard"></i></button>
                        <div class="invalid-feedback" data-role="chpass-new-feedback">{lang key='website/services/err-chpass-empty'}</div>
                    </div>
                    <div class="wstyle-password-strength" data-strength="0" data-labels="|{lang key='website/sign/password-strength-weak'}|{lang key='website/sign/password-strength-fair'}|{lang key='website/sign/password-strength-good'}|{lang key='website/sign/password-strength-strong'}">
                        <span class="strength-bar"></span><span class="strength-bar"></span>
                        <span class="strength-bar"></span><span class="strength-bar"></span>
                    </div>
                    <small class="text-body-secondary" data-role="strength-label"></small>
                </div>
                <div class="mt-3">
                    <label class="form-label" for="sd-chpass-account">{lang key='website/services/chpass-account-label'}</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="sd-chpass-account" autocomplete="current-password" placeholder="{lang key='website/services/chpass-account-ph'}">
                        <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/services/chpass-show'}"><i class="bi bi-eye"></i></button>
                        <div class="invalid-feedback" data-role="chpass-account-feedback">{lang key='website/services/err-chpass-account'}</div>
                    </div>
                    <div class="form-text"><i class="bi bi-shield-check me-1"></i>{lang key='website/services/chpass-account-note'}</div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/services/btn-cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="sd-chpass-save" data-busy-text="{lang key='website/services/chpass-saving'}"><i class="bi bi-key me-1"></i>{lang key='website/services/chpass-save'}</button>
            </div>
        </div>
    </div>
</div>
{/if}
{hook name='ui:client.service_detail.modals.end'}
{/block}
