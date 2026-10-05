{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='js/libs/tom-select/tom-select.bootstrap5.min.css'}">
    <link rel="stylesheet" href="{asset path='css/ticket-create.css'}">
    <script src="{asset path='js/libs/tom-select/tom-select.complete.min.js'}" defer></script>
{/block}

{block name=scripts}
    <script src="{asset path='js/ticket-create.js'}" defer></script>
{/block}

{block name=content}
<section class="pt-4 pb-4 pt-lg-4 pb-lg-5">
    <div class="container"
         data-ticket-create
         data-post-url="{link route='tickets'}"
         data-fields-url="{link route='tickets'}"
         data-kb-url="{link route='tickets'}"
         data-txt-fail="{lang key='website/tickets/create/err-generic'}"
         data-txt-attach-total="{lang key='website/tickets/error-attach-total'}"
         data-access-groups="{$access_groups_json}">

        <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-4">
            <div>
                <h1 class="list-title">{lang key='website/tickets/create/title'}</h1>
                <p class="text-body-secondary mb-0 mt-1">{lang key='website/tickets/create/lead'}</p>
            </div>
            <nav aria-label="{lang key='website/tickets/breadcrumb-aria'}">
                <ol class="breadcrumb mb-0">
                    {if $is_guest}
                    <li class="breadcrumb-item"><a href="{link route='home'}">{lang key='website/index/breadcrumb-home'}</a></li>
                    {else}
                    <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                    <li class="breadcrumb-item"><a href="{link route='tickets'}">{lang key='website/tickets/title'}</a></li>
                    {/if}
                    <li class="breadcrumb-item active" aria-current="page">{lang key='website/tickets/create/crumb'}</li>
                </ol>
            </nav>
        </div>

        <div data-ticket-step="form">
        <div class="row g-4">
            <div class="col-lg-8{if $ticket_create_blocked} d-flex{/if}">
                {if $ticket_create_blocked}
                <div class="basic-empty-state w-100 align-self-center">
                    {if $ticket_create_block_reason == 'no-service'}
                    <i class="bi bi-box-seam" aria-hidden="true"></i>
                    <span class="fw-semibold">{lang key='website/tickets/create/no-service-title'}</span>
                    <span class="fs-7">{lang key='website/tickets/create/err-no-service'}</span>
                    {else}
                    <i class="bi bi-shield-exclamation" aria-hidden="true"></i>
                    <span class="fw-semibold">{lang key='website/tickets/create/blocked-title'}</span>
                    <span class="fs-7">{lang key='website/tickets/create/err-blocked'}</span>
                    {if $terms_contract_link}<a class="btn btn-soft btn-sm mt-1" href="{$terms_contract_link}" target="_blank" rel="noopener"><i class="bi bi-file-earmark-text me-1"></i>{lang key='website/sign/register-terms-tos'}</a>{/if}
                    {/if}
                </div>
                {else}
                <form action="{link route='tickets'}" method="post" enctype="multipart/form-data" novalidate data-ticket-form>
                    <div class="card">
                        <div class="card-body p-4">
                            <div class="row g-3">
                                {hook name='ui:client.ticket_create.form.top'}
                                {if $is_guest}
                                <div class="col-12">
                                    <p class="d-flex align-items-center gap-2 fs-8 text-body-secondary mb-0">
                                        <i class="bi bi-info-circle" aria-hidden="true"></i>
                                        <span>{lang key='website/tickets/create/guest-info'} <a class="fw-semibold text-decoration-none" href="{link route='sign-in'}">{lang key='website/tickets/create/guest-login'}</a> {lang key='website/tickets/create/guest-info-2'}</span>
                                    </p>
                                </div>
                                <div class="col-sm-6">
                                    <label for="tkt-name" class="form-label">{lang key='website/tickets/create/guest-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                                    <input type="text" class="form-control" id="tkt-name" name="name" autocomplete="name" maxlength="120" placeholder="{lang key='website/tickets/create/guest-name-ph'}" required>
                                    <div class="invalid-feedback">{lang key='website/tickets/create/err-guest-name'}</div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="tkt-email" class="form-label">{lang key='website/tickets/create/guest-email'} <span class="text-danger" aria-hidden="true">*</span></label>
                                    <input type="email" class="form-control" id="tkt-email" name="email" autocomplete="email" maxlength="190" placeholder="{lang key='website/tickets/create/guest-email-ph'}" required>
                                    <div class="invalid-feedback">{lang key='website/tickets/create/err-guest-email'}</div>
                                </div>
                                {/if}
                                <div class="col-sm-6">
                                    <label for="tkt-department" class="form-label">{lang key='website/tickets/create/department'} <span class="text-danger" aria-hidden="true">*</span></label>
                                    <select class="form-select" id="tkt-department" name="department" data-cf-source required>
                                        <option value="" selected disabled>{lang key='website/tickets/create/department-ph'}</option>
                                        {foreach $departments as $d}<option value="{$d.id}">{$d.name}</option>{/foreach}
                                    </select>
                                    <div class="invalid-feedback">{lang key='website/tickets/create/err-department'}</div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="tkt-priority" class="form-label">{lang key='website/tickets/create/priority'}</label>
                                    <select class="form-select" id="tkt-priority" name="priority">
                                        {foreach $priorities as $p}<option value="{$p.value}"{if $p.selected} selected{/if}>{$p.label}</option>{/foreach}
                                    </select>
                                </div>

                                <div class="col-12" data-custom-fields>
                                    <div class="row g-3" data-cf-body></div>
                                </div>

                                {hook name='ui:client.ticket_create.fields.after'}

                                {if !$is_guest}
                                <div class="col-12">
                                    <label for="tkt-service" class="form-label">{lang key='website/tickets/create/service'} <span class="text-danger" data-service-required hidden aria-hidden="true">*</span><span class="text-body-secondary fw-normal" data-service-optional>{lang key='website/tickets/create/optional'}</span></label>
                                    <select class="form-select" id="tkt-service" name="related_service" data-basic-select data-rich-select data-search-placeholder="{lang key='website/tickets/create/service-search'}" data-required-departments="{$service_required_departments|default:''}" data-autoselect="{$service_autoselect|default:0}">
                                        <option value="">{lang key='website/tickets/create/service-none'}</option>
                                        {foreach $service_groups as $g}
                                        <optgroup label="{$g.label}">
                                            {foreach $g.items as $it}<option value="{$it.id}" data-data="{$it.data}"{if $preselected_service && $it.id == $preselected_service} selected{/if}>{$it.text}</option>{/foreach}
                                        </optgroup>
                                        {/foreach}
                                    </select>
                                    <div class="invalid-feedback">{lang key='website/tickets/create/err-service-required'}</div>
                                    <div class="form-text">{lang key='website/tickets/create/service-hint'}</div>
                                </div>
                                {/if}

                                <div class="col-12">
                                    <label for="tkt-subject" class="form-label">{lang key='website/tickets/create/subject'} <span class="text-danger" aria-hidden="true">*</span></label>
                                    <input type="text" class="form-control" id="tkt-subject" name="subject" maxlength="120" placeholder="{lang key='website/tickets/create/subject-ph'}" required>
                                    <div class="invalid-feedback">{lang key='website/tickets/create/err-subject'}</div>
                                </div>

                                <div class="col-12">
                                    <label for="tkt-message" class="form-label">{lang key='website/tickets/create/message'} <span class="text-danger" aria-hidden="true">*</span></label>
                                    <div class="composer" data-composer>
                                        <textarea class="form-control composer-input" id="tkt-message" name="message" rows="8" placeholder="{lang key='website/tickets/create/message-ph'}" required></textarea>
                                        <label class="composer-bar">
                                            <span class="composer-bar-text">
                                                <span class="fw-semibold">{lang key='website/tickets/create/encrypt'}</span>
                                                <span class="composer-bar-hint">{lang key='website/tickets/create/encrypt-hint'}</span>
                                            </span>
                                            <span class="composer-lock"><i class="bi bi-shield-lock"></i></span>
                                            <input class="form-check-input visually-hidden" type="checkbox" id="tkt-encrypt" name="encrypt_message" value="1" aria-label="{lang key='website/tickets/create/encrypt'}">
                                        </label>
                                    </div>
                                    <div class="invalid-feedback">{lang key='website/tickets/create/err-message'}</div>

                                    <div class="wui-collapse" id="kbSuggest" data-kb-suggest>
                                        <div class="wui-collapse-inner">
                                            <div class="pt-3">
                                                <div class="kb-suggest">
                                                    <div class="kb-suggest-head" id="kbSuggestHead"><i class="bi bi-lightbulb" aria-hidden="true"></i><span>{lang key='website/tickets/create/kb-head'}</span></div>
                                                    <ul class="kb-suggest-list" data-role="kb-list" aria-labelledby="kbSuggestHead"></ul>
                                                    <span class="visually-hidden" data-role="kb-status" aria-live="polite" aria-atomic="true"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                {if $access_groups}
                                <div class="col-12" data-access-block>
                                    <button type="button" class="cred-toggle collapsed" data-wui-toggle data-wui-target="#tcAccess" aria-expanded="false" aria-controls="tcAccess">
                                        <span class="cred-toggle-ico"><i class="bi bi-key"></i></span>
                                        <span class="cred-toggle-text">{lang key='website/tickets/detail/cred-add'} <span class="text-body-secondary fw-normal">{lang key='website/tickets/detail/cred-optional'}</span></span>
                                        <i class="bi bi-chevron-down wui-collapse-caret"></i>
                                    </button>
                                    <div class="wui-collapse" id="tcAccess">
                                        <div class="wui-collapse-inner">
                                            <div class="cred-panel">
                                                <p class="cred-secure"><i class="bi bi-shield-lock"></i><span>{lang key='website/tickets/detail/cred-secure'}</span></p>
                                                <div class="cred-list" data-cred-list></div>
                                                <button type="button" class="cred-add" data-action="cred-add"><i class="bi bi-plus-lg me-1"></i>{lang key='website/tickets/detail/cred-add-another'}</button>
                                            </div>
                                        </div>
                                    </div>
                                    <template data-cred-template>
                                        <div class="cred-item" data-cred-item>
                                            <div class="cred-head">
                                                <span class="cred-ico" data-cred-ico><i class="bi bi-key"></i></span>
                                                <select class="form-select form-select-sm cred-type" data-cred-group aria-label="{lang key='website/tickets/detail/cred-group-label'}">
                                                    <option value="">{lang key='website/tickets/detail/cred-select-group'}</option>
                                                    {foreach $access_groups as $g}<option value="{$g.id}" data-icon="{$g.icon}">{$g.name}</option>{/foreach}
                                                </select>
                                                <button type="button" class="btn btn-ghost btn-sm cred-remove" data-action="cred-remove" data-bs-toggle="tooltip" title="{lang key='website/tickets/detail/cred-remove'}" aria-label="{lang key='website/tickets/detail/cred-remove'}"><i class="bi bi-x-lg"></i></button>
                                            </div>
                                            <div class="cred-fields row g-3 pt-3" data-access-fields></div>
                                        </div>
                                    </template>
                                </div>
                                {/if}

                                <div class="col-12">
                                    <label class="form-label" for="tkt-attachments">{lang key='website/tickets/create/attachments'} <span class="text-body-secondary fw-normal">{lang key='website/tickets/create/optional'}</span></label>
                                    <div class="file-upload file-upload-compact" data-file-upload>
                                        <label class="file-upload-drop" for="tkt-attachments">
                                            <input type="file" id="tkt-attachments" name="attachments[]" class="visually-hidden" accept="{$attach_accept}" data-max-mb="{$attach_max_mb}" data-max-post="{$attach_max_post}" multiple>
                                            <span class="icon-disc"><i class="bi bi-cloud-arrow-up"></i></span>
                                            <span><span class="fw-semibold">{lang key='website/tickets/create/browse'}</span> {lang key='website/tickets/create/drop'}</span>
                                            <span class="fs-8">{lang key='website/tickets/create/attach-hint' p1=$attach_max_mb}</span>
                                        </label>
                                        <ul class="file-upload-list" data-role="file-list"></ul>
                                    </div>
                                </div>

                                <div class="col-12">
                                    {if $is_guest}{captcha area='ticket-create'}{else}{captcha area='ticket-create' tray='ticketCaptcha'}{/if}
                                </div>
                            </div>

                            {csrf form='ticket-create'}

                            {hook name='ui:client.ticket_create.form.bottom'}

                            <div class="wui-collapse" data-role="tc-alert">
                                <div class="wui-collapse-inner">
                                    <div class="pt-3">
                                        <div class="auth-alert auth-alert-danger" role="alert" aria-live="assertive">
                                            <i class="bi bi-exclamation-triangle-fill"></i>
                                            <span></span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex flex-wrap justify-content-end gap-2 border-top pt-3 mt-3">
                                <a class="btn btn-soft" href="{if $is_guest}{link route='home'}{else}{link route='tickets'}{/if}">{lang key='website/tickets/create/cancel'}</a>
                                <button class="btn btn-primary" type="submit" data-submit data-busy="{lang key='website/tickets/create/submit-busy'}"><i class="bi bi-send me-1"></i>{lang key='website/tickets/create/submit'}</button>
                            </div>
                        </div>
                    </div>
                </form>
                {/if}
            </div>

            <div class="col-lg-4">
                <aside>
                    <div class="card">
                        <div class="card-body p-4">
                            <h2 class="h6 fw-semibold d-flex align-items-center"><i class="bi bi-lightbulb me-2 text-warning"></i>{lang key='website/tickets/create/aside-kb-title'}</h2>
                            <p class="fs-7 text-body-secondary">{lang key='website/tickets/create/aside-kb-text'}</p>
                            <a class="btn btn-soft btn-sm w-100" href="{link route='kbase'}" target="_blank" rel="noopener"><i class="bi bi-journal-text me-1"></i>{lang key='website/tickets/create/aside-kb-cta'}</a>
                        </div>
                    </div>
                    <div class="card mt-3">
                        <div class="card-body p-4">
                            <h2 class="h6 fw-semibold d-flex align-items-center"><i class="bi bi-clock-history me-2 text-body-secondary"></i>{lang key='website/tickets/create/aside-next-title'}</h2>
                            <p class="fs-7 text-body-secondary mb-2">{lang key='website/tickets/create/aside-next-1'}</p>
                            <p class="fs-7 text-body-secondary mb-0">{lang key='website/tickets/create/aside-next-2'}</p>
                        </div>
                    </div>
                    {hook name='ui:client.ticket_create.sidebar.bottom'}
                </aside>
            </div>
        </div>
        </div>

        <div class="d-none" data-ticket-step="done">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body p-4 p-lg-5 text-center">
                            <span class="ticket-done-icon"><i class="bi bi-check-circle"></i></span>
                            <h2 class="h4 mt-3 mb-2">{lang key='website/tickets/create/done-title'}</h2>
                            {if $is_guest}
                            <p class="text-body-secondary mb-4">{lang key='website/tickets/create/guest-done-pre'} <strong data-role="ticket-ref"></strong> {lang key='website/tickets/create/guest-done-mid'} <strong data-role="ticket-email"></strong>{lang key='website/tickets/create/guest-done-post'}</p>
                            {else}
                            <p class="text-body-secondary mb-4">{lang key='website/tickets/create/done-pre'} <strong data-role="ticket-ref"></strong> {lang key='website/tickets/create/done-mid'} <strong data-role="ticket-email"></strong>{lang key='website/tickets/create/done-post'}</p>
                            {/if}
                            <div class="d-flex flex-wrap justify-content-center gap-2">
                                <a class="btn btn-primary" data-role="ticket-view" href="{if $is_guest}{link route='home'}{else}{link route='tickets'}{/if}"><i class="bi bi-eye me-1"></i>{lang key='website/tickets/create/done-view'}</a>
                                {if $is_guest}
                                <a class="btn btn-soft" href="{link route='home'}"><i class="bi bi-house me-1"></i>{lang key='website/tickets/create/guest-done-home'}</a>
                                {else}
                                <a class="btn btn-soft" href="{link route='tickets'}"><i class="bi bi-list-ul me-1"></i>{lang key='website/tickets/create/done-back'}</a>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</section>
{/block}
