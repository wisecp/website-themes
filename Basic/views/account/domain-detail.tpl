{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/service-detail.css'}">
    <link rel="stylesheet" href="{asset path='css/domain-detail.css'}">
    {if $domain.can_manage && $caps.whois}
    <link rel="stylesheet" href="{asset path='js/libs/tom-select/tom-select.bootstrap5.min.css'}">
    <link rel="stylesheet" href="{asset path='js/libs/intl-tel-input/css/intlTelInput.min.css'}">
    <script src="{asset path='js/libs/tom-select/tom-select.complete.min.js'}" defer></script>
    <script src="{asset path='js/libs/intl-tel-input/js/intlTelInput.min.js'}" defer></script>
    {/if}
{/block}

{block name=scripts}
    <script src="{asset path='js/domain-detail.js'}" defer></script>
    <script src="{asset path='js/service-transfer.js'}" defer></script>
{/block}

{block name=content}
{assign var=d value=$domain}
{assign var=canAct value=($d.can_manage && $d.actionable)}
{assign var=nsManage value=($canAct && $caps.nameservers)}
{assign var=cnsManage value=($canAct && $caps.child_ns)}
{assign var=showNsTab value=($nsManage || $cnsManage)}
{assign var=nsBoth value=($nsManage && $cnsManage)}
{assign var=dnsRecordsActive value=($canAct && $caps.dns_records && $d.dns_active)}
{assign var=dnsRecordsUpsell value=($canAct && $caps.dns_records && $d.dns_upsell)}
{assign var=dnsRecordsPending value=($canAct && $caps.dns_records && $d.dns_pending)}
{assign var=dnssecManage value=($canAct && $caps.dnssec)}
{assign var=showDnsTab value=($dnsRecordsActive || $dnsRecordsUpsell || $dnsRecordsPending || $dnssecManage)}
{assign var=contactsManage value=($canAct && $caps.whois)}
{assign var=wpVisible value=($canAct && $d.wp_offered)}
{assign var=contactsTab value=($contactsManage || $wpVisible)}
{assign var=cwBoth value=($contactsManage && $wpVisible)}
{assign var=fwdActive value=($canAct && $d.fwd_active)}
{assign var=fwdUpsell value=($canAct && $d.fwd_available)}
{assign var=fwdPending value=($canAct && $d.fwd_pending)}
{assign var=efwdManage value=($fwdActive && $caps.email_forwarding)}
{assign var=ufwdManage value=($fwdActive && $caps.domain_forwarding)}
{assign var=fwdBoth value=($efwdManage && $ufwdManage)}
{assign var=showFwdTab value=($fwdActive || $fwdUpsell || $fwdPending)}
{assign var=transferTab value=($canAct && ($caps.transfer_lock || $caps.auth_code))}
{assign var=billingTab value=$d.can_manage}
{assign var=dnsRecordsAny value=($dnsRecordsActive || $dnsRecordsUpsell || $dnsRecordsPending)}
{assign var=heroShortcuts value=($showNsTab || $dnsRecordsAny || $transferTab)}
{assign var=heroMenu value=($heroShortcuts || ($canAct && $caps.auth_code))}
<section class="pt-4 pb-5">
    <div class="container" data-domain-detail data-id="{$d.id}"
        data-txt-days-left="{lang key='website/domains/days-left'}"
        data-txt-day-left="{lang key='website/domains/days-left-one'}"
        data-txt-on="{lang key='website/domains/on'}" data-txt-off="{lang key='website/domains/off'}"
        {if $cnsManage}data-txt-cns-del-title="{lang key='website/domains/cns-del-title'}" data-txt-cns-del-msg="{lang key='website/domains/cns-del-msg'}" data-txt-cns-del-action="{lang key='website/domains/cns-del-action'}"{/if}
        {if $dnsRecordsActive}data-txt-dns-del-title="{lang key='website/domains/dns-del-title'}" data-txt-dns-del-msg="{lang key='website/domains/dns-del-msg'}" data-txt-dns-del-action="{lang key='website/domains/dns-del-action'}" data-txt-dns-edit="{lang key='website/domains/dns-edit'}" data-txt-dns-add-title="{lang key='website/domains/dns-add-title'}" data-txt-dns-edit-title="{lang key='website/domains/dns-edit-title'}"{/if}
        {if $dnssecManage}data-txt-dnssec-del-title="{lang key='website/domains/dnssec-del-title'}" data-txt-dnssec-del-msg="{lang key='website/domains/dnssec-del-msg'}" data-txt-dnssec-del-action="{lang key='website/domains/dnssec-del-action'}"{/if}
        {if $efwdManage}data-txt-efwd-del-title="{lang key='website/domains/efwd-del-title'}" data-txt-efwd-del-msg="{lang key='website/domains/efwd-del-msg'}" data-txt-efwd-del-action="{lang key='website/domains/efwd-del-action'}"{/if}
        {if $contactsManage}data-txt-whois-registrant="{lang key='website/domains/whois-role-registrant'}" data-txt-whois-administrative="{lang key='website/domains/whois-role-administrative'}" data-txt-whois-technical="{lang key='website/domains/whois-role-technical'}" data-txt-whois-billing="{lang key='website/domains/whois-role-billing'}" data-txt-whois-all="{lang key='website/domains/whois-role-all'}"{/if}
        {if $transferTab && $caps.transfer_lock_get}data-lock-live="1"{/if}
        {if $is_self}data-txt-bill-default="{lang key='website/domains/bill-profile-default'}"{/if}
        {if $can_manage}data-txt-cancel="{lang key='website/domains/cancel'}" data-op-url="{link route='domains'}"{/if}>
        {if $can_manage}{csrf form='domains'}{/if}

        <nav aria-label="{lang key='website/domains/breadcrumb-aria'}">
            <ol class="breadcrumb mb-3">
                <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                <li class="breadcrumb-item"><a href="{link route='domains'}">{lang key='website/domains/title'}</a></li>
                <li class="breadcrumb-item active" aria-current="page">{$d.name}</li>
            </ol>
        </nav>

        <header class="sd-hero">
            <div class="sd-hero-main">
                <div class="sd-hero-lead">
                    <span class="sd-hero-ico sd-hero-ico-logo">
                        {if $d.logo}<img src="{$d.logo}" alt=".{$d.tld}">{else}<i class="bi bi-globe2"></i>{/if}
                    </span>
                    <div class="sd-hero-id">
                        <div class="sd-hero-titlerow">
                            <h1 class="sd-hero-title">{$d.name}</h1>
                            {if $d.badge == 'pending'}<span class="sd-status sd-status-pending"><i class="bi bi-hourglass-split"></i>{$d.status_label}</span>
                            {elseif $d.badge == 'expired'}<span class="sd-status sd-status-expired"><i class="bi bi-calendar-x"></i>{$d.status_label}</span>
                            {elseif $d.badge == 'suspended'}<span class="sd-status sd-status-expired"><i class="bi bi-pause-circle"></i>{$d.status_label}</span>
                            {elseif $d.badge == 'cancelled'}<span class="sd-status sd-status-cancelled"><i class="bi bi-x-circle"></i>{$d.status_label}</span>
                            {else}<span class="sd-status sd-status-active"><i class="bi bi-check-circle"></i>{$d.status_label}</span>{/if}
                        </div>
                        <div class="sd-hero-meta">
                            <a class="sd-hero-domain" href="{$d.visit_link}" target="_blank" rel="noopener">{lang key='website/domains/visit-site'}<i class="bi bi-box-arrow-up-right" aria-hidden="true"></i></a>
                            {if $d.order_id}
                            <span class="sd-dot" aria-hidden="true"></span>
                            <span class="sd-hero-orderid num-tabular">{lang key='website/domains/order-no'} #{$d.order_number}</span>
                            {/if}
                            <span class="sd-dot" aria-hidden="true"></span>
                            <span class="list-chip"><i class="bi bi-globe2"></i>{lang key='website/domains/chip-domain'}</span>
                        </div>
                    </div>
                </div>
                {if $d.can_manage && (($d.renewable && ($d.renew_open_invoice || $d.renew_terms || $d.renew_at_cap)) || $heroMenu)}
                <div class="sd-hero-actions">
                    {if $d.renewable && $d.renew_open_invoice}
                    <a href="{$d.renew_open_invoice}" class="btn btn-secondary btn-sm"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/domains/renew'}</a>
                    {elseif $d.renewable && ($d.renew_terms || $d.renew_at_cap)}
                    <div class="dropdown">
                        <button type="button" class="btn btn-secondary btn-sm dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/domains/renew'}</button>
                        <ul class="dropdown-menu dropdown-menu-end sd-menu sd-renew-menu">
                            <li><h6 class="dropdown-header">{lang key='website/domains/renew-for'}</h6></li>
                            {if $d.renew_at_cap}
                            <li><span class="dropdown-item-text fs-8 text-body-secondary"><i class="bi bi-info-circle me-1"></i>{lang key='website/domains/renew-at-cap'}</span></li>
                            {else}
                            {foreach $d.renew_terms as $term}
                            <li><button type="button" class="dropdown-item sd-renew-opt" data-action="renew-period" data-years="{$term.years}"><span class="sd-renew-opt-label">{$term.label}{if $term.save_label}<span class="sd-renew-save">{$term.save_label}</span>{/if}</span><span class="sd-renew-opt-price num-tabular">{$term.total_fmt}</span></button></li>
                            {/foreach}
                            {/if}
                        </ul>
                    </div>
                    {/if}
                    {if $heroMenu}
                    <div class="dropdown">
                        <button class="btn btn-soft btn-sm" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/domains/more-actions'}"><i class="bi bi-three-dots"></i></button>
                        <ul class="dropdown-menu dropdown-menu-end sd-menu">
                            {if $showNsTab}<li><button type="button" class="dropdown-item" data-action="show-tab" data-tab="dd-nameservers-tab"><i class="bi bi-hdd-network"></i>{lang key='website/domains/hero-manage-ns'}</button></li>{/if}
                            {if $dnsRecordsAny}<li><button type="button" class="dropdown-item" data-action="show-tab" data-tab="dd-dns-tab"><i class="bi bi-card-list"></i>{lang key='website/domains/hero-edit-dns'}</button></li>{/if}
                            {if $transferTab}<li><button type="button" class="dropdown-item" data-action="show-tab" data-tab="dd-transfer-tab"><i class="bi bi-arrow-left-right"></i>{lang key='website/domains/hero-transfer'}</button></li>{/if}
                            {if $canAct && $caps.auth_code}
                            {if $heroShortcuts}<li><hr class="dropdown-divider"></li>{/if}
                            <li><button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#eppCodeModal"><i class="bi bi-key"></i>{lang key='website/domains/epp-action'}</button></li>
                            {/if}
                        </ul>
                    </div>
                    {/if}
                    {hook name='ui:client.domain_detail.hero_actions.end'}
                </div>
                {/if}
            </div>
            <div class="sd-hero-foot">
                <dl class="sd-facts">
                    <div class="sd-fact">
                        <dt>{lang key='website/domains/f-registered'}</dt>
                        <dd class="num-tabular">{if $d.registered}{$d.registered}{else}-{/if}</dd>
                    </div>
                    <div class="sd-fact">
                        <dt>{lang key='website/domains/expires'}</dt>
                        <dd class="num-tabular">{if $d.expires}{$d.expires}{else}-{/if}</dd>
                    </div>
                    <div class="sd-fact">
                        <dt>{lang key='website/domains/renewal-price'}</dt>
                        <dd class="num-tabular">{$d.amount}{if $d.cycle_short}<span class="sd-fact-unit">/{$d.cycle_short}</span>{/if}</dd>
                    </div>
                    <div class="sd-fact">
                        <dt>{lang key='website/domains/auto-renew'}</dt>
                        <dd>
                            {if $d.sub_blocked}
                            <a href="{$d.subscriptions_link}" class="badge bg-success-subtle text-success-emphasis text-decoration-none" title="{lang key='website/domains/autorenew-subscription-note'}"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/domains/autorenew-subscription'}</a>
                            {elseif $canAct && $d.account_autopay}
                            <div class="form-check form-switch sd-switch-inline m-0" data-bs-toggle="tooltip" title="{lang key='website/account/autorenew-locked-account'}">
                                <input class="form-check-input" type="checkbox" role="switch" id="dd-autorenew-hero" checked disabled aria-label="{lang key='website/domains/autorenew-aria'}">
                                <span class="sd-switch-state">{lang key='website/domains/on'}</span>
                            </div>
                            {elseif $canAct}
                            <div class="form-check form-switch sd-switch-inline m-0">
                                <input class="form-check-input" type="checkbox" role="switch" id="dd-autorenew-hero" data-action="toggle-autorenew" data-id="{$d.id}" aria-label="{lang key='website/domains/autorenew-aria'}"{if $d.autorenew} checked{/if}>
                                <span class="sd-switch-state" data-role="autorenew-state">{if $d.autorenew}{lang key='website/domains/on'}{else}{lang key='website/domains/off'}{/if}</span>
                            </div>
                            {else}
                            <span class="badge {if $d.autorenew}bg-success-subtle text-success-emphasis{else}bg-secondary-subtle text-secondary-emphasis{/if}"><i class="bi {if $d.autorenew}bi-arrow-repeat{else}bi-dash-circle{/if} me-1"></i>{if $d.autorenew}{lang key='website/domains/on'}{else}{lang key='website/domains/off'}{/if}</span>
                            {/if}
                        </dd>
                    </div>
                </dl>
                {if $d.due_iso && $d.start_iso}
                <div class="sd-renew" data-start="{$d.start_iso}" data-due="{$d.due_iso}" data-today="{$d.today_iso}">
                    <div class="sd-renew-head">
                        <span class="sd-renew-label"><i class="bi bi-calendar-check me-1"></i>{lang key='website/domains/renews-on'} {$d.expires}</span>
                        <span class="sd-renew-rem num-tabular" data-role="renew-rem"></span>
                    </div>
                    <div class="progress progress-thin" role="progressbar" aria-label="{lang key='website/domains/term-elapsed-aria'}" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                        <div class="progress-bar" data-role="renew-bar"></div>
                    </div>
                </div>
                {/if}
            </div>
        </header>

        {hook name='ui:client.domain_detail.hero.after'}

        <div class="card sd-tabcard">
            <div class="card-header sd-tabbar">
                <ul class="nav sd-segtabs" role="tablist" data-basic-tabs="domain-detail">
                    <li class="nav-item" role="presentation"><button class="nav-link active" id="dd-overview-tab" data-tab-hash="overview" data-bs-toggle="tab" data-bs-target="#dd-overview" type="button" role="tab" aria-controls="dd-overview" aria-selected="true"><i class="bi bi-grid-1x2 me-1"></i>{lang key='website/domains/tab-overview'}</button></li>
                    {if $showNsTab}<li class="nav-item" role="presentation"><button class="nav-link" id="dd-nameservers-tab" data-tab-hash="nameservers" data-bs-toggle="tab" data-bs-target="#dd-nameservers" type="button" role="tab" aria-controls="dd-nameservers" aria-selected="false"><i class="bi bi-hdd-network me-1"></i>{lang key='website/domains/tab-nameservers'}</button></li>{/if}
                    {if $showDnsTab}<li class="nav-item" role="presentation"><button class="nav-link" id="dd-dns-tab" data-tab-hash="dns" data-bs-toggle="tab" data-bs-target="#dd-dns" type="button" role="tab" aria-controls="dd-dns" aria-selected="false"><i class="bi bi-card-list me-1"></i>{lang key='website/domains/tab-dns'}</button></li>{/if}
                    {if $showFwdTab}<li class="nav-item" role="presentation"><button class="nav-link" id="dd-forwarding-tab" data-tab-hash="forwarding" data-bs-toggle="tab" data-bs-target="#dd-forwarding" type="button" role="tab" aria-controls="dd-forwarding" aria-selected="false"><i class="bi bi-signpost-2 me-1"></i>{lang key='website/domains/tab-forwarding'}</button></li>{/if}
                    {if $contactsTab}<li class="nav-item" role="presentation"><button class="nav-link" id="dd-contacts-tab" data-tab-hash="contacts" data-bs-toggle="tab" data-bs-target="#dd-contacts" type="button" role="tab" aria-controls="dd-contacts" aria-selected="false"><i class="bi bi-person-vcard me-1"></i>{lang key='website/domains/tab-contacts'}</button></li>{/if}
                    {if $transferTab}<li class="nav-item" role="presentation"><button class="nav-link" id="dd-transfer-tab" data-tab-hash="transfer" data-bs-toggle="tab" data-bs-target="#dd-transfer" type="button" role="tab" aria-controls="dd-transfer" aria-selected="false"><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/domains/tab-transfer'}</button></li>{/if}
                    {if $serviceTransferTab}<li class="nav-item" role="presentation"><button class="nav-link" id="dd-service-transfer-tab" data-tab-hash="service-transfer" data-bs-toggle="tab" data-bs-target="#dd-service-transfer" type="button" role="tab" aria-controls="dd-service-transfer" aria-selected="false"><i class="bi bi-people me-1"></i>{lang key='website/services/service-transfer/tab'}</button></li>{/if}
                    {if $billingTab}<li class="nav-item" role="presentation"><button class="nav-link" id="dd-billing-tab" data-tab-hash="billing" data-bs-toggle="tab" data-bs-target="#dd-billing" type="button" role="tab" aria-controls="dd-billing" aria-selected="false"><i class="bi bi-receipt me-1"></i>{lang key='website/domains/tab-billing'}</button></li>{/if}
                    <li class="nav-item" role="presentation"><button class="nav-link" id="dd-activity-tab" data-tab-hash="activity" data-bs-toggle="tab" data-bs-target="#dd-activity" type="button" role="tab" aria-controls="dd-activity" aria-selected="false"><i class="bi bi-activity me-1"></i>{lang key='website/domains/tab-activity'}</button></li>
                    {hook name='ui:client.domain_detail.tabs.end'}
                </ul>
            </div>
            <div class="card-body sd-panes">
                <div class="tab-content">

                    <div class="tab-pane fade show active" id="dd-overview" role="tabpanel" aria-labelledby="dd-overview-tab" tabindex="0">
                        {hook name='ui:client.domain_detail.overview.top'}
                        <div class="row g-3">
                            <div class="col-lg-6">
                                <section class="sd-panel h-100">
                                    <h2 class="sd-panel-title"><i class="bi bi-info-circle me-1"></i>{lang key='website/domains/domain-information'}</h2>
                                    <dl class="sd-info mb-0">
                                        <div class="sd-info-row"><dt>{lang key='website/domains/domain'}</dt><dd>{$d.name}</dd></div>
                                        <div class="sd-info-row"><dt>{lang key='website/domains/f-registered'}</dt><dd class="num-tabular">{if $d.registered}{$d.registered}{else}-{/if}</dd></div>
                                        <div class="sd-info-row"><dt>{lang key='website/domains/expires'}</dt><dd class="num-tabular">{if $d.expires}{$d.expires}{else}-{/if}</dd></div>
                                        <div class="sd-info-row"><dt>{lang key='website/domains/registration-term'}</dt><dd>{$d.term_label}</dd></div>
                                        {if $d.order_id}<div class="sd-info-row"><dt>{lang key='website/domains/order-number'}</dt><dd class="num-tabular">#{$d.order_number}</dd></div>{/if}
                                    </dl>
                                </section>
                            </div>
                            <div class="col-lg-6">
                                <section class="sd-panel h-100">
                                    <h2 class="sd-panel-title"><i class="bi bi-shield-check me-1"></i>{lang key='website/domains/protection'}</h2>
                                    <ul class="dd-toggle-list">
                                        {if $caps.transfer_lock}
                                        <li class="dd-toggle-row">
                                            <span class="dd-toggle-text"><span class="dd-toggle-name">{lang key='website/domains/registrar-lock'}</span><span class="dd-toggle-sub fs-7">{lang key='website/domains/registrar-lock-sub'}</span></span>
                                            {if $canAct}
                                            <div class="form-check form-switch sd-switch-inline m-0">
                                                <input class="form-check-input" type="checkbox" role="switch" id="dd-lock-ov" data-action="toggle-lock" data-id="{$d.id}" aria-label="{lang key='website/domains/registrar-lock'}"{if $d.locked} checked{/if}>
                                                <span class="sd-switch-state" data-role="lock-state">{if $d.locked}{lang key='website/domains/on'}{else}{lang key='website/domains/off'}{/if}</span>
                                            </div>
                                            {else}
                                            <span class="badge {if $d.locked}bg-success-subtle text-success-emphasis{else}bg-secondary-subtle text-secondary-emphasis{/if}"><i class="bi {if $d.locked}bi-lock{else}bi-unlock{/if} me-1"></i>{if $d.locked}{lang key='website/domains/on'}{else}{lang key='website/domains/off'}{/if}</span>
                                            {/if}
                                        </li>
                                        {/if}
                                        {if $caps.whois_privacy}
                                        <li class="dd-toggle-row">
                                            <span class="dd-toggle-text"><span class="dd-toggle-name">{lang key='website/domains/whois-privacy-name'}</span><span class="dd-toggle-sub fs-7">{lang key='website/domains/whois-privacy-sub'}</span></span>
                                            <span class="d-inline-flex align-items-center gap-2">
                                                <span class="badge {if $d.whois_privacy}bg-success-subtle text-success-emphasis{else}bg-secondary-subtle text-secondary-emphasis{/if}" data-role="privacy-badge"><i class="bi {if $d.whois_privacy}bi-shield-check{else}bi-shield-slash{/if} me-1"></i>{if $d.whois_privacy}{lang key='website/domains/on'}{else}{lang key='website/domains/off'}{/if}</span>
                                                {if $contactsTab}<button type="button" class="btn btn-ghost btn-sm" data-action="show-tab" data-tab="dd-contacts-tab" data-bs-toggle="tooltip" title="{lang key='website/domains/wp-ov-manage'}" aria-label="{lang key='website/domains/wp-ov-manage'}"><i class="bi bi-pencil"></i></button>{/if}
                                            </span>
                                        </li>
                                        {/if}
                                        <li class="dd-toggle-row">
                                            <span class="dd-toggle-text"><span class="dd-toggle-name">{lang key='website/domains/auto-renew'}</span><span class="dd-toggle-sub fs-7">{lang key='website/domains/auto-renew-sub'}</span></span>
                                            {if $d.sub_blocked}
                                            <a href="{$d.subscriptions_link}" class="badge bg-success-subtle text-success-emphasis text-decoration-none" title="{lang key='website/domains/autorenew-subscription-note'}"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/domains/autorenew-subscription'}</a>
                                            {elseif $canAct && $d.account_autopay}
                                            <div class="form-check form-switch sd-switch-inline m-0" data-bs-toggle="tooltip" title="{lang key='website/account/autorenew-locked-account'}">
                                                <input class="form-check-input" type="checkbox" role="switch" id="dd-autorenew-ov" checked disabled aria-label="{lang key='website/domains/autorenew-aria'}">
                                                <span class="sd-switch-state">{lang key='website/domains/on'}</span>
                                            </div>
                                            {elseif $canAct}
                                            <div class="form-check form-switch sd-switch-inline m-0">
                                                <input class="form-check-input" type="checkbox" role="switch" id="dd-autorenew-ov" data-action="toggle-autorenew" data-id="{$d.id}" aria-label="{lang key='website/domains/autorenew-aria'}"{if $d.autorenew} checked{/if}>
                                                <span class="sd-switch-state" data-role="autorenew-state">{if $d.autorenew}{lang key='website/domains/on'}{else}{lang key='website/domains/off'}{/if}</span>
                                            </div>
                                            {else}
                                            <span class="badge {if $d.autorenew}bg-success-subtle text-success-emphasis{else}bg-secondary-subtle text-secondary-emphasis{/if}"><i class="bi {if $d.autorenew}bi-arrow-repeat{else}bi-dash-circle{/if} me-1"></i>{if $d.autorenew}{lang key='website/domains/on'}{else}{lang key='website/domains/off'}{/if}</span>
                                            {/if}
                                        </li>
                                    </ul>
                                </section>
                                {hook name='ui:client.domain_detail.protection.after'}
                            </div>
                            {if $d.ns}
                            <div class="col-lg-6">
                                <section class="sd-panel h-100">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-hdd-network me-1"></i>{lang key='website/domains/ns-title'}</h2>
                                        {if $nsManage}<button type="button" class="btn btn-soft btn-sm" data-action="show-tab" data-tab="dd-nameservers-tab"><i class="bi bi-pencil me-1"></i>{lang key='website/domains/ns-manage'}</button>{/if}
                                    </div>
                                    <ul class="dd-ns-list mb-0" data-role="ns-preview">
                                        {foreach $d.ns as $host}
                                        <li class="dd-ns-item"><span class="dd-ns-num num-tabular">{$host@iteration}</span><span class="dd-ns-host">{$host}</span></li>
                                        {/foreach}
                                    </ul>
                                </section>
                            </div>
                            {/if}
                            {if $dnsRecordsAny}
                            <div class="col-lg-6">
                                <section class="sd-panel h-100">
                                    <h2 class="sd-panel-title"><i class="bi bi-card-list me-1"></i>{lang key='website/domains/dns-records-title'}</h2>
                                    {if $dnsRecordsActive}
                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/domains/dns-ov-active-text'}</p>
                                    <div class="dd-stat" data-role="dns-ov-stat">
                                        <span class="dd-stat-value num-tabular" data-role="dns-ov-count"><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span></span>
                                        <span class="dd-stat-label">{lang key='website/domains/dns-ov-records'}</span>
                                    </div>
                                    <button type="button" class="btn btn-soft btn-sm mt-3" data-action="show-tab" data-tab="dd-dns-tab"><i class="bi bi-pencil me-1"></i>{lang key='website/domains/hero-edit-dns'}</button>
                                    {else}
                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/domains/dns-ov-text'}</p>
                                    <button type="button" class="btn btn-soft btn-sm" data-action="show-tab" data-tab="dd-dns-tab"><i class="bi bi-pencil me-1"></i>{lang key='website/domains/hero-edit-dns'}</button>
                                    {/if}
                                </section>
                            </div>
                            {/if}
                        </div>
                        {hook name='ui:client.domain_detail.overview.bottom'}
                    </div>

                    {if $showNsTab}
                    <div class="tab-pane fade" id="dd-nameservers" role="tabpanel" aria-labelledby="dd-nameservers-tab" tabindex="0">
                        {hook name='ui:client.domain_detail.nameservers.top'}
                        <div class="row g-3">
                            {if $nsManage}
                            <div class="col-lg-{if $nsBoth}7{else}12{/if}">
                                <section class="sd-panel h-100" data-ns-panel data-default-ns="{$d.default_ns_str}">
                                    <h2 class="sd-panel-title"><i class="bi bi-hdd-network me-1"></i>{lang key='website/domains/ns-title'}</h2>
                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/domains/ns-detail-intro'}</p>
                                    <div class="row g-2" role="radiogroup" aria-label="{lang key='website/domains/ns-mode-aria'}">
                                        <div class="col-sm-6">
                                            <label class="option-card option-card-radio h-100">
                                                <input class="form-check-input" type="radio" name="dd-nsmode" value="default" data-action="ns-mode"{if !$d.ns_custom} checked{/if}>
                                                <span class="d-flex align-items-center gap-2"><span class="option-media"><i class="bi bi-hdd-network"></i></span><span class="fw-semibold">{lang key='website/domains/ns-mode-default'}</span></span>
                                                <span class="fs-8 fw-semibold d-block mt-1">{if $d.default_ns_str}{$d.default_ns_str}{else}{lang key='website/domains/ns-no-default'}{/if}</span>
                                            </label>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="option-card option-card-radio h-100">
                                                <input class="form-check-input" type="radio" name="dd-nsmode" value="custom" data-action="ns-mode"{if $d.ns_custom} checked{/if}>
                                                <span class="d-flex align-items-center gap-2"><span class="option-media"><i class="bi bi-pencil-square"></i></span><span class="fw-semibold">{lang key='website/domains/ns-mode-custom'}</span></span>
                                                <span class="fs-8 text-body-secondary d-block mt-1">{lang key='website/domains/ns-mode-custom-sub'}</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="wui-collapse{if $d.ns_custom} wui-show{/if}" id="dd-ns-custom" data-role="ns-custom">
                                        <div class="wui-collapse-inner">
                                            <div class="pt-3">
                                                <div class="row g-3">
                                                    <div class="col-sm-6">
                                                        <label for="ddNs1" class="form-label">{lang key='website/domains/ns-1'}</label>
                                                        <input type="text" class="form-control" id="ddNs1" value="{$d.ns1}" placeholder="ns1.example.com" data-role="ns-input" inputmode="url">
                                                        <div class="invalid-feedback">{lang key='website/domains/ns-1-invalid'}</div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label for="ddNs2" class="form-label">{lang key='website/domains/ns-2'}</label>
                                                        <input type="text" class="form-control" id="ddNs2" value="{$d.ns2}" placeholder="ns2.example.com" data-role="ns-input" inputmode="url">
                                                        <div class="invalid-feedback">{lang key='website/domains/ns-2-invalid'}</div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label for="ddNs3" class="form-label">{lang key='website/domains/ns-3'} <span class="text-body-secondary">{lang key='website/domains/ns-optional'}</span></label>
                                                        <input type="text" class="form-control" id="ddNs3" value="{$d.ns3}" placeholder="ns3.example.com" data-role="ns-input" inputmode="url">
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label for="ddNs4" class="form-label">{lang key='website/domains/ns-4'} <span class="text-body-secondary">{lang key='website/domains/ns-optional'}</span></label>
                                                        <input type="text" class="form-control" id="ddNs4" value="{$d.ns4}" placeholder="ns4.example.com" data-role="ns-input" inputmode="url">
                                                    </div>
                                                </div>
                                                {if $d.default_ns_str}<button type="button" class="btn btn-ghost btn-sm mt-3" data-action="ns-use-default"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/domains/ns-reset-default'}</button>{/if}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-end mt-3">
                                        <button type="button" class="btn btn-primary" data-action="ns-save" data-busy-text="{lang key='website/domains/ns-saving'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/ns-save'}</button>
                                    </div>
                                </section>
                            </div>
                            {/if}
                            {if $cnsManage}
                            <div class="col-lg-{if $nsBoth}5{else}12{/if}">
                                <section class="sd-panel h-100" data-cns-panel>
                                    <h2 class="sd-panel-title"><i class="bi bi-diagram-3 me-1"></i>{lang key='website/domains/cns-title'}</h2>
                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/domains/cns-intro'}</p>
                                    <div class="text-center py-4" data-role="glue-loading">
                                        <span class="spinner-border spinner-border-sm text-secondary" role="status" aria-hidden="true"></span>
                                        <span class="visually-hidden">{lang key='website/domains/cns-loading'}</span>
                                    </div>
                                    <div class="d-none" data-role="glue-populated">
                                        <ul class="dd-glue-list" data-role="glue-list"></ul>
                                        <button type="button" class="btn btn-soft btn-sm mt-3" data-bs-toggle="modal" data-bs-target="#ddGlueModal"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/cns-add'}</button>
                                    </div>
                                    <div class="basic-empty-state d-none" data-role="glue-empty">
                                        <i class="bi bi-diagram-3" aria-hidden="true"></i>
                                        <span class="fw-semibold">{lang key='website/domains/cns-empty-title'}</span>
                                        <span class="fs-7">{lang key='website/domains/cns-empty-text'}</span>
                                        <button type="button" class="btn btn-soft btn-sm mt-1" data-bs-toggle="modal" data-bs-target="#ddGlueModal"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/cns-add'}</button>
                                    </div>
                                </section>
                            </div>
                            {/if}
                        </div>
                        {hook name='ui:client.domain_detail.nameservers.bottom'}
                    </div>
                    {/if}

                    {if $showDnsTab}
                    <div class="tab-pane fade" id="dd-dns" role="tabpanel" aria-labelledby="dd-dns-tab" tabindex="0" data-dns-pane{if $dnsRecordsActive && $caps.dns_edit} data-dns-editable="1"{/if}>
                        {hook name='ui:client.domain_detail.dns.top'}
                        {if $dnsRecordsActive && !$d.dns_free}
                        <div class="d-flex flex-wrap align-items-center gap-2 border-bottom pb-3 mb-3">
                            <span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/domains/dns-active-badge'}</span>
                            <span class="fs-7 text-body-secondary">{lang key='website/domains/dns-active-note'}</span>
                            {if $d.dns_addon_fmt}<span class="dd-addon-price num-tabular ms-auto">{$d.dns_addon_fmt}<span class="sd-fact-unit">/{lang key='website/domains/dns-addon-yr'}</span></span>{/if}
                        </div>
                        {/if}
                        {if $dnsRecordsActive}
                        <section class="sd-panel" data-dns-records>
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-card-list me-1"></i>{lang key='website/domains/dns-records-title'}</h2>
                                <button type="button" class="btn btn-primary btn-sm" data-action="dns-add"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/dns-add'}</button>
                            </div>
                            <p class="fs-7 text-body-secondary mb-3"><i class="bi bi-info-circle me-1"></i>{lang key='website/domains/dns-detail-intro'}</p>
                            <div class="text-center py-4" data-role="dns-loading">
                                <span class="spinner-border spinner-border-sm text-secondary" role="status" aria-hidden="true"></span>
                                <span class="visually-hidden">{lang key='website/domains/dns-loading'}</span>
                            </div>
                            <div class="table-responsive d-none" data-role="dns-table">
                                <table class="table table-hover align-middle dd-dns-table mb-0">
                                    <thead>
                                        <tr>
                                            <th scope="col">{lang key='website/domains/dns-th-type'}</th>
                                            <th scope="col">{lang key='website/domains/dns-th-name'}</th>
                                            <th scope="col">{lang key='website/domains/dns-th-value'}</th>
                                            <th scope="col" class="text-end">{lang key='website/domains/dns-th-ttl'}</th>
                                            <th scope="col" class="text-end">{lang key='website/domains/dns-th-priority'}</th>
                                            <th scope="col" class="text-end">{lang key='website/domains/dns-th-actions'}</th>
                                        </tr>
                                    </thead>
                                    <tbody data-role="dns-rows"></tbody>
                                </table>
                            </div>
                            <div class="basic-empty-state d-none" data-role="dns-empty">
                                <i class="bi bi-card-list" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/domains/dns-empty-title'}</span>
                                <span class="fs-7">{lang key='website/domains/dns-empty-text'}</span>
                                <button type="button" class="btn btn-soft btn-sm mt-1" data-action="dns-add"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/dns-add'}</button>
                            </div>
                        </section>
                        {elseif $dnsRecordsPending}
                        <section class="sd-panel">
                            <div class="basic-empty-state">
                                <i class="bi bi-hourglass-split" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/domains/dns-pending-title'}</span>
                                <span class="fs-7">{lang key='website/domains/dns-pending-text'}</span>
                                {if $d.dns_pending_link}<a class="btn btn-primary btn-sm mt-1" href="{$d.dns_pending_link}"><i class="bi bi-credit-card me-1"></i>{lang key='website/domains/dns-pending-pay'}</a>{/if}
                            </div>
                        </section>
                        {elseif $dnsRecordsUpsell}
                        <section class="sd-panel">
                            <div class="basic-empty-state">
                                <i class="bi bi-card-list" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/domains/dns-upsell-title'}</span>
                                <span class="fs-7">{lang key='website/domains/dns-upsell-text'}</span>
                                {if $d.dns_addon_fmt}<span class="dd-addon-price num-tabular">{$d.dns_addon_fmt}<span class="sd-fact-unit">/{lang key='website/domains/dns-addon-yr'}</span></span>{/if}
                                <button type="button" class="btn btn-primary btn-sm mt-1" data-action="dns-buy" data-busy-text="{lang key='website/domains/dns-buying'}"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/dns-buy'}</button>
                                <span class="fs-8 text-body-secondary">{lang key='website/domains/dns-upsell-note'}</span>
                            </div>
                        </section>
                        {/if}
                        {if $dnssecManage}
                        <section class="sd-panel{if $dnsRecordsActive || $dnsRecordsUpsell} mt-3{/if}" data-dnssec-panel>
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-shield-lock me-1"></i>{lang key='website/domains/dnssec-title'}</h2>
                                <button type="button" class="btn btn-soft btn-sm" data-bs-toggle="modal" data-bs-target="#ddDnssecModal"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/dnssec-add'}</button>
                            </div>
                            <p class="fs-7 text-body-secondary mb-3">{lang key='website/domains/dnssec-intro'}</p>
                            <div class="text-center py-4" data-role="dnssec-loading">
                                <span class="spinner-border spinner-border-sm text-secondary" role="status" aria-hidden="true"></span>
                                <span class="visually-hidden">{lang key='website/domains/dnssec-loading'}</span>
                            </div>
                            <div class="d-none" data-role="dnssec-populated">
                                <ul class="dd-glue-list" data-role="dnssec-list"></ul>
                            </div>
                            <div class="basic-empty-state d-none" data-role="dnssec-empty">
                                <i class="bi bi-shield-lock" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/domains/dnssec-empty-title'}</span>
                                <span class="fs-7">{lang key='website/domains/dnssec-empty-text'}</span>
                                <button type="button" class="btn btn-soft btn-sm mt-1" data-bs-toggle="modal" data-bs-target="#ddDnssecModal"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/dnssec-add'}</button>
                            </div>
                        </section>
                        {/if}
                        {hook name='ui:client.domain_detail.dns.bottom'}
                    </div>
                    {/if}

                    {if $showFwdTab}
                    <div class="tab-pane fade" id="dd-forwarding" role="tabpanel" aria-labelledby="dd-forwarding-tab" tabindex="0" data-forwarding-pane>
                        {hook name='ui:client.domain_detail.forwarding.top'}
                        {if $fwdUpsell}
                        <section class="sd-panel">
                            <div class="basic-empty-state">
                                <i class="bi bi-signpost-2" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/domains/fwd-upsell-title'}</span>
                                <span class="fs-7">{lang key='website/domains/fwd-upsell-text'}</span>
                                {if $d.fwd_addon_fmt}<span class="dd-addon-price num-tabular">{$d.fwd_addon_fmt}<span class="sd-fact-unit">/{lang key='website/domains/fwd-addon-yr'}</span></span>{/if}
                                <button type="button" class="btn btn-primary btn-sm mt-1" data-action="fwd-buy" data-busy-text="{lang key='website/domains/fwd-buying'}"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/fwd-buy'}</button>
                                <span class="fs-8 text-body-secondary">{lang key='website/domains/fwd-upsell-note'}</span>
                            </div>
                        </section>
                        {elseif $fwdPending}
                        <section class="sd-panel">
                            <div class="basic-empty-state">
                                <i class="bi bi-hourglass-split" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/domains/fwd-pending-title'}</span>
                                <span class="fs-7">{lang key='website/domains/fwd-pending-text'}</span>
                                {if $d.fwd_pending_link}<a class="btn btn-primary btn-sm mt-1" href="{$d.fwd_pending_link}"><i class="bi bi-credit-card me-1"></i>{lang key='website/domains/fwd-pending-pay'}</a>{/if}
                            </div>
                        </section>
                        {elseif $fwdActive}
                        {if !$d.fwd_free}
                        <div class="d-flex flex-wrap align-items-center gap-2 border-bottom pb-3 mb-3">
                            <span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/domains/fwd-active-badge'}</span>
                            <span class="fs-7 text-body-secondary">{lang key='website/domains/fwd-active-note'}</span>
                            {if $d.fwd_addon_fmt}<span class="dd-addon-price num-tabular ms-auto">{$d.fwd_addon_fmt}<span class="sd-fact-unit">/{lang key='website/domains/fwd-addon-yr'}</span></span>{/if}
                        </div>
                        {/if}
                        <div class="row g-3">
                            {if $efwdManage}
                            <div class="{if $fwdBoth}col-lg-6{else}col-12{/if}">
                                <section class="sd-panel h-100" data-efwd-panel>
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-envelope-at me-1"></i>{lang key='website/domains/efwd-title'}</h2>
                                        <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#efwdModal"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/efwd-add'}</button>
                                    </div>
                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/domains/efwd-intro'}</p>
                                    <div class="text-center py-4" data-role="efwd-loading">
                                        <span class="spinner-border spinner-border-sm text-secondary" role="status" aria-hidden="true"></span>
                                        <span class="visually-hidden">{lang key='website/domains/efwd-loading'}</span>
                                    </div>
                                    <div class="table-responsive d-none" data-role="efwd-populated">
                                        <table class="table table-hover align-middle dd-fwd-table mb-0">
                                            <thead>
                                                <tr>
                                                    <th scope="col">{lang key='website/domains/efwd-th-source'}</th>
                                                    <th scope="col">{lang key='website/domains/efwd-th-target'}</th>
                                                    <th scope="col" class="text-end">{lang key='website/domains/efwd-th-actions'}</th>
                                                </tr>
                                            </thead>
                                            <tbody data-role="efwd-rows"></tbody>
                                        </table>
                                    </div>
                                    <div class="basic-empty-state d-none" data-role="efwd-empty">
                                        <i class="bi bi-envelope-at" aria-hidden="true"></i>
                                        <span class="fw-semibold">{lang key='website/domains/efwd-empty-title'}</span>
                                        <span class="fs-7">{lang key='website/domains/efwd-empty-text'}</span>
                                        <button type="button" class="btn btn-soft btn-sm mt-1" data-bs-toggle="modal" data-bs-target="#efwdModal"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/efwd-add'}</button>
                                    </div>
                                </section>
                            </div>
                            {/if}
                            {if $ufwdManage}
                            <div class="{if $fwdBoth}col-lg-6{else}col-12{/if}">
                                <section class="sd-panel h-100" data-ufwd-panel>
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-signpost-split me-1"></i>{lang key='website/domains/ufwd-title'}</h2>
                                        <div class="form-check form-switch sd-switch-inline m-0">
                                            <input class="form-check-input" type="checkbox" role="switch" id="dd-urlfwd-enable" data-action="urlfwd-toggle" aria-label="{lang key='website/domains/ufwd-title'}">
                                            <span class="sd-switch-state" data-role="urlfwd-state">{lang key='website/domains/off'}</span>
                                        </div>
                                    </div>
                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/domains/ufwd-intro'}</p>
                                    <div class="text-center py-4" data-role="ufwd-loading">
                                        <span class="spinner-border spinner-border-sm text-secondary" role="status" aria-hidden="true"></span>
                                        <span class="visually-hidden">{lang key='website/domains/ufwd-loading'}</span>
                                    </div>
                                    <div class="d-none" data-role="ufwd-body">
                                        <div class="d-none" data-role="urlfwd-settings">
                                            <div class="mb-3">
                                                <label class="form-label" for="dd-urlfwd-dest">{lang key='website/domains/ufwd-dest'}</label>
                                                <input type="url" class="form-control" id="dd-urlfwd-dest" data-role="urlfwd-dest" placeholder="{lang key='website/domains/ufwd-dest-ph'}" inputmode="url">
                                                <div class="invalid-feedback">{lang key='website/domains/ufwd-dest-invalid'}</div>
                                            </div>
                                            <span class="form-label d-block mb-1">{lang key='website/domains/ufwd-type'}</span>
                                            <div class="row g-2" role="radiogroup" aria-label="{lang key='website/domains/ufwd-type'}">
                                                <div class="col-sm-6">
                                                    <label class="option-card option-card-radio h-100">
                                                        <input class="form-check-input" type="radio" name="dd-urlfwd-type" value="301" data-action="urlfwd-type" checked>
                                                        <span class="d-flex align-items-center gap-2"><span class="option-media"><i class="bi bi-bookmark-star"></i></span><span class="fw-semibold">{lang key='website/domains/ufwd-301'}</span></span>
                                                        <span class="fs-8 text-body-secondary d-block mt-1">{lang key='website/domains/ufwd-301-desc'}</span>
                                                    </label>
                                                </div>
                                                <div class="col-sm-6">
                                                    <label class="option-card option-card-radio h-100">
                                                        <input class="form-check-input" type="radio" name="dd-urlfwd-type" value="302" data-action="urlfwd-type">
                                                        <span class="d-flex align-items-center gap-2"><span class="option-media"><i class="bi bi-arrow-repeat"></i></span><span class="fw-semibold">{lang key='website/domains/ufwd-302'}</span></span>
                                                        <span class="fs-8 text-body-secondary d-block mt-1">{lang key='website/domains/ufwd-302-desc'}</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="basic-empty-state d-none" data-role="urlfwd-off">
                                            <i class="bi bi-signpost-split" aria-hidden="true"></i>
                                            <span class="fw-semibold">{lang key='website/domains/ufwd-off-title'}</span>
                                            <span class="fs-7">{lang key='website/domains/ufwd-off-text'}</span>
                                            <button type="button" class="btn btn-soft btn-sm mt-1" data-action="urlfwd-enable"><i class="bi bi-toggle-on me-1"></i>{lang key='website/domains/ufwd-enable'}</button>
                                        </div>
                                    </div>
                                </section>
                            </div>
                            {/if}
                        </div>
                        {/if}
                        {hook name='ui:client.domain_detail.forwarding.bottom'}
                    </div>
                    {/if}

                    {if $contactsTab}
                    <div class="tab-pane fade" id="dd-contacts" role="tabpanel" aria-labelledby="dd-contacts-tab" tabindex="0">
                        {hook name='ui:client.domain_detail.contacts.top'}
                        <div class="row g-3">
                            {if $contactsManage}
                            <div class="{if $cwBoth}col-lg-7{else}col-12{/if}">
                                <section class="sd-panel{if $wpVisible} h-100{/if}" data-whois-panel{if $caps.whois_save} data-whois-editable="1"{/if}>
                                    <h2 class="sd-panel-title"><i class="bi bi-person-vcard me-1"></i>{lang key='website/domains/whois-contacts-title'}</h2>
                                    <div data-role="whois-loading">
                                        <div class="d-flex align-items-center gap-2 text-body-secondary py-3">
                                            <span class="spinner-border spinner-border-sm" aria-hidden="true"></span>{lang key='website/domains/whois-loading'}
                                        </div>
                                    </div>
                                    <div class="d-none" data-role="whois-content">
                                        <div class="form-check form-switch dd-same-toggle">
                                            <input class="form-check-input" type="checkbox" role="switch" id="dd-same-contact" data-action="contact-same" checked>
                                            <label class="form-check-label" for="dd-same-contact">{lang key='website/domains/whois-same-label'}</label>
                                        </div>
                                        <div class="wui-collapse" data-role="contact-roles">
                                            <div class="wui-collapse-inner">
                                                <div class="pt-3">
                                                    <ul class="nav nav-pills dd-contact-pills" role="tablist">
                                                        {foreach ['registrant','administrative','technical','billing'] as $role}
                                                        {assign var=rlabel value="website/domains/whois-role-"|cat:$role}
                                                        <li class="nav-item" role="presentation"><button class="nav-link{if $role@first} active{/if}" id="dd-c-{$role}-tab" data-bs-toggle="tab" data-bs-target="#dd-cp-{$role}" type="button" role="tab" aria-controls="dd-cp-{$role}" aria-selected="{if $role@first}true{else}false{/if}">{lang key=$rlabel}</button></li>
                                                        {/foreach}
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-content pt-3">
                                            {foreach ['registrant','administrative','technical','billing'] as $role}
                                            <div class="tab-pane fade{if $role@first} show active{/if}" id="dd-cp-{$role}" role="tabpanel" aria-labelledby="dd-c-{$role}-tab" tabindex="0" data-whois-role="{$role}">
                                                <dl class="sd-info mb-3">
                                                    <div class="sd-info-row"><dt>{lang key='website/domains/whois-f-name'}</dt><dd data-wf="name">-</dd></div>
                                                    <div class="sd-info-row"><dt>{lang key='website/domains/whois-f-organization'}</dt><dd data-wf="company">-</dd></div>
                                                    <div class="sd-info-row"><dt>{lang key='website/domains/whois-f-email'}</dt><dd data-wf="email">-</dd></div>
                                                    <div class="sd-info-row"><dt>{lang key='website/domains/whois-f-phone'}</dt><dd class="num-tabular" data-wf="phone">-</dd></div>
                                                    <div class="sd-info-row"><dt>{lang key='website/domains/whois-f-address'}</dt><dd data-wf="address">-</dd></div>
                                                </dl>
                                                {if $caps.whois_save}<button type="button" class="btn btn-soft btn-sm" data-action="contact-edit" data-role="{$role}"><i class="bi bi-pencil me-1"></i>{lang key='website/domains/whois-edit'}</button>{/if}
                                            </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                </section>
                            </div>
                            {/if}
                            {if $wpVisible}
                            <div class="{if $cwBoth}col-lg-5{else}col-12{/if}">
                                <section class="sd-panel h-100">
                                    <h2 class="sd-panel-title"><i class="bi bi-incognito me-1"></i>{lang key='website/domains/wp-panel-title'}</h2>
                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/domains/wp-panel-intro'}</p>
                                    {if $d.wp_manage}
                                    <div class="form-check form-switch sd-switch-inline m-0">
                                        <input class="form-check-input" type="checkbox" role="switch" id="dd-privacy" data-action="toggle-privacy" data-id="{$d.id}" aria-label="{lang key='website/domains/wp-panel-title'}"{if $d.whois_privacy} checked{/if}>
                                        <span class="sd-switch-state" data-role="privacy-state">{if $d.whois_privacy}{lang key='website/domains/on'}{else}{lang key='website/domains/off'}{/if}</span>
                                    </div>
                                    <p class="fs-8 text-body-secondary mb-0 mt-2"><i class="bi {if $d.wp_free}bi-check-circle{else}bi-shield-check{/if} me-1"></i>{if $d.wp_free}{lang key='website/domains/wp-included-free'}{else}{lang key='website/domains/wp-included-addon'}{/if}</p>
                                    {elseif $d.wp_pending}
                                    <div class="dd-addon">
                                        <div class="dd-addon-top">
                                            <span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/domains/wp-pending-badge'}</span>
                                            {if $d.wp_addon_fmt}<span class="dd-addon-price num-tabular">{$d.wp_addon_fmt}<span class="sd-fact-unit">/{lang key='website/domains/wp-addon-yr'}</span></span>{/if}
                                        </div>
                                        <p class="fs-8 text-body-secondary mb-0">{lang key='website/domains/wp-pending-text'}</p>
                                        {if $d.wp_pending_link}<a class="btn btn-primary btn-sm mt-3" href="{$d.wp_pending_link}"><i class="bi bi-credit-card me-1"></i>{lang key='website/domains/wp-pending-pay'}</a>{/if}
                                    </div>
                                    {elseif $d.wp_available}
                                    <div class="dd-addon">
                                        <div class="dd-addon-top">
                                            {if $d.wp_addon_fmt}<span class="dd-addon-price num-tabular">{$d.wp_addon_fmt}<span class="sd-fact-unit">/{lang key='website/domains/wp-addon-yr'}</span></span>{/if}
                                        </div>
                                        <button type="button" class="btn btn-primary btn-sm mt-2" data-action="privacy-buy" data-busy-text="{lang key='website/domains/wp-buying'}"><i class="bi bi-shield-plus me-1"></i>{lang key='website/domains/wp-buy'}</button>
                                    </div>
                                    {/if}
                                </section>
                            </div>
                            {/if}
                        </div>
                        {hook name='ui:client.domain_detail.contacts.bottom'}
                    </div>
                    {/if}

                    {if $transferTab}
                    <div class="tab-pane fade" id="dd-transfer" role="tabpanel" aria-labelledby="dd-transfer-tab" tabindex="0">
                        {hook name='ui:client.domain_detail.transfer.top'}
                        <div class="row g-3">
                            <div class="col-lg-7">
                                {if $caps.transfer_lock}
                                <section class="sd-panel">
                                    <h2 class="sd-panel-title"><i class="bi bi-lock me-1"></i>{lang key='website/domains/registrar-lock'}</h2>
                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/domains/transfer-lock-intro'}</p>
                                    <div class="form-check form-switch sd-switch-inline m-0">
                                        <input class="form-check-input" type="checkbox" role="switch" id="dd-lock-tab" data-action="toggle-lock" data-id="{$d.id}" aria-label="{lang key='website/domains/registrar-lock'}"{if $d.locked} checked{/if}>
                                        <span class="sd-switch-state" data-role="lock-state">{if $d.locked}{lang key='website/domains/on'}{else}{lang key='website/domains/off'}{/if}</span>
                                    </div>
                                </section>
                                {/if}
                                {if $caps.auth_code}
                                <section class="sd-panel{if $caps.transfer_lock} mt-3{/if}">
                                    <h2 class="sd-panel-title"><i class="bi bi-key me-1"></i>{lang key='website/domains/transfer-epp-title'}</h2>
                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/domains/transfer-epp-intro'}</p>
                                    <button type="button" class="btn btn-soft" data-bs-toggle="modal" data-bs-target="#eppCodeModal"><i class="bi bi-envelope me-1"></i>{lang key='website/domains/epp-action'}</button>
                                </section>
                                {/if}
                            </div>
                            <div class="col-lg-5">
                                <section class="sd-panel h-100">
                                    <h2 class="sd-panel-title"><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/domains/transfer-out-title'}</h2>
                                    <ol class="dd-steps mb-0">
                                        <li class="dd-step"><span class="dd-step-num num-tabular">1</span><span class="dd-step-text">{lang key='website/domains/transfer-step-1'}</span></li>
                                        <li class="dd-step"><span class="dd-step-num num-tabular">2</span><span class="dd-step-text">{lang key='website/domains/transfer-step-2'}</span></li>
                                        <li class="dd-step"><span class="dd-step-num num-tabular">3</span><span class="dd-step-text">{lang key='website/domains/transfer-step-3'}</span></li>
                                    </ol>
                                    <p class="fs-8 text-body-secondary mb-0 mt-3"><i class="bi bi-info-circle me-1"></i>{lang key='website/domains/transfer-out-note'}</p>
                                </section>
                            </div>
                        </div>
                        {hook name='ui:client.domain_detail.transfer.bottom'}
                    </div>
                    {/if}

                    {if $serviceTransferTab}
                    {include file='components/service-transfer.tpl'}
                    {/if}

                    {if $billingTab}
                    <div class="tab-pane fade" id="dd-billing" role="tabpanel" aria-labelledby="dd-billing-tab" tabindex="0">
                        {hook name='ui:client.domain_detail.billing.top'}
                        <div class="row g-3">
                            <div class="col-lg-5">
                                <section class="sd-panel h-100">
                                    <h2 class="sd-panel-title"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/domains/bill-renewal'}</h2>
                                    <dl class="sd-info mb-3">
                                        <div class="sd-info-row"><dt>{lang key='website/domains/bill-next-due'}</dt><dd class="num-tabular">{if $d.expires}{$d.expires}{else}-{/if}</dd></div>
                                        <div class="sd-info-row"><dt>{lang key='website/domains/bill-renewal-price'}</dt><dd class="num-tabular">{$d.amount}{if $d.cycle_short}<span class="sd-fact-unit">/{$d.cycle_short}</span>{/if}</dd></div>
                                        {if $d.pay_method}<div class="sd-info-row"><dt>{lang key='website/domains/bill-payment-method'}</dt><dd><span class="sd-card-brand"><i class="bi bi-credit-card-2-front me-1"></i>{$d.pay_method}</span></dd></div>{/if}
                                    </dl>
                                    {if $d.sub_blocked}
                                    <div class="d-flex align-items-center justify-content-between gap-2">
                                        <span class="fs-7">{lang key='website/domains/autorenew-subscription-note'}</span>
                                        <a href="{$d.subscriptions_link}" class="badge bg-success-subtle text-success-emphasis text-decoration-none"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/domains/autorenew-subscription'}</a>
                                    </div>
                                    {elseif $canAct && $d.account_autopay}
                                    <div class="sd-autorenew" data-state="on">
                                        <div class="form-check form-switch m-0" data-bs-toggle="tooltip" title="{lang key='website/account/autorenew-locked-account'}">
                                            <input class="form-check-input" type="checkbox" role="switch" id="dd-autorenew-bill" checked disabled aria-label="{lang key='website/domains/autorenew-aria'}">
                                            <label class="form-check-label" for="dd-autorenew-bill">{lang key='website/domains/bill-autorenew-label'}</label>
                                        </div>
                                        <p class="fs-7 text-body-secondary m-0">{lang key='website/account/autorenew-locked-account'}</p>
                                    </div>
                                    {elseif $canAct}
                                    <div class="sd-autorenew" data-state="{if $d.autorenew}on{else}off{/if}" data-has-payment-source="{if $d.has_pay_source}1{else}0{/if}">
                                        <div class="form-check form-switch m-0">
                                            <input class="form-check-input" type="checkbox" role="switch" id="dd-autorenew-bill" data-action="toggle-autorenew" data-id="{$d.id}" aria-label="{lang key='website/domains/autorenew-aria'}"{if $d.autorenew} checked{/if}>
                                            <label class="form-check-label" for="dd-autorenew-bill">{lang key='website/domains/bill-autorenew-label'}</label>
                                        </div>
                                        <p class="fs-7 text-body-secondary m-0">{lang key='website/domains/bill-autorenew-note'}</p>
                                    </div>
                                    {else}
                                    <div class="d-flex align-items-center justify-content-between gap-2">
                                        <span class="fs-7">{lang key='website/domains/bill-autorenew-label'}</span>
                                        <span class="badge {if $d.autorenew}bg-success-subtle text-success-emphasis{else}bg-secondary-subtle text-secondary-emphasis{/if}"><i class="bi {if $d.autorenew}bi-arrow-repeat{else}bi-dash-circle{/if} me-1"></i>{if $d.autorenew}{lang key='website/domains/on'}{else}{lang key='website/domains/off'}{/if}</span>
                                    </div>
                                    {/if}
                                </section>
                            </div>
                            <div class="col-lg-7">
                                {if $is_self}
                                <section class="sd-panel mb-3">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-person-vcard me-1"></i>{lang key='website/domains/bill-profile-title'}</h2>
                                        {if $billing_profiles}<button type="button" class="btn btn-soft btn-sm" data-wui-toggle data-wui-target="#ddBillingProfilePicker" aria-expanded="false" aria-controls="ddBillingProfilePicker"><i class="bi bi-pencil me-1"></i>{lang key='website/domains/bill-profile-change'}</button>{/if}
                                    </div>
                                    <div class="wui-collapse wui-show" id="ddBillingProfileSummary" data-billing-summary>
                                        <div class="wui-collapse-inner">
                                            {if $billing_profile}
                                            <div class="sd-bprofile">
                                                <span class="sd-bprofile-ico"><i class="bi bi-person-vcard"></i></span>
                                                <div class="sd-bprofile-body">
                                                    <span class="sd-bprofile-name"><span data-role="assigned-name">{$billing_profile.name}</span>{if $billing_profile.default} <span class="badge bg-primary-subtle text-primary-emphasis ms-1" data-role="assigned-default"><i class="bi bi-star-fill me-1"></i>{lang key='website/domains/bill-profile-default'}</span>{/if}</span>
                                                    <span class="sd-bprofile-addr" data-role="assigned-addr">{$billing_profile.address}</span>
                                                </div>
                                            </div>
                                            {else}
                                            <p class="fs-7 text-body-secondary mb-0">{lang key='website/domains/bill-profile-none'}</p>
                                            {/if}
                                        </div>
                                    </div>
                                    {if $billing_profiles}
                                    <div class="wui-collapse" id="ddBillingProfilePicker">
                                        <div class="wui-collapse-inner">
                                            <div class="pt-1">
                                                <div class="input-group">
                                                    <select class="form-select" id="ddBillingProfileSelect" data-role="bprofile-select" aria-label="{lang key='website/domains/bill-profile-title'}">
                                                        {foreach $billing_profiles as $bp}
                                                        <option value="{$bp.id}" data-profile-name="{$bp.name}" data-profile-addr="{$bp.address}" data-profile-default="{if $bp.default}1{else}0{/if}"{if $billing_profile && $bp.id == $billing_profile.id} selected{/if}>{$bp.name}{if $bp.place} - {$bp.place}{/if}{if $bp.default} ({lang key='website/domains/bill-profile-default'}){/if}</option>
                                                        {/foreach}
                                                    </select>
                                                    <button type="button" class="btn btn-primary" data-action="assign-billing-profile" data-id="{$d.id}" data-busy-text="{lang key='website/domains/bill-profile-saving'}">{lang key='website/domains/bill-profile-save'}</button>
                                                </div>
                                                <p class="form-text mb-0" data-role="bprofile-preview">{if $billing_profile}{$billing_profile.address}{/if}</p>
                                            </div>
                                        </div>
                                    </div>
                                    {/if}
                                </section>
                                {/if}
                                {hook name='ui:client.domain_detail.billing_invoices.before'}
                                <section class="sd-panel">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-receipt me-1"></i>{lang key='website/domains/bill-invoices-title'}</h2>
                                        {if $related_invoices}<a class="fs-7 fw-semibold sd-seeall" href="{link route='invoices'}">{lang key='website/domains/bill-invoices-viewall'}<i class="bi bi-chevron-right ms-1"></i></a>{/if}
                                    </div>
                                    {if $related_invoices}
                                    <ul class="sd-invoices">
                                        {foreach $related_invoices as $inv}
                                        <li class="sd-invoice">
                                            <span class="sd-invoice-ico"><i class="bi bi-receipt"></i></span>
                                            <div class="sd-invoice-body"><a class="sd-invoice-no num-tabular" href="{$inv.link}">{$inv.number}</a><span class="sd-invoice-date num-tabular">{$inv.date}</span></div>
                                            {if $inv.badge == 'paid'}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/domains/inv-st-paid'}</span>
                                            {elseif $inv.badge == 'overdue'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/domains/inv-st-overdue'}</span>
                                            {elseif $inv.badge == 'refunded'}<span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/domains/inv-st-refunded'}</span>
                                            {elseif $inv.badge == 'cancelled'}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/domains/inv-st-cancelled'}</span>
                                            {elseif $inv.badge == 'waiting'}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-clock me-1"></i>{lang key='website/domains/inv-st-waiting'}</span>
                                            {else}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/domains/inv-st-unpaid'}</span>{/if}
                                            <span class="sd-invoice-amount num-tabular">{$inv.total_fmt}</span>
                                            <a class="btn btn-soft btn-sm" href="{$inv.link}"><i class="bi bi-eye me-1"></i>{lang key='website/domains/bill-invoice-view'}</a>
                                        </li>
                                        {/foreach}
                                    </ul>
                                    {else}
                                    <div class="basic-empty-state">
                                        <i class="bi bi-receipt"></i>
                                        <p class="mb-0">{lang key='website/domains/bill-invoices-empty'}</p>
                                    </div>
                                    {/if}
                                </section>
                            </div>
                        </div>
                        {hook name='ui:client.domain_detail.billing.bottom'}
                    </div>
                    {/if}

                    <div class="tab-pane fade" id="dd-activity" role="tabpanel" aria-labelledby="dd-activity-tab" tabindex="0">
                        {hook name='ui:client.domain_detail.activity.top'}
                        <section class="sd-panel">
                            <h2 class="sd-panel-title"><i class="bi bi-activity me-1"></i>{lang key='website/domains/act-title'}</h2>
                            {if $activity}
                            <ul class="dd-activity mb-0">
                                {foreach $activity as $ev}
                                <li class="dd-event"><span class="dd-event-ico"><i class="bi {$ev.icon}"></i></span><span class="dd-event-body"><span class="dd-event-text">{$ev.text}</span><span class="dd-event-time num-tabular">{$ev.time}</span></span></li>
                                {/foreach}
                            </ul>
                            {else}
                            <div class="basic-empty-state">
                                <i class="bi bi-activity"></i>
                                <p class="mb-0">{lang key='website/domains/act-empty'}</p>
                            </div>
                            {/if}
                        </section>
                        {hook name='ui:client.domain_detail.activity.bottom'}
                    </div>

                    {hook name='ui:client.domain_detail.panes.end'}

                </div>
            </div>
        </div>

    </div>
</section>
{/block}

{block name=body_end}
{if $can_manage && $d.actionable && $caps.auth_code}
<div class="modal fade" id="eppCodeModal" tabindex="-1" aria-labelledby="eppCodeTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-key"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="eppCodeTitle">{lang key='website/domains/epp-title'}</h2>
                    <span class="modal-sub" data-role="epp-domain">{$d.name}</span>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                <p class="fs-7 text-body-secondary">{lang key='website/domains/epp-intro-1'} <strong>{$d.name}</strong> {lang key='website/domains/epp-intro-2'}</p>
                <label class="form-label" for="eppPassword">{lang key='website/domains/epp-password-label'}</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="eppPassword" autocomplete="current-password" placeholder="{lang key='website/domains/epp-password-ph'}">
                    <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/domains/show-password'}"><i class="bi bi-eye"></i></button>
                </div>
                <div class="form-text"><i class="bi bi-shield-check me-1"></i>{lang key='website/domains/epp-confirm-note'}</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="epp-send" data-busy-text="{lang key='website/domains/epp-sending'}"><i class="bi bi-send me-1"></i>{lang key='website/domains/epp-send'}</button>
            </div>
        </div>
    </div>
</div>
{/if}

{if $cnsManage}
<div class="modal fade" id="ddGlueModal" tabindex="-1" aria-labelledby="ddGlueTitle" aria-hidden="true" data-domain="{$d.name}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-diagram-3"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="ddGlueTitle">{lang key='website/domains/cns-modal-title'}</h2>
                    <span class="modal-sub">{$d.name}</span>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                <p class="text-body-secondary fs-7 mb-3">{lang key='website/domains/cns-modal-intro'}</p>
                <div class="row g-3">
                    <div class="col-12">
                        <label for="glueHost" class="form-label">{lang key='website/domains/cns-host'}</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="glueHost" placeholder="ns1">
                            <span class="input-group-text">.{$d.name}</span>
                        </div>
                        <div class="invalid-feedback">{lang key='website/domains/cns-host-invalid'}</div>
                    </div>
                    <div class="col-12">
                        <label for="glueIp" class="form-label">{lang key='website/domains/cns-ip'}</label>
                        <input type="text" class="form-control num-tabular" id="glueIp" placeholder="192.0.2.10" inputmode="decimal">
                        <div class="invalid-feedback">{lang key='website/domains/cns-ip-invalid'}</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="glue-save" data-busy-text="{lang key='website/domains/cns-adding'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/cns-add'}</button>
            </div>
        </div>
    </div>
</div>
{/if}

{if $dnsRecordsActive}
<div class="modal fade" id="ddDnsModal" tabindex="-1" aria-labelledby="ddDnsTitle" aria-hidden="true" data-domain="{$d.name}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-card-list"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="ddDnsTitle" data-role="dns-modal-title">{lang key='website/domains/dns-add-title'}</h2>
                    <span class="modal-sub">{$d.name}</span>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="ddDnsIdentity">
                <div class="row g-3">
                    <div class="col-sm-4">
                        <label for="ddDnsType" class="form-label">{lang key='website/domains/dns-f-type'}</label>
                        <select class="form-select" id="ddDnsType" data-role="dns-type">
                            {foreach $dns_config.record_types as $rt}<option value="{$rt}">{$rt}</option>{/foreach}
                        </select>
                    </div>
                    <div class="col-sm-8">
                        <label for="ddDnsName" class="form-label">{lang key='website/domains/dns-f-name'}</label>
                        <input type="text" class="form-control" id="ddDnsName" placeholder="{lang key='website/domains/dns-f-name-ph'}">
                        <div class="invalid-feedback">{lang key='website/domains/dns-f-name-invalid'}</div>
                    </div>
                    <div class="col-12">
                        <label for="ddDnsValue" class="form-label">{lang key='website/domains/dns-f-value'}</label>
                        <input type="text" class="form-control" id="ddDnsValue" placeholder="{lang key='website/domains/dns-f-value-ph'}">
                        <div class="invalid-feedback">{lang key='website/domains/dns-f-value-invalid'}</div>
                    </div>
                    <div class="col-sm-6">
                        <label for="ddDnsTtl" class="form-label">{lang key='website/domains/dns-f-ttl'}</label>
                        <select class="form-select" id="ddDnsTtl">
                            <option value="300">{lang key='website/domains/dns-ttl-300'}</option>
                            <option value="3600" selected>{lang key='website/domains/dns-ttl-3600'}</option>
                            <option value="14400">{lang key='website/domains/dns-ttl-14400'}</option>
                            <option value="86400">{lang key='website/domains/dns-ttl-86400'}</option>
                        </select>
                    </div>
                    <div class="col-sm-6">
                        <div class="wui-collapse" id="dd-dns-priority" data-role="dns-priority-wrap">
                            <div class="wui-collapse-inner">
                                <div>
                                    <label for="ddDnsPriority" class="form-label">{lang key='website/domains/dns-f-priority'}</label>
                                    <input type="number" class="form-control num-tabular" id="ddDnsPriority" value="10" min="0" inputmode="numeric">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="dns-save" data-busy-text="{lang key='website/domains/dns-saving'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/dns-save-btn'}</button>
            </div>
        </div>
    </div>
</div>
{/if}

{if $dnssecManage}
<div class="modal fade" id="ddDnssecModal" tabindex="-1" aria-labelledby="ddDnssecTitle" aria-hidden="true" data-domain="{$d.name}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-shield-lock"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="ddDnssecTitle">{lang key='website/domains/dnssec-add-title'}</h2>
                    <span class="modal-sub">{$d.name}</span>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                <p class="text-body-secondary fs-7 mb-3">{lang key='website/domains/dnssec-modal-intro'}</p>
                <div class="row g-3">
                    <div class="col-sm-4">
                        <label for="ddDsKeyTag" class="form-label">{lang key='website/domains/dnssec-f-keytag'}</label>
                        <input type="number" class="form-control num-tabular" id="ddDsKeyTag" min="0" placeholder="34505" inputmode="numeric">
                        <div class="invalid-feedback">{lang key='website/domains/dnssec-f-keytag-invalid'}</div>
                    </div>
                    <div class="col-sm-4">
                        <label for="ddDsAlgorithm" class="form-label">{lang key='website/domains/dnssec-f-algorithm'}</label>
                        <select class="form-select" id="ddDsAlgorithm">
                            {foreach $dns_config.algorithms as $ak => $av}<option value="{$ak}">{$av}</option>{/foreach}
                        </select>
                    </div>
                    <div class="col-sm-4">
                        <label for="ddDsDigestType" class="form-label">{lang key='website/domains/dnssec-f-digesttype'}</label>
                        <select class="form-select" id="ddDsDigestType">
                            {foreach $dns_config.digest_types as $dk => $dv}<option value="{$dk}">{$dv}</option>{/foreach}
                        </select>
                    </div>
                    <div class="col-12">
                        <label for="ddDsDigest" class="form-label">{lang key='website/domains/dnssec-f-digest'}</label>
                        <input type="text" class="form-control" id="ddDsDigest" placeholder="{lang key='website/domains/dnssec-f-digest-ph'}">
                        <div class="invalid-feedback">{lang key='website/domains/dnssec-f-digest-invalid'}</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="dnssec-save" data-busy-text="{lang key='website/domains/dnssec-saving'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/dnssec-add-btn'}</button>
            </div>
        </div>
    </div>
</div>
{/if}

{if $efwdManage}
<div class="modal fade" id="efwdModal" tabindex="-1" aria-labelledby="efwdTitle" aria-hidden="true" data-domain="{$d.name}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-envelope-at"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="efwdTitle">{lang key='website/domains/efwd-modal-title'}</h2>
                    <span class="modal-sub">{$d.name}</span>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label" for="efwdSource">{lang key='website/domains/efwd-f-source'}</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="efwdSource" placeholder="{lang key='website/domains/efwd-f-source-ph'}" autocomplete="off">
                        <span class="input-group-text">@{$d.name}</span>
                    </div>
                    <div class="invalid-feedback">{lang key='website/domains/efwd-f-source-invalid'}</div>
                </div>
                <div class="mb-0">
                    <label class="form-label" for="efwdDest">{lang key='website/domains/efwd-f-target'}</label>
                    <input type="email" class="form-control" id="efwdDest" placeholder="{lang key='website/domains/efwd-f-target-ph'}" autocomplete="off">
                    <div class="invalid-feedback">{lang key='website/domains/efwd-f-target-invalid'}</div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="efwd-save" data-busy-text="{lang key='website/domains/efwd-adding'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/efwd-add'}</button>
            </div>
        </div>
    </div>
</div>
{/if}

{if $contactsManage && $caps.whois_save}
<div class="modal fade" id="contactEditModal" tabindex="-1" aria-labelledby="contactEditTitle" aria-hidden="true"{if $whois_profiles} data-whois-profiles="{$whois_profiles_json}"{/if}>
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-person-vcard"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="contactEditTitle">{lang key='website/domains/whois-modal-title'}</h2>
                    <p class="modal-subtitle" data-role="contact-modal-sub"></p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                {if $whois_profiles}
                <div class="mb-3">
                    <label for="ddCProfile" class="form-label">{lang key='website/domains/whois-fill-profile'}</label>
                    <select class="form-select" id="ddCProfile" data-action="contact-profile">
                        <option value="">{lang key='website/domains/whois-profile-blank'}</option>
                        {foreach $whois_profiles as $wp}
                        <option value="{$wp.id}">{$wp.name}{if $wp.default} {lang key='website/domains/whois-default-suffix'}{/if}</option>
                        {/foreach}
                    </select>
                </div>
                {/if}
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label for="ddCFirst" class="form-label">{lang key='website/domains/whois-first'}</label>
                        <input type="text" class="form-control" id="ddCFirst" autocomplete="given-name">
                        <div class="invalid-feedback">{lang key='website/domains/whois-err-first'}</div>
                    </div>
                    <div class="col-sm-6">
                        <label for="ddCLast" class="form-label">{lang key='website/domains/whois-last'}</label>
                        <input type="text" class="form-control" id="ddCLast" autocomplete="family-name">
                        <div class="invalid-feedback">{lang key='website/domains/whois-err-last'}</div>
                    </div>
                    <div class="col-12">
                        <label for="ddCCompany" class="form-label">{lang key='website/domains/whois-org'} <span class="text-body-secondary">{lang key='website/domains/whois-optional'}</span></label>
                        <input type="text" class="form-control" id="ddCCompany" autocomplete="organization">
                    </div>
                    <div class="col-sm-6">
                        <label for="ddCEmail" class="form-label">{lang key='website/domains/whois-email'}</label>
                        <input type="email" class="form-control" id="ddCEmail" autocomplete="email">
                        <div class="invalid-feedback">{lang key='website/domains/whois-err-email'}</div>
                    </div>
                    <div class="col-sm-6">
                        <label for="ddCPhone" class="form-label">{lang key='website/domains/whois-phone'}</label>
                        <input type="tel" class="form-control" id="ddCPhone" autocomplete="tel">
                    </div>
                    <div class="col-12">
                        <label for="ddCAddress" class="form-label">{lang key='website/domains/whois-street'}</label>
                        <input type="text" class="form-control" id="ddCAddress" autocomplete="address-line1">
                    </div>
                    <div class="col-sm-6">
                        <label for="ddCCity" class="form-label">{lang key='website/domains/whois-city'}</label>
                        <input type="text" class="form-control" id="ddCCity" autocomplete="address-level2">
                    </div>
                    <div class="col-sm-3">
                        <label for="ddCState" class="form-label">{lang key='website/domains/whois-state'}</label>
                        <input type="text" class="form-control" id="ddCState" autocomplete="address-level1">
                    </div>
                    <div class="col-sm-3">
                        <label for="ddCZip" class="form-label">{lang key='website/domains/whois-zip'}</label>
                        <input type="text" class="form-control num-tabular" id="ddCZip" autocomplete="postal-code">
                    </div>
                    <div class="col-12">
                        <label for="ddCCountry" class="form-label">{lang key='website/domains/whois-country'}</label>
                        <select class="form-select" id="ddCCountry" data-basic-select data-flag-select autocomplete="country">
                            {foreach $whois_countries as $c}
                            <option value="{$c.a2_iso}">{$c.name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <p class="fs-8 text-body-secondary mb-0 mt-3"><i class="bi bi-info-circle me-1"></i>{lang key='website/domains/whois-note'}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="contact-save" data-busy-text="{lang key='website/domains/whois-contacts-saving'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/whois-save-btn'}</button>
            </div>
        </div>
    </div>
</div>
{/if}

{hook name='ui:client.domain_detail.modals.end'}
{/block}
