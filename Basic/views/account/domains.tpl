{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='js/libs/tom-select/tom-select.bootstrap5.min.css'}">
    <link rel="stylesheet" href="{asset path='js/libs/intl-tel-input/css/intlTelInput.min.css'}">
    <script src="{asset path='js/libs/tom-select/tom-select.complete.min.js'}" defer></script>
    <script src="{asset path='js/libs/intl-tel-input/js/intlTelInput.min.js'}" defer></script>
    <script src="{asset path='js/list.js'}" defer></script>
{/block}

{block name=scripts}
    <script src="{asset path='js/domains.js'}" defer></script>
{/block}

{block name=content}
<section class="pt-4 pb-4 pt-lg-4 pb-lg-5">
    <div class="container list-page" data-domains-page>
        {if $can_manage}{csrf form='domains'}{/if}

        <div class="list-pagehead">
            <div>
                <nav aria-label="{lang key='website/domains/breadcrumb-aria'}">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                        <li class="breadcrumb-item active" aria-current="page">{lang key='website/domains/title'}</li>
                    </ol>
                </nav>
                <h1 class="list-title">{lang key='website/domains/title'}</h1>
            </div>
            {if $can_manage || $register_link}
            <div class="d-flex flex-wrap gap-2 list-headactions">
                {if $can_manage}
                <button type="button" class="btn btn-soft btn-sm" data-bs-toggle="modal" data-bs-target="#whoisProfilesModal"><i class="bi bi-person-vcard me-1"></i>{lang key='website/domains/whois-profiles'}</button>
                <button type="button" class="btn btn-soft btn-sm" data-bs-toggle="modal" data-bs-target="#defaultNsModal"><i class="bi bi-hdd-network me-1"></i>{lang key='website/domains/default-ns'}</button>
                {/if}
                {if $register_link}<a class="btn btn-soft btn-sm fw-semibold list-order" href="{$register_link}"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/register-domain'}</a>{/if}
                {hook name='ui:client.domains_list.header_actions.end'}
            </div>
            {/if}
        </div>

        {if $has_domains}
        <div class="list-summary" role="group" aria-label="{lang key='website/domains/tiles-aria'}">
            <button type="button" class="list-tile list-tile-primary is-active" data-seg="all" aria-pressed="true">
                <i class="bi bi-globe2 list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-globe2"></i></span>
                <span>
                    <span class="list-tile-value num-tabular d-block">{$tiles.total}</span>
                    <span class="list-tile-label d-block">{lang key='website/domains/tile-total'}</span>
                </span>
            </button>
            <button type="button" class="list-tile list-tile-success" data-seg="active" aria-pressed="false">
                <i class="bi bi-check-circle list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-check-circle"></i></span>
                <span>
                    <span class="list-tile-value num-tabular d-block">{$tiles.active}</span>
                    <span class="list-tile-label d-block">{lang key='website/domains/st-active'}</span>
                </span>
            </button>
            <button type="button" class="list-tile list-tile-warning" data-seg="due" aria-pressed="false">
                <i class="bi bi-clock-history list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-clock-history"></i></span>
                <span>
                    <span class="list-tile-value num-tabular d-block">{$tiles.expiring}</span>
                    <span class="list-tile-label d-block">{lang key='website/domains/tile-expiring'}</span>
                </span>
            </button>
            <button type="button" class="list-tile list-tile-danger" data-seg="attention" aria-pressed="false">
                <i class="bi bi-exclamation-triangle list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-exclamation-triangle"></i></span>
                <span>
                    <span class="list-tile-value num-tabular d-block">{$tiles.attention}</span>
                    <span class="list-tile-label d-block">{lang key='website/domains/tile-attention'}</span>
                </span>
            </button>
        </div>
        {hook name='ui:client.domains_list.tiles.after'}

        {if $attention}
        <div class="list-attention" role="region" aria-label="{lang key='website/domains/attention-aria'}">
            {foreach $attention as $a}
            <div class="list-alert list-alert-danger" data-alert-id="{$a.id}">
                <i class="bi bi-calendar-x-fill list-alert-ico" aria-hidden="true"></i>
                <div class="list-alert-body"><strong>{$a.name}</strong> {$a.text}</div>
                <button type="button" class="basic-alert-close" data-action="dismiss-alert" aria-label="{lang key='website/domains/dismiss'}"><i class="bi bi-x-lg" aria-hidden="true"></i></button>
            </div>
            {/foreach}
        </div>
        {/if}
        {hook name='ui:client.domains_list.attention.after'}

        <div class="list-toolbar">
            <div class="list-search input-group">
                <label class="input-group-text" for="list-search"><i class="bi bi-search"></i></label>
                <input type="search" autocomplete="off" name="q" data-lpignore="true" data-1p-ignore data-form-type="other" class="form-control" id="list-search" placeholder="{lang key='website/domains/search-ph'}" aria-label="{lang key='website/domains/search-ph'}">
            </div>
            <div class="list-controls">
                <label for="list-type" class="form-label mb-0 list-control-label">{lang key='website/domains/tld-label'}</label>
                <select class="form-select w-auto" id="list-type" aria-label="{lang key='website/domains/tld-label'}">
                    <option value="">{lang key='website/domains/tld-all'}</option>
                    {foreach $tlds as $g => $label}<option value="{$g}">{$label}</option>{/foreach}
                </select>
                <label for="list-status" class="form-label mb-0 list-control-label">{lang key='website/domains/status-label'}</label>
                <select class="form-select w-auto" id="list-status" aria-label="{lang key='website/domains/status-label'}">
                    <option value="">{lang key='website/domains/status-all'}</option>
                    <option value="active">{lang key='website/domains/st-active'}</option>
                    <option value="expiring">{lang key='website/domains/st-expiring'}</option>
                    <option value="pending">{lang key='website/domains/st-pending'}</option>
                    <option value="expired">{lang key='website/domains/st-expired'}</option>
                    <option value="cancelled">{lang key='website/domains/st-cancelled'}</option>
                </select>
                <label for="list-sort" class="form-label mb-0 list-control-label">{lang key='website/domains/sort-label'}</label>
                <select class="form-select w-auto" id="list-sort" aria-label="{lang key='website/domains/sort-label'}">
                    <option value="status">{lang key='website/domains/sort-default'}</option>
                    <option value="due">{lang key='website/domains/sort-due'}</option>
                    <option value="name">{lang key='website/domains/sort-name'}</option>
                    <option value="price-desc">{lang key='website/domains/sort-price-desc'}</option>
                    <option value="price-asc">{lang key='website/domains/sort-price-asc'}</option>
                    <option value="created">{lang key='website/domains/sort-created'}</option>
                </select>
            </div>
            {hook name='ui:client.domains_list.toolbar.end'}
        </div>

        <div class="list-rows" data-noun="domains" data-today="{$today_ymd}"{if $table_ajax} data-ajax="{$table_ajax}"{/if}
            data-txt-count="{lang key='website/index/list-count'}"
            data-txt-nores="{lang key='website/index/list-nores'}"
            data-txt-noun="{lang key='website/domains/noun'}"{if $can_manage}
            data-op-url="{link route='domains'}"
            data-txt-locked="{lang key='website/domains/locked'}"
            data-txt-unlocked="{lang key='website/domains/unlocked'}"
            data-txt-autorenew-on="{lang key='website/domains/autorenew-on'}"
            data-txt-autorenew-off="{lang key='website/domains/autorenew-off'}"{/if}>
            <div class="list-skeleton" aria-hidden="true">
                {for $i=1 to 5}
                <div class="list-skel-row">
                    <span class="basic-skeleton list-skel-ico"></span>
                    <div class="list-skel-main"><span class="basic-skeleton list-skel-line is-title"></span><span class="basic-skeleton list-skel-line is-meta"></span></div>
                    <div class="list-skel-side"><span class="basic-skeleton list-skel-line"></span><span class="basic-skeleton list-skel-line is-price"></span><span class="basic-skeleton list-skel-btn"></span></div>
                </div>
                {/for}
            </div>

            {$rows_html nofilter}

            <div class="list-empty basic-empty-state d-none" data-role="empty">
                <i class="bi bi-inbox" aria-hidden="true"></i>
                <span class="fw-semibold">{lang key='website/domains/nores-title'}</span>
                <span class="fs-7">{lang key='website/domains/nores-text'}</span>
                <button type="button" class="btn btn-soft btn-sm mt-1" data-action="list-clear"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/domains/clear-filters'}</button>
            </div>
        </div>

        <div class="list-foot">
            <div class="list-foot-info">
                <div class="list-perpage">
                    <label for="list-perpage" class="list-control-label mb-0">{lang key='website/index/list-perpage'}</label>
                    <select class="form-select form-select-sm w-auto" id="list-perpage" aria-label="{lang key='website/index/list-perpage'}">
                        <option value="10">10</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select>
                </div>
                <p class="list-count num-tabular mb-0" data-role="count" aria-live="polite"></p>
            </div>
            <nav class="list-pagination" aria-label="{lang key='website/domains/pagination-aria'}" data-role="pagination"><ul class="pagination pagination-sm m-0"></ul></nav>
        </div>
        {if $list_tax_inclusive}<p class="fs-8 text-body-secondary mt-2 mb-0" data-tax-incl>{lang key='website/services/updown/pc-tax-included'}</p>{/if}
        {else}
        <div class="basic-empty-state is-page">
            <i class="bi bi-globe2" aria-hidden="true"></i>
            <span class="fw-semibold">{lang key='website/domains/empty-title'}</span>
            <span class="fs-7">{lang key='website/domains/empty-text'}</span>
            <a class="btn btn-primary btn-sm mt-1" href="{if $register_link}{$register_link}{else}{link route='domain'}{/if}"><i class="bi bi-search me-1"></i>{lang key='website/domains/register-domain'}</a>
        </div>
        {/if}

    </div>
</section>
{/block}

{block name=body_end}
{if $can_manage}
<div class="modal fade" id="domainNsModal" tabindex="-1" aria-labelledby="domainNsTitle" aria-hidden="true"
     data-op-url="{link route='domains'}"
     data-txt-default-filled="{lang key='website/domains/ns-default-filled'}"
     data-txt-no-default="{lang key='website/domains/ns-no-default'}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-hdd-network"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="domainNsTitle">{lang key='website/domains/ns-title'}</h2>
                    <p class="modal-subtitle" data-role="ns-domain"></p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/ns-close'}"></button>
            </div>
            <div class="modal-body">
                <p class="text-body-secondary fs-7 mb-3">{lang key='website/domains/ns-intro'}</p>
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label for="domNs1" class="form-label">{lang key='website/domains/ns-1'}</label>
                        <input type="text" class="form-control" id="domNs1" placeholder="ns1.example.com" autocomplete="off">
                        <div class="invalid-feedback">{lang key='website/domains/ns-1-invalid'}</div>
                    </div>
                    <div class="col-sm-6">
                        <label for="domNs2" class="form-label">{lang key='website/domains/ns-2'}</label>
                        <input type="text" class="form-control" id="domNs2" placeholder="ns2.example.com" autocomplete="off">
                        <div class="invalid-feedback">{lang key='website/domains/ns-2-invalid'}</div>
                    </div>
                    <div class="col-sm-6">
                        <label for="domNs3" class="form-label">{lang key='website/domains/ns-3'} <span class="text-body-secondary">{lang key='website/domains/ns-optional'}</span></label>
                        <input type="text" class="form-control" id="domNs3" placeholder="ns3.example.com" autocomplete="off">
                    </div>
                    <div class="col-sm-6">
                        <label for="domNs4" class="form-label">{lang key='website/domains/ns-4'} <span class="text-body-secondary">{lang key='website/domains/ns-optional'}</span></label>
                        <input type="text" class="form-control" id="domNs4" placeholder="ns4.example.com" autocomplete="off">
                    </div>
                </div>
                <button type="button" class="btn btn-ghost btn-sm mt-3 d-none" data-action="domain-ns-default"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/domains/ns-use-default'}</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/ns-cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="domain-ns-save" data-busy-text="{lang key='website/domains/ns-saving'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/ns-save'}</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="domainWhoisModal" tabindex="-1" aria-labelledby="domainWhoisTitle" aria-hidden="true"
     data-op-url="{link route='domains'}"
     data-txt-default-suffix="{lang key='website/domains/whois-default-suffix'}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-person-vcard"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="domainWhoisTitle">{lang key='website/domains/whois-title'}</h2>
                    <p class="modal-subtitle" data-role="whois-domain"></p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                <p class="text-body-secondary fs-7 mb-3">{lang key='website/domains/whois-intro'}</p>
                <label for="domWhoisProfile" class="form-label">{lang key='website/domains/whois-profile-label'}</label>
                <select class="form-select" id="domWhoisProfile">
                    {if $whois_profiles}{foreach $whois_profiles as $wp}<option value="{$wp.id}">{$wp.name}{if $wp.default} {lang key='website/domains/whois-default-suffix'}{/if}</option>{/foreach}{else}<option value="">{lang key='website/domains/whois-no-profiles'}</option>{/if}
                </select>
                <div class="form-check form-switch mt-3">
                    <input class="form-check-input" type="checkbox" role="switch" id="domWhoisPrivacy">
                    <label class="form-check-label" for="domWhoisPrivacy">{lang key='website/domains/whois-privacy'}</label>
                </div>
                <button type="button" class="btn btn-ghost btn-sm mt-3" data-action="whois-open-manage"><i class="bi bi-pencil-square me-1"></i>{lang key='website/domains/whois-manage'}</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="domain-whois-save" data-busy-text="{lang key='website/domains/whois-saving'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/whois-apply'}</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="eppCodeModal" tabindex="-1" aria-labelledby="eppCodeTitle" aria-hidden="true"
     data-op-url="{link route='domains'}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-key"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="eppCodeTitle">{lang key='website/domains/epp-title'}</h2>
                    <p class="modal-subtitle" data-role="epp-domain"></p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                <p class="text-body-secondary fs-7 mb-3">{lang key='website/domains/epp-intro-1'} <span class="fw-semibold">{$epp_email}</span> {lang key='website/domains/epp-intro-2'}</p>
                <form autocomplete="off">
                    <input type="text" name="username" value="{$epp_email}" autocomplete="username" class="visually-hidden" tabindex="-1" aria-hidden="true" readonly>
                    <label for="eppPassword" class="form-label">{lang key='website/domains/epp-password-label'}</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="eppPassword" autocomplete="current-password" placeholder="{lang key='website/domains/epp-password-ph'}">
                        <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/domains/show-password'}"><i class="bi bi-eye"></i></button>
                    </div>
                    <div class="form-text"><i class="bi bi-shield-check me-1"></i>{lang key='website/domains/epp-confirm-note'}</div>
                    <div class="invalid-feedback">{lang key='website/domains/epp-password-invalid'}</div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="epp-send" data-busy-text="{lang key='website/domains/epp-sending'}"><i class="bi bi-envelope me-1"></i>{lang key='website/domains/epp-send'}</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="transferStatusModal" tabindex="-1" aria-labelledby="transferStatusTitle" aria-hidden="true"
     data-op-url="{link route='domains'}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-arrow-down-circle"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="transferStatusTitle">{lang key='website/domains/transfer-title'}</h2>
                    <p class="modal-subtitle" data-role="transfer-domain"></p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                <p class="text-body-secondary fs-7 mb-3">{lang key='website/domains/transfer-note'}</p>
                <label for="transferAuthCode" class="form-label">{lang key='website/domains/transfer-authcode-label'}</label>
                <input type="text" class="form-control" id="transferAuthCode" placeholder="{lang key='website/domains/transfer-authcode-ph'}" autocomplete="off">
                <div class="invalid-feedback">{lang key='website/domains/transfer-authcode-invalid'}</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="transfer-submit" data-busy-text="{lang key='website/domains/transfer-saving'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/transfer-submit'}</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="domainVerifyModal" tabindex="-1" aria-labelledby="domainVerifyTitle" aria-hidden="true" data-verify-state="form"
     data-op-url="{link route='domains'}"
     data-txt-browse="{lang key='website/domains/verify-browse'}"
     data-txt-drop="{lang key='website/domains/verify-drop'}"
     data-txt-select="{lang key='website/domains/verify-select-ph'}"
     data-txt-optional="{lang key='website/domains/optional'}"
     data-vt-form="{lang key='website/domains/verify-title'}"
     data-vt-review="{lang key='website/domains/verify-title-review'}"
     data-vt-rejected="{lang key='website/domains/verify-title-rejected'}"
     data-vs-form="{lang key='website/domains/verify-sub-form'}"
     data-vs-review="{lang key='website/domains/verify-sub-review'}"
     data-vs-rejected="{lang key='website/domains/verify-sub-rejected'}"
     data-vl-form="{lang key='website/domains/verify-submit'}"
     data-vl-rejected="{lang key='website/domains/verify-submit-rejected'}"
     data-txt-pending="{lang key='website/domains/verify-st-pending'}"
     data-txt-verified="{lang key='website/domains/verify-st-verified'}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-clipboard-check"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="domainVerifyTitle" data-role="verify-title">{lang key='website/domains/verify-title'}</h2>
                    <p class="modal-subtitle"><span data-role="verify-domain"></span> <span data-role="verify-subtitle">{lang key='website/domains/verify-sub-form'}</span></p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                <div class="text-center py-4" data-role="verify-loading"><span class="spinner-border spinner-border-sm text-body-secondary" aria-hidden="true"></span></div>

                <div class="alert alert-danger d-flex align-items-start gap-2 d-none" role="alert" data-verify-show="rejected">
                    <i class="bi bi-exclamation-octagon-fill flex-shrink-0 mt-1" aria-hidden="true"></i>
                    <div>
                        <span class="fw-semibold d-block">{lang key='website/domains/verify-rejected-title'}</span>
                        <span class="d-block mt-1">{lang key='website/domains/verify-reason-label'} <span data-role="verify-reason"></span></span>
                        <span class="d-block mt-1">{lang key='website/domains/verify-rejected-hint'}</span>
                    </div>
                </div>

                <div class="text-center py-2 d-none" data-verify-show="review">
                    <span class="modal-icon modal-icon--info mb-3"><i class="bi bi-hourglass-split" aria-hidden="true"></i></span>
                    <h3 class="h6 mb-2">{lang key='website/domains/verify-review-title'}</h3>
                    <p class="fs-7 text-body-secondary mb-0">{lang key='website/domains/verify-review-body'}</p>
                </div>

                <div class="d-none" data-verify-show="form rejected">
                    <p class="fs-7 text-body-secondary">{lang key='website/domains/verify-form-intro'}</p>
                    <div class="row g-3" data-role="verify-fields"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal" data-verify-show="form rejected">{lang key='website/domains/cancel'}</button>
                <button type="button" class="btn btn-primary d-none" data-action="verify-submit" data-verify-show="form rejected" data-busy-text="{lang key='website/domains/verify-submitting'}"><i class="bi bi-check-lg me-1"></i><span data-role="verify-submit-label">{lang key='website/domains/verify-submit'}</span></button>
                <button type="button" class="btn btn-primary d-none" data-bs-dismiss="modal" data-verify-show="review"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/verify-got-it'}</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="whoisProfilesModal" tabindex="-1" aria-labelledby="whoisProfilesTitle" aria-hidden="true"
     data-op-url="{link route='domains'}"
     data-txt-add-title="{lang key='website/domains/wp-add-title'}"
     data-txt-edit-title="{lang key='website/domains/wp-edit-title'}"
     data-txt-default="{lang key='website/domains/wp-default'}"
     data-txt-set-default="{lang key='website/domains/wp-set-default'}"
     data-txt-edit="{lang key='website/domains/wp-edit'}"
     data-txt-delete="{lang key='website/domains/wp-delete'}"
     data-txt-cancel="{lang key='website/domains/cancel'}"
     data-txt-confirm-del="{lang key='website/domains/wp-confirm-del'}"
     data-txt-keep="{lang key='website/domains/wp-keep'}">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-person-vcard"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="whoisProfilesTitle">{lang key='website/domains/wp-title'}</h2>
                    <p class="modal-subtitle">{lang key='website/domains/wp-subtitle'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                <p class="text-body-secondary fs-7 mb-3">{lang key='website/domains/wp-intro'}</p>
                <div class="list-group" data-role="wp-list">
                    {foreach $whois_profiles as $wp}
                    <div class="list-group-item d-flex flex-wrap align-items-center justify-content-between gap-2" data-wp-id="{$wp.id}"{if $wp.default} data-wp-default="1"{/if}>
                        <div class="whois-profile-main">
                            <div class="d-flex align-items-center gap-2">
                                <span class="fw-semibold" data-role="wp-name">{$wp.name}</span>
                                <span class="badge bg-success-subtle text-success-emphasis" data-role="wp-default-badge"{if !$wp.default} hidden{/if}><i class="bi bi-check-circle me-1"></i>{lang key='website/domains/wp-default'}</span>
                            </div>
                            <div class="fs-8 text-body-secondary" data-role="wp-meta">{$wp.email}{if $wp.country}, {$wp.country}{/if}</div>
                        </div>
                        <div class="d-flex align-items-center gap-1 flex-shrink-0" data-role="wp-actions">
                            <button type="button" class="btn btn-soft btn-sm{if $wp.default} d-none{/if}" data-action="wp-set-default"><i class="bi bi-check2-circle me-1"></i>{lang key='website/domains/wp-set-default'}</button>
                            <button type="button" class="btn btn-soft btn-sm" data-action="wp-edit"><i class="bi bi-pencil me-1"></i>{lang key='website/domains/wp-edit'}</button>
                            <button type="button" class="btn btn-ghost btn-sm" data-action="wp-delete" aria-label="{lang key='website/domains/wp-delete'}" data-bs-toggle="tooltip" title="{lang key='website/domains/wp-delete'}"><i class="bi bi-trash"></i></button>
                        </div>
                    </div>
                    {/foreach}
                </div>
                <div class="basic-empty-state py-4{if $whois_profiles} d-none{/if}" data-role="wp-empty">
                    <i class="bi bi-person-vcard" aria-hidden="true"></i>
                    <span class="fw-semibold">{lang key='website/domains/wp-empty-title'}</span>
                    <span class="fs-7">{lang key='website/domains/wp-empty-text'}</span>
                </div>
                <div class="wui-collapse" id="whoisProfileForm">
                    <div class="wui-collapse-inner">
                        <div class="pt-3 border-top">
                            <h3 class="h6 mb-3" data-role="wp-form-title">{lang key='website/domains/wp-add-title'}</h3>
                            <input type="hidden" id="wpId" value="0">
                            <div class="row g-3">
                                <div class="col-12">
                                    <label for="wpName" class="form-label">{lang key='website/domains/wp-f-name'}</label>
                                    <input type="text" class="form-control" id="wpName" placeholder="{lang key='website/domains/wp-f-name-ph'}">
                                    <div class="invalid-feedback">{lang key='website/domains/wp-f-name-invalid'}</div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="wpFirst" class="form-label">{lang key='website/domains/wp-f-first'}</label>
                                    <input type="text" class="form-control" id="wpFirst" autocomplete="given-name">
                                </div>
                                <div class="col-sm-6">
                                    <label for="wpLast" class="form-label">{lang key='website/domains/wp-f-last'}</label>
                                    <input type="text" class="form-control" id="wpLast" autocomplete="family-name">
                                </div>
                                <div class="col-12">
                                    <label for="wpOrg" class="form-label">{lang key='website/domains/wp-f-org'} <span class="text-body-secondary">{lang key='website/domains/optional'}</span></label>
                                    <input type="text" class="form-control" id="wpOrg" autocomplete="organization">
                                </div>
                                <div class="col-sm-6">
                                    <label for="wpEmail" class="form-label">{lang key='website/domains/wp-f-email'}</label>
                                    <input type="email" class="form-control" id="wpEmail" placeholder="you@example.com" autocomplete="email">
                                    <div class="invalid-feedback">{lang key='website/domains/wp-f-email-invalid'}</div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="wpPhone" class="form-label">{lang key='website/domains/wp-f-phone'}</label>
                                    <input type="tel" class="form-control" id="wpPhone" placeholder="+1 555 000 0000" autocomplete="tel">
                                </div>
                                <div class="col-sm-8">
                                    <label for="wpAddress" class="form-label">{lang key='website/domains/wp-f-address'}</label>
                                    <input type="text" class="form-control" id="wpAddress" autocomplete="street-address">
                                </div>
                                <div class="col-sm-4">
                                    <label for="wpPostal" class="form-label">{lang key='website/domains/wp-f-postal'}</label>
                                    <input type="text" class="form-control" id="wpPostal" autocomplete="postal-code">
                                </div>
                                <div class="col-sm-6">
                                    <label for="wpCity" class="form-label">{lang key='website/domains/wp-f-city'}</label>
                                    <input type="text" class="form-control" id="wpCity" autocomplete="address-level2">
                                </div>
                                <div class="col-sm-6">
                                    <label for="wpCountry" class="form-label">{lang key='website/domains/wp-f-country'}</label>
                                    <select class="form-select" id="wpCountry" data-basic-select data-flag-select autocomplete="country-name">
                                        <option value="">{lang key='website/domains/wp-f-country-ph'}</option>
                                        {foreach $countries as $c}<option value="{$c.a2_iso}">{$c.name}</option>{/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="d-flex justify-content-end gap-2 mt-3">
                                <button type="button" class="btn btn-soft btn-sm" data-action="wp-discard">{lang key='website/domains/wp-discard'}</button>
                                <button type="button" class="btn btn-primary btn-sm" data-action="wp-save" data-busy-text="{lang key='website/domains/wp-saving'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/wp-save'}</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/close-btn'}</button>
                <button type="button" class="btn btn-primary" data-action="wp-add"><i class="bi bi-plus-lg me-1"></i>{lang key='website/domains/wp-add'}</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="defaultNsModal" tabindex="-1" aria-labelledby="defaultNsTitle" aria-hidden="true"
     data-op-url="{link route='domains'}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-hdd-network"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="defaultNsTitle">{lang key='website/domains/dns-title'}</h2>
                    <p class="modal-subtitle">{lang key='website/domains/dns-subtitle'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domains/close'}"></button>
            </div>
            <div class="modal-body">
                <p class="text-body-secondary fs-7 mb-3">{lang key='website/domains/dns-intro'}</p>
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label for="defaultNs1" class="form-label">{lang key='website/domains/ns-1'}</label>
                        <input type="text" class="form-control" id="defaultNs1" value="{$default_ns.ns1}" placeholder="ns1.example.com" autocomplete="off">
                        <div class="invalid-feedback">{lang key='website/domains/ns-1-invalid'}</div>
                    </div>
                    <div class="col-sm-6">
                        <label for="defaultNs2" class="form-label">{lang key='website/domains/ns-2'}</label>
                        <input type="text" class="form-control" id="defaultNs2" value="{$default_ns.ns2}" placeholder="ns2.example.com" autocomplete="off">
                        <div class="invalid-feedback">{lang key='website/domains/ns-2-invalid'}</div>
                    </div>
                    <div class="col-sm-6">
                        <label for="defaultNs3" class="form-label">{lang key='website/domains/ns-3'} <span class="text-body-secondary">{lang key='website/domains/ns-optional'}</span></label>
                        <input type="text" class="form-control" id="defaultNs3" value="{$default_ns.ns3}" placeholder="ns3.example.com" autocomplete="off">
                    </div>
                    <div class="col-sm-6">
                        <label for="defaultNs4" class="form-label">{lang key='website/domains/ns-4'} <span class="text-body-secondary">{lang key='website/domains/ns-optional'}</span></label>
                        <input type="text" class="form-control" id="defaultNs4" value="{$default_ns.ns4}" placeholder="ns4.example.com" autocomplete="off">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/domains/cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="default-ns-save" data-busy-text="{lang key='website/domains/dns-saving'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/domains/dns-save'}</button>
            </div>
        </div>
    </div>
</div>
{hook name='ui:client.domains_list.modals.end'}
{/if}
{/block}
