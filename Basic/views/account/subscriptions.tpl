{extends file='layouts/default.tpl'}

{block name=content}
<section class="pt-4 pb-4 pt-lg-4 pb-lg-5">
    <div class="container list-page" data-subs-page
        data-op-url="{$canonical_link}"
        data-services-url="{$services_op_url}"
        data-domains-url="{$domains_op_url}"
        data-txt-dismiss="{lang key='website/invoices/subs-dialog-dismiss'}"
        data-txt-cancel-title="{lang key='website/invoices/subs-cancel-title'}"
        data-txt-cancel-msg="{lang key='website/invoices/subs-cancel-msg'}"
        data-txt-cancel-action="{lang key='website/invoices/subs-cancel-action'}"
        data-txt-remove-title="{lang key='website/invoices/subs-remove-title'}"
        data-txt-remove-msg="{lang key='website/invoices/subs-remove-msg'}"
        data-txt-remove-action="{lang key='website/invoices/subs-remove-action'}"
        data-txt-error="{lang key='website/invoices/subs-err-generic'}"
        data-txt-st-cancelled="{lang key='website/invoices/subs-st-cancelled'}">

        <span class="d-none" data-csrf-form="invoice-subscriptions">{csrf form='invoice-subscriptions'}</span>
        <span class="d-none" data-csrf-form="services">{csrf form='services'}</span>
        <span class="d-none" data-csrf-form="domains">{csrf form='domains'}</span>

        <div class="list-pagehead">
            <div>
                <nav aria-label="{lang key='website/invoices/breadcrumb-aria'}">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                        <li class="breadcrumb-item"><a href="{$invoices_link}">{lang key='website/invoices/title'}</a></li>
                        <li class="breadcrumb-item active" aria-current="page">{lang key='website/invoices/subs-title'}</li>
                    </ol>
                </nav>
                <h1 class="list-title">{lang key='website/invoices/subs-title'}</h1>
            </div>
            <div class="d-flex flex-wrap gap-2 list-headactions">
                <a class="btn btn-soft btn-sm" href="{$invoices_link}"><i class="bi bi-receipt me-1"></i>{lang key='website/invoices/subs-btn-invoices'}</a>
                {if $is_self}
                <a class="btn btn-soft btn-sm" href="{$balance_link}"><i class="bi bi-wallet2 me-1"></i>{lang key='website/invoices/subs-btn-balance'}</a>
                <a class="btn btn-soft btn-sm" href="{$saved_cards_link}"><i class="bi bi-credit-card-2-back me-1"></i>{lang key='website/invoices/saved-cards'}</a>
                {/if}
            </div>
        </div>

        {hook name='ui:client.subscriptions.top'}

        {if $is_self && $account_auto}
        <div class="alert alert-info d-flex align-items-center" role="alert">
            <i class="bi bi-arrow-repeat me-2"></i>
            <div>{lang key='website/invoices/subs-banner-auto' source=$source_label}</div>
        </div>
        {elseif $is_self && $renewals && $source_warn && !$source_label}
        <div class="alert alert-warning d-flex align-items-center" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>
            <div>{lang key='website/invoices/subs-banner-no-source'} <a href="{$balance_link}" class="alert-link">{lang key='website/invoices/subs-btn-balance'}</a> · <a href="{$saved_cards_link}" class="alert-link">{lang key='website/invoices/saved-cards'}</a></div>
        </div>
        {/if}

        <div class="d-flex align-items-center justify-content-between mt-4 mb-2">
            <h2 class="fs-5 fw-semibold mb-0">{lang key='website/invoices/subs-sec-gateway'}</h2>
        </div>
        <p class="fs-7 text-body-secondary mb-3">{lang key='website/invoices/subs-sec-gateway-desc'}</p>

        {if $subs_active || $subs_past}

            {if $subs_active}
            <button class="btn btn-link btn-sm p-0 mb-2 fw-semibold text-decoration-none d-inline-flex align-items-center" type="button" data-wui-toggle data-wui-target="#subsActive" aria-expanded="true">
                {lang key='website/invoices/subs-group-active'} (<span data-role="subs-active-count">{$subs_active|count}</span>)<i class="bi bi-chevron-down ms-1"></i>
            </button>
            <div class="wui-collapse wui-show" id="subsActive"><div class="wui-collapse-inner">
                <div class="row g-3 pb-2">
                    {foreach $subs_active as $s}
                        {include file='components/subscription-card.tpl' s=$s}
                    {/foreach}
                </div>
            </div></div>
            {/if}

            {if $subs_past}
            <div class="mt-2">
                <button class="btn btn-link btn-sm p-0 mb-2 fw-semibold text-decoration-none d-inline-flex align-items-center collapsed" type="button" data-wui-toggle data-wui-target="#subsPast" aria-expanded="false">
                    {lang key='website/invoices/subs-group-past'} (<span data-role="subs-past-count">{$subs_past|count}</span>)<i class="bi bi-chevron-down ms-1"></i>
                </button>
                <div class="wui-collapse" id="subsPast"><div class="wui-collapse-inner">
                    <div class="row g-3 pb-2">
                        {foreach $subs_past as $s}
                            {include file='components/subscription-card.tpl' s=$s}
                        {/foreach}
                    </div>
                </div></div>
            </div>
            {/if}

        {else}
        <div class="basic-empty-state">
            <i class="bi bi-arrow-repeat" aria-hidden="true"></i>
            <span class="fw-semibold">{lang key='website/invoices/subs-empty-gateway-title'}</span>
            <span class="fs-7">{lang key='website/invoices/subs-empty-gateway-text'}</span>
        </div>
        {/if}

        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mt-5 mb-2">
            <h2 class="fs-5 fw-semibold mb-0">{lang key='website/invoices/subs-sec-renewals'}</h2>
            {if $is_self && $source_label}
            <span class="fs-7 text-body-secondary">{lang key='website/invoices/subs-f-source'}: <span class="fw-semibold">{$source_label}</span>{if $source_warn} <span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-exclamation-triangle me-1"></i>{lang key='website/invoices/subs-source-expired'}</span>{/if}</span>
            {/if}
        </div>
        <p class="fs-7 text-body-secondary mb-3">{lang key='website/invoices/subs-sec-renewals-desc'}</p>

        {if $renewals}
        <div class="list-rows" data-noun="renewals">
            {foreach $renewals as $r}
            <article class="list-item">
                <span class="list-ico{if $r.icon.kind == 'logo'} has-logo{/if}">{if $r.icon.kind == 'logo'}<img src="{$r.icon.src}" alt="">{else}<i class="{$r.icon.class|default:'bi bi-hdd-stack'}"></i>{/if}</span>
                <div class="list-main">
                    <div class="list-head">
                        <a class="list-name" href="{$r.link}">{$r.name}</a>
                        {if $r.status == 'active'}
                        <span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/invoices/subs-st-active'}</span>
                        {elseif $r.status == 'suspended'}
                        <span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-pause-circle me-1"></i>{lang key='website/invoices/subs-st-suspended'}</span>
                        {else}
                        <span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-gear-fill me-1"></i>{lang key='website/invoices/subs-st-pending'}</span>
                        {/if}
                    </div>
                    <div class="list-meta">
                        {if $r.cycle}<span class="list-chip"><i class="bi bi-arrow-repeat"></i>{$r.cycle}</span>{/if}
                        {if $r.due_date}<span class="list-ident">{lang key='website/invoices/subs-f-due'}: <span class="num-tabular">{$r.due_date}</span></span>{/if}
                    </div>
                </div>
                <div class="list-side">
                    {if $r.fee}
                    <div class="list-price">
                        <span class="list-amount num-tabular">{$r.fee}</span>
                        {if $r.cycle}<span class="list-cycle">{$r.cycle}</span>{/if}
                    </div>
                    {/if}
                    <div class="list-actions">
                        {if $r.can_toggle && $autorenew_locked}
                        <span class="form-check form-switch mb-0" data-bs-toggle="tooltip" title="{lang key='website/account/autorenew-locked-account'}">
                            <input class="form-check-input" type="checkbox" role="switch" checked disabled
                                aria-label="{lang key='website/invoices/subs-toggle-aria'}">
                        </span>
                        {elseif $r.can_toggle}
                        <span class="form-check form-switch mb-0">
                            <input class="form-check-input" type="checkbox" role="switch" checked
                                data-action="toggle-autorenew"
                                data-id="{$r.id}"
                                data-kind="{if $r.is_domain}domain{else}service{/if}"
                                aria-label="{lang key='website/invoices/subs-toggle-aria'}">
                        </span>
                        {else}
                        <span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/invoices/subs-toggle-on'}</span>
                        {/if}
                    </div>
                </div>
            </article>
            {/foreach}
        </div>
        {else}
        <div class="basic-empty-state">
            <i class="bi bi-calendar-check" aria-hidden="true"></i>
            <span class="fw-semibold">{lang key='website/invoices/subs-empty-renewals-title'}</span>
            <span class="fs-7">{lang key='website/invoices/subs-empty-renewals-text'}</span>
        </div>
        {/if}

    </div>
</section>
{/block}

{block name=scripts}
    <script src="{asset path='js/subscriptions.js'}" defer></script>
{/block}
