{extends file='layouts/default.tpl'}


{block name=head}
    <link rel="stylesheet" href="{asset path='css/service-detail.css'}">
    <link rel="stylesheet" href="{asset path='css/service-detail-sms.css'}">
    <link rel="stylesheet" href="{asset path='css/libs/wcp-table/table.css'}">
    <link rel="stylesheet" href="{asset path='js/libs/intl-tel-input/css/intlTelInput.min.css'}">
{/block}

{block name=content}
<section class="pt-4 pb-5">
    <div class="container" data-sms-panel data-op-url="{link route='sms'}"
         data-sms-contacts="{$sms_contacts_json}" data-sms-groups="{$sms_groups_json}"
         data-sms-senders="{$sms_senders_json}"
         data-sms-rates="{$sms_rates_json}" data-sms-prefixes="{$sms_prefixes_json}"
         data-sms-names="{$sms_names_json}"
         data-sms-balance="{$send_balance_raw}" data-sms-currency="{$send_currency}"
         data-sms-max-parts="{$sms_max_parts}"
         data-sms-gsm-single="{$sms_limits.gsm.single}" data-sms-gsm-multi="{$sms_limits.gsm.multi}"
         data-sms-uni-single="{$sms_limits.unicode.single}" data-sms-uni-multi="{$sms_limits.unicode.multi}"
         data-txt-sn-not-selected="{lang key='website/sms/panel/sn-not-selected'}"
         data-txt-sn-recipients="{lang key='website/sms/panel/sn-reccount'}"
         data-txt-sn-from-groups="{lang key='website/sms/panel/sn-from-groups'}"
         data-txt-sn-typed="{lang key='website/sms/panel/sn-typed'}"
         data-txt-sn-skipped="{lang key='website/sms/panel/sn-skipped'}"
         data-txt-sn-blocked="{lang key='website/sms/panel/sn-blocked'}"
         data-txt-sn-unpriced="{lang key='website/sms/panel/sn-unpriced'}"
         data-txt-sn-truncated="{lang key='website/sms/panel/sn-truncated'}"
         data-txt-sn-lowbalance-tip="{lang key='website/sms/panel/sn-lowbalance-tip'}"
         data-txt-sn-sending="{lang key='website/sms/panel/rv-sending'}"
         data-txt-sn-characters="{lang key='website/sms/panel/sn-characters'}"
         data-txt-sn-sms="{lang key='website/sms/panel/sn-sms'}"
         data-sms-page="{$sms_page}" data-sms-pages="{$sms_pages}" data-sms-total="{$sms_contacts_total}" data-sms-filtered="{$sms_contacts_filtered}" data-sms-per-page="{$sms_per_page}"
         data-txt-pager="{lang key='website/sms/panel/con-pager'}"
         data-txt-loading="{lang key='website/sms/panel/con-loading'}"
         data-txt-edit="{lang key='website/sms/panel/con-edit'}"
         data-txt-delete="{lang key='website/sms/panel/con-delete'}"
         data-txt-rename="{lang key='website/sms/panel/con-rename'}"
         data-txt-group-options="{lang key='website/sms/panel/con-group-options'}"
         data-txt-cancel="{lang key='website/sms/panel/con-cancel'}"
         data-txt-remove="{lang key='website/sms/panel/con-remove'}"
         data-txt-del-ct-title="{lang key='website/sms/panel/con-del-ct-title'}"
         data-txt-del-ct-msg="{lang key='website/sms/panel/con-del-ct-msg'}"
         data-txt-del-gr-title="{lang key='website/sms/panel/con-del-gr-title'}"
         data-txt-del-gr-msg="{lang key='website/sms/panel/con-del-gr-msg'}"
         data-txt-ct-add="{lang key='website/sms/panel/ct-add-title'}"
         data-txt-ct-edit="{lang key='website/sms/panel/ct-edit-title'}"
         data-txt-gr-add="{lang key='website/sms/panel/gr-add-title'}"
         data-txt-gr-rename="{lang key='website/sms/panel/gr-rename-title'}"
         data-txt-sample="{lang key='website/sms/panel/im-sample-done'}"
         data-txt-sid-default="{lang key='website/sms/panel/sid-default'}"
         data-txt-sid-active-n="{lang key='website/sms/panel/sid-active-n'}"
         data-txt-sid-pending-n="{lang key='website/sms/panel/sid-pending-n'}"
         data-txt-sid-rejected-n="{lang key='website/sms/panel/sid-rejected-n'}"
         data-txt-sid-no-countries="{lang key='website/sms/panel/sid-no-countries'}"
         data-txt-sid-added="{lang key='website/sms/panel/sid-added'}"
         data-txt-sid-no-country-hint="{lang key='website/sms/panel/sid-no-country-hint'}"
         data-txt-sid-countries="{lang key='website/sms/panel/sid-countries'}"
         data-txt-sid-set-default="{lang key='website/sms/panel/sid-set-default'}"
         data-txt-sid-add-country="{lang key='website/sms/panel/sid-add-country'}"
         data-txt-sid-remove="{lang key='website/sms/panel/sid-remove'}"
         data-txt-sid-cstatus-active="{lang key='website/sms/panel/sid-cstatus-active'}"
         data-txt-sid-cstatus-pending="{lang key='website/sms/panel/sid-cstatus-pending'}"
         data-txt-sid-cstatus-rejected="{lang key='website/sms/panel/sid-cstatus-rejected'}"
         data-txt-sid-submitted="{lang key='website/sms/panel/sid-submitted'}"
         data-txt-sid-resubmit="{lang key='website/sms/panel/sid-resubmit'}"
         data-txt-sid-this="{lang key='website/sms/panel/sid-this'}"
         data-txt-sid-sender="{lang key='website/sms/panel/sid-sender'}"
         data-txt-sid-country="{lang key='website/sms/panel/sid-country'}"
         data-txt-sid-del-title="{lang key='website/sms/panel/sid-del-title'}"
         data-txt-sid-del-msg="{lang key='website/sms/panel/sid-del-msg'}">
        {csrf form='sms-panel'}

        <nav aria-label="{lang key='website/sms/panel/breadcrumb-aria'}">
            <ol class="breadcrumb mb-3">
                <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                <li class="breadcrumb-item active" aria-current="page">{lang key='website/sms/panel/hero-title'}</li>
            </ol>
        </nav>

        {hook name='ui:client.sms_panel.top'}

        <header class="sd-hero">
            <div class="sd-hero-main">
                <div class="sd-hero-lead">
                    <span class="sd-hero-ico"><i class="bi bi-chat-dots"></i></span>
                    <div class="sd-hero-id">
                        <div class="sd-hero-titlerow">
                            <h1 class="sd-hero-title">{lang key='website/sms/panel/hero-title'}</h1>
                        </div>
                        <div class="sd-hero-meta">
                            <span class="text-body-secondary">{lang key='website/sms/panel/hero-lead'}</span>
                        </div>
                    </div>
                </div>
                <div class="sd-hero-actions">
                    <button type="button" class="btn btn-secondary btn-sm" data-action="show-tab" data-tab="sd-send-tab"><i class="bi bi-send me-1"></i>{lang key='website/sms/panel/tab-send'}</button>
                </div>
            </div>
            <div class="sd-hero-foot">
                <dl class="sd-facts">
                    <div class="sd-fact">
                        <dt>{lang key='website/sms/panel/f-credit'}</dt>
                        <dd class="num-tabular">{$credit_balance}</dd>
                    </div>
                    <div class="sd-fact">
                        <dt>{lang key='website/sms/panel/f-sent'}</dt>
                        <dd class="num-tabular">{$sent_month}</dd>
                    </div>
                </dl>
            </div>
        </header>

        <div class="card sd-tabcard">
            <div class="card-header sd-tabbar" data-scroll-prev="{lang key='needs/tabs-scroll-prev'}" data-scroll-next="{lang key='needs/tabs-scroll-next'}">
                <ul class="nav sd-segtabs" role="tablist" data-wstyle-tabs="sms">
                    <li class="nav-item" role="presentation"><button class="nav-link active" id="sd-overview-tab" data-tab-hash="overview" data-bs-toggle="tab" data-bs-target="#sd-overview" type="button" role="tab" aria-controls="sd-overview" aria-selected="true"><i class="bi bi-grid-1x2 me-1"></i>{lang key='website/sms/panel/tab-overview'}</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" id="sd-send-tab" data-tab-hash="send" data-bs-toggle="tab" data-bs-target="#sd-send" type="button" role="tab" aria-controls="sd-send" aria-selected="false"><i class="bi bi-send me-1"></i>{lang key='website/sms/panel/tab-send'}</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" id="sd-contacts-tab" data-tab-hash="contacts" data-bs-toggle="tab" data-bs-target="#sd-contacts" type="button" role="tab" aria-controls="sd-contacts" aria-selected="false"><i class="bi bi-person-rolodex me-1"></i>{lang key='website/sms/panel/tab-contacts'}</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" id="sd-senderids-tab" data-tab-hash="senderids" data-bs-toggle="tab" data-bs-target="#sd-senderids" type="button" role="tab" aria-controls="sd-senderids" aria-selected="false"><i class="bi bi-person-badge me-1"></i>{lang key='website/sms/panel/tab-senderids'}</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" id="sd-history-tab" data-tab-hash="history" data-bs-toggle="tab" data-bs-target="#sd-history" type="button" role="tab" aria-controls="sd-history" aria-selected="false"><i class="bi bi-clock-history me-1"></i>{lang key='website/sms/panel/tab-history'}</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" id="sd-activity-tab" data-tab-hash="activity" data-bs-toggle="tab" data-bs-target="#sd-activity" type="button" role="tab" aria-controls="sd-activity" aria-selected="false"><i class="bi bi-activity me-1"></i>{lang key='website/sms/panel/tab-activity'}</button></li>
                </ul>
            </div>
            <div class="card-body sd-panes">
                <div class="tab-content">

                    <div class="tab-pane fade show active" id="sd-overview" role="tabpanel" aria-labelledby="sd-overview-tab" tabindex="0">
                        <div class="row g-3">
                            <div class="col-lg-5">
                                <section class="sd-panel h-100 d-flex flex-column">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-wallet2 me-1"></i>{lang key='website/sms/panel/ov-credit-title'}</h2>
                                        <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#sd-addcredit"><i class="bi bi-coin me-1"></i>{lang key='website/sms/panel/ov-add-credit'}</button>
                                    </div>
                                    <div class="sms-credit">
                                        <span class="sms-credit-amount num-tabular" data-role="credit-balance">{$credit_balance}</span>
                                        <span class="sms-credit-label fs-7 text-body-secondary">{lang key='website/sms/panel/ov-credit-avail'}</span>
                                    </div>
                                    <p class="fs-7 text-body-secondary mb-0">{lang key='website/sms/panel/ov-credit-desc'} <a href="{link route='international-sms'}">{lang key='website/sms/panel/ov-view-rates'}</a>.</p>
                                </section>
                            </div>
                            <div class="col-lg-7">
                                <section class="sd-panel h-100 d-flex flex-column">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-graph-up me-1"></i>{lang key='website/sms/panel/ov-usage-title'}</h2>
                                    </div>
                                    <div class="sms-stats">
                                        <div class="sms-stat">
                                            <span class="sms-stat-value num-tabular">{$sent_month}</span>
                                            <span class="sms-stat-label">{lang key='website/sms/panel/ov-sent'}</span>
                                        </div>
                                        <div class="sms-stat">
                                            <span class="sms-stat-value num-tabular">{$spent_month}</span>
                                            <span class="sms-stat-label">{lang key='website/sms/panel/ov-spent'}</span>
                                        </div>
                                    </div>
                                </section>
                            </div>

                            <div class="col-lg-7">
                                <section class="sd-panel h-100">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-code-slash me-1"></i>{lang key='website/sms/panel/ov-api-title'}</h2>
                                        <a class="btn btn-soft btn-sm" href="{link route='kbase'}"><i class="bi bi-journal-code me-1"></i>{lang key='website/sms/panel/ov-api-docs'}</a>
                                    </div>
                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/sms/panel/ov-api-desc'}</p>
                                    <div class="sd-fields">
                                        <div class="sd-field sd-field-wide">
                                            <span class="sd-field-label">{lang key='website/sms/panel/ov-api-base-label'}</span>
                                            <div class="sd-field-val">
                                                <span>{$sms_api_base}</span>
                                                <button type="button" class="btn btn-ghost btn-sm sd-copy" data-action="copy" data-copy-text="{$sms_api_base}" aria-label="{lang key='website/sms/panel/ov-api-copy-aria'}" data-bs-toggle="tooltip" title="{lang key='website/sms/panel/ov-api-copy'}"><i class="bi bi-clipboard"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                    {if !$sms_api_enabled}<div class="form-text mt-2"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/ov-api-disabled'}</div>{/if}
                                </section>
                            </div>
                            <div class="col-lg-5">
                                <section class="sd-panel h-100">
                                    <h2 class="sd-panel-title"><i class="bi bi-card-list me-1"></i>{lang key='website/sms/panel/ov-details-title'}</h2>
                                    <dl class="sd-info mb-0">
                                        <div class="sd-info-row"><dt>{lang key='website/sms/panel/ov-account-no'}</dt><dd class="num-tabular">{$sms_account_no}</dd></div>
                                        <div class="sd-info-row"><dt>{lang key='website/sms/panel/ov-default-sender'}</dt><dd>{if $sms_default_sender}{$sms_default_sender}{else}<span class="text-body-secondary">{lang key='website/sms/panel/ov-default-none'}</span>{/if}</dd></div>
                                        <div class="sd-info-row"><dt>{lang key='website/sms/panel/ov-routing'}</dt><dd>{lang key='website/sms/panel/ov-routing-val'}</dd></div>
                                        <div class="sd-info-row"><dt>{lang key='website/sms/panel/ov-coverage'}</dt><dd>{lang key='website/sms/panel/ov-coverage-val'}</dd></div>
                                    </dl>
                                </section>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="sd-send" role="tabpanel" aria-labelledby="sd-send-tab" tabindex="0">
                        <div class="row g-3">
                            <div class="col-lg-7">
                                <section class="sd-panel h-100">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-send me-1"></i>{lang key='website/sms/panel/sn-compose'}</h2>
                                        <span class="sms-balance" data-role="send-balance"><i class="bi bi-wallet2 me-1"></i>{lang key='website/sms/panel/sn-balance'} <span class="num-tabular" data-role="send-balance-value">{$send_balance}</span></span>
                                    </div>

                                    {hook name='ui:client.sms_send.top'}

                                    <div class="mb-3">
                                        <label class="form-label" for="sms-send-origin">{lang key='website/sms/panel/sn-sender'} <span class="text-danger">*</span></label>
                                        <select class="form-select" id="sms-send-origin" data-role="send-origin">
                                            <option value="" {if !$send_senders}selected{/if}>{lang key='website/sms/panel/sn-sender-choose'}</option>
                                            {foreach $send_senders as $s}
                                                <option value="{$s.name}" data-approved="{$s.approved}"{if $s.selected} selected{/if}>{$s.name}</option>
                                            {/foreach}
                                        </select>
                                        <div class="form-text">{lang key='website/sms/panel/sn-sender-hint'} <a href="#" data-action="show-tab" data-tab="sd-senderids-tab">{lang key='website/sms/panel/sn-sender-manage'}</a>.</div>
                                    </div>

                                    <div class="mb-3">
                                        <div class="d-flex align-items-center justify-content-between gap-2 mb-1">
                                            <label class="form-label mb-0" for="sms-send-message">{lang key='website/sms/panel/sn-message'} <span class="text-danger">*</span></label>
                                            <span class="sms-msgmeta fs-8 text-body-secondary"><span class="num-tabular"><span data-role="send-charcount">0</span> {lang key='website/sms/panel/sn-characters'} &middot; <span data-role="send-smscount">1</span> {lang key='website/sms/panel/sn-sms'}</span><span class="badge bg-secondary-subtle text-secondary-emphasis" data-role="send-encoding"><i class="bi bi-type me-1"></i>GSM-7</span></span>
                                        </div>
                                        <textarea class="form-control" id="sms-send-message" rows="5" placeholder="{lang key='website/sms/panel/sn-message-ph'}" data-role="send-message"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <span class="form-label d-block mb-1">{lang key='website/sms/panel/sn-recipients'} <span class="text-danger">*</span></span>
                                        <div class="sms-groups" role="group" aria-label="{lang key='website/sms/panel/sn-groups-aria'}" data-role="send-grouplist">
                                            {foreach $sms_groups as $g}
                                                <label class="sms-group">
                                                    <input class="form-check-input" type="checkbox" data-role="send-group" data-group-id="{$g.id}" data-count="{$g.count}">
                                                    <span class="sms-group-name">{$g.name}</span>
                                                    <span class="sms-group-count num-tabular">{$g.count}</span>
                                                </label>
                                            {foreachelse}
                                                <p class="fs-8 text-body-secondary mb-0">{lang key='website/sms/panel/sn-no-groups'} <a href="#" data-action="show-tab" data-tab="sd-contacts-tab">{lang key='website/sms/panel/sn-no-groups-cta'}</a>.</p>
                                            {/foreach}
                                        </div>
                                        <label class="form-label fs-7 mt-3 mb-1" for="sms-send-numbers">{lang key='website/sms/panel/sn-manual'}</label>
                                        <textarea class="form-control sms-numbers" id="sms-send-numbers" rows="4" inputmode="tel" placeholder="{lang key='website/sms/panel/sn-numbers-ph'}" data-role="send-numbers"></textarea>
                                        <div class="form-text"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/sn-numbers-hint'}</div>
                                    </div>

                                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-2">
                                        <span class="sms-reccount" data-role="send-reccount"><i class="bi bi-people"></i><span><span class="num-tabular" data-role="send-numcount">0</span> {lang key='website/sms/panel/sn-reccount'}</span></span>
                                        <span class="d-inline-block" data-role="send-btn-wrap" data-managed-tooltip>
                                            <button type="button" class="btn btn-secondary" data-action="send-sms"><i class="bi bi-send me-1"></i>{lang key='website/sms/panel/sn-review'}</button>
                                        </span>
                                    </div>

                                    {hook name='ui:client.sms_send.bottom'}
                                </section>
                            </div>
                            <div class="col-lg-5">
                                <section class="sd-panel">
                                    <h2 class="sd-panel-title"><i class="bi bi-clipboard-check me-1"></i>{lang key='website/sms/panel/sn-summary'}</h2>
                                    <dl class="sd-info mb-0">
                                        <div class="sd-info-row"><dt>{lang key='website/sms/panel/sn-sender'}</dt><dd class="sms-sum-origin is-muted" data-role="send-sum-origin">{lang key='website/sms/panel/sn-not-selected'}</dd></div>
                                        <div class="sd-info-row"><dt>{lang key='website/sms/panel/sn-recipients'}</dt><dd class="num-tabular" data-role="send-sum-recipients">0</dd></div>
                                        <div class="sd-info-row"><dt>{lang key='website/sms/panel/sn-per-message'}</dt><dd class="num-tabular" data-role="send-sum-parts">1</dd></div>
                                        <div class="sd-info-row"><dt>{lang key='website/sms/panel/sn-total-messages'}</dt><dd class="num-tabular" data-role="send-sum-total">0</dd></div>
                                    </dl>
                                    <div class="sms-send-cost">
                                        <span class="sms-send-cost-label"><i class="bi bi-cash-coin me-1"></i>{lang key='website/sms/panel/sn-cost'}</span>
                                        <span class="sms-send-cost-value num-tabular" data-role="send-sum-cost">{$send_zero}</span>
                                    </div>
                                    <div class="wui-collapse" data-role="send-lowbalance-wrap">
                                        <div class="wui-collapse-inner">
                                            <div class="sms-lowbalance pt-2"><i class="bi bi-exclamation-triangle me-1"></i>{lang key='website/sms/panel/sn-lowbalance'}<button type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#sd-addcredit">{lang key='website/sms/panel/ov-add-credit'}</button></div>
                                        </div>
                                    </div>
                                    <div class="wui-collapse" data-role="send-blocked-wrap">
                                        <div class="wui-collapse-inner">
                                            <div class="sms-skip pt-2">
                                                <span class="sms-skip-head"><i class="bi bi-shield-exclamation me-1"></i><span data-role="send-blocked-text"></span></span>
                                                <span class="sms-skip-list" data-role="send-blocked-list"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="wui-collapse" data-role="send-unpriced-wrap">
                                        <div class="wui-collapse-inner">
                                            <div class="sms-skip pt-2">
                                                <span class="sms-skip-head"><i class="bi bi-slash-circle me-1"></i><span data-role="send-unpriced-text"></span></span>
                                                <span class="sms-skip-list" data-role="send-unpriced-list"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="fs-8 text-body-secondary mb-0 mt-2">{lang key='website/sms/panel/sn-rate-note'} <a href="{link route='international-sms'}">{lang key='website/sms/panel/sn-view-rates'}</a>.</p>
                                </section>
                                <section class="sd-panel mt-3">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-rulers me-1"></i>{lang key='website/sms/panel/sn-length'}</h2>
                                        <span class="badge bg-secondary-subtle text-secondary-emphasis" data-role="send-encoding-badge"><i class="bi bi-type me-1"></i>GSM-7</span>
                                    </div>
                                    <ul class="sms-charguide fs-7 mb-0">
                                        <li><span>{lang key='website/sms/panel/sn-upto'} <span class="num-tabular" data-role="len-1">{$sms_limits.gsm.single}</span> {lang key='website/sms/panel/sn-characters'}</span><span class="num-tabular">1 {lang key='website/sms/panel/sn-sms'}</span></li>
                                        <li><span>{lang key='website/sms/panel/sn-upto'} <span class="num-tabular" data-role="len-2">{$sms_limits.gsm.multi*2}</span> {lang key='website/sms/panel/sn-characters'}</span><span class="num-tabular">2 {lang key='website/sms/panel/sn-sms'}</span></li>
                                        <li><span>{lang key='website/sms/panel/sn-upto'} <span class="num-tabular" data-role="len-3">{$sms_limits.gsm.multi*3}</span> {lang key='website/sms/panel/sn-characters'}</span><span class="num-tabular">3 {lang key='website/sms/panel/sn-sms'}</span></li>
                                        <li><span>{lang key='website/sms/panel/sn-each'} +<span class="num-tabular" data-role="len-step">{$sms_limits.gsm.multi}</span> {lang key='website/sms/panel/sn-characters'}</span><span class="num-tabular">+1 {lang key='website/sms/panel/sn-sms'}</span></li>
                                    </ul>
                                    <p class="fs-8 text-body-secondary mb-0 mt-2"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/sn-unicode-note'}</p>
                                </section>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="sd-contacts" role="tabpanel" aria-labelledby="sd-contacts-tab" tabindex="0">
                        <div class="row g-3">
                            <div class="col-lg-4">
                                <section class="sd-panel h-100">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><i class="bi bi-collection me-1"></i>{lang key='website/sms/panel/con-groups'}</h2>
                                        <button type="button" class="btn btn-soft btn-sm" data-action="group-add"><i class="bi bi-plus-lg me-1"></i>{lang key='website/sms/panel/con-new-group'}</button>
                                    </div>
                                    <ul class="sms-cgroup-list" data-role="cgroup-list">
                                        <li>
                                            <button type="button" class="sms-cgroup is-active" data-action="select-group" data-group="all" aria-pressed="true">
                                                <span class="sms-cgroup-ico"><i class="bi bi-people"></i></span>
                                                <span class="sms-cgroup-name">{lang key='website/sms/panel/con-all'}</span>
                                                <span class="sms-cgroup-count num-tabular" data-count="{$sms_contacts_total}">{$sms_contacts_total}</span>
                                            </button>
                                        </li>
                                        {foreach $sms_groups as $g}
                                        <li>
                                            <button type="button" class="sms-cgroup" data-action="select-group" data-group="{$g.id}" aria-pressed="false">
                                                <span class="sms-cgroup-ico"><i class="bi bi-collection"></i></span>
                                                <span class="sms-cgroup-name">{$g.name}</span>
                                                <span class="sms-cgroup-count num-tabular" data-count="{$g.count}">{$g.count}</span>
                                            </button>
                                            <div class="dropdown sms-cgroup-more">
                                                <button type="button" class="btn btn-soft btn-sm" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/sms/panel/con-group-options'}"><i class="bi bi-three-dots"></i></button>
                                                <ul class="dropdown-menu dropdown-menu-end sd-menu">
                                                    <li><button type="button" class="dropdown-item" data-action="group-edit" data-group="{$g.id}" data-group-name="{$g.name}"><i class="bi bi-pencil"></i>{lang key='website/sms/panel/con-rename'}</button></li>
                                                    <li><button type="button" class="dropdown-item text-danger" data-action="group-delete" data-group="{$g.id}" data-group-name="{$g.name}"><i class="bi bi-trash3"></i>{lang key='website/sms/panel/con-delete'}</button></li>
                                                </ul>
                                            </div>
                                        </li>
                                        {/foreach}
                                    </ul>
                                    <p class="fs-8 text-body-secondary mb-0 mt-3"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/con-groups-hint'}</p>
                                </section>
                            </div>
                            <div class="col-lg-8">
                                <section class="sd-panel h-100 d-flex flex-column">
                                    <div class="sd-panel-head">
                                        <h2 class="sd-panel-title"><span data-role="contacts-title">{lang key='website/sms/panel/con-all'}</span> <span class="text-body-secondary fw-normal">(<span class="num-tabular" data-role="contacts-count">{$sms_contacts_total}</span>)</span></h2>
                                        <div class="d-flex flex-wrap gap-2">
                                            <button type="button" class="btn btn-soft btn-sm" data-action="contacts-import"><i class="bi bi-upload me-1"></i>{lang key='website/sms/panel/con-import'}</button>
                                            <button type="button" class="btn btn-primary btn-sm" data-action="contact-add"><i class="bi bi-person-plus me-1"></i>{lang key='website/sms/panel/con-add'}</button>
                                        </div>
                                    </div>
                                    <div class="sms-contacts-toolbar">
                                        <label for="sms-contacts-search" class="visually-hidden">{lang key='website/sms/panel/con-search-label'}</label>
                                        <div class="input-group input-group-sm">
                                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                                            <input type="search" class="form-control" id="sms-contacts-search" placeholder="{lang key='website/sms/panel/con-search-ph'}" autocomplete="off" data-role="contacts-search">
                                        </div>
                                    </div>
                                    <div class="sms-contacts-listwrap" data-role="contacts-listwrap">
                                        <div class="table-responsive{if !$sms_contacts} d-none{/if}" data-role="contacts-table">
                                            <table class="table table-hover align-middle sms-contact-table mb-0">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">{lang key='website/sms/panel/con-th-name'}</th>
                                                        <th scope="col">{lang key='website/sms/panel/con-th-number'}</th>
                                                        <th scope="col">{lang key='website/sms/panel/con-th-groups'}</th>
                                                        <th scope="col"><span class="visually-hidden">{lang key='website/sms/panel/con-th-actions'}</span></th>
                                                    </tr>
                                                </thead>
                                                <tbody data-role="contact-rows">
                                                    {foreach $sms_contacts as $c}
                                                    <tr class="sms-contact-row" data-id="{$c.id}" data-groups="{$c.groups_attr}" data-name="{$c.name_l}" data-search="{$c.search}">
                                                        <td class="sms-contact-name">{$c.name}</td>
                                                        <td class="num-tabular">{$c.number}</td>
                                                        <td>{foreach $c.gnames as $gn}<span class="sms-ctag">{$gn}</span>{/foreach}</td>
                                                        <td class="text-end sms-contact-actions">
                                                            <button type="button" class="btn btn-ghost btn-sm" data-action="contact-edit" data-bs-toggle="tooltip" title="{lang key='website/sms/panel/con-edit'}" aria-label="{lang key='website/sms/panel/con-edit'} {$c.name}"><i class="bi bi-pencil"></i></button>
                                                            <button type="button" class="btn btn-ghost btn-sm" data-action="contact-delete" data-bs-toggle="tooltip" title="{lang key='website/sms/panel/con-delete'}" aria-label="{lang key='website/sms/panel/con-delete'} {$c.name}"><i class="bi bi-trash3"></i></button>
                                                        </td>
                                                    </tr>
                                                    {/foreach}
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="sms-contacts-pager d-flex flex-wrap justify-content-between align-items-center gap-2 mt-3{if $sms_pages <= 1} d-none{/if}" data-role="contacts-pager">
                                            <span class="fs-8 text-body-secondary num-tabular" data-role="pager-info"></span>
                                            <div class="btn-group btn-group-sm" role="group" aria-label="{lang key='website/sms/panel/con-pages-aria'}">
                                                <button type="button" class="btn btn-soft" data-action="contacts-prev"{if $sms_page <= 1} disabled{/if} aria-label="{lang key='website/sms/panel/con-prev'}"><i class="bi bi-chevron-left"></i></button>
                                                <button type="button" class="btn btn-soft" data-action="contacts-next"{if $sms_page >= $sms_pages} disabled{/if} aria-label="{lang key='website/sms/panel/con-next'}"><i class="bi bi-chevron-right"></i></button>
                                            </div>
                                        </div>
                                        <div class="wstyle-empty-state{if $sms_contacts} d-none{/if}" data-role="contacts-empty">
                                            <i class="bi bi-person-rolodex" aria-hidden="true"></i>
                                            <span class="fw-semibold">{lang key='website/sms/panel/con-empty'}</span>
                                        </div>
                                        <div class="sms-contacts-overlay" aria-hidden="true">
                                            <span class="spinner-border spinner-border-sm text-secondary" role="status"></span>
                                        </div>
                                    </div>
                                    <p class="fs-8 text-body-secondary mb-0 mt-3"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/con-foot'}</p>
                                </section>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="sd-senderids" role="tabpanel" aria-labelledby="sd-senderids-tab" tabindex="0">
                        <section class="sd-panel">
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-person-badge me-1"></i>{lang key='website/sms/panel/sid-title'}</h2>
                                <button type="button" class="btn btn-primary btn-sm" data-wui-toggle data-wui-target="#sd-addsender" aria-expanded="false" aria-controls="sd-addsender"><i class="bi bi-plus-lg me-1"></i>{lang key='website/sms/panel/sid-add'}</button>
                            </div>
                            <p class="fs-7 text-body-secondary mb-0">{lang key='website/sms/panel/sid-lead'}</p>

                            <div class="wui-collapse" id="sd-addsender">
                                <div class="wui-collapse-inner">
                                    <div class="pt-3">
                                        <div class="sms-addsender">
                                            <div class="mb-3">
                                                <label class="form-label" for="sms-newsender">{lang key='website/sms/panel/sid-new'} <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="sms-newsender" maxlength="11" autocomplete="off" spellcheck="false" placeholder="{lang key='website/sms/panel/sid-new-ph'}" data-role="newsender-input">
                                                <div class="form-text">{lang key='website/sms/panel/sid-new-help'}</div>
                                            </div>
                                            <div class="form-check mb-3">
                                                <input class="form-check-input" type="checkbox" id="sms-sender-legal" data-role="newsender-legal">
                                                <label class="form-check-label fs-7" for="sms-sender-legal">{lang key='website/sms/panel/sid-legal'}</label>
                                            </div>
                                            <div class="d-flex flex-wrap justify-content-end gap-2">
                                                <button type="button" class="btn btn-soft" data-wui-toggle data-wui-target="#sd-addsender"><i class="bi bi-x-lg me-1"></i>{lang key='website/sms/panel/sid-discard'}</button>
                                                <button type="button" class="btn btn-primary" data-action="add-sender" disabled><i class="bi bi-plus-lg me-1"></i>{lang key='website/sms/panel/sid-add'}</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <ul class="sms-sender-list mt-3{if !$sms_senders} d-none{/if}" data-role="sender-list">
                                {foreach $sms_senders as $s}
                                <li class="sms-sender{if $s.counts.waiting} is-pending{elseif $s.counts.inactive} is-rejected{/if}" data-sender-id="{$s.id}">
                                    <div class="sms-sender-row">
                                        <span class="sms-sender-ico"><i class="bi bi-person-badge"></i></span>
                                        <div class="sms-sender-main">
                                            <span class="sms-sender-head">
                                                <span class="sms-sender-name">{$s.name}</span>
                                                {if $s.is_default}<span class="badge bg-primary-subtle text-primary-emphasis" data-role="sender-default-badge"><i class="bi bi-star-fill me-1"></i>{lang key='website/sms/panel/sid-default'}</span>{/if}
                                                {if $s.counts.active}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/sms/panel/sid-active-n' n=$s.counts.active}</span>{/if}
                                                {if $s.counts.waiting}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/sms/panel/sid-pending-n' n=$s.counts.waiting}</span>{/if}
                                                {if $s.counts.inactive}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/sms/panel/sid-rejected-n' n=$s.counts.inactive}</span>{/if}
                                                {if !$s.countries}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/sms/panel/sid-no-countries'}</span>{/if}
                                            </span>
                                            <span class="sms-sender-meta fs-7 text-body-secondary">{if $s.countries}<span class="num-tabular">{lang key='website/sms/panel/sid-added'} {$s.added}</span>{else}<span>{lang key='website/sms/panel/sid-no-country-hint'}</span>{/if}</span>
                                        </div>
                                        <div class="sms-sender-actions">
                                            {if $s.counts.active}<button type="button" class="btn btn-ghost btn-sm" data-wui-toggle data-wui-target="#sd-ctry-{$s.id}" aria-expanded="false" aria-controls="sd-ctry-{$s.id}"><i class="bi bi-globe2 me-1"></i>{lang key='website/sms/panel/sid-countries'}<i class="bi bi-chevron-down wui-collapse-caret ms-1"></i></button>{/if}
                                            {if !$s.is_default}<button type="button" class="btn btn-soft btn-sm" data-action="sender-default" data-id="{$s.id}"><i class="bi bi-star me-1"></i>{lang key='website/sms/panel/sid-set-default'}</button>{/if}
                                            <button type="button" class="btn btn-soft btn-sm" data-action="add-country" data-id="{$s.id}" data-sender="{$s.name}"><i class="bi bi-globe-americas me-1"></i>{lang key='website/sms/panel/sid-add-country'}</button>
                                            <button type="button" class="btn btn-ghost btn-sm" data-action="sender-remove" data-id="{$s.id}" data-sender="{$s.name}" aria-label="{lang key='website/sms/panel/sid-remove'}" data-bs-toggle="tooltip" title="{lang key='website/sms/panel/sid-remove'}"><i class="bi bi-trash3"></i></button>
                                        </div>
                                    </div>
                                    {assign var=hasAttention value=false}
                                    {foreach $s.countries as $c}{if $c.status != 'active'}{assign var=hasAttention value=true}{/if}{/foreach}
                                    {if $hasAttention}
                                    <div class="sms-country-list">
                                        {foreach $s.countries as $c}{if $c.status == 'waiting'}
                                        <div class="sms-country">
                                            <span class="sms-country-name"><i class="bi bi-geo-alt me-1"></i>{$c.name}</span>
                                            <span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/sms/panel/sid-cstatus-pending'}</span>
                                            {if $c.date}<span class="sms-country-note fs-8 text-body-secondary">{lang key='website/sms/panel/sid-submitted'} {$c.date}</span>{/if}
                                        </div>
                                        {elseif $c.status == 'inactive'}
                                        <div class="sms-country">
                                            <span class="sms-country-name"><i class="bi bi-geo-alt me-1"></i>{$c.name}</span>
                                            <span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/sms/panel/sid-cstatus-rejected'}</span>
                                            {if $c.reason}<span class="sms-country-note fs-8 text-body-secondary">{$c.reason}</span>{/if}
                                            <button type="button" class="btn btn-soft btn-sm sms-country-action" data-action="resubmit" data-id="{$c.id}" data-sender="{$s.name}" data-country="{$c.name}" data-reason="{$c.reason}"><i class="bi bi-arrow-clockwise me-1"></i>{lang key='website/sms/panel/sid-resubmit'}</button>
                                        </div>
                                        {/if}{/foreach}
                                    </div>
                                    {/if}
                                    {if $s.counts.active}
                                    <div class="wui-collapse" id="sd-ctry-{$s.id}">
                                        <div class="wui-collapse-inner">
                                            <div class="sms-country-list pt-3">
                                                {foreach $s.countries as $c}{if $c.status == 'active'}
                                                <div class="sms-country"><span class="sms-country-name"><i class="bi bi-geo-alt me-1"></i>{$c.name}</span><span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/sms/panel/sid-cstatus-active'}</span></div>
                                                {/if}{/foreach}
                                            </div>
                                        </div>
                                    </div>
                                    {/if}
                                </li>
                                {/foreach}
                            </ul>
                            <div class="wstyle-empty-state{if $sms_senders} d-none{/if}" data-role="sender-empty">
                                <i class="bi bi-person-badge" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/sms/panel/sid-empty'}</span>
                            </div>

                            <div class="sd-req-foot fs-7 text-body-secondary mt-3"><i class="bi bi-shield-lock me-1"></i>{lang key='website/sms/panel/sid-foot'}</div>
                        </section>
                    </div>

                    <div class="tab-pane fade" id="sd-history" role="tabpanel" aria-labelledby="sd-history-tab" tabindex="0">
                        <section class="sd-panel">
                            <div class="sd-panel-head">
                                <h2 class="sd-panel-title"><i class="bi bi-clock-history me-1"></i>{lang key='website/sms/panel/hist-title'}</h2>
                                <span class="fs-7 text-body-secondary">{lang key='website/sms/panel/hist-last'}</span>
                            </div>
                            <div class="wcp-table" data-name="sms-sends">
                                <div class="wcp-table-header">
                                    <label class="wcp-entries-label fs-8 text-body-secondary mb-0">
                                        <select class="form-select form-select-sm wcp-entries-select" aria-label="{lang key='website/sms/panel/hist-per-page-aria'}">
                                            <option value="10">10</option>
                                            <option value="25">25</option>
                                            <option value="50">50</option>
                                            <option value="-1">{lang key='website/sms/panel/hist-all'}</option>
                                        </select>
                                        {lang key='website/sms/panel/hist-per-page'}
                                    </label>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle sms-history-table mb-0">
                                        <thead>
                                            <tr>
                                                <th scope="col" data-sortable="desc" data-column="date">{lang key='website/sms/panel/hist-th-date'}</th>
                                                <th scope="col" data-sortable="true" data-column="sender">{lang key='website/sms/panel/hist-th-sender'}</th>
                                                <th scope="col">{lang key='website/sms/panel/hist-th-message'}</th>
                                                <th scope="col" class="text-end" data-sortable="true" data-column="recipients">{lang key='website/sms/panel/hist-th-recipients'}</th>
                                                <th scope="col" class="text-end" data-sortable="true" data-column="cost">{lang key='website/sms/panel/hist-th-cost'}</th>
                                                <th scope="col" data-sortable="true" data-column="dest">{lang key='website/sms/panel/hist-th-dest'}</th>
                                                <th scope="col" data-sortable="true" data-column="status">{lang key='website/sms/panel/hist-th-status'}</th>
                                                <th scope="col"><span class="visually-hidden">{lang key='website/sms/panel/hist-th-details'}</span></th>
                                            </tr>
                                        </thead>
                                        <tbody class="wcp-table-body">
                                            {foreach $send_history as $h}
                                            <tr data-status="{$h.status}" data-date="{$h.date}" data-time="{$h.time}" data-dest="{$h.dest}" data-sender="{$h.sender}" data-recipients="{$h.recipients}" data-delivered="{$h.delivered}" data-cost="{$h.cost}" data-message="{$h.message}" data-id="{$h.id}">
                                                <td class="num-tabular" data-value="{$h.ts}">{$h.date}<span class="d-block fs-8 text-body-secondary">{$h.time}</span></td>
                                                <td>{$h.sender}</td>
                                                <td class="sms-msg-cell"><span class="sms-msg-preview" title="{$h.message}">{$h.message}</span></td>
                                                <td class="text-end num-tabular" data-value="{$h.recipients}">{$h.recipients}</td>
                                                <td class="text-end num-tabular" data-value="{$h.cost_raw}">{$h.cost}</td>
                                                <td data-value="{$h.dest}">{if $h.dest_code}<span class="iti__flag iti__{$h.dest_code}"></span>{/if}{$h.dest}</td>
                                                {if $h.status == 'delivered'}<td data-value="{lang key='website/sms/panel/hist-status-delivered'}"><span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/sms/panel/hist-status-delivered'}</span></td>
                                                {elseif $h.status == 'partial'}<td data-value="{lang key='website/sms/panel/hist-status-partial'}"><span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-exclamation-triangle me-1"></i>{lang key='website/sms/panel/hist-status-partial'}</span></td>
                                                {elseif $h.status == 'pending'}<td data-value="{lang key='website/sms/panel/batch-pending'}"><span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/sms/panel/batch-pending'}</span></td>
                                                {else}<td data-value="{lang key='website/sms/panel/hist-status-failed'}"><span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/sms/panel/hist-status-failed'}</span></td>{/if}
                                                <td class="text-end"><button type="button" class="btn btn-ghost btn-sm" data-action="batch-view" data-id="{$h.id}" aria-label="{lang key='website/sms/panel/hist-view'}" data-bs-toggle="tooltip" title="{lang key='website/sms/panel/hist-view'}"><i class="bi bi-eye"></i></button></td>
                                            </tr>
                                            {/foreach}
                                        </tbody>
                                        <tbody class="wcp-table-loader-body d-none">
                                            <tr><td colspan="8" class="text-center py-4"><span class="wcp-table-loader spinner-border spinner-border-sm text-secondary" role="status" aria-hidden="true"></span></td></tr>
                                        </tbody>
                                        <tbody class="wcp-table-no-result-body d-none">
                                            <tr><td colspan="8"><div class="wcp-table-no-result wstyle-empty-state py-4"><i class="bi bi-inbox" aria-hidden="true"></i><span class="fw-semibold">{lang key='website/sms/panel/hist-empty'}</span></div></td></tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="wcp-table-footer">
                                    <div class="wcp-table-info fs-8 text-body-secondary" data-msg1="{lang key='website/sms/panel/hist-info1'}" data-msg2="{lang key='website/sms/panel/hist-info2'}" data-msg3="{lang key='website/sms/panel/hist-info3'}"></div>
                                    <nav class="wcp-table-pagination" aria-label="{lang key='website/sms/panel/hist-pages-aria'}">
                                        <ul class="pagination pagination-sm mb-0"></ul>
                                    </nav>
                                </div>
                            </div>
                            <p class="fs-8 text-body-secondary mb-0 mt-2"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/hist-foot'}</p>
                        </section>
                    </div>

                    <div class="tab-pane fade" id="sd-activity" role="tabpanel" aria-labelledby="sd-activity-tab" tabindex="0">
                        <section class="sd-panel">
                            <h2 class="sd-panel-title mb-3"><i class="bi bi-activity me-1"></i>{lang key='website/sms/panel/act-title'}</h2>
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
                                <i class="bi bi-activity" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/sms/panel/act-empty'}</span>
                            </div>
                            {/if}
                        </section>
                    </div>

                </div>
            </div>
        </div>

    </div>
</section>
{/block}

{block name=body_end}
    <div class="modal fade" id="sd-addcredit" tabindex="-1" aria-labelledby="sd-addcredit-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon"><i class="bi bi-coin"></i></span>
                    <div class="modal-titles">
                        <h5 class="modal-title" id="sd-addcredit-title">{lang key='website/sms/panel/credit-modal-title'}</h5>
                        <p class="modal-subtitle">{lang key='website/sms/panel/credit-modal-sub'}</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/sms/panel/close'}"></button>
                </div>
                <div class="modal-body">
                    <div class="sms-credit-current">
                        <span class="fs-7 text-body-secondary">{lang key='website/sms/panel/credit-current'}</span>
                        <span class="num-tabular fw-bold" data-role="credit-current">{$credit_balance}</span>
                    </div>
                    <span class="form-label d-block mb-2">{lang key='website/sms/panel/credit-choose'}</span>
                    <div class="sms-amount-grid" role="radiogroup" aria-label="{lang key='website/sms/panel/credit-choose'}">
                        {foreach $credit_presets as $cp}
                        <label class="sms-amount">
                            <input class="form-check-input visually-hidden" type="radio" name="sms-credit-amount" value="{$cp.value}" data-amount="{$cp.value}"{if $cp@iteration == 2} checked{/if}>
                            <span class="sms-amount-value num-tabular">{$cp.label}</span>
                        </label>
                        {/foreach}
                    </div>
                    <div class="mt-3">
                        <label class="form-label fs-7" for="sms-credit-custom">{lang key='website/sms/panel/credit-custom'}</label>
                        <div class="input-group">
                            <span class="input-group-text">{$balance_code}</span>
                            <input type="number" class="form-control num-tabular" id="sms-credit-custom" min="5" step="5" placeholder="0.00" data-role="credit-custom" aria-label="{lang key='website/sms/panel/credit-custom'}">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="sms-addcredit-total me-auto">
                        <span class="fs-7 text-body-secondary">{lang key='website/sms/panel/credit-new'}</span>
                        <span class="num-tabular fw-bold" data-role="credit-newbalance">{$credit_balance}</span>
                    </div>
                    <a class="btn btn-primary" data-role="credit-continue" data-base-url="{link route='balance'}" href="{link route='balance'}"><i class="bi bi-credit-card me-1"></i>{lang key='website/sms/panel/credit-continue'}</a>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="sd-batch-modal" tabindex="-1" aria-labelledby="sd-batch-title" aria-hidden="true"
         data-txt-delivered="{lang key='website/sms/panel/hist-status-delivered'}"
         data-txt-partial="{lang key='website/sms/panel/hist-status-partial'}"
         data-txt-failed="{lang key='website/sms/panel/hist-status-failed'}"
         data-txt-pending="{lang key='website/sms/panel/batch-pending'}"
         data-txt-loading="{lang key='website/sms/panel/batch-loading'}"
         data-txt-empty="{lang key='website/sms/panel/batch-empty'}"
         data-txt-error="{lang key='website/sms/panel/batch-error'}"
         data-txt-cap="{lang key='website/sms/panel/batch-cap-note'}"
         data-txt-downloaded="{lang key='website/sms/panel/batch-downloaded'}">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon"><i class="bi bi-send-check"></i></span>
                    <div class="modal-titles">
                        <h5 class="modal-title" id="sd-batch-title">{lang key='website/sms/panel/batch-title'}</h5>
                        <p class="modal-subtitle" data-role="batch-sub"></p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/sms/panel/close'}"></button>
                </div>
                <div class="modal-body">
                    <div class="sms-batch-summary">
                        <div class="sms-batch-cell"><span class="sms-batch-k">{lang key='website/sms/panel/hist-th-sender'}</span><span class="sms-batch-v" data-role="batch-sender"></span></div>
                        <div class="sms-batch-cell"><span class="sms-batch-k">{lang key='website/sms/panel/hist-th-status'}</span><span class="sms-batch-v" data-role="batch-status"></span></div>
                        <div class="sms-batch-cell"><span class="sms-batch-k">{lang key='website/sms/panel/hist-th-cost'}</span><span class="sms-batch-v num-tabular" data-role="batch-cost"></span></div>
                        <div class="sms-batch-cell"><span class="sms-batch-k">{lang key='website/sms/panel/hist-th-recipients'}</span><span class="sms-batch-v num-tabular" data-role="batch-recipients"></span></div>
                        <div class="sms-batch-cell"><span class="sms-batch-k">{lang key='website/sms/panel/batch-delivered'}</span><span class="sms-batch-v num-tabular" data-role="batch-delivered"></span></div>
                        <div class="sms-batch-cell"><span class="sms-batch-k">{lang key='website/sms/panel/batch-failed'}</span><span class="sms-batch-v num-tabular" data-role="batch-failed"></span></div>
                    </div>
                    <div class="sms-batch-message mb-3">
                        <span class="form-label">{lang key='website/sms/panel/hist-th-message'}</span>
                        <p class="sms-batch-message-text mb-0" data-role="batch-message"></p>
                    </div>
                    <div class="sd-panel-head">
                        <h3 class="sd-panel-title fs-6 mb-0"><i class="bi bi-people me-1"></i>{lang key='website/sms/panel/batch-per-recipient'}</h3>
                        <span class="fs-8 text-body-secondary">{lang key='website/sms/panel/batch-sample'} <span class="num-tabular" data-role="batch-rec-total">0</span> {lang key='website/sms/panel/batch-sample-suffix'}</span>
                    </div>
                    <div class="sms-rec-filter" role="group" aria-label="{lang key='website/sms/panel/batch-filter-aria'}">
                        <button type="button" class="sms-rec-tab is-active" data-action="rec-filter" data-rec-filter="all">{lang key='website/sms/panel/batch-all'} <span class="num-tabular" data-role="rec-count-all">0</span></button>
                        <button type="button" class="sms-rec-tab sms-rec-ok" data-action="rec-filter" data-rec-filter="delivered"><i class="bi bi-check-circle me-1"></i>{lang key='website/sms/panel/hist-status-delivered'} <span class="num-tabular" data-role="rec-count-delivered">0</span></button>
                        <button type="button" class="sms-rec-tab sms-rec-warn" data-action="rec-filter" data-rec-filter="pending"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/sms/panel/batch-pending'} <span class="num-tabular" data-role="rec-count-pending">0</span></button>
                        <button type="button" class="sms-rec-tab sms-rec-bad" data-action="rec-filter" data-rec-filter="failed"><i class="bi bi-x-circle me-1"></i>{lang key='website/sms/panel/hist-status-failed'} <span class="num-tabular" data-role="rec-count-failed">0</span></button>
                    </div>
                    <div class="table-responsive sms-recipient-scroll">
                        <table class="table table-sm align-middle sms-recipient-table mb-0">
                            <thead>
                                <tr>
                                    <th scope="col">{lang key='website/sms/panel/batch-number'}</th>
                                    <th scope="col">{lang key='website/sms/panel/hist-th-status'}</th>
                                    <th scope="col" class="text-end">{lang key='website/sms/panel/batch-updated'}</th>
                                </tr>
                            </thead>
                            <tbody data-role="batch-recipients-rows"></tbody>
                        </table>
                    </div>
                    <p class="fs-8 text-body-secondary mb-0 mt-2"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/batch-foot'}</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-action="batch-download"><i class="bi bi-download me-1"></i>{lang key='website/sms/panel/batch-download'}</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="sd-contact-modal" tabindex="-1" aria-labelledby="sd-contact-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon"><i class="bi bi-person-plus"></i></span>
                    <div class="modal-titles">
                        <h5 class="modal-title" id="sd-contact-title" data-role="contact-modal-title">{lang key='website/sms/panel/ct-add-title'}</h5>
                        <p class="modal-subtitle">{lang key='website/sms/panel/ct-sub'}</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/sms/panel/close'}"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label" for="sms-contact-name">{lang key='website/sms/panel/ct-name'} <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="sms-contact-name" autocomplete="off" placeholder="{lang key='website/sms/panel/ct-name-ph'}" data-role="contact-name">
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="sms-contact-phone">{lang key='website/sms/panel/ct-number'} <span class="text-danger">*</span></label>
                        <input type="tel" class="form-control num-tabular" id="sms-contact-phone" autocomplete="off" placeholder="{lang key='website/sms/panel/ct-number-ph'}" data-role="contact-phone">
                        <div class="form-text"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/ct-number-help'}</div>
                    </div>
                    <div>
                        <span class="form-label d-block mb-2">{lang key='website/sms/panel/ct-groups'}</span>
                        <div class="sms-group-picker" role="group" aria-label="{lang key='website/sms/panel/ct-groups-aria'}" data-role="contact-group-picker">
                            {foreach $sms_groups as $g}
                            <label class="sms-group"><input class="form-check-input" type="checkbox" value="{$g.id}" data-role="contact-group"><span class="sms-group-name">{$g.name}</span></label>
                            {/foreach}
                        </div>
                        <p class="fs-8 text-body-secondary mb-0 mt-2{if $sms_groups} d-none{/if}" data-role="contact-nogroups"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/ct-no-groups'}</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-action="contact-save"><i class="bi bi-check-lg me-1"></i>{lang key='website/sms/panel/ct-save'}</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="sd-group-modal" tabindex="-1" aria-labelledby="sd-group-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon"><i class="bi bi-collection"></i></span>
                    <div class="modal-titles">
                        <h5 class="modal-title" id="sd-group-title" data-role="group-modal-title">{lang key='website/sms/panel/gr-add-title'}</h5>
                        <p class="modal-subtitle">{lang key='website/sms/panel/gr-sub'}</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/sms/panel/close'}"></button>
                </div>
                <div class="modal-body">
                    <label class="form-label" for="sms-group-name">{lang key='website/sms/panel/gr-name'} <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="sms-group-name" autocomplete="off" placeholder="{lang key='website/sms/panel/gr-name-ph'}" data-role="group-name">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-action="group-save"><i class="bi bi-check-lg me-1"></i>{lang key='website/sms/panel/gr-save'}</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="sd-import-modal" tabindex="-1" aria-labelledby="sd-import-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon"><i class="bi bi-upload"></i></span>
                    <div class="modal-titles">
                        <h5 class="modal-title" id="sd-import-title">{lang key='website/sms/panel/im-title'}</h5>
                        <p class="modal-subtitle">{lang key='website/sms/panel/im-sub'}</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/sms/panel/close'}"></button>
                </div>
                <div class="modal-body">
                    <label class="form-label" for="sms-import-file">{lang key='website/sms/panel/im-file'} <span class="text-danger">*</span></label>
                    <div class="file-upload" data-file-upload>
                        <label class="file-upload-drop" for="sms-import-file">
                            <input type="file" id="sms-import-file" name="sms_import_file" class="visually-hidden" accept=".csv" data-max-mb="10">
                            <span class="icon-disc"><i class="bi bi-filetype-csv"></i></span>
                            <span><span class="fw-semibold">{lang key='website/sms/panel/im-browse'}</span> {lang key='website/sms/panel/im-drop'}</span>
                            <span class="fs-8">{lang key='website/sms/panel/im-hint'}</span>
                        </label>
                        <ul class="file-upload-list" data-role="file-list"></ul>
                    </div>
                    <div class="form-text mb-3"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/im-columns'} <a href="#" data-action="import-sample">{lang key='website/sms/panel/im-sample'}</a>.</div>
                    <label class="form-label" for="sms-import-group">{lang key='website/sms/panel/im-group'}</label>
                    <select class="form-select" id="sms-import-group" data-role="import-group">
                        <option value="" selected>{lang key='website/sms/panel/im-no-group'}</option>
                        {foreach $sms_groups as $g}
                        <option value="{$g.id}">{$g.name}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-action="import-submit"><i class="bi bi-upload me-1"></i>{lang key='website/sms/panel/im-submit'}</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="sd-addcountry" tabindex="-1" aria-labelledby="sd-addcountry-title" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon"><i class="bi bi-globe-americas"></i></span>
                    <div class="modal-titles">
                        <h5 class="modal-title" id="sd-addcountry-title">{lang key='website/sms/panel/ac-title'}</h5>
                        <p class="modal-subtitle">{lang key='website/sms/panel/ac-sub'} <span class="fw-semibold" data-role="addcountry-sender">{lang key='website/sms/panel/ac-this-sender'}</span></p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/sms/panel/close'}"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label" for="sms-country-search">{lang key='website/sms/panel/ac-countries'} <span class="text-danger">*</span> <span class="fw-normal text-body-secondary">(<span class="num-tabular" data-role="addcountry-count">0</span> {lang key='website/sms/panel/ac-selected'})</span></label>
                        <div class="input-group mb-2">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input type="text" class="form-control" id="sms-country-search" placeholder="{lang key='website/sms/panel/ac-filter'}" autocomplete="off" data-role="addcountry-filter">
                        </div>
                        <div class="sms-country-picker" data-role="addcountry-picker">
                            {foreach $sms_prereg_countries as $pc}
                            <label class="sms-country-opt"><input class="form-check-input" type="checkbox" data-role="country-opt" value="{$pc.code}"><span>{$pc.name}</span></label>
                            {/foreach}
                            <p class="sms-country-empty fs-7 text-body-secondary text-center mb-0 d-none" data-role="addcountry-empty">{lang key='website/sms/panel/ac-no-match'}</p>
                        </div>
                    </div>

                    <label class="form-label" for="sms-country-docs">{lang key='website/sms/panel/ac-docs'} <span class="text-danger">*</span></label>
                    <div class="file-upload" data-file-upload>
                        <label class="file-upload-drop" for="sms-country-docs">
                            <input type="file" id="sms-country-docs" name="sms_country_docs" class="visually-hidden" accept=".pdf,.jpg,.jpeg,.png,.zip,.rar" data-max-mb="20" multiple>
                            <span class="icon-disc"><i class="bi bi-cloud-arrow-up"></i></span>
                            <span><span class="fw-semibold">{lang key='website/sms/panel/ac-browse'}</span> {lang key='website/sms/panel/ac-drop'}</span>
                            <span class="fs-8">{lang key='website/sms/panel/ac-hint'}</span>
                        </label>
                        <ul class="file-upload-list" data-role="file-list"></ul>
                    </div>
                    <div class="form-text"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/ac-note'}</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-action="addcountry-submit" disabled><i class="bi bi-send-check me-1"></i>{lang key='website/sms/panel/ac-submit'}</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="sd-resubmit" tabindex="-1" aria-labelledby="sd-resubmit-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon modal-icon--danger"><i class="bi bi-arrow-clockwise"></i></span>
                    <div class="modal-titles">
                        <h5 class="modal-title" id="sd-resubmit-title">{lang key='website/sms/panel/rs-title'}</h5>
                        <p class="modal-subtitle"><span class="fw-semibold" data-role="resubmit-sender">{lang key='website/sms/panel/rs-sender'}</span> &middot; <span data-role="resubmit-country">{lang key='website/sms/panel/rs-country'}</span></p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/sms/panel/close'}"></button>
                </div>
                <div class="modal-body">
                    <div class="sd-alert sd-alert-danger" role="status">
                        <span class="sd-alert-ico"><i class="bi bi-x-circle"></i></span>
                        <div class="sd-alert-body">
                            <span class="sd-alert-title">{lang key='website/sms/panel/rs-why'}</span>
                            <span class="sd-alert-text" data-role="resubmit-reason"></span>
                        </div>
                    </div>
                    <label class="form-label" for="sms-resubmit-docs">{lang key='website/sms/panel/rs-docs'} <span class="text-danger">*</span></label>
                    <div class="file-upload" data-file-upload>
                        <label class="file-upload-drop" for="sms-resubmit-docs">
                            <input type="file" id="sms-resubmit-docs" name="sms_resubmit_docs" class="visually-hidden" accept=".pdf,.jpg,.jpeg,.png,.zip,.rar" data-max-mb="20" multiple>
                            <span class="icon-disc"><i class="bi bi-cloud-arrow-up"></i></span>
                            <span><span class="fw-semibold">{lang key='website/sms/panel/ac-browse'}</span> {lang key='website/sms/panel/ac-drop'}</span>
                            <span class="fs-8">{lang key='website/sms/panel/ac-hint'}</span>
                        </label>
                        <ul class="file-upload-list" data-role="file-list"></ul>
                    </div>
                    <div class="form-text"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/rs-note'}</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-action="resubmit-submit"><i class="bi bi-arrow-clockwise me-1"></i>{lang key='website/sms/panel/rs-submit'}</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="sd-review-modal" tabindex="-1" aria-labelledby="sd-review-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon"><i class="bi bi-send-check"></i></span>
                    <div class="modal-titles">
                        <h5 class="modal-title" id="sd-review-title">{lang key='website/sms/panel/rv-title'}</h5>
                        <p class="modal-subtitle">{lang key='website/sms/panel/rv-subtitle'}</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/sms/panel/con-cancel'}"></button>
                </div>
                <div class="modal-body">
                    <div class="sms-batch-message mb-3">
                        <span class="form-label">{lang key='website/sms/panel/sn-message'}</span>
                        <p class="sms-batch-message-text mb-0" data-role="review-message"></p>
                    </div>
                    <div class="sms-batch-summary">
                        <div class="sms-batch-cell"><span class="sms-batch-k">{lang key='website/sms/panel/sn-sender'}</span><span class="sms-batch-v" data-role="review-sender"></span></div>
                        <div class="sms-batch-cell"><span class="sms-batch-k">{lang key='website/sms/panel/sn-recipients'}</span><span class="sms-batch-v num-tabular" data-role="review-recipients">0</span></div>
                        <div class="sms-batch-cell"><span class="sms-batch-k">{lang key='website/sms/panel/sn-per-message'}</span><span class="sms-batch-v num-tabular" data-role="review-parts">1</span></div>
                        <div class="sms-batch-cell"><span class="sms-batch-k">{lang key='website/sms/panel/sn-total-messages'}</span><span class="sms-batch-v num-tabular" data-role="review-total">0</span></div>
                        <div class="sms-batch-cell sms-batch-cell-em"><span class="sms-batch-k"><i class="bi bi-cash-coin me-1"></i>{lang key='website/sms/panel/sn-cost'}</span><span class="sms-batch-v num-tabular" data-role="review-cost">{$send_zero}</span></div>
                        <div class="sms-batch-cell sms-batch-cell-em"><span class="sms-batch-k"><i class="bi bi-wallet2 me-1"></i>{lang key='website/sms/panel/rv-after'}</span><span class="sms-batch-v num-tabular" data-role="review-after">{$send_zero}</span></div>
                    </div>
                    <p class="fs-7 text-body-secondary mb-0 mt-2"><i class="bi bi-people me-1"></i><span data-role="review-breakdown"></span></p>
                    <div class="sms-skip sms-skip-review mt-3 d-none" data-role="review-skip-wrap">
                        <span class="sms-skip-head"><i class="bi bi-exclamation-triangle me-1"></i>{lang key='website/sms/panel/rv-skipped'}</span>
                        <span class="sms-skip-list" data-role="review-skip-list"></span>
                    </div>
                    <p class="fs-8 text-body-secondary mb-0 mt-2"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/panel/sn-rate-note'} <a href="{link route='international-sms'}">{lang key='website/sms/panel/sn-view-rates'}</a>.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/sms/panel/con-cancel'}</button>
                    <button type="button" class="btn btn-secondary" data-action="confirm-send"><i class="bi bi-send me-1"></i>{lang key='website/sms/panel/rv-send-now'}</button>
                </div>
            </div>
        </div>
    </div>
{/block}

{block name=scripts}
    <script src="{asset path='js/libs/wcp-table/table.js'}" defer></script>
    <script src="{asset path='js/service-detail-sms.js'}" defer></script>
{/block}
