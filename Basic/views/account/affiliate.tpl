{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/affiliate.css'}">
    {if $aff_promo}<link rel="stylesheet" href="{asset path='css/knowledgebase.css'}">{/if}
{/block}

{block name=scripts}
    <script src="{asset path='js/list.js'}" defer></script>
    <script src="{asset path='js/affiliate.js'}" defer></script>
{/block}

{block name=content}
<section class="pt-4 pb-5" data-aff-page
         data-aff-url="{link route='affiliate'}"
         data-txt-copied="{lang key='website/affiliate/link-copied'}"
         data-txt-cancel="{lang key='website/affiliate/cancel'}">
    <div class="container list-page">
        {csrf form='affiliate'}

        <div class="list-pagehead">
            <div>
                <nav aria-label="{lang key='website/affiliate/breadcrumb-aria'}">
                    <ol class="breadcrumb mb-1">
                        {if !$aff_visitor}<li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>{/if}
                        <li class="breadcrumb-item active" aria-current="page">{lang key='website/affiliate/title'}</li>
                    </ol>
                </nav>
                <h1 class="list-title">{lang key='website/affiliate/title'}</h1>
            </div>
            {if $aff_enrolled}
            <div class="d-flex flex-wrap gap-2">
                {if $aff_can_manage}<button type="button" class="btn btn-soft btn-sm fw-semibold" data-bs-toggle="modal" data-bs-target="#payoutMethodsModal"><i class="bi bi-credit-card-2-back me-1"></i>{lang key='website/affiliate/payout-methods'}</button>{/if}
                <button type="button" class="btn btn-soft btn-sm fw-semibold" data-bs-toggle="modal" data-bs-target="#termsModal"><i class="bi bi-info-circle me-1"></i>{lang key='website/affiliate/program-terms'}</button>
            </div>
            {/if}
        </div>

        {if !$aff_enrolled}
        <div class="card">
            <div class="card-body aff-join">
                <span class="aff-join-ico"><i class="bi bi-people-fill"></i></span>
                <h2 class="aff-join-title">{lang key='website/affiliate/join-title'}</h2>
                <p class="aff-join-lead">{lang key='website/affiliate/join-lead'}</p>
                <div class="aff-join-perks">
                    {if $aff_show_rate}
                    <div class="aff-perk">
                        <span class="aff-perk-ico"><i class="bi bi-percent"></i></span>
                        <span><span class="aff-perk-title">{$aff_rate}% {lang key='website/affiliate/perk-commission'}</span><span class="aff-perk-text">{lang key='website/affiliate/perk-commission-text'}</span></span>
                    </div>
                    {/if}
                    <div class="aff-perk">
                        <span class="aff-perk-ico"><i class="bi bi-clock-history"></i></span>
                        <span><span class="aff-perk-title">{$aff_cookie_days}-{lang key='website/affiliate/perk-cookie'}</span><span class="aff-perk-text">{lang key='website/affiliate/perk-cookie-text'}</span></span>
                    </div>
                    <div class="aff-perk">
                        <span class="aff-perk-ico"><i class="bi bi-cash-stack"></i></span>
                        <span><span class="aff-perk-title">{if $aff_min_fmt}{$aff_min_fmt} {/if}{lang key='website/affiliate/perk-payout'}</span><span class="aff-perk-text">{lang key='website/affiliate/perk-payout-text'}</span></span>
                    </div>
                </div>
                {if $aff_can_manage}
                <form id="aff-join-form">
                    <button type="submit" class="btn btn-primary" data-action="aff-join" data-busy-text="{lang key='website/affiliate/joining'}"><i class="bi bi-person-plus me-1"></i>{lang key='website/affiliate/join-cta'}</button>
                </form>
                {elseif $aff_visitor}
                <div class="d-flex flex-wrap justify-content-center gap-2">
                    {if $registration_enabled}<a class="btn btn-primary" href="{$aff_signup_link}"><i class="bi bi-person-plus me-1"></i>{lang key='website/index/auth-signup'}</a>{/if}
                    {if $login_enabled}<a class="btn btn-soft" href="{$aff_signin_link}"><i class="bi bi-box-arrow-in-right me-1"></i>{lang key='website/index/auth-login'}</a>{/if}
                </div>
                {/if}
            </div>
        </div>
        {else}

        {hook name='ui:client.affiliate_dashboard.top'}

        <div class="aff-stats">
            <div class="aff-stat aff-rise aff-rise-1">
                <i class="bi bi-cash-coin aff-stat-watermark text-success-emphasis" aria-hidden="true"></i>
                <div class="aff-stat-top">
                    <span class="aff-stat-ico bg-success-subtle text-success-emphasis"><i class="bi bi-cash-coin"></i></span>
                    <span class="aff-stat-label">{lang key='website/affiliate/kpi-earned'}</span>
                </div>
                <span class="aff-stat-value num-tabular">{$aff_earned_fmt}</span>
                <div class="aff-stat-foot"><span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-graph-up-arrow me-1"></i>{lang key='website/affiliate/kpi-earned-badge'}</span></div>
            </div>
            <div class="aff-stat aff-rise aff-rise-2">
                <i class="bi bi-wallet2 aff-stat-watermark text-primary-emphasis" aria-hidden="true"></i>
                <div class="aff-stat-top">
                    <span class="aff-stat-ico bg-primary-subtle text-primary-emphasis"><i class="bi bi-wallet2"></i></span>
                    <span class="aff-stat-label">{lang key='website/affiliate/kpi-available'}</span>
                </div>
                <span class="aff-stat-value num-tabular">{$aff_available_fmt}</span>
                <div class="aff-stat-foot"><span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/affiliate/kpi-available-badge'}</span></div>
            </div>
            <div class="aff-stat aff-rise aff-rise-3">
                <i class="bi bi-hourglass-split aff-stat-watermark text-warning-emphasis" aria-hidden="true"></i>
                <div class="aff-stat-top">
                    <span class="aff-stat-ico bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split"></i></span>
                    <span class="aff-stat-label">{lang key='website/affiliate/kpi-clearing'}</span>
                </div>
                <span class="aff-stat-value num-tabular">{$aff_clearing_fmt}</span>
                <div class="aff-stat-foot"><span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-clock me-1"></i>{lang key='website/affiliate/kpi-clearing-badge'}</span></div>
            </div>
            <div class="aff-stat aff-rise aff-rise-4">
                <i class="bi bi-people aff-stat-watermark text-info-emphasis" aria-hidden="true"></i>
                <div class="aff-stat-top">
                    <span class="aff-stat-ico bg-info-subtle text-info-emphasis"><i class="bi bi-people"></i></span>
                    <span class="aff-stat-label">{lang key='website/affiliate/kpi-referrals'}</span>
                </div>
                <span class="aff-stat-value num-tabular">{$aff_referrals}</span>
                <div class="aff-stat-foot"><span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-person-check me-1"></i>{$aff_converted} {lang key='website/affiliate/kpi-converted'}</span></div>
            </div>
        </div>

        {hook name='ui:client.affiliate_stats.after'}

        <section class="card aff-toolkit">
            <div class="card-body p-4">
                <div class="row g-4">
                    <div class="col-lg-7">
                        <h2 class="aff-toolkit-title">{lang key='website/affiliate/referral-link'}</h2>
                        <p class="text-body-secondary fs-7 mb-3">{lang key='website/affiliate/referral-lead'}</p>

                        <label for="aff-link" class="form-label">{lang key='website/affiliate/referral-link'}</label>
                        <div class="input-group mb-3">
                            <span class="input-group-text"><i class="bi bi-link-45deg"></i></span>
                            <input type="text" class="form-control" id="aff-link" value="{$aff_ref_link}" readonly aria-label="{lang key='website/affiliate/referral-link'}">
                            <button class="btn btn-soft" type="button" data-action="copy" data-copy-text="{$aff_ref_link}" data-bs-toggle="tooltip" title="{lang key='website/affiliate/copy-link'}"><i class="bi bi-clipboard"></i></button>
                        </div>

                        <label for="aff-code" class="form-label">{lang key='website/affiliate/referral-code'}</label>
                        <div class="input-group mb-3">
                            <span class="input-group-text"><i class="bi bi-hash"></i></span>
                            <input type="text" class="form-control" id="aff-code" value="{$aff_ref_code}" readonly aria-label="{lang key='website/affiliate/referral-code'}">
                            <button class="btn btn-soft" type="button" data-action="copy" data-copy-text="{$aff_ref_code}" data-bs-toggle="tooltip" title="{lang key='website/affiliate/copy-code'}"><i class="bi bi-clipboard"></i></button>
                        </div>

                        <span class="form-label d-block">{lang key='website/affiliate/share'}</span>
                        <div class="aff-share">
                            <a class="btn btn-soft aff-share-btn" href="mailto:?body={$aff_ref_link_enc}" data-bs-toggle="tooltip" title="{lang key='website/affiliate/share-email'}" aria-label="{lang key='website/affiliate/share-email'}"><i class="bi bi-envelope"></i></a>
                            <a class="btn btn-soft aff-share-btn" href="https://twitter.com/intent/tweet?url={$aff_ref_link_enc}" target="_blank" rel="noopener" data-bs-toggle="tooltip" title="{lang key='website/affiliate/share-x'}" aria-label="{lang key='website/affiliate/share-x'}"><i class="bi bi-twitter-x"></i></a>
                            <a class="btn btn-soft aff-share-btn" href="https://www.facebook.com/sharer/sharer.php?u={$aff_ref_link_enc}" target="_blank" rel="noopener" data-bs-toggle="tooltip" title="{lang key='website/affiliate/share-facebook'}" aria-label="{lang key='website/affiliate/share-facebook'}"><i class="bi bi-facebook"></i></a>
                            <a class="btn btn-soft aff-share-btn" href="https://wa.me/?text={$aff_ref_link_enc}" target="_blank" rel="noopener" data-bs-toggle="tooltip" title="{lang key='website/affiliate/share-whatsapp'}" aria-label="{lang key='website/affiliate/share-whatsapp'}"><i class="bi bi-whatsapp"></i></a>
                            <a class="btn btn-soft aff-share-btn" href="https://www.linkedin.com/sharing/share-offsite/?url={$aff_ref_link_enc}" target="_blank" rel="noopener" data-bs-toggle="tooltip" title="{lang key='website/affiliate/share-linkedin'}" aria-label="{lang key='website/affiliate/share-linkedin'}"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>

                    <div class="col-lg-5">
                        <div class="aff-payout{if !$aff_ready} is-below{/if}">
                            <div>
                                <div class="aff-payout-label">
                                    <span class="aff-payout-amount num-tabular">{$aff_available_fmt}</span>
                                    {if $aff_min_fmt}<span class="aff-payout-min">{$aff_min_fmt} {lang key='website/affiliate/min-label'}</span>{/if}
                                </div>
                                <div class="progress progress-thin" role="progressbar" aria-label="{lang key='website/affiliate/progress-aria'}" aria-valuenow="{$aff_progress}" aria-valuemin="0" aria-valuemax="100">
                                    <div class="progress-bar" style="inline-size: {$aff_progress}%"></div>
                                </div>
                                {if $aff_ready}
                                <p class="aff-payout-helper is-ready mt-2 mb-0"><i class="bi bi-check-circle"></i>{lang key='website/affiliate/payout-ready'}</p>
                                {else}
                                <p class="aff-payout-helper is-below mt-2 mb-0"><i class="bi bi-hourglass-split"></i>{lang key='website/affiliate/payout-below'}</p>
                                {/if}
                            </div>
                            {if $aff_can_manage}
                            <div class="aff-payout-action-area">
                                <div class="aff-payout-actions">
                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#payoutModal"{if !$aff_ready} disabled{/if}><i class="bi bi-cash-stack me-1"></i>{lang key='website/affiliate/request-payout'}</button>
                                    <button type="button" class="btn btn-soft" data-bs-toggle="modal" data-bs-target="#payoutHistoryModal"><i class="bi bi-clock-history me-1"></i>{lang key='website/affiliate/payout-history'}</button>
                                </div>
                                <div class="wui-collapse{if $aff_pending} wui-show{/if}" data-role="payout-pending-strip">
                                    <div class="wui-collapse-inner">
                                        <div class="aff-payout-strip-pad">
                                            <div class="aff-payout-strip">
                                                <i class="bi bi-hourglass-split aff-payout-strip-ico" aria-hidden="true"></i>
                                                <span class="aff-payout-strip-text"><span class="num-tabular fw-semibold" data-role="pending-amount">{if $aff_pending}{$aff_pending.amount_fmt}{/if}</span> {lang key='website/affiliate/payout-processing'}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            {/if}
                            <ul class="aff-facts">
                                <li class="aff-fact"><i class="bi bi-percent"></i><span class="aff-fact-label">{lang key='website/affiliate/fact-rate'}</span><span class="aff-fact-value">{$aff_rate}%</span></li>
                                <li class="aff-fact"><i class="bi bi-clock-history"></i><span class="aff-fact-label">{lang key='website/affiliate/fact-cookie'}</span><span class="aff-fact-value">{$aff_cookie_days} {lang key='website/affiliate/days'}</span></li>
                                {if $aff_min_fmt}<li class="aff-fact"><i class="bi bi-cash-stack"></i><span class="aff-fact-label">{lang key='website/affiliate/fact-minimum'}</span><span class="aff-fact-value num-tabular">{$aff_min_fmt}</span></li>{/if}
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        {if $aff_promo}
        <section class="card aff-toolkit" data-role="aff-promo">
            <div class="card-body p-4">
                <h2 class="aff-toolkit-title">{lang key='website/affiliate/promo-title'}</h2>
                <p class="text-body-secondary fs-7 mb-3">{lang key='website/affiliate/promo-lead'}</p>
                <div class="kb-prose">{content var=$aff_promo}</div>
            </div>
        </section>
        {/if}

        <div class="aff-list-head d-flex flex-wrap align-items-end justify-content-between gap-2">
            <div>
                <h2 class="aff-list-title">{lang key='website/affiliate/commissions'}</h2>
                <p class="text-body-secondary fs-7 mb-0">{lang key='website/affiliate/commissions-lead'}</p>
            </div>
        </div>

        {if $aff_commissions}
        <div class="list-toolbar mt-3">
            <div class="list-search input-group">
                <label class="input-group-text" for="list-search"><i class="bi bi-search"></i></label>
                <input type="search" autocomplete="off" class="form-control" id="list-search" placeholder="{lang key='website/affiliate/search'}" aria-label="{lang key='website/affiliate/search'}">
            </div>
            <div class="list-controls">
                <label for="list-status" class="form-label mb-0 list-control-label">{lang key='website/affiliate/filter-status'}</label>
                <select class="form-select w-auto" id="list-status" aria-label="{lang key='website/affiliate/filter-status'}">
                    <option value="">{lang key='website/affiliate/filter-all-statuses'}</option>
                    <option value="valid">{lang key='website/affiliate/status-valid'}</option>
                    <option value="invalid">{lang key='website/affiliate/status-invalid'}</option>
                </select>
                <label for="list-sort" class="form-label mb-0 list-control-label">{lang key='website/affiliate/sort'}</label>
                <select class="form-select w-auto" id="list-sort" aria-label="{lang key='website/affiliate/sort'}">
                    <option value="status">{lang key='website/affiliate/sort-default'}</option>
                    <option value="created">{lang key='website/affiliate/sort-newest'}</option>
                    <option value="price-desc">{lang key='website/affiliate/sort-amount-desc'}</option>
                    <option value="price-asc">{lang key='website/affiliate/sort-amount-asc'}</option>
                </select>
            </div>
        </div>

        <div class="list-rows" data-today="{$today_ymd}" data-noun="commissions"
            data-txt-count="{lang key='website/index/list-count'}"
            data-txt-nores="{lang key='website/index/list-nores'}"
            data-txt-noun="{lang key='website/affiliate/noun'}">

            {foreach $aff_commissions as $c}
            <article class="list-item" data-status="{if $c.valid}valid{else}invalid{/if}" data-group="commission" data-flag="{$c.flag}" data-name="{$c.name_key}" data-search="{$c.search}" data-price="{$c.commission}" data-due="0" data-start="{$c.ts}">
                <span class="list-ico"><i class="bi bi-cash-coin"></i></span>
                <div class="list-main">
                    <div class="list-head">
                        <span class="list-name">{$c.referral}</span>
                    </div>
                    <div class="list-meta">
                        <span class="list-chip"><i class="bi bi-cash-coin"></i>{lang key='website/affiliate/type-commission'}</span>
                        {if $c.date}<span class="list-orderid num-tabular">{$c.date}</span>{/if}
                    </div>
                </div>
                <div class="list-side">
                    <div class="aff-cell-status">
                        {if $c.valid}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/affiliate/status-valid'}</span>
                        {else}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/affiliate/status-invalid'}</span>{/if}
                        {if $c.flag == 'available'}<span class="aff-note is-ready"><i class="bi bi-check2-circle me-1"></i>{lang key='website/affiliate/note-available'}</span>
                        {elseif $c.flag == 'clearing'}<span class="aff-note is-clearing" data-bs-toggle="tooltip" title="{lang key='website/affiliate/note-clearing-tip'}"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/affiliate/note-clearing'} {$c.clearing_date}</span>
                        {else}<span class="aff-note is-rejected"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/affiliate/note-rejected'}</span>{/if}
                    </div>
                    <div class="aff-cell-service">
                        {if $c.service}<span class="aff-service-name">{$c.service}</span><span class="aff-service-cat">{$c.category}</span>
                        {else}<span class="aff-amount-void">-</span>{/if}
                    </div>
                    <div class="list-price">
                        <span class="list-amount num-tabular{if !$c.valid} aff-amount-void{/if}">{$c.amount_fmt}</span>
                        <span class="list-cycle">{lang key='website/affiliate/col-payment'}</span>
                    </div>
                    <div class="list-price aff-commission">
                        <span class="list-amount num-tabular{if !$c.valid} aff-amount-void{/if}">{$c.commission_fmt}</span>
                        <span class="list-cycle">{lang key='website/affiliate/col-commission'}</span>
                    </div>
                </div>
            </article>
            {/foreach}

            <div class="list-empty basic-empty-state d-none" data-role="empty">
                <i class="bi bi-inbox" aria-hidden="true"></i>
                <span class="fw-semibold">{lang key='website/affiliate/nores-title'}</span>
                <span class="fs-7">{lang key='website/affiliate/nores-text'}</span>
                <button type="button" class="btn btn-soft btn-sm mt-1" data-action="list-clear"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/affiliate/clear-filters'}</button>
            </div>

        </div>

        <div class="list-foot">
            <p class="list-count num-tabular" data-role="count" aria-live="polite"></p>
            <nav class="list-pagination" aria-label="{lang key='website/affiliate/pagination-aria'}" data-role="pagination">
                <ul class="pagination pagination-sm m-0"></ul>
            </nav>
        </div>
        {else}
        <div class="basic-empty-state mt-3">
            <i class="bi bi-cash-coin" aria-hidden="true"></i>
            <span class="fw-semibold">{lang key='website/affiliate/empty-title'}</span>
            <span class="fs-7">{lang key='website/affiliate/empty-text'}</span>
        </div>
        {/if}

        {/if}

    </div>
</section>
{/block}

{block name=body_end}
{if $aff_enrolled}
{if $aff_can_manage}
<div class="modal fade" id="payoutModal" tabindex="-1" aria-labelledby="payoutModalTitle" aria-hidden="true"
     data-available="{$aff_available}" data-min="{$aff_min}" data-payment-info='{$aff_payment_info_json nofilter}'>
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-cash-stack"></i></span>
                <div class="modal-titles">
                    <h5 class="modal-title" id="payoutModalTitle">{lang key='website/affiliate/request-payout'}</h5>
                    <p class="modal-subtitle">{lang key='website/affiliate/payout-modal-sub'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/affiliate/close'}"></button>
            </div>
            <form id="payoutForm" novalidate>
                <div class="modal-body">
                    <div class="aff-payout-avail">
                        <span class="aff-payout-avail-ico"><i class="bi bi-wallet2"></i></span>
                        <span>
                            <span class="aff-payout-avail-label">{lang key='website/affiliate/available-to-withdraw'}</span>
                            <span class="aff-payout-avail-value num-tabular">{$aff_available_fmt}</span>
                        </span>
                    </div>

                    <div class="mb-3">
                        <label for="payout-amount" class="form-label">{lang key='website/affiliate/amount'} <span class="text-danger" aria-hidden="true">*</span></label>
                        <div class="input-group">
                            {if $aff_currency_position == 'LEFT'}<span class="input-group-text">{$aff_currency_symbol}</span>{/if}
                            <input type="text" class="form-control num-tabular" id="payout-amount" name="amount" inputmode="decimal" value="{$aff_available_input}" autocomplete="off" aria-describedby="payout-amount-help">
                            {if $aff_currency_position == 'RIGHT'}<span class="input-group-text">{$aff_currency_symbol}</span>{/if}
                            <div class="invalid-feedback">{lang key='website/affiliate/err-amount-range'}</div>
                        </div>
                        <div class="form-text" id="payout-amount-help">{lang key='website/affiliate/amount-help'}</div>
                    </div>

                    <div class="mb-1">
                        <span class="form-label d-block">{lang key='website/affiliate/payout-method'} <span class="text-danger" aria-hidden="true">*</span></span>
                        {if $aff_gateways}
                        <div class="d-flex flex-column gap-2" data-role="payout-method-list">
                            {foreach $aff_gateways as $i => $gw}
                            <label class="option-card option-card-radio option-card-sm d-flex align-items-center gap-3">
                                <input class="form-check-input" type="radio" name="gateway" value="{$gw|escape}"{if $i == 0} checked{/if}>
                                <span class="option-media"><i class="bi bi-cash-stack"></i></span>
                                <span class="me-auto"><span class="fw-semibold d-block">{$gw}</span>{if isset($aff_payment_info[$gw]) && $aff_payment_info[$gw] != ''}<span class="fs-8 text-body-secondary">{$aff_payment_info[$gw]}</span>{/if}</span>
                            </label>
                            {/foreach}
                        </div>
                        <div class="mt-3" data-role="gateway-info-wrap">
                            <label for="payout-gateway-info" class="form-label">{lang key='website/affiliate/gateway-info'} <span class="text-danger" aria-hidden="true">*</span></label>
                            <textarea class="form-control" id="payout-gateway-info" name="gateway_info" rows="2" placeholder="{lang key='website/affiliate/gateway-info-ph'}"></textarea>
                            <div class="form-text"><i class="bi bi-info-circle me-1"></i>{lang key='website/affiliate/gateway-info-help'}</div>
                        </div>
                        <div class="form-check mt-2">
                            <input class="form-check-input" type="checkbox" id="payout-save-default" name="save_default" value="1">
                            <label class="form-check-label fs-8" for="payout-save-default">{lang key='website/affiliate/save-default'}</label>
                        </div>
                        {else}
                        <div class="aff-no-methods" data-role="payout-no-methods">
                            <span class="aff-no-methods-ico"><i class="bi bi-credit-card-2-back"></i></span>
                            <p class="fw-semibold mb-1">{lang key='website/affiliate/no-gateway-title'}</p>
                            <p class="fs-7 text-body-secondary mb-2">{lang key='website/affiliate/no-gateway-text'}</p>
                        </div>
                        {/if}
                    </div>

                    <div class="captcha-slot d-none mt-3" data-captcha>
                        <div class="captcha-mock"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/affiliate/cancel'}</button>
                    <button type="submit" class="btn btn-primary" data-action="submit-payout" data-busy-text="{lang key='website/affiliate/requesting'}"{if !$aff_gateways} disabled{/if}><i class="bi bi-cash-stack me-1"></i>{lang key='website/affiliate/request-payout'}</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="payoutMethodsModal" tabindex="-1" aria-labelledby="payoutMethodsTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-credit-card-2-back"></i></span>
                <div class="modal-titles">
                    <h5 class="modal-title" id="payoutMethodsTitle">{lang key='website/affiliate/payout-methods'}</h5>
                    <p class="modal-subtitle">{lang key='website/affiliate/methods-sub'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/affiliate/close'}"></button>
            </div>
            <div class="modal-body">
                {if $aff_gateways}
                <div class="d-flex flex-column gap-2" data-payout-methods>
                    {foreach $aff_gateways as $i => $gw}
                    <form class="aff-method-form" data-gateway="{$gw|escape}">
                        <input type="hidden" name="gateway" value="{$gw|escape}">
                        <div class="aff-method">
                            <span class="aff-method-media"><i class="bi bi-cash-stack"></i></span>
                            <span class="me-auto">
                                <span class="aff-method-title">{$gw}</span>
                                <span class="aff-method-detail" data-role="method-detail" data-empty="{lang key='website/affiliate/method-not-set'}">{if isset($aff_payment_info[$gw]) && $aff_payment_info[$gw] != ''}{$aff_payment_info[$gw]}{else}{lang key='website/affiliate/method-not-set'}{/if}</span>
                            </span>
                            <button type="button" class="btn btn-ghost btn-sm" data-wui-toggle data-wui-target="#method-{$i}" aria-expanded="false" data-bs-toggle="tooltip" title="{lang key='website/affiliate/method-edit'}" aria-label="{lang key='website/affiliate/method-edit'}"><i class="bi bi-pencil"></i></button>
                        </div>
                        <div class="wui-collapse" id="method-{$i}">
                            <div class="wui-collapse-inner">
                                <div class="pt-2">
                                    <label class="form-label fs-8" for="method-info-{$i}">{lang key='website/affiliate/gateway-info'}</label>
                                    <textarea class="form-control" id="method-info-{$i}" name="gateway_info" rows="2" placeholder="{lang key='website/affiliate/gateway-info-ph'}">{if isset($aff_payment_info[$gw])}{$aff_payment_info[$gw]}{/if}</textarea>
                                    <div class="d-flex justify-content-end gap-2 mt-2">
                                        <button type="submit" class="btn btn-primary btn-sm" data-action="save-method" data-busy-text="{lang key='website/affiliate/saving'}"><i class="bi bi-check2 me-1"></i>{lang key='website/affiliate/save'}</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    {/foreach}
                </div>
                {else}
                <div class="basic-empty-state">
                    <i class="bi bi-credit-card-2-back" aria-hidden="true"></i>
                    <span class="fw-semibold">{lang key='website/affiliate/no-gateway-title'}</span>
                    <span class="fs-7">{lang key='website/affiliate/no-gateway-text'}</span>
                </div>
                {/if}
            </div>
        </div>
    </div>
</div>
{/if}

<div class="modal fade" id="termsModal" tabindex="-1" aria-labelledby="termsModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-info-circle"></i></span>
                <div class="modal-titles">
                    <h5 class="modal-title" id="termsModalTitle">{lang key='website/affiliate/program-terms'}</h5>
                    <p class="modal-subtitle">{lang key='website/affiliate/terms-sub'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/affiliate/close'}"></button>
            </div>
            <div class="modal-body">
                <ul class="aff-facts mb-3">
                    <li class="aff-fact"><i class="bi bi-percent"></i><span class="aff-fact-label">{lang key='website/affiliate/fact-rate'}</span><span class="aff-fact-value">{$aff_rate}%</span></li>
                    <li class="aff-fact"><i class="bi bi-clock-history"></i><span class="aff-fact-label">{lang key='website/affiliate/fact-cookie'}</span><span class="aff-fact-value">{$aff_cookie_days} {lang key='website/affiliate/days'}</span></li>
                    <li class="aff-fact"><i class="bi bi-hourglass-split"></i><span class="aff-fact-label">{lang key='website/affiliate/fact-clearing'}</span><span class="aff-fact-value">{$aff_clearing_days} {lang key='website/affiliate/days'}</span></li>
                    {if $aff_min_fmt}<li class="aff-fact"><i class="bi bi-cash-stack"></i><span class="aff-fact-label">{lang key='website/affiliate/fact-minimum'}</span><span class="aff-fact-value num-tabular">{$aff_min_fmt}</span></li>{/if}
                </ul>
                <p class="text-body-secondary fs-7 mb-0">{lang key='website/affiliate/terms-body'}</p>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="payoutHistoryModal" tabindex="-1" aria-labelledby="payoutHistoryTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-clock-history"></i></span>
                <div class="modal-titles">
                    <h5 class="modal-title" id="payoutHistoryTitle">{lang key='website/affiliate/payout-history'}</h5>
                    <p class="modal-subtitle">{lang key='website/affiliate/history-sub'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/affiliate/close'}"></button>
            </div>
            <div class="modal-body">
                {if $aff_withdrawals}
                <div data-role="history-list">
                    <div class="aff-history-summary">
                        <span class="aff-history-summary-label"><i class="bi bi-cash-stack me-1"></i>{lang key='website/affiliate/total-paid'}</span>
                        <span class="aff-history-summary-value num-tabular">{$aff_paid_total_fmt}</span>
                    </div>
                    <div class="aff-payout-history">
                        {foreach $aff_withdrawals as $w}
                        <div class="aff-history-row">
                            <span class="aff-history-ico"><i class="bi bi-cash-stack"></i></span>
                            <div class="aff-history-main">
                                <span class="aff-history-amount num-tabular">{$w.amount_fmt}</span>
                                <span class="aff-history-meta">{$w.gateway}{if $w.date} · {$w.date}{/if}</span>
                                {if $w.status == 'rejected' && $w.reason}<span class="aff-history-reason"><i class="bi bi-exclamation-circle me-1"></i>{$w.reason}</span>{/if}
                            </div>
                            <span class="aff-history-status">{if $w.status == 'completed'}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/affiliate/wd-paid'}</span>{elseif $w.status == 'rejected'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/affiliate/wd-rejected'}</span>{else}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/affiliate/wd-cancelled'}</span>{/if}</span>
                        </div>
                        {/foreach}
                    </div>
                </div>
                {else}
                <div class="basic-empty-state" data-role="history-empty">
                    <i class="bi bi-cash-stack" aria-hidden="true"></i>
                    <span class="fw-semibold">{lang key='website/affiliate/history-empty-title'}</span>
                    <span class="fs-7">{lang key='website/affiliate/history-empty-text'}</span>
                </div>
                {/if}
            </div>
        </div>
    </div>
</div>
{/if}
{/block}
