{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='js/libs/tom-select/tom-select.bootstrap5.min.css'}">
    <link rel="stylesheet" href="{asset path='js/libs/intl-tel-input/css/intlTelInput.min.css'}">
    <link rel="stylesheet" href="{asset path='css/account-settings.css'}">
    <script src="{asset path='js/libs/tom-select/tom-select.complete.min.js'}" defer></script>
    <script src="{asset path='js/libs/intl-tel-input/js/intlTelInput.min.js'}" defer></script>
    {if $show_activity || $show_messages}
    <link rel="stylesheet" href="{asset path='css/libs/wcp-table/table.css'}">
    <script src="{asset path='js/libs/wcp-table/table.js'}" defer></script>
    {/if}
{/block}

{block name=content}
<section class="pt-4 pb-5" data-account-page data-account-url="{$account_url}" data-txt-busy="{lang key='website/account/busy-generic'}" data-txt-verified="{lang key='website/account/verify-verified'}" data-txt-resend-in="{lang key='website/account/resend-in'}" data-txt-rmavatar-title="{lang key='website/account/rmavatar-title'}" data-txt-rmavatar-msg="{lang key='website/account/rmavatar-msg'}" data-txt-rmavatar-ok="{lang key='website/account/remove'}" data-txt-cancel="{lang key='website/account/cancel'}" data-txt-check-all="{lang key='website/account/contacts-check-all'}" data-txt-uncheck-all="{lang key='website/account/contacts-uncheck-all'}" data-txt-del-title="{lang key='website/account/contacts-delete-title'}" data-txt-del-msg="{lang key='website/account/contacts-delete-msg'}" data-txt-del-ok="{lang key='website/account/contacts-delete'}" data-txt-default="{lang key='website/account/contacts-default'}" data-txt-set-default="{lang key='website/account/contacts-set-default'}" data-txt-edit="{lang key='website/account/contacts-edit'}" data-txt-delete="{lang key='website/account/contacts-delete'}" data-txt-more="{lang key='website/account/contacts-more'}" data-txt-msg-loading="{lang key='website/account/messages-loading'}" data-txt-act-col-activity="{lang key='website/account/activity-th-activity'}" data-txt-act-col-details="{lang key='website/account/activity-th-details'}" data-txt-act-col-date="{lang key='website/account/activity-th-date'}" data-txt-act-downloaded="{lang key='website/account/activity-downloaded'}" data-txt-revoke-title="{lang key='website/account/sessions-revoke-title'}" data-txt-revoke-msg="{lang key='website/account/sessions-revoke-msg'}" data-txt-revoke-ok="{lang key='website/account/sessions-revoke'}" data-txt-revokeall-title="{lang key='website/account/sessions-revokeall-title'}" data-txt-revokeall-msg="{lang key='website/account/sessions-revokeall-msg'}" data-txt-revokeall-ok="{lang key='website/account/sessions-signout-all'}" data-txt-trusted-revoke-title="{lang key='website/account/trusted-revoke-title'}" data-txt-trusted-revoke-msg="{lang key='website/account/trusted-revoke-msg'}" data-txt-trusted-revoke-ok="{lang key='website/account/trusted-revoke'}" data-txt-trusted-revokeall-title="{lang key='website/account/trusted-revokeall-title'}" data-txt-trusted-revokeall-msg="{lang key='website/account/trusted-revokeall-msg'}" data-txt-trusted-revokeall-ok="{lang key='website/account/trusted-revoke-all'}" data-txt-pd-pending-deletion="{lang key='website/account/pd-pending-deletion'}" data-txt-pd-pending-anonymization="{lang key='website/account/pd-pending-anonymization'}" data-txt-pd-declined-deletion="{lang key='website/account/pd-declined-deletion'}" data-txt-pd-declined-anonymization="{lang key='website/account/pd-declined-anonymization'}" data-txt-pd-pending-text="{lang key='website/account/pd-pending-text'}" data-txt-pd-consent-required="{lang key='website/account/pd-consent-required-error'}" data-txt-pd-del-title="{lang key='website/account/pd-confirm-delete-title'}" data-txt-pd-del-msg="{lang key='website/account/pd-confirm-delete-msg'}" data-txt-pd-del-ok="{lang key='website/account/pd-confirm-delete-ok'}" data-txt-pd-anon-title="{lang key='website/account/pd-confirm-anonymize-title'}" data-txt-pd-anon-msg="{lang key='website/account/pd-confirm-anonymize-msg'}" data-txt-pd-anon-ok="{lang key='website/account/pd-confirm-anonymize-ok'}">
    <div class="container">
        {csrf form='account-profile'}

        <nav aria-label="{lang key='website/account/breadcrumb-aria'}">
            <ol class="breadcrumb mb-1">
                <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                <li class="breadcrumb-item active" aria-current="page">{lang key='website/account/title'}</li>
            </ol>
        </nav>
        <div class="as-pagehead">
            <h1 class="list-title mb-0">{lang key='website/account/title'}</h1>
            <p class="text-body-secondary mb-0">{lang key='website/account/lead'}</p>
        </div>

        <div class="row g-4 mt-1">
            <div class="col-lg-3">
                <div class="as-rail">
                    <ul class="nav as-vtabs" role="tablist" aria-orientation="vertical" data-basic-tabs="account-settings">
                        {if $show_profile}
                        <li class="nav-item" role="presentation"><button class="nav-link active" id="as-profile-tab" data-tab-hash="profile" data-bs-toggle="tab" data-bs-target="#as-profile" type="button" role="tab" aria-controls="as-profile" aria-selected="true"><i class="bi bi-person"></i><span>{lang key='website/account/tab-profile'}</span></button></li>
                        {/if}
                        {if $show_contacts}
                        <li class="nav-item" role="presentation"><button class="nav-link{if !$show_profile} active{/if}" id="as-invoices-tab" data-tab-hash="contacts" data-bs-toggle="tab" data-bs-target="#as-invoices" type="button" role="tab" aria-controls="as-invoices" aria-selected="{if !$show_profile}true{else}false{/if}"><i class="bi bi-receipt"></i><span>{lang key='website/account/tab-contacts'}</span></button></li>
                        {/if}
                        {if $show_cards}
                        <li class="nav-item" role="presentation"><button class="nav-link" id="as-cards-tab" data-tab-hash="cards" data-bs-toggle="tab" data-bs-target="#as-cards" type="button" role="tab" aria-controls="as-cards" aria-selected="false"><i class="bi bi-credit-card-2-back"></i><span>{lang key='website/account/tab-cards'}</span></button></li>
                        {/if}
                        {if $show_security}
                        <li class="nav-item" role="presentation"><button class="nav-link" id="as-security-tab" data-tab-hash="security" data-bs-toggle="tab" data-bs-target="#as-security" type="button" role="tab" aria-controls="as-security" aria-selected="false"><i class="bi bi-shield-lock"></i><span>{lang key='website/account/tab-security'}</span></button></li>
                        {/if}
                        {if $show_2fa}
                        <li class="nav-item" role="presentation"><button class="nav-link" id="as-2fa-tab" data-tab-hash="two-factor" data-bs-toggle="tab" data-bs-target="#as-2fa" type="button" role="tab" aria-controls="as-2fa" aria-selected="false"><i class="bi bi-shield-check"></i><span>{lang key='website/account/tab-2fa'}</span></button></li>
                        {/if}
                        {if $show_notification_feed}
                        <li class="nav-item" role="presentation"><button class="nav-link{if !$show_profile && !$show_contacts} active{/if}" id="as-notiffeed-tab" data-tab-hash="notifications" data-bs-toggle="tab" data-bs-target="#as-notiffeed" type="button" role="tab" aria-controls="as-notiffeed" aria-selected="{if !$show_profile && !$show_contacts}true{else}false{/if}"><i class="bi bi-bell"></i><span>{lang key='website/notifications/title'}</span></button></li>
                        {/if}
                        {if $show_notifications}
                        <li class="nav-item" role="presentation"><button class="nav-link" id="as-notifications-tab" data-tab-hash="notification-preferences" data-bs-toggle="tab" data-bs-target="#as-notifications" type="button" role="tab" aria-controls="as-notifications" aria-selected="false"><i class="bi bi-sliders"></i><span>{lang key='website/account/tab-notifications'}</span></button></li>
                        {/if}
                        {if $show_verification}
                        <li class="nav-item" role="presentation"><button class="nav-link" id="as-verify-tab" data-tab-hash="verification" data-bs-toggle="tab" data-bs-target="#as-verify" type="button" role="tab" aria-controls="as-verify" aria-selected="false"><i class="bi bi-patch-check"></i><span>{lang key='website/account/tab-verification'}</span></button></li>
                        {/if}
                        {if $show_activity}
                        <li class="nav-item" role="presentation"><button class="nav-link" id="as-activity-tab" data-tab-hash="activity" data-bs-toggle="tab" data-bs-target="#as-activity" type="button" role="tab" aria-controls="as-activity" aria-selected="false"><i class="bi bi-clock-history"></i><span>{lang key='website/account/tab-activity'}</span></button></li>
                        {/if}
                        {if $show_messages}
                        <li class="nav-item" role="presentation"><button class="nav-link" id="as-messages-tab" data-tab-hash="messages" data-bs-toggle="tab" data-bs-target="#as-messages" type="button" role="tab" aria-controls="as-messages" aria-selected="false"><i class="bi bi-envelope"></i><span>{lang key='website/account/tab-messages'}</span></button></li>
                        {/if}
                        {if $show_personal_data}
                        <li class="nav-item" role="presentation"><button class="nav-link" id="as-personal-data-tab" data-tab-hash="personal-data" data-bs-toggle="tab" data-bs-target="#as-personal-data" type="button" role="tab" aria-controls="as-personal-data" aria-selected="false"><i class="bi bi-person-lock"></i><span>{lang key='website/account/tab-personal-data'}</span></button></li>
                        {/if}
                        {hook name='ui:client.account.tabs.after'}
                    </ul>
                </div>
            </div>

            <div class="col-lg-9">
                {if $missing_required_fields || $missing_verifications}
                <div class="alert alert-warning mb-4" role="alert">
                    <div class="d-flex align-items-start gap-2">
                        <i class="bi bi-exclamation-triangle-fill mt-1" aria-hidden="true"></i>
                        <div class="flex-grow-1">
                            <span class="fw-semibold d-block">{lang key='website/account/gate-notice-title'}</span>
                            <span class="fs-7">{lang key='website/account/gate-notice-text'}</span>
                        </div>
                        <span class="badge bg-warning-subtle text-warning-emphasis flex-shrink-0"><i class="bi bi-list-check me-1"></i>{$missing_required_fields|@count + $missing_verifications|@count}</span>
                    </div>

                    <div class="mt-2">
                        {foreach $missing_required_fields as $f}
                        <button type="button" class="as-gate-step" data-action="as-goto-profile" data-as-field="{$f.name}">
                            <i class="bi bi-person-vcard" aria-hidden="true"></i>
                            <span class="as-gate-step-name">{$f.label}</span>
                            <span class="as-gate-step-go">{lang key='website/account/tab-profile'}</span>
                            <i class="bi bi-chevron-right" aria-hidden="true"></i>
                        </button>
                        {/foreach}
                        {foreach $missing_verifications as $v}
                        <button type="button" class="as-gate-step" data-action="as-goto-verification" data-as-anchor="{$v.anchor}">
                            <i class="bi bi-patch-check" aria-hidden="true"></i>
                            <span class="as-gate-step-name">{$v.label}</span>
                            <span class="as-gate-step-go">{lang key='website/account/tab-verification'}</span>
                            <i class="bi bi-chevron-right" aria-hidden="true"></i>
                        </button>
                        {/foreach}
                    </div>
                </div>
                {/if}
                <div class="tab-content">

                    {if $show_profile}
                    <div class="tab-pane fade show active" id="as-profile" role="tabpanel" aria-labelledby="as-profile-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/account/profile-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/account/profile-sub'}</p>
                            </div>
                        </div>

                        <form id="as-profile-form" action="{$account_url}" method="post" novalidate>
                            {csrf form='account-profile'}
                            <div class="as-panel">

                                {if $show_kind}
                                <section class="as-section as-section-mid">
                                    <div class="as-section-aside">
                                        <h3 class="as-section-title">{lang key='website/account/type-title'}</h3>
                                        <p class="as-section-note">{lang key='website/account/type-note'}</p>
                                    </div>
                                    <div class="as-section-body">
                                        <div class="btn-group as-type-toggle" role="group" aria-label="{lang key='website/account/type-title'}">
                                            <input type="radio" class="btn-check" name="account_type" id="as-type-individual" value="individual" autocomplete="off"{if $p_kind != 'company'} checked{/if}{if !$edit_kind} disabled{/if}>
                                            <label class="btn btn-soft" for="as-type-individual"><i class="bi bi-person me-1"></i>{lang key='website/account/type-individual'}</label>
                                            <input type="radio" class="btn-check" name="account_type" id="as-type-company" value="company" autocomplete="off"{if $p_kind == 'company'} checked{/if}{if !$edit_kind} disabled{/if}>
                                            <label class="btn btn-soft" for="as-type-company"><i class="bi bi-building me-1"></i>{lang key='website/account/type-company'}</label>
                                        </div>
                                        <div class="wui-collapse{if $p_kind == 'company'} wui-show{/if}" id="as-company-fields">
                                            <div class="wui-collapse-inner">
                                                <div class="pt-3">
                                                    <div class="row g-3">
                                                        <div class="col-12">
                                                            <label for="as-company-name" class="form-label">{lang key='website/account/company-name'}{if $company_name_required} <span class="text-danger" aria-hidden="true">*</span>{/if}</label>
                                                            <input type="text" class="form-control" id="as-company-name" name="company_name" autocomplete="organization" value="{$p_company_name}"{if $company_name_required} required{/if}>
                                                            <div class="invalid-feedback">{lang key='website/account/err-company-name'}</div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label for="as-vat" class="form-label">{lang key='website/account/vat'}{if $tax_number_required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                                            <input type="text" class="form-control" id="as-vat" name="vat_number" autocomplete="off" value="{$p_tax_number}"{if $tax_number_required} required{/if}>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label for="as-tax-office" class="form-label">{lang key='website/account/tax-office'}{if $tax_office_required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                                            <input type="text" class="form-control" id="as-tax-office" name="tax_office" autocomplete="off" value="{$p_tax_office}"{if $tax_office_required} required{/if}>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                                {/if}

                                <section class="as-section">
                                    <div class="as-section-aside">
                                        <h3 class="as-section-title">{lang key='website/account/personal-title'}</h3>
                                        <p class="as-section-note">{lang key='website/account/personal-note'}</p>
                                    </div>
                                    <div class="as-section-body">
                                        <div class="as-avatar-edit">
                                            <span class="account-avatar-lg as-avatar" data-role="as-avatar">{if $p_avatar}<img class="account-avatar-img" src="{$p_avatar}" alt="{lang key='website/account/avatar-alt'}" data-role="as-avatar-img">{else}<span data-role="as-avatar-initials">{$p_initials}</span>{/if}</span>
                                            <div class="as-avatar-meta">
                                                <div class="as-avatar-actions">
                                                    <label class="btn btn-soft btn-sm mb-0" for="as-avatar-file"><i class="bi bi-camera me-1"></i>{lang key='website/account/change-photo'}</label>
                                                    <input type="file" id="as-avatar-file" name="avatar" class="visually-hidden" accept=".jpg,.jpeg,.png,.webp" data-max-mb="5" data-role="as-avatar-input">
                                                    <button type="button" class="btn btn-ghost btn-sm" data-action="as-remove-avatar"{if !$p_avatar} hidden{/if}><i class="bi bi-trash3 me-1"></i>{lang key='website/account/remove'}</button>
                                                </div>
                                                <p class="as-avatar-hint">{lang key='website/account/avatar-hint'}</p>
                                            </div>
                                        </div>
                                        <div class="row g-3">
                                            <div class="col-sm-6">
                                                <label for="as-first-name" class="form-label">{lang key='website/account/first-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                                                <input type="text" class="form-control" id="as-first-name" name="first_name" autocomplete="given-name" value="{$p_name}"{if !$edit_name} readonly{/if} required>
                                                <div class="invalid-feedback">{lang key='website/account/err-first-name'}</div>
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="as-last-name" class="form-label">{lang key='website/account/last-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                                                <input type="text" class="form-control" id="as-last-name" name="last_name" autocomplete="family-name" value="{$p_surname}"{if !$edit_name} readonly{/if} required>
                                                <div class="invalid-feedback">{lang key='website/account/err-last-name'}</div>
                                            </div>
                                            {if $show_birthday}
                                            <div class="col-sm-6">
                                                <label for="as-birthday" class="form-label">{lang key='website/account/birthday'}{if $birthday_required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                                <input type="date" class="form-control" id="as-birthday" name="birthday" value="{$p_birthday}"{if !$edit_birthday} readonly{/if}{if $birthday_required} required{/if}{if $birthday_max} max="{$birthday_max}"{/if}>
                                                {if $birthday_adult}<div class="form-text"><i class="bi bi-shield-check me-1"></i>{lang key='website/account/birthday-adult-note'}</div>{/if}
                                                <div class="invalid-feedback">{if $birthday_adult}{lang key='website/account/err-birthday-adult'}{else}{lang key='website/account/err-birthday'}{/if}</div>
                                            </div>
                                            {/if}
                                            {if $show_identity}
                                            <div class="col-sm-6">
                                                <label for="as-identity" class="form-label">{lang key='website/account/identity'}{if $identity_required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                                <input type="text" class="form-control" id="as-identity" name="identity" autocomplete="off" value="{$p_identity}"{if !$edit_identity} readonly{/if}{if $identity_required} required{/if}>
                                                {if $identity_required}<div class="invalid-feedback">{lang key='website/account/err-identity'}</div>{/if}
                                            </div>
                                            {/if}
                                        </div>
                                    </div>
                                </section>

                                <section class="as-section">
                                    <div class="as-section-aside">
                                        <h3 class="as-section-title">{lang key='website/account/contact-title'}</h3>
                                        <p class="as-section-note">{lang key='website/account/contact-note'}</p>
                                    </div>
                                    <div class="as-section-body">
                                        <div>
                                            <label for="as-email" class="form-label">{lang key='website/account/email'} <span class="text-danger" aria-hidden="true">*</span></label>
                                            <div class="as-field-with-action">
                                                <input type="email" class="form-control" id="as-email" name="email" autocomplete="email" value="{$p_email}" readonly>
                                                {if $edit_email}<button type="button" class="btn btn-soft" data-wui-toggle data-wui-target="#as-email-change" aria-expanded="false" aria-controls="as-email-change"><i class="bi bi-pencil me-1"></i>{lang key='website/account/change'}</button>{/if}
                                            </div>
                                            {if $p_email_verified}
                                            <div class="form-text"><i class="bi bi-check-circle text-success me-1"></i><span class="fw-semibold">{lang key='website/account/email-verified'}</span> {lang key='website/account/email-verified-note'}</div>
                                            {else}
                                            <div class="form-text"><i class="bi bi-exclamation-circle text-warning me-1"></i><span class="fw-semibold">{lang key='website/account/email-unverified'}</span> {lang key='website/account/email-unverified-note'}</div>
                                            {/if}
                                        </div>
                                        <div class="wui-collapse" id="as-email-change">
                                            <div class="wui-collapse-inner">
                                                <div class="as-inset pt-3">
                                                    <p class="fs-7 text-body-secondary mb-3">{lang key='website/account/email-change-intro'}</p>
                                                    <div class="row g-3 align-items-end">
                                                        <div class="col-sm-7">
                                                            <label for="as-new-email" class="form-label">{lang key='website/account/new-email'}</label>
                                                            <input type="email" class="form-control" id="as-new-email" placeholder="you@example.com">
                                                        </div>
                                                        <div class="col-sm-5">
                                                            <button type="button" class="btn btn-soft w-100" data-action="as-email-send-code" data-busy-text="{lang key='website/account/sending'}"><i class="bi bi-send me-1"></i>{lang key='website/account/send-code'}</button>
                                                        </div>
                                                    </div>
                                                    <div class="wui-collapse" id="as-email-code">
                                                        <div class="wui-collapse-inner">
                                                            <div class="pt-3">
                                                                <span class="form-label d-block">{lang key='website/account/verification-code'}</span>
                                                                <div class="as-otp" data-as-otp role="group" aria-label="{lang key='website/account/verification-code'}">
                                                                    <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="one-time-code" maxlength="1" aria-label="{lang key='website/account/digit'} 1">
                                                                    <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/digit'} 2">
                                                                    <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/digit'} 3">
                                                                    <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/digit'} 4">
                                                                    <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/digit'} 5">
                                                                    <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/digit'} 6">
                                                                </div>
                                                                <p class="fs-8 text-body-secondary mt-2 mb-0">{lang key='website/account/code-sent-to'} <strong data-role="as-new-email-echo">you@example.com</strong>. <button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none align-baseline" data-action="as-email-send-code" data-busy-text="{lang key='website/account/sending'}">{lang key='website/account/resend-code'}</button></p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        {if $show_phone}
                                        <div class="as-field-divided">
                                            <label for="as-phone" class="form-label">{lang key='website/account/phone'}{if $phone_required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                            <input type="tel" class="form-control" id="as-phone" autocomplete="tel" value="{$p_phone}"{if !$edit_phone} readonly{/if}{if $phone_required} required{/if}>
                                            <input type="hidden" name="phone" id="as-phone-full" value="{$p_phone}">
                                            <div class="invalid-feedback">{lang key='website/account/err-phone'}</div>
                                            <div class="d-flex flex-wrap align-items-center gap-2 mt-2">
                                                {if $p_phone_verified}
                                                <span class="form-text mb-0 me-auto" data-role="as-phone-status"><i class="bi bi-check-circle text-success me-1"></i><span class="fw-semibold">{lang key='website/account/phone-verified'}</span> {lang key='website/account/phone-note'}</span>
                                                {else}
                                                <span class="form-text mb-0 me-auto" data-role="as-phone-status">{lang key='website/account/phone-note'}</span>
                                                {if $verify_phone_enabled}<button type="button" class="btn btn-soft btn-sm" data-action="as-phone-send-code-profile" data-busy-text="{lang key='website/account/sending'}"><i class="bi bi-shield-check me-1"></i>{lang key='website/account/verify-phone'}</button>{/if}
                                                {/if}
                                            </div>
                                            {if $verify_phone_enabled}
                                            <div class="wui-collapse" id="as-profile-phone-code">
                                                <div class="wui-collapse-inner">
                                                    <div class="pt-3">
                                                        <span class="form-label d-block">{lang key='website/account/verification-code'}</span>
                                                        <div class="as-otp" data-as-otp role="group" aria-label="{lang key='website/account/phone-verification-code'}">
                                                            <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="one-time-code" maxlength="1" aria-label="{lang key='website/account/digit'} 1">
                                                            <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/digit'} 2">
                                                            <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/digit'} 3">
                                                            <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/digit'} 4">
                                                            <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/digit'} 5">
                                                            <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/digit'} 6">
                                                        </div>
                                                        <p class="fs-8 text-body-secondary mt-2 mb-0">{lang key='website/account/code-sent-sms'} <button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none align-baseline" data-action="as-phone-send-code-profile">{lang key='website/account/resend-code'}</button></p>
                                                    </div>
                                                </div>
                                            </div>
                                            {/if}
                                        </div>
                                        {/if}
                                        {if $show_landline}
                                        <div class="as-field-divided">
                                            <label for="as-landline" class="form-label">{lang key='website/account/landline'}{if $landline_required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                            <input type="tel" class="form-control" id="as-landline" name="landline_phone" autocomplete="tel" value="{$p_landline}"{if !$edit_landline} readonly{/if}{if $landline_required} required{/if}>
                                            {if $landline_required}<div class="invalid-feedback">{lang key='website/account/err-landline'}</div>{/if}
                                        </div>
                                        {/if}
                                    </div>
                                </section>

                                <section class="as-section">
                                    <div class="as-section-aside">
                                        <h3 class="as-section-title">{lang key='website/account/prefs-title'}</h3>
                                        <p class="as-section-note">{lang key='website/account/prefs-note'}</p>
                                    </div>
                                    <div class="as-section-body">
                                        <div class="row g-3">
                                            <div class="col-sm-6">
                                                <label for="as-language" class="form-label">{lang key='website/account/language'}</label>
                                                <select class="form-select" id="as-language" name="language" data-basic-select>
                                                    {foreach $lang_list as $l}<option value="{$l.key}"{if $l.key == $p_lang} selected{/if}>{$l.name}</option>{/foreach}
                                                </select>
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="as-currency" class="form-label">{lang key='website/account/currency'}</label>
                                                <select class="form-select" id="as-currency" name="currency" data-basic-select>
                                                    {foreach $pref_currencies as $c}<option value="{$c.id}"{if $c.id == $p_currency} selected{/if}>{$c.code} - {$c.name}</option>{/foreach}
                                                </select>
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="as-timezone" class="form-label">{lang key='website/account/timezone'}</label>
                                                <select class="form-select" id="as-timezone" name="timezone" data-basic-select>
                                                    <option value=""{if $p_timezone == ''} selected{/if}>{lang key='website/account/timezone-default'} ({$pref_timezone_default})</option>
                                                    {foreach $pref_timezones as $tzKey => $tzLabel}<option value="{$tzKey}"{if $tzKey == $p_timezone} selected{/if}>{$tzLabel}</option>{/foreach}
                                                </select>
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="as-date-format" class="form-label">{lang key='website/account/date-format'}</label>
                                                <select class="form-select" id="as-date-format" name="date_format" data-basic-select>
                                                    <option value=""{if $p_date_format == ''} selected{/if}>{lang key='website/account/date-format-default'} ({$pref_dateformat_default})</option>
                                                    {foreach $pref_dateformats as $fmtKey => $fmtLabel}<option value="{$fmtKey}"{if $fmtKey == $p_date_format} selected{/if}>{$fmtLabel}</option>{/foreach}
                                                </select>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-label mb-2">{lang key='website/account/display-mode'}</div>
                                                <div class="as-thememode" role="group" aria-label="{lang key='website/account/display-mode'}">
                                                    <button type="button" class="btn" data-action="set-theme" data-theme="light" data-theme-option aria-pressed="false"><i class="bi bi-sun me-1"></i>{lang key='website/account/theme-light'}</button>
                                                    <button type="button" class="btn" data-action="set-theme" data-theme="dark" data-theme-option aria-pressed="false"><i class="bi bi-moon-stars me-1"></i>{lang key='website/account/theme-dark'}</button>
                                                    <button type="button" class="btn" data-action="set-theme" data-theme="auto" data-theme-option aria-pressed="false"><i class="bi bi-circle-half me-1"></i>{lang key='website/account/theme-auto'}</button>
                                                </div>
                                                <div class="form-text">{lang key='website/account/display-mode-note'}</div>
                                            </div>
                                        </div>
                                    </div>
                                </section>

                                {if $custom_fields}
                                <section class="as-section">
                                    <div class="as-section-aside">
                                        <h3 class="as-section-title">{lang key='website/account/additional-title'}</h3>
                                        <p class="as-section-note">{lang key='website/account/additional-note'}</p>
                                    </div>
                                    <div class="as-section-body">
                                        <div class="row g-3">
                                            {foreach $custom_fields as $cf}
                                            {assign var=cfId value="as-cf-`$cf.id`"}
                                            {if $cf.type == 'textarea'}
                                            <div class="col-12">
                                                <label for="{$cfId}" class="form-label">{$cf.name}{if $cf.required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                                <textarea class="form-control" id="{$cfId}" name="field_{$cf.id}" rows="3"{if $cf.required} required{/if}{if $cf.uneditable} readonly{/if}>{$cf.value}</textarea>
                                                {if $cf.required}<div class="invalid-feedback">{lang key='website/account/err-required'}</div>{/if}
                                            </div>
                                            {elseif $cf.type == 'select'}
                                            <div class="col-sm-6">
                                                <label for="{$cfId}" class="form-label">{$cf.name}{if $cf.required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                                <select class="form-select" id="{$cfId}" name="field_{$cf.id}"{if $cf.required} required{/if}{if $cf.uneditable} disabled{/if}>
                                                    <option value="">{lang key='website/account/select-option'}</option>
                                                    {foreach $cf.options as $opt}<option value="{$opt.value}"{if $opt.selected} selected{/if}>{$opt.value}</option>{/foreach}
                                                </select>
                                                {if $cf.required}<div class="invalid-feedback">{lang key='website/account/err-required'}</div>{/if}
                                            </div>
                                            {elseif $cf.type == 'radio'}
                                            <div class="col-12">
                                                <span class="form-label d-block">{$cf.name}{if $cf.required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</span>
                                                <div class="d-flex flex-wrap gap-3">
                                                    {foreach $cf.options as $oi => $opt}
                                                    <div class="form-check"><input class="form-check-input" type="radio" name="field_{$cf.id}" id="{$cfId}-{$oi}" value="{$opt.value}"{if $opt.selected} checked{/if}{if $cf.required} required{/if}{if $cf.uneditable} disabled{/if}><label class="form-check-label" for="{$cfId}-{$oi}">{$opt.value}</label></div>
                                                    {/foreach}
                                                </div>
                                            </div>
                                            {elseif $cf.type == 'checkbox'}
                                            <div class="col-12">
                                                <span class="form-label d-block">{$cf.name}{if $cf.required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</span>
                                                <div class="d-flex flex-wrap gap-3">
                                                    {foreach $cf.options as $oi => $opt}
                                                    <div class="form-check"><input class="form-check-input" type="checkbox" name="field_{$cf.id}[]" id="{$cfId}-{$oi}" value="{$opt.value}"{if $opt.selected} checked{/if}{if $cf.uneditable} disabled{/if}><label class="form-check-label" for="{$cfId}-{$oi}">{$opt.value}</label></div>
                                                    {/foreach}
                                                </div>
                                            </div>
                                            {elseif $cf.type == 'date'}
                                            <div class="col-sm-6">
                                                <label for="{$cfId}" class="form-label">{$cf.name}{if $cf.required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                                <input type="date" class="form-control" id="{$cfId}" name="field_{$cf.id}" value="{$cf.value}"{if $cf.required} required{/if}{if $cf.uneditable} readonly{/if}>
                                                {if $cf.required}<div class="invalid-feedback">{lang key='website/account/err-required'}</div>{/if}
                                            </div>
                                            {else}
                                            <div class="col-sm-6">
                                                <label for="{$cfId}" class="form-label">{$cf.name}{if $cf.required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                                <input type="text" class="form-control" id="{$cfId}" name="field_{$cf.id}" value="{$cf.value}"{if $cf.required} required{/if}{if $cf.uneditable} readonly{/if}>
                                                {if $cf.required}<div class="invalid-feedback">{lang key='website/account/err-required'}</div>{/if}
                                            </div>
                                            {/if}
                                            {/foreach}
                                        </div>
                                    </div>
                                </section>
                                {/if}

                                {hook name='ui:client.account.profile.form.bottom'}

                                <div class="as-panel-foot">
                                    <button type="submit" class="btn btn-primary" data-busy-text="{lang key='website/account/saving'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/account/save'}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    {/if}

                    {if $show_contacts}
                    <div class="tab-pane fade{if !$show_profile} show active{/if}" id="as-invoices" role="tabpanel" aria-labelledby="as-invoices-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/account/contacts-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/account/contacts-sub'}</p>
                            </div>
                            <button type="button" class="btn btn-primary" data-action="as-add-profile"><i class="bi bi-plus-lg me-1"></i>{lang key='website/account/contacts-add'}</button>
                        </div>

                        <div class="as-list{if !$contacts} d-none{/if}" data-role="as-profiles-list" data-contacts="{$contacts_json}">
                            {foreach $contacts as $c}
                            <article class="as-item" data-profile-id="{$c.id}">
                                <span class="as-item-ico"><i class="bi {if $c.kind == 'corporate'}bi-building{else}bi-person-vcard{/if}"></i></span>
                                <div class="as-item-main">
                                    <div class="as-item-head">
                                        <span class="as-item-name">{$c.full_name}</span>
                                        {if $c.label}<span class="as-item-dim">&middot; {$c.label}</span>{/if}
                                        {if $c.default}<span class="badge bg-primary-subtle text-primary-emphasis"><i class="bi bi-star-fill me-1"></i>{lang key='website/account/contacts-default'}</span>{/if}
                                    </div>
                                    <div class="as-item-meta">
                                        {if $c.company_name}<span class="as-item-line">{$c.company_name}</span>{/if}
                                        {if $c.email}<span class="list-chip"><i class="bi bi-envelope"></i>{$c.email}</span>{/if}
                                        {if $c.phone}<span class="list-chip"><i class="bi bi-telephone"></i>{$c.phone}</span>{/if}
                                    </div>
                                </div>
                                <div class="as-item-actions">
                                    {if $c.default}
                                    <button type="button" class="btn btn-soft btn-sm as-default-toggle" disabled><i class="bi bi-star-fill me-1"></i>{lang key='website/account/contacts-default'}</button>
                                    {else}
                                    <button type="button" class="btn btn-soft btn-sm as-default-toggle" data-action="as-default-profile" data-profile-id="{$c.id}"><i class="bi bi-star me-1"></i>{lang key='website/account/contacts-set-default'}</button>
                                    {/if}
                                    <button type="button" class="btn btn-soft btn-sm" data-action="as-edit-profile" data-profile-id="{$c.id}"><i class="bi bi-pencil me-1"></i>{lang key='website/account/contacts-edit'}</button>
                                    <div class="dropdown">
                                        <button type="button" class="btn btn-soft btn-sm" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/account/contacts-more'}"><i class="bi bi-three-dots"></i></button>
                                        <ul class="dropdown-menu dropdown-menu-end">
                                            <li><button type="button" class="dropdown-item text-danger" data-action="as-delete-profile" data-profile-id="{$c.id}" data-profile-name="{$c.full_name}" data-busy-text="{lang key='website/account/busy-deleting'}"><i class="bi bi-trash3"></i>{lang key='website/account/contacts-delete'}</button></li>
                                        </ul>
                                    </div>
                                </div>
                            </article>
                            {/foreach}
                        </div>

                        <div class="basic-empty-state{if $contacts} d-none{/if}" data-role="as-profiles-empty">
                            <i class="bi bi-person-vcard" aria-hidden="true"></i>
                            <span class="fw-semibold">{lang key='website/account/contacts-empty-title'}</span>
                            <span class="fs-7">{lang key='website/account/contacts-empty-sub'}</span>
                            <button type="button" class="btn btn-soft btn-sm mt-1" data-action="as-add-profile"><i class="bi bi-plus-lg me-1"></i>{lang key='website/account/contacts-empty-add'}</button>
                        </div>
                    </div>
                    {/if}

                    {if $show_security}
                    <div class="tab-pane fade" id="as-security" role="tabpanel" aria-labelledby="as-security-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/account/security-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/account/security-sub'}</p>
                            </div>
                        </div>

                        <section class="as-card">
                            <h3 class="as-section-title">{lang key='website/account/password-title'}</h3>
                            <form id="as-password-form" novalidate data-pw-min="{$password_min}" data-pw-chars="{$password_chars}" data-pw-chars-msg="{lang key='needs/password-needs-special' characters=$password_chars}">
                                <div class="row g-3">
                                    <div class="col-12" data-password-field>
                                        <label for="as-new-password" class="form-label">{lang key='website/account/new-password'} <span class="text-danger" aria-hidden="true">*</span></label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="as-new-password" name="new_password" autocomplete="new-password" required>
                                            <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/account/password-show'}"><i class="bi bi-eye"></i></button>
                                            <button class="btn btn-soft" type="button" data-action="password-generate" data-bs-toggle="tooltip" title="{lang key='website/account/password-generate'}"><i class="bi bi-stars"></i></button>
                                            <button class="btn btn-soft" type="button" data-action="password-copy" data-bs-toggle="tooltip" title="{lang key='website/account/password-copy'}"><i class="bi bi-clipboard"></i></button>
                                        </div>
                                        <div class="basic-password-strength" data-strength="0" data-labels="|{lang key='website/sign/password-strength-weak'}|{lang key='website/sign/password-strength-fair'}|{lang key='website/sign/password-strength-good'}|{lang key='website/sign/password-strength-strong'}">
                                            <span class="strength-bar"></span><span class="strength-bar"></span>
                                            <span class="strength-bar"></span><span class="strength-bar"></span>
                                        </div>
                                        <small class="text-body-secondary" data-role="strength-label"></small>
                                        <div class="invalid-feedback">{lang key='website/account/err-password-min' min=$password_min}</div>
                                        <small class="text-body-secondary d-block">{if $password_chars}{lang key='website/account/password-rule-chars' min=$password_min chars=$password_chars}{else}{lang key='website/account/password-rule' min=$password_min}{/if}</small>
                                    </div>
                                    <div class="col-12">
                                        <label for="as-current-password" class="form-label">{lang key='website/account/current-password'} <span class="text-danger" aria-hidden="true">*</span></label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="as-current-password" name="current_password" autocomplete="current-password" placeholder="{lang key='website/account/current-password-ph'}" required>
                                            <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/account/password-show'}"><i class="bi bi-eye"></i></button>
                                        </div>
                                        <div class="form-text"><i class="bi bi-shield-check me-1"></i>{lang key='website/account/current-password-note'}</div>
                                        <div class="invalid-feedback">{lang key='website/account/err-current-password'}</div>
                                    </div>
                                </div>
                                <div class="as-save-bar">
                                    <button type="submit" class="btn btn-primary" data-busy-text="{lang key='website/account/password-updating'}"><i class="bi bi-key me-1"></i>{lang key='website/account/password-update'}</button>
                                </div>
                            </form>
                        </section>

                        {if $show_security_question}
                        <section class="as-card">
                            <h3 class="as-section-title">{lang key='website/account/security-question-title'}</h3>
                            <p class="fs-7 text-body-secondary">{lang key='website/account/security-question-sub'}</p>
                            <form id="as-secq-form" novalidate>
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label for="as-security-question" class="form-label">{lang key='website/account/security-question-label'}{if $security_question_required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                        <input type="text" class="form-control" id="as-security-question" name="security_question" autocomplete="off" data-lpignore="true" data-1p-ignore data-bwignore value="{$p_security_question}" placeholder="{lang key='website/account/security-question-ph'}"{if $security_question_required} required{/if}>
                                        <div class="invalid-feedback">{lang key='website/account/err-security-question'}</div>
                                        {if !$security_question_required}<div class="form-text">{lang key='website/account/security-question-clear-note'}</div>{/if}
                                    </div>
                                    <div class="col-12" data-password-field>
                                        <label for="as-security-answer" class="form-label">{lang key='website/account/security-answer-label'}{if $security_question_required && !$p_security_answer_set} <span class="text-danger" aria-hidden="true">*</span>{/if}</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="as-security-answer" name="security_question_answer" autocomplete="new-password" data-lpignore="true" data-1p-ignore data-bwignore placeholder="{if $p_security_answer_set}{lang key='website/account/security-answer-ph-set'}{else}{lang key='website/account/security-answer-ph'}{/if}">
                                            <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/account/password-show'}"><i class="bi bi-eye"></i></button>
                                        </div>
                                        <div class="form-text"><i class="bi bi-shield-lock me-1"></i>{lang key='website/account/security-answer-note'}</div>
                                        <div class="invalid-feedback">{lang key='website/account/err-security-answer'}</div>
                                    </div>
                                </div>
                                <div class="as-save-bar">
                                    <button type="submit" class="btn btn-primary" data-busy-text="{lang key='website/account/security-question-saving'}"><i class="bi bi-shield-lock me-1"></i>{lang key='website/account/security-question-save'}</button>
                                </div>
                            </form>
                        </section>
                        {/if}

                        {if $passkeys_enabled}
                        <section class="as-card">
                            <div class="as-card-head">
                                <h3 class="as-section-title mb-0">{lang key='website/account/passkeys-title'}</h3>
                                <button type="button" class="btn btn-soft btn-sm" data-action="as-passkey-add"><i class="bi bi-plus-lg me-1"></i>{lang key='website/account/passkeys-add'}</button>
                            </div>
                            <p class="fs-7 text-body-secondary">{lang key='website/account/passkeys-sub'}</p>
                            <div class="as-list{if !$passkeys} d-none{/if}" data-role="as-passkeys-list"
                                data-txt-created="{lang key='website/account/passkeys-created'}"
                                data-txt-lastused="{lang key='website/account/passkeys-last-used'}"
                                data-txt-remove="{lang key='website/account/passkeys-remove'}"
                                data-txt-remove-title="{lang key='website/account/passkeys-remove-title'}"
                                data-txt-remove-msg="{lang key='website/account/passkeys-remove-msg'}"
                                data-txt-unsupported="{lang key='website/account/passkeys-unsupported'}">
                                {foreach $passkeys as $pk}
                                <article class="as-item as-item-flat" data-passkey-id="{$pk.id}">
                                    <span class="as-item-ico"><i class="bi bi-fingerprint"></i></span>
                                    <div class="as-item-main">
                                        <div class="as-item-head"><span class="as-item-name">{$pk.label}</span></div>
                                        <div class="as-item-meta">
                                            <span class="as-item-dim">{lang key='website/account/passkeys-created'} {$pk.cdate}</span>
                                            {if $pk.last_used}<span class="as-item-dim">{lang key='website/account/passkeys-last-used'} {$pk.last_used}</span>{/if}
                                        </div>
                                    </div>
                                    <div class="as-item-actions">
                                        <button type="button" class="btn btn-soft btn-sm" data-action="as-passkey-remove" data-passkey-id="{$pk.id}" data-passkey-name="{$pk.label}">{lang key='website/account/passkeys-remove'}</button>
                                    </div>
                                </article>
                                {/foreach}
                            </div>
                            <div class="basic-empty-state{if $passkeys} d-none{/if}" data-role="as-passkeys-empty">
                                <i class="bi bi-fingerprint" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/account/passkeys-empty-title'}</span>
                                <span class="fs-7">{lang key='website/account/passkeys-empty-sub'}</span>
                            </div>
                        </section>
                        {/if}

                        <section class="as-card">
                            <div class="as-card-head">
                                <h3 class="as-section-title mb-0">{lang key='website/account/sessions-title'}</h3>
                                <button type="button" class="btn btn-outline-danger btn-sm{if !$sessions_has_others} d-none{/if}" data-action="as-revoke-all"><i class="bi bi-box-arrow-right me-1"></i>{lang key='website/account/sessions-signout-all'}</button>
                            </div>
                            <p class="fs-7 text-body-secondary">{lang key='website/account/sessions-sub'}</p>
                            {if $sessions}
                            <div class="as-list" data-role="as-sessions-list">
                                {foreach $sessions as $s}
                                <article class="as-item as-item-flat" data-session-token="{$s.token}"{if $s.current} data-session-current="1"{/if}>
                                    <span class="as-item-ico{if $s.current} as-item-ico-success{/if}"><i class="bi {$s.icon}"></i></span>
                                    <div class="as-item-main">
                                        <div class="as-item-head">
                                            <span class="as-item-name">{$s.device}</span>
                                            {if $s.current}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-broadcast me-1"></i>{lang key='website/account/sessions-this-device'}</span>{/if}
                                        </div>
                                        <div class="as-item-meta">
                                            {if $s.location}<span class="list-chip"><i class="bi bi-geo-alt"></i>{$s.location}</span>{/if}
                                            {if $s.ip}<span class="as-item-dim num-tabular">{$s.ip}</span>{/if}
                                            <span class="as-item-dim">{$s.when}</span>
                                        </div>
                                    </div>
                                    {if !$s.current}
                                    <div class="as-item-actions">
                                        <button type="button" class="btn btn-soft btn-sm" data-action="as-revoke-session" data-session-token="{$s.token}" data-session-name="{$s.device}">{lang key='website/account/sessions-revoke'}</button>
                                    </div>
                                    {/if}
                                </article>
                                {/foreach}
                            </div>
                            {else}
                            <div class="basic-empty-state">
                                <i class="bi bi-shield-check" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/account/sessions-empty-title'}</span>
                                <span class="fs-7">{lang key='website/account/sessions-empty-sub'}</span>
                            </div>
                            {/if}
                        </section>

                        {if $trusted_devices_visible}
                        <section class="as-card">
                            <div class="as-card-head">
                                <h3 class="as-section-title mb-0">{lang key='website/account/trusted-title'}</h3>
                                <button type="button" class="btn btn-outline-danger btn-sm{if !$trusted_devices} d-none{/if}" data-action="as-trusted-revoke-all"><i class="bi bi-shield-x me-1"></i>{lang key='website/account/trusted-revoke-all'}</button>
                            </div>
                            <p class="fs-7 text-body-secondary">{lang key='website/account/trusted-sub'}</p>
                            <div class="as-list{if !$trusted_devices} d-none{/if}" data-role="as-trusted-list">
                                {foreach $trusted_devices as $d}
                                <article class="as-item as-item-flat" data-trusted-id="{$d.id}">
                                    <span class="as-item-ico{if $d.current} as-item-ico-success{/if}"><i class="bi {$d.icon}"></i></span>
                                    <div class="as-item-main">
                                        <div class="as-item-head">
                                            <span class="as-item-name">{$d.device}</span>
                                            {if $d.current}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-broadcast me-1"></i>{lang key='website/account/trusted-this-device'}</span>{/if}
                                        </div>
                                        <div class="as-item-meta">
                                            {if $d.location}<span class="list-chip"><i class="bi bi-geo-alt"></i>{$d.location}</span>{/if}
                                            {if $d.ip}<span class="as-item-dim num-tabular">{$d.ip}</span>{/if}
                                            {if $d.last}<span class="as-item-dim">{lang key='website/account/trusted-last'} {$d.last}</span>{/if}
                                            {if $d.expires}<span class="as-item-dim">{lang key='website/account/trusted-expires'} {$d.expires}</span>{/if}
                                        </div>
                                    </div>
                                    <div class="as-item-actions">
                                        <button type="button" class="btn btn-soft btn-sm" data-action="as-trusted-revoke" data-trusted-id="{$d.id}" data-trusted-name="{$d.device}">{lang key='website/account/trusted-revoke'}</button>
                                    </div>
                                </article>
                                {/foreach}
                            </div>
                            <div class="basic-empty-state{if $trusted_devices} d-none{/if}" data-role="as-trusted-empty">
                                <i class="bi bi-shield-lock" aria-hidden="true"></i>
                                <span class="fw-semibold">{lang key='website/account/trusted-empty-title'}</span>
                                <span class="fs-7">{lang key='website/account/trusted-empty-sub'}</span>
                            </div>
                        </section>
                        {/if}

                        {hook name='ui:client.account.security.after'}
                    </div>
                    {/if}

                    {if $show_2fa}
                    <div class="tab-pane fade" id="as-2fa" role="tabpanel" aria-labelledby="as-2fa-tab" tabindex="0" data-twofa-active="{$twofa_active}">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/account/2fa-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/account/2fa-sub'}</p>
                            </div>
                        </div>
                        {if $twofa_required && !$twofa_active}
                        <div class="as-2fa-required" data-role="as-2fa-required" role="alert">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                            <div>
                                <span class="fw-semibold">{lang key='website/account/2fa-required-title'}</span>
                                <p class="mb-0">{lang key='website/account/2fa-required-sub'}</p>
                            </div>
                        </div>
                        {/if}
                        <section class="as-card">
                            <div class="as-2fa-note{if !$twofa_active} d-none{/if}" data-role="as-2fa-note"><i class="bi bi-info-circle"></i><span>{$twofa_active_note}</span></div>
                            {if isset($twofa_methods.Totp)}
                            <div class="as-2fa-row">
                                <span class="as-2fa-ico"><i class="bi bi-phone"></i></span>
                                <div class="as-2fa-body">
                                    <div class="as-2fa-head">
                                        <span class="as-2fa-name">{lang key='website/account/2fa-totp-name'}</span>
                                        {if $twofa_methods.Totp.active}<span class="badge bg-success-subtle text-success-emphasis" data-role="totp-badge"><i class="bi bi-check-circle me-1"></i>{lang key='website/account/2fa-badge-enabled'}</span>{else}<span class="badge bg-secondary-subtle text-secondary-emphasis" data-role="totp-badge"><i class="bi bi-dash-circle me-1"></i>{lang key='website/account/2fa-badge-not-enabled'}</span>{/if}
                                    </div>
                                    <p class="fs-7 text-body-secondary mb-0">{lang key='website/account/2fa-totp-desc'}</p>
                                </div>
                                <div class="as-2fa-actions">
                                    <button type="button" class="btn btn-soft btn-sm{if $twofa_methods.Totp.active} d-none{/if}" data-action="as-2fa-setup" data-role="totp-enable"{if $twofa_active && !$twofa_methods.Totp.active} disabled{/if}><i class="bi bi-gear me-1"></i>{lang key='website/account/2fa-setup'}</button>
                                    <button type="button" class="btn btn-soft btn-sm{if !$twofa_methods.Totp.active} d-none{/if}" data-action="as-2fa-disable" data-role="totp-disable" data-method="Totp"><i class="bi bi-x-circle me-1"></i>{lang key='website/account/2fa-disable'}</button>
                                </div>
                            </div>
                            {/if}
                            {if isset($twofa_methods.Sms)}
                            <hr class="as-divider">
                            <div class="as-2fa-row">
                                <span class="as-2fa-ico"><i class="bi bi-chat-dots"></i></span>
                                <div class="as-2fa-body">
                                    <div class="as-2fa-head">
                                        <span class="as-2fa-name">{lang key='website/account/2fa-sms-name'}</span>
                                        {if $twofa_methods.Sms.active}<span class="badge bg-success-subtle text-success-emphasis" data-role="sms-badge"><i class="bi bi-check-circle me-1"></i>{lang key='website/account/2fa-badge-configured'}</span>{else}<span class="badge bg-secondary-subtle text-secondary-emphasis" data-role="sms-badge"><i class="bi bi-dash-circle me-1"></i>{lang key='website/account/2fa-badge-not-configured'}</span>{/if}
                                    </div>
                                    <p class="fs-7 text-body-secondary mb-0">{lang key='website/account/2fa-sms-desc'}</p>
                                </div>
                                <div class="as-2fa-actions">
                                    <button type="button" class="btn btn-soft btn-sm{if $twofa_methods.Sms.active} d-none{/if}" data-action="as-sms-setup" data-role="sms-enable"{if $twofa_active && !$twofa_methods.Sms.active} disabled{/if}><i class="bi bi-gear me-1"></i>{lang key='website/account/2fa-setup'}</button>
                                    <button type="button" class="btn btn-soft btn-sm{if !$twofa_methods.Sms.active} d-none{/if}" data-action="as-2fa-disable" data-role="sms-disable" data-method="Sms"><i class="bi bi-x-circle me-1"></i>{lang key='website/account/2fa-disable'}</button>
                                </div>
                            </div>
                            {/if}
                            {if isset($twofa_methods.Email)}
                            <hr class="as-divider">
                            <div class="as-2fa-row">
                                <span class="as-2fa-ico"><i class="bi bi-envelope"></i></span>
                                <div class="as-2fa-body">
                                    <div class="as-2fa-head">
                                        <span class="as-2fa-name">{lang key='website/account/2fa-email-name'}</span>
                                        {if $twofa_methods.Email.active}<span class="badge bg-success-subtle text-success-emphasis" data-role="email2fa-badge"><i class="bi bi-check-circle me-1"></i>{lang key='website/account/2fa-badge-configured'}</span>{else}<span class="badge bg-secondary-subtle text-secondary-emphasis" data-role="email2fa-badge"><i class="bi bi-dash-circle me-1"></i>{lang key='website/account/2fa-badge-not-configured'}</span>{/if}
                                    </div>
                                    <p class="fs-7 text-body-secondary mb-0">{lang key='website/account/2fa-email-desc'}</p>
                                </div>
                                <div class="as-2fa-actions">
                                    <button type="button" class="btn btn-soft btn-sm{if $twofa_methods.Email.active} d-none{/if}" data-action="as-email2fa-setup" data-role="email2fa-enable"{if $twofa_active && !$twofa_methods.Email.active} disabled{/if}><i class="bi bi-gear me-1"></i>{lang key='website/account/2fa-setup'}</button>
                                    <button type="button" class="btn btn-soft btn-sm{if !$twofa_methods.Email.active} d-none{/if}" data-action="as-2fa-disable" data-role="email2fa-disable" data-method="Email"><i class="bi bi-x-circle me-1"></i>{lang key='website/account/2fa-disable'}</button>
                                </div>
                            </div>
                            {/if}
                        </section>
                    </div>
                    {/if}

                    {if $show_notification_feed}
                    <div class="tab-pane fade{if !$show_profile && !$show_contacts} show active{/if}" id="as-notiffeed" role="tabpanel" aria-labelledby="as-notiffeed-tab" tabindex="0"
                         data-notif-page
                         data-notif-url="{link route='my-account'}"
                         data-txt-read="{lang key='website/notifications/mark-one'}"
                         data-txt-new="{lang key='website/notifications/new'}"
                         data-txt-empty="{lang key='website/notifications/empty-text'}"
                         data-txt-error="{lang key='website/notifications/error'}">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/notifications/title'}</h2>
                                <p class="as-pane-sub">{lang key='website/notifications/subtitle'}</p>
                            </div>
                            <div class="as-pane-tools">
                                <span class="notif-new{if !$notification_count} d-none{/if}" data-role="notif-page-new">{lang key='website/notifications/new' count=$notification_count|default:0}</span>
                                <button type="button" class="btn btn-soft btn-sm{if !$notification_count} d-none{/if}" data-action="notif-read-all"><i class="bi bi-check2-all me-1"></i>{lang key='website/notifications/mark-all'}</button>
                            </div>
                        </div>

                        {csrf form='notifications'}

                        <section class="as-card as-card-flush" data-role="notif-card">
                            <div class="notif-list np-list" data-role="notif-list"></div>
                            <div class="np-more d-none" data-role="notif-more" aria-label="{lang key='website/notifications/loading'}">
                                <div class="notif-skel"><span class="notif-skel-disc basic-skeleton"></span><span class="notif-skel-body"><span class="notif-skel-line basic-skeleton"></span><span class="notif-skel-line is-sub basic-skeleton"></span></span></div>
                                <div class="notif-skel"><span class="notif-skel-disc basic-skeleton"></span><span class="notif-skel-body"><span class="notif-skel-line basic-skeleton"></span><span class="notif-skel-line is-sub basic-skeleton"></span></span></div>
                            </div>
                            <div class="np-sentinel" data-role="notif-sentinel" aria-hidden="true"></div>
                            <p class="np-end d-none" data-role="notif-end">{lang key='website/notifications/end'}</p>
                        </section>

                        <div class="wcp-empty-state d-none" data-role="notif-empty">
                            <i class="bi bi-bell" aria-hidden="true"></i>
                            <span class="fw-semibold">{lang key='website/notifications/empty-title'}</span>
                            <span class="fs-7">{lang key='website/notifications/empty-text'}</span>
                        </div>
                    </div>
                    {/if}

                    {if $show_notifications}
                    <div class="tab-pane fade" id="as-notifications" role="tabpanel" aria-labelledby="as-notifications-tab" tabindex="0">
                        <form id="as-notif-form">
                            <div class="as-pane-head">
                                <div>
                                    <h2 class="as-pane-title">{lang key='website/account/notif-title'}</h2>
                                    <p class="as-pane-sub">{lang key='website/account/notif-sub'}</p>
                                </div>
                            </div>

                            <section class="as-card as-card-flush">
                                <div class="as-notif-table" role="table" aria-label="{lang key='website/account/notif-title'}">
                                    <div class="as-notif-row as-notif-headrow" role="row">
                                        <span class="as-notif-cat" role="columnheader">{lang key='website/account/notif-th-notification'}</span>
                                        <span class="as-notif-ch" role="columnheader"><i class="bi bi-envelope me-1"></i>{lang key='website/account/notif-th-email'}</span>
                                        <span class="as-notif-ch" role="columnheader"><i class="bi bi-chat-left-text me-1"></i>{lang key='website/account/notif-th-sms'}</span>
                                    </div>
                                    {foreach $notif_prefs as $p}
                                    <div class="as-notif-row" role="row">
                                        <span class="as-notif-cat" role="cell">
                                            <span class="as-notif-name">{$p.label}{if $p.locked} <span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-lock me-1"></i>{lang key='website/account/notif-always-on'}</span>{/if}</span>
                                            <span class="as-notif-desc">{$p.desc}</span>
                                        </span>
                                        <span class="as-notif-ch" role="cell">
                                            <span class="form-check form-switch as-switch m-0"><input class="form-check-input" type="checkbox" role="switch" name="notif_email_{$p.suffix}" value="1"{if $p.email_on} checked{/if}{if $p.locked} disabled{/if} aria-label="{$p.label}, {lang key='website/account/notif-th-email'}"></span>
                                        </span>
                                        <span class="as-notif-ch" role="cell">
                                            <span class="form-check form-switch as-switch m-0"><input class="form-check-input" type="checkbox" role="switch" name="notif_sms_{$p.suffix}" value="1"{if $p.sms_on} checked{/if}{if $p.locked} disabled{/if} aria-label="{$p.label}, {lang key='website/account/notif-th-sms'}"></span>
                                        </span>
                                    </div>
                                    {/foreach}
                                </div>
                            </section>

                            <div class="as-save-bar">
                                <button type="submit" class="btn btn-primary" data-busy-text="{lang key='website/account/notif-saving'}"><i class="bi bi-check-lg me-1"></i>{lang key='website/account/notif-save'}</button>
                            </div>
                        </form>
                    </div>
                    {/if}

                    {if $show_cards}
                    <div class="tab-pane fade" id="as-cards" role="tabpanel" aria-labelledby="as-cards-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/account/cards-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/account/cards-sub'}</p>
                            </div>
                            {if $cards_add_enabled}
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#as-card-modal"><i class="bi bi-plus-lg me-1"></i>{lang key='website/account/cards-add'}</button>
                            {/if}
                        </div>

                        <div class="as-list" data-role="as-cards-list"{if !$cards} hidden{/if} data-txt-default="{lang key='website/account/cards-default'}" data-txt-set-default="{lang key='website/account/cards-set-default'}" data-txt-expires="{lang key='website/account/cards-expires'}" data-txt-ending="{lang key='website/account/cards-ending'}" data-txt-delete="{lang key='website/account/cards-delete'}" data-txt-delete-action="{lang key='website/account/cards-delete-action'}" data-txt-delete-title="{lang key='website/account/cards-delete-title'}" data-txt-delete-generic="{lang key='website/account/cards-delete-generic'}" data-txt-delete-note="{lang key='website/account/cards-delete-note'}" data-txt-cancel="{lang key='website/account/cards-cancel'}" data-txt-added="{lang key='website/account/card-added'}" data-txt-setup-failed="{lang key='website/account/card-setup-failed'}" data-txt-autopay-badge="{lang key='website/account/cards-autopay-badge'}" data-txt-autopay-on="{lang key='website/account/cards-autopay-on'}" data-txt-autopay-off="{lang key='website/account/cards-autopay-off'}" data-txt-more="{lang key='website/account/cards-more'}" data-txt-make-primary="{lang key='website/account/cards-make-primary'}" data-txt-expired-badge="{lang key='website/account/cards-expired-badge'}" data-txt-expired-hint="{lang key='website/account/cards-expired-hint'}">
                            {foreach $cards as $c}
                            <article class="as-item" data-card-id="{$c.id}">
                                <span class="as-item-ico as-card-brand" role="img" aria-label="{$c.brand}">{$c.brand_svg nofilter}</span>
                                <div class="as-item-main">
                                    <div class="as-item-head">
                                        <span class="as-item-name">{$c.brand} {lang key='website/account/cards-ending'} {$c.ln4}</span>
                                        {if $c.is_default}<span class="badge bg-primary-subtle text-primary-emphasis"><i class="bi bi-star-fill me-1"></i>{lang key='website/account/cards-default'}</span>{/if}
                                        {if $c.autopay_label}<span class="badge bg-success-subtle text-success-emphasis" data-role="autopay-badge"><i class="bi bi-arrow-repeat me-1"></i>{$c.autopay_label}</span>{/if}
                                        {if $c.expired}<span class="badge bg-danger-subtle text-danger-emphasis" data-role="expired-badge"><i class="bi bi-calendar-x me-1"></i>{lang key='website/account/cards-expired-badge'}</span>{/if}
                                    </div>
                                    <div class="as-item-meta">
                                        <span class="as-item-line num-tabular">{lang key='website/account/cards-expires'} {$c.expiry_month}/{$c.expiry_year}</span>
                                        {if $c.name}<span class="as-item-dim">{$c.name}</span>{/if}
                                        {if $c.bank_name}<span class="as-item-dim">{$c.bank_name}</span>{/if}
                                    </div>
                                </div>
                                <div class="as-item-actions">
                                    {if $c.is_default}
                                    <button type="button" class="btn btn-soft btn-sm as-default-toggle" disabled><i class="bi bi-star-fill me-1"></i>{lang key='website/account/cards-default'}</button>
                                    {elseif $c.expired}
                                    <button type="button" class="btn btn-soft btn-sm as-default-toggle" disabled title="{lang key='website/account/cards-expired-hint'}"><i class="bi bi-star me-1"></i>{lang key='website/account/cards-set-default'}</button>
                                    {else}
                                    <button type="button" class="btn btn-soft btn-sm as-default-toggle" data-action="as-default-card" data-card-id="{$c.id}"><i class="bi bi-star me-1"></i>{lang key='website/account/cards-set-default'}</button>
                                    {/if}
                                    <div class="dropdown">
                                        <button type="button" class="btn btn-soft btn-sm" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/account/cards-more'}"><i class="bi bi-three-dots"></i></button>
                                        <ul class="dropdown-menu dropdown-menu-end">
                                            {if $c.auto_pay > 1}
                                            <li><button type="button" class="dropdown-item" data-action="as-card-primary" data-card-id="{$c.id}"><i class="bi bi-star"></i>{lang key='website/account/cards-make-primary'}</button></li>
                                            {/if}
                                            <li><button type="button" class="dropdown-item" data-action="as-card-autopay" data-card-id="{$c.id}" data-enabled="{if $c.auto_pay}1{else}0{/if}"{if !$c.auto_pay && $c.expired} disabled{/if}><i class="bi {if $c.auto_pay}bi-pause-circle{else}bi-arrow-repeat{/if}"></i>{if $c.auto_pay}{lang key='website/account/cards-autopay-off'}{else}{lang key='website/account/cards-autopay-on'}{/if}</button></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><button type="button" class="dropdown-item text-danger" data-action="as-delete-card" data-card-id="{$c.id}" data-card-name="{$c.brand} {lang key='website/account/cards-ending'} {$c.ln4}"><i class="bi bi-trash3"></i>{lang key='website/account/cards-delete-action'}</button></li>
                                        </ul>
                                    </div>
                                </div>
                            </article>
                            {/foreach}
                        </div>

                        <div class="basic-empty-state{if $cards} d-none{/if}" data-role="as-cards-empty">
                            <i class="bi bi-credit-card-2-back" aria-hidden="true"></i>
                            <span class="fw-semibold">{lang key='website/account/cards-empty-title'}</span>
                            <span class="fs-7">{lang key='website/account/cards-empty-sub'}</span>
                            {if $cards_add_enabled}
                            <button type="button" class="btn btn-soft btn-sm mt-1" data-bs-toggle="modal" data-bs-target="#as-card-modal"><i class="bi bi-plus-lg me-1"></i>{lang key='website/account/cards-add-first'}</button>
                            {/if}
                        </div>

                        {hook name='ui:client.account.cards.after'}
                    </div>
                    {/if}

                    {if $show_verification}
                    <div class="tab-pane fade" id="as-verify" role="tabpanel" aria-labelledby="as-verify-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/account/verify-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/account/verify-sub'}</p>
                            </div>
                        </div>

                        <div class="as-verify-status" data-verify-state="{$verify_state}" data-st-unverified-t="{lang key='website/account/verify-state-unverified-title'}" data-st-unverified-x="{lang key='website/account/verify-state-unverified-text'}" data-st-pending-t="{lang key='website/account/verify-state-pending-title'}" data-st-pending-x="{lang key='website/account/verify-state-pending-text'}" data-st-verified-t="{lang key='website/account/verify-state-verified-title'}" data-st-verified-x="{lang key='website/account/verify-state-verified-text'}" data-st-rejected-t="{lang key='website/account/verify-state-rejected-title'}" data-st-rejected-x="{lang key='website/account/verify-state-rejected-text'}">
                            <span class="as-verify-status-ico"><i class="bi {$verify_state_icon}"></i></span>
                            <div class="as-verify-status-body">
                                <h3 class="as-verify-status-title">{$verify_state_title}</h3>
                                <p class="as-verify-status-text mb-0">{$verify_state_text}</p>
                            </div>
                            {if $verify_total > 0}<span class="as-verify-progress num-tabular">{$verify_done} / {$verify_total}</span>{/if}
                        </div>

                        {if $verify_email_required || $verify_email_verified}
                        <section class="as-card">
                            <div class="as-verify-item" data-verify-anchor="email">
                                <span class="as-item-ico{if $verify_email_verified} as-item-ico-success{/if}"><i class="bi bi-envelope-check"></i></span>
                                <div class="as-item-main">
                                    <div class="as-item-head">
                                        <span class="as-item-name">{lang key='website/account/verify-email-name'}</span>
                                        {if $verify_email_verified}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/account/verify-verified'}</span>{else}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-dash-circle me-1"></i>{lang key='website/account/verify-unverified'}</span>{/if}
                                    </div>
                                    <div class="as-item-meta"><span class="as-item-line">{$verify_email}</span></div>
                                </div>
                                {if !$verify_email_verified && $verify_email_required}
                                <div class="as-item-actions">
                                    <button type="button" class="btn btn-soft btn-sm" data-wui-toggle data-wui-target="#as-email-verify" aria-expanded="false" aria-controls="as-email-verify"><i class="bi bi-shield-check me-1"></i>{lang key='website/account/verify-email-btn'}</button>
                                </div>
                                {/if}
                            </div>
                            {if !$verify_email_verified && $verify_email_required}
                            <div class="wui-collapse" id="as-email-verify">
                                <div class="wui-collapse-inner">
                                    <div class="as-subpanel pt-3">
                                        <div class="row g-3 align-items-end">
                                            <div class="col-sm-7">
                                                <p class="form-label mb-0">{lang key='website/account/verify-email-intro'} <strong>{$verify_email}</strong></p>
                                            </div>
                                            <div class="col-sm-5">
                                                <button type="button" class="btn btn-soft w-100" data-action="as-email-verify-send" data-busy-text="{lang key='website/account/verify-sending'}"><i class="bi bi-send me-1"></i>{lang key='website/account/verify-send-code'}</button>
                                            </div>
                                        </div>
                                        <div class="wui-collapse" id="as-email-vcode">
                                            <div class="wui-collapse-inner">
                                                <div class="pt-3">
                                                    <label class="form-label">{lang key='website/account/verify-code-label'}</label>
                                                    <div class="as-otp" data-as-otp role="group" aria-label="{lang key='website/account/verify-code-label'}">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="one-time-code" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 1">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 2">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 3">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 4">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 5">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 6">
                                                    </div>
                                                    <p class="fs-8 text-body-secondary mt-2 mb-0">{lang key='website/account/verify-email-code-hint'} <button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none align-baseline" data-action="as-email-verify-send" data-busy-text="{lang key='website/account/sending'}">{lang key='website/account/verify-resend'}</button></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            {/if}
                        </section>
                        {/if}

                        {if $verify_phone_enabled || $verify_phone_verified}
                        <section class="as-card">
                            <div class="as-verify-item" data-verify-anchor="phone">
                                <span class="as-item-ico{if $verify_phone_verified} as-item-ico-success{/if}"><i class="bi bi-phone"></i></span>
                                <div class="as-item-main">
                                    <div class="as-item-head">
                                        <span class="as-item-name">{lang key='website/account/verify-phone-name'}</span>
                                        {if $verify_phone_verified}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/account/verify-verified'}</span>{else}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-dash-circle me-1"></i>{lang key='website/account/verify-unverified'}</span>{/if}
                                    </div>
                                    <div class="as-item-meta"><span class="as-item-line">{if $verify_phone_verified}{$verify_phone}{else}{lang key='website/account/verify-phone-add'}{/if}</span></div>
                                </div>
                                {if !$verify_phone_verified && $verify_phone_enabled}
                                <div class="as-item-actions">
                                    <button type="button" class="btn btn-soft btn-sm" data-wui-toggle data-wui-target="#as-phone-verify" aria-expanded="false" aria-controls="as-phone-verify"><i class="bi bi-shield-check me-1"></i>{lang key='website/account/verify-phone-btn'}</button>
                                </div>
                                {/if}
                            </div>
                            {if !$verify_phone_verified && $verify_phone_enabled}
                            <div class="wui-collapse" id="as-phone-verify">
                                <div class="wui-collapse-inner">
                                    <div class="as-subpanel pt-3">
                                        <div class="row g-3 align-items-end">
                                            <div class="col-sm-7">
                                                <label for="as-verify-phone" class="form-label">{lang key='website/account/verify-phone-label'}</label>
                                                <input type="tel" class="form-control" id="as-verify-phone" autocomplete="tel" value="{$verify_phone_raw}">
                                                <input type="hidden" id="as-verify-phone-full">
                                            </div>
                                            <div class="col-sm-5">
                                                <button type="button" class="btn btn-soft w-100" data-action="as-phone-send-code" data-busy-text="{lang key='website/account/verify-sending'}"><i class="bi bi-send me-1"></i>{lang key='website/account/verify-send-code'}</button>
                                            </div>
                                        </div>
                                        <div class="wui-collapse" id="as-phone-code">
                                            <div class="wui-collapse-inner">
                                                <div class="pt-3">
                                                    <label class="form-label">{lang key='website/account/verify-code-label'}</label>
                                                    <div class="as-otp" data-as-otp role="group" aria-label="{lang key='website/account/verify-code-label'}">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="one-time-code" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 1">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 2">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 3">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 4">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 5">
                                                        <input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/account/verify-digit'} 6">
                                                    </div>
                                                    <p class="fs-8 text-body-secondary mt-2 mb-0">{lang key='website/account/verify-code-hint'} <button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none align-baseline" data-action="as-phone-send-code" data-busy-text="{lang key='website/account/sending'}">{lang key='website/account/verify-resend'}</button></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            {/if}
                        </section>
                        {/if}

                        {foreach $verify_fields as $fld}
                        <section class="as-card">
                            <div class="as-verify-item{if !$fld.locked} mb-3{/if}{if $fld.custom_html} align-items-start{/if}" data-verify-anchor="vf-{$fld.id}">
                                <span class="as-item-ico{if $fld.status == 'verified'} as-item-ico-success{/if}"><i class="bi {$fld.icon}"></i></span>
                                <div class="as-item-main">
                                    <div class="as-item-head">
                                        <span class="as-item-name">{$fld.label}</span>
                                        {if $fld.status == 'verified'}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/account/verify-verified'}</span>{elseif $fld.status == 'awaiting'}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/account/verify-in-review'}</span>{elseif $fld.status == 'unverified'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/account/verify-rejected'}</span>{else}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-dash-circle me-1"></i>{lang key='website/account/verify-not-started'}</span>{/if}
                                    </div>
                                    <div class="as-item-meta"><span class="as-item-line">{$fld.hint}</span></div>
                                    {if $fld.custom_html}<div class="mt-3" data-field-type="{$fld.type}">{$fld.custom_html nofilter}</div>{/if}
                                </div>
                            </div>
                            {if !$fld.custom_html && !$fld.locked}
                            <div data-field-type="{$fld.type}">
                                {if $fld.type == 'file'}
                                <label for="as-vf-{$fld.id}" class="form-label">{lang key='website/account/verify-required-info'}{if $fld.required} <span class="text-danger" aria-hidden="true">*</span>{/if}</label>
                                {if $fld.file_name}<p class="fs-8 text-body-secondary mb-2"><i class="bi bi-paperclip me-1"></i>{$fld.file_name}</p>{/if}
                                <div class="file-upload" data-file-upload>
                                    <label class="file-upload-drop" for="as-vf-{$fld.id}">
                                        <input type="file" id="as-vf-{$fld.id}" name="vf_file_{$fld.id}" class="visually-hidden"{if $fld.allowed_ext} accept="{$fld.allowed_ext}"{/if}{if $fld.max_size} data-max-mb="{$fld.max_size}"{/if}{if $fld.required && !$fld.file_name} required{/if}>
                                        <span class="icon-disc"><i class="bi bi-cloud-arrow-up"></i></span>
                                        <span><span class="fw-semibold">{lang key='website/account/verify-browse'}</span> {lang key='website/account/verify-drop'}</span>
                                        {if $fld.allowed_ext || $fld.max_size}<span class="fs-8">{$fld.allowed_ext}{if $fld.allowed_ext && $fld.max_size} · {/if}{if $fld.max_size}{lang key='website/account/verify-max'} {$fld.max_size} MB{/if}</span>{/if}
                                    </label>
                                    <ul class="file-upload-list" data-role="file-list"></ul>
                                </div>
                                {elseif $fld.type == 'textarea'}
                                <label for="as-vf-{$fld.id}" class="form-label">{lang key='website/account/verify-required-info'}</label>
                                <textarea class="form-control" id="as-vf-{$fld.id}" name="vf[{$fld.id}]" rows="3" placeholder="{lang key='website/account/verify-enter-details'}">{$fld.value}</textarea>
                                {elseif $fld.type == 'selectbox'}
                                <label for="as-vf-{$fld.id}" class="form-label">{lang key='website/account/verify-required-info'}{if $fld.required} <span class="text-danger" aria-hidden="true">*</span>{/if}</label>
                                <select class="form-select" id="as-vf-{$fld.id}" name="vf[{$fld.id}]"{if $fld.required} required{/if}>
                                    <option value="">{lang key='website/account/verify-select-option'}</option>
                                    {foreach $fld.options as $opt}<option value="{$opt.value}"{if $opt.selected} selected{/if}>{$opt.value}</option>{/foreach}
                                </select>
                                <div class="invalid-feedback">{lang key='website/account/verify-required-msg'}</div>
                                {elseif $fld.type == 'radio'}
                                <span class="form-label d-block">{lang key='website/account/verify-required-info'}</span>
                                <div class="d-flex flex-wrap gap-3" role="radiogroup" aria-label="{$fld.label}">
                                    {foreach $fld.options as $opt name=ropt}
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="vf[{$fld.id}]" id="as-vf-{$fld.id}-{$smarty.foreach.ropt.index}" value="{$opt.value}"{if $opt.selected} checked{/if}>
                                        <label class="form-check-label" for="as-vf-{$fld.id}-{$smarty.foreach.ropt.index}">{$opt.value}</label>
                                    </div>
                                    {/foreach}
                                </div>
                                {elseif $fld.type == 'checkbox'}
                                <span class="form-label d-block">{lang key='website/account/verify-required-info'}</span>
                                {foreach $fld.options as $opt name=copt}
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="as-vf-{$fld.id}-{$smarty.foreach.copt.index}" name="vf[{$fld.id}][]" value="{$opt.value}"{if $opt.selected} checked{/if}>
                                    <label class="form-check-label" for="as-vf-{$fld.id}-{$smarty.foreach.copt.index}">{$opt.value}</label>
                                </div>
                                {/foreach}
                                {else}
                                <label for="as-vf-{$fld.id}" class="form-label">{lang key='website/account/verify-required-info'}{if $fld.required} <span class="text-danger" aria-hidden="true">*</span>{/if}</label>
                                <input type="text" class="form-control" id="as-vf-{$fld.id}" name="vf[{$fld.id}]" autocomplete="off" value="{$fld.value}"{if $fld.required} required{/if}>
                                <div class="invalid-feedback">{lang key='website/account/verify-required-msg'}</div>
                                {/if}
                            </div>
                            {/if}
                        </section>
                        {/foreach}

                        {if $verify_can_submit}
                        <div class="as-save-bar">
                            <button type="button" class="btn btn-primary" data-action="as-verify-submit" data-busy-text="{lang key='website/account/verify-submitting'}"><i class="bi bi-shield-check me-1"></i>{lang key='website/account/verify-submit'}</button>
                        </div>
                        {/if}
                    </div>
                    {/if}

                    {if $show_activity}
                    <div class="tab-pane fade" id="as-activity" role="tabpanel" aria-labelledby="as-activity-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/account/activity-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/account/activity-sub'}</p>
                            </div>
                            <div class="as-pane-tools">
                                <select class="form-select form-select-sm as-activity-filter" id="as-activity-filter" data-table-filter="account-activity" data-filter-column="type" aria-label="{lang key='website/account/activity-filter-aria'}">
                                    <option value="" selected>{lang key='website/account/activity-filter-all'}</option>
                                    <option value="login">{lang key='website/account/activity-filter-logins'}</option>
                                    <option value="action">{lang key='website/account/activity-filter-actions'}</option>
                                </select>
                                <button type="button" class="btn btn-soft btn-sm" data-action="as-activity-download"><i class="bi bi-download me-1"></i>{lang key='website/account/activity-download'}</button>
                            </div>
                        </div>

                        <section class="as-card">
                            <div class="wcp-table" data-name="account-activity"{if $activity_ajax} data-ajax="{$activity_ajax}"{/if}>
                                <div class="wcp-table-header">
                                    <label class="wcp-entries-label fs-8 text-body-secondary mb-0">
                                        <select class="form-select form-select-sm wcp-entries-select" aria-label="{lang key='website/account/entries-aria'}">
                                            <option value="10">10</option>
                                            <option value="25">25</option>
                                            <option value="50">50</option>
                                            <option value="-1">{lang key='website/account/entries-all'}</option>
                                        </select>
                                        {lang key='website/account/per-page'}
                                    </label>
                                    <div class="as-table-search input-group input-group-sm">
                                        <label class="input-group-text" for="as-activity-search"><i class="bi bi-search"></i></label>
                                        <input type="search" class="form-control wcp-search-input" id="as-activity-search" placeholder="{lang key='website/account/activity-search-ph'}" aria-label="{lang key='website/account/activity-search-ph'}" autocomplete="off">
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead>
                                            <tr>
                                                <th scope="col">{lang key='website/account/activity-th-activity'}</th>
                                                <th scope="col">{lang key='website/account/activity-th-details'}</th>
                                                <th scope="col" class="text-end" data-sortable="desc" data-column="date">{lang key='website/account/activity-th-date'}</th>
                                            </tr>
                                        </thead>
                                        <tbody class="wcp-table-body">
                                            {$activity_html nofilter}
                                        </tbody>
                                        <tbody class="wcp-table-loader-body d-none">
                                            <tr><td colspan="3" class="text-center py-4"><span class="wcp-table-loader spinner-border spinner-border-sm text-secondary" role="status" aria-hidden="true"></span></td></tr>
                                        </tbody>
                                        <tbody class="wcp-table-no-result-body d-none">
                                            <tr><td colspan="3"><div class="wcp-table-no-result basic-empty-state py-4"><i class="bi bi-clock-history" aria-hidden="true"></i><span class="fw-semibold">{lang key='website/account/activity-empty-title'}</span><span class="fs-7">{lang key='website/account/activity-empty-sub'}</span></div></td></tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="wcp-table-footer">
                                    <div class="wcp-table-info fs-8 text-body-secondary" data-msg1="{lang key='website/account/activity-info-empty'}" data-msg2="{lang key='website/account/activity-info-filtered'}" data-msg3="{lang key='website/account/activity-info-showing'}"></div>
                                    <nav class="wcp-table-pagination" aria-label="{lang key='website/account/activity-pages-aria'}">
                                        <ul class="pagination pagination-sm mb-0"></ul>
                                    </nav>
                                </div>
                            </div>
                        </section>
                    </div>
                    {/if}

                    {if $show_messages}
                    <div class="tab-pane fade" id="as-messages" role="tabpanel" aria-labelledby="as-messages-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/account/messages-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/account/messages-sub'}</p>
                            </div>
                        </div>

                        <section class="as-card">
                            <div class="wcp-table" data-name="account-messages"{if $messages_ajax} data-ajax="{$messages_ajax}"{/if}>
                                <div class="wcp-table-header">
                                    <label class="wcp-entries-label fs-8 text-body-secondary mb-0">
                                        <select class="form-select form-select-sm wcp-entries-select" aria-label="{lang key='website/account/entries-aria'}">
                                            <option value="10">10</option>
                                            <option value="25">25</option>
                                            <option value="50">50</option>
                                            <option value="-1">{lang key='website/account/entries-all'}</option>
                                        </select>
                                        {lang key='website/account/per-page'}
                                    </label>
                                    <div class="as-table-search input-group input-group-sm">
                                        <label class="input-group-text" for="as-messages-search"><i class="bi bi-search"></i></label>
                                        <input type="search" class="form-control wcp-search-input" id="as-messages-search" placeholder="{lang key='website/account/messages-search-ph'}" aria-label="{lang key='website/account/messages-search-ph'}" autocomplete="off">
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0 as-messages-table">
                                        <thead>
                                            <tr>
                                                <th scope="col">{lang key='website/account/messages-th-subject'}</th>
                                                <th scope="col">{lang key='website/account/messages-th-channel'}</th>
                                                <th scope="col" class="text-end" data-sortable="desc" data-column="date">{lang key='website/account/messages-th-date'}</th>
                                            </tr>
                                        </thead>
                                        <tbody class="wcp-table-body">
                                            {$messages_html nofilter}
                                        </tbody>
                                        <tbody class="wcp-table-loader-body d-none">
                                            <tr><td colspan="3" class="text-center py-4"><span class="wcp-table-loader spinner-border spinner-border-sm text-secondary" role="status" aria-hidden="true"></span></td></tr>
                                        </tbody>
                                        <tbody class="wcp-table-no-result-body d-none">
                                            <tr><td colspan="3"><div class="wcp-table-no-result basic-empty-state py-4"><i class="bi bi-envelope" aria-hidden="true"></i><span class="fw-semibold">{lang key='website/account/messages-empty-title'}</span><span class="fs-7">{lang key='website/account/messages-empty-sub'}</span></div></td></tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="wcp-table-footer">
                                    <div class="wcp-table-info fs-8 text-body-secondary" data-msg1="{lang key='website/account/messages-info-empty'}" data-msg2="{lang key='website/account/messages-info-filtered'}" data-msg3="{lang key='website/account/messages-info-showing'}"></div>
                                    <nav class="wcp-table-pagination" aria-label="{lang key='website/account/messages-pages-aria'}">
                                        <ul class="pagination pagination-sm mb-0"></ul>
                                    </nav>
                                </div>
                            </div>
                        </section>
                    </div>
                    {/if}

                    {if $show_personal_data}
                    <div class="tab-pane fade" id="as-personal-data" role="tabpanel" aria-labelledby="as-personal-data-tab" tabindex="0" data-gdpr-required="{if $gdpr_required}true{else}false{/if}">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/account/pd-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/account/pd-sub'}</p>
                            </div>
                        </div>

                        <div class="as-panel">
                            <div class="alert alert-warning d-flex gap-2 mt-4{if !($gdpr_required && !$gdpr_consent)} d-none{/if}" role="alert" data-role="as-gdpr-required">
                                <i class="bi bi-exclamation-triangle-fill flex-shrink-0"></i>
                                <span>{lang key='website/account/pd-required-alert'}</span>
                            </div>

                            <section class="as-section">
                                <div class="as-section-aside">
                                    <h3 class="as-section-title">{lang key='website/account/pd-consent-title'}</h3>
                                    <p class="as-section-note">{lang key='website/account/pd-consent-note'}</p>
                                </div>
                                <div class="as-section-body">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" role="switch" id="as-gdpr-consent"{if $gdpr_consent} checked{/if}>
                                        <label class="form-check-label" for="as-gdpr-consent">{lang key='website/account/pd-consent-label-pre'} <a href="{if $gdpr_contract_link}{$gdpr_contract_link}{else}#{/if}"{if $gdpr_contract_link} target="_blank" rel="noopener"{/if}>{lang key='website/account/pd-privacy-policy'}</a> {lang key='website/account/pd-consent-label-post'}</label>
                                    </div>
                                    <p class="fs-8 text-body-secondary mt-3 mb-0{if !$gdpr_consent} d-none{/if}" data-role="as-consent-given"><i class="bi bi-check-circle-fill text-success me-1"></i>{lang key='website/account/pd-consent-given'} <strong class="num-tabular" data-role="as-consent-date">{$gdpr_consent_at}</strong>.</p>
                                    <p class="fs-8 text-warning-emphasis mt-3 mb-0{if $gdpr_consent} d-none{/if}" data-role="as-consent-withdrawn"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/account/pd-consent-withdrawn'}</p>
                                </div>
                            </section>

                            <section class="as-section">
                                <div class="as-section-aside">
                                    <h3 class="as-section-title">{lang key='website/account/pd-download-title'}</h3>
                                    <p class="as-section-note">{lang key='website/account/pd-download-note'}</p>
                                </div>
                                <div class="as-section-body">
                                    <button type="button" class="btn btn-soft" data-action="as-download-data" data-busy-text="{lang key='website/account/pd-download-preparing'}"><i class="bi bi-download me-1"></i>{lang key='website/account/pd-download-btn'}</button>
                                    <p class="fs-8 text-body-secondary mt-2 mb-0">{lang key='website/account/pd-download-includes'}</p>
                                </div>
                            </section>

                            <section class="as-section">
                                <div class="as-section-aside">
                                    <h3 class="as-section-title">{lang key='website/account/pd-removal-title'}</h3>
                                    <p class="as-section-note">{lang key='website/account/pd-removal-note'}</p>
                                </div>
                                <div class="as-section-body" data-role="as-removal" data-removal-state="{$gdpr_removal_state}" data-removal-kind="{$gdpr_removal_kind}" data-removal-reason="{$gdpr_removal_reason}">
                                    <div class="as-verify-status d-none" data-verify-state="warning" data-role="as-removal-status">
                                        <span class="as-verify-status-ico"><i class="bi bi-hourglass-split"></i></span>
                                        <div class="as-verify-status-body">
                                            <h4 class="as-verify-status-title" data-role="as-removal-title"></h4>
                                            <p class="as-verify-status-text mb-0" data-role="as-removal-text"></p>
                                            <p class="as-verify-status-text mb-0 mt-2 d-none" data-role="as-removal-reason"><i class="bi bi-info-circle me-1"></i><span class="fw-semibold">{lang key='website/account/pd-reason-label'}</span> <span data-role="as-removal-reason-text"></span></p>
                                        </div>
                                    </div>

                                    <div class="d-none mb-1" data-role="as-removal-withdraw">
                                        <button type="button" class="btn btn-soft" data-action="as-removal-withdraw"><i class="bi bi-x-circle me-1"></i>{lang key='website/account/pd-withdraw-btn'}</button>
                                    </div>

                                    <div class="as-inset" data-role="as-removal-actions">
                                        <p class="fs-7 mb-3"><i class="bi bi-info-circle text-body-secondary me-1"></i>{lang key='website/account/pd-removal-intro'}</p>
                                        <div class="d-flex flex-wrap gap-2">
                                            <button type="button" class="btn btn-outline-danger" data-action="as-delete-data"><i class="bi bi-trash3 me-1"></i>{lang key='website/account/pd-delete-btn'}</button>
                                            <button type="button" class="btn btn-soft" data-action="as-anonymize-data"><i class="bi bi-incognito me-1"></i>{lang key='website/account/pd-anonymize-btn'}</button>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                    {/if}

                </div>
            </div>
        </div>

        {hook name='ui:client.account.settings.after'}

    </div>
</section>
{/block}

{block name=body_end}
    {include file='components/dash-twofa-modal.tpl' twofa_gate_inline=true}

    {if $show_contacts}
    <div class="modal fade" id="as-profile-modal" tabindex="-1" aria-labelledby="as-profile-modal-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon modal-icon--primary"><i class="bi bi-receipt"></i></span>
                    <div class="modal-titles">
                        <h2 class="modal-title h5" id="as-profile-modal-title" data-role="as-profile-modal-title" data-title-add="{lang key='website/account/contacts-modal-add'}" data-title-edit="{lang key='website/account/contacts-modal-edit'}">{lang key='website/account/contacts-modal-add'}</h2>
                        <p class="modal-subtitle">{lang key='website/account/contacts-modal-sub'}</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/account/cancel'}"></button>
                </div>
                <form id="as-profile-modal-form" novalidate data-country-map="{$contact_country_map}">
                    <input type="hidden" name="id" id="as-prof-id" value="0">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="as-prof-label" class="form-label">{lang key='website/account/contacts-label'} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span></label>
                            <input type="text" class="form-control" id="as-prof-label" name="label" placeholder="{lang key='website/account/contacts-label-ph'}">
                            <div class="form-text">{lang key='website/account/contacts-label-hint'}</div>
                        </div>
                        <div class="row g-3">
                            <div class="col-12">
                                <div class="as-verify-item mb-3">
                                    <span class="as-item-ico"><i class="bi bi-person-vcard"></i></span>
                                    <div class="as-item-main">
                                        <div class="as-item-head"><span class="as-item-name">{lang key='website/account/contacts-type'}</span></div>
                                        <div class="as-item-meta"><span class="as-item-line">{lang key='website/account/contacts-type-hint'}</span></div>
                                    </div>
                                </div>
                                <div class="btn-group as-type-toggle w-100" role="group" aria-label="{lang key='website/account/contacts-type'}">
                                    <input type="radio" class="btn-check" name="profile_type" id="as-prof-individual" value="individual" autocomplete="off" checked>
                                    <label class="btn btn-soft" for="as-prof-individual"><i class="bi bi-person me-1"></i>{lang key='website/account/contacts-individual'}</label>
                                    <input type="radio" class="btn-check" name="profile_type" id="as-prof-company" value="company" autocomplete="off">
                                    <label class="btn btn-soft" for="as-prof-company"><i class="bi bi-building me-1"></i>{lang key='website/account/contacts-company'}</label>
                                </div>
                                <div class="wui-collapse" id="as-prof-company-name-wrap">
                                    <div class="wui-collapse-inner">
                                        <div class="pt-3">
                                            <div class="row g-3">
                                                <div class="col-12">
                                                    <label for="as-prof-company-name" class="form-label">{lang key='website/account/contacts-company-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                                                    <input type="text" class="form-control" id="as-prof-company-name" name="company_name" autocomplete="organization">
                                                    <div class="invalid-feedback">{lang key='website/account/err-contact-company'}</div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="as-prof-tax" class="form-label">{lang key='website/account/contacts-tax-id'} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span></label>
                                                    <input type="text" class="form-control" id="as-prof-tax" name="tax_id" autocomplete="off">
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="as-prof-tax-office" class="form-label">{lang key='website/account/contacts-tax-office'} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span></label>
                                                    <input type="text" class="form-control" id="as-prof-tax-office" name="tax_office" autocomplete="off">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <h3 class="as-modal-section">{lang key='website/account/contacts-details'}</h3>
                            </div>
                            <div class="col-sm-6">
                                <label for="as-prof-first" class="form-label">{lang key='website/account/contacts-first'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="as-prof-first" name="first_name" autocomplete="given-name" required>
                                <div class="invalid-feedback">{lang key='website/account/err-contact-first'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="as-prof-last" class="form-label">{lang key='website/account/contacts-last'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="as-prof-last" name="last_name" autocomplete="family-name" required>
                                <div class="invalid-feedback">{lang key='website/account/err-contact-last'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="as-prof-email" class="form-label">{lang key='website/account/contacts-email'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="email" class="form-control" id="as-prof-email" name="contact_email" autocomplete="email" required>
                                <div class="invalid-feedback">{lang key='website/account/err-contact-email'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="as-prof-phone" class="form-label">{lang key='website/account/contacts-phone'} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span></label>
                                <input type="tel" class="form-control" id="as-prof-phone" autocomplete="tel">
                                <input type="hidden" name="contact_phone" id="as-prof-phone-full">
                            </div>
                            <div class="col-sm-6">
                                <label for="as-prof-national-id" class="form-label">{lang key='website/account/contacts-national'} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span> <i class="bi bi-question-circle text-body-secondary" data-bs-toggle="tooltip" title="{lang key='website/account/contacts-national-tip'}"></i></label>
                                <input type="text" class="form-control" id="as-prof-national-id" name="identity" autocomplete="off">
                            </div>

                            <div class="col-12">
                                <h3 class="as-modal-section">{lang key='website/account/contacts-billing'}</h3>
                            </div>
                            <div class="col-12">
                                <label for="as-prof-address" class="form-label">{lang key='website/account/contacts-address'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="as-prof-address" name="address1" autocomplete="address-line1" placeholder="{lang key='website/account/contacts-address-ph'}" required>
                                <div class="invalid-feedback">{lang key='website/account/err-contact-address'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="as-prof-country" class="form-label">{lang key='website/account/contacts-country'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <select class="form-select" id="as-prof-country" name="country" autocomplete="country" data-basic-select data-flag-select required>
                                    <option value="">{lang key='website/account/contacts-select-country'}</option>
                                    {foreach $contact_countries as $co}<option value="{$co.a2_iso}">{$co.name}</option>{/foreach}
                                </select>
                                <div class="invalid-feedback">{lang key='website/account/err-contact-country'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="as-prof-state" class="form-label">{lang key='website/account/contacts-state'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <select class="form-select" id="as-prof-state" data-basic-select data-placeholder="{lang key='website/account/contacts-select-state'}" disabled>
                                    <option value="">{lang key='website/account/contacts-select-state'}</option>
                                </select>
                                <input type="text" class="form-control d-none" id="as-prof-state-text" placeholder="{lang key='website/account/contacts-state'}" autocomplete="address-level1">
                                <div class="invalid-feedback">{lang key='website/account/err-contact-state'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="as-prof-city" class="form-label">{lang key='website/account/contacts-city'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <select class="form-select" id="as-prof-city" data-basic-select data-placeholder="{lang key='website/account/contacts-select-city'}" disabled>
                                    <option value="">{lang key='website/account/contacts-select-city'}</option>
                                </select>
                                <input type="text" class="form-control d-none" id="as-prof-city-text" placeholder="{lang key='website/account/contacts-city'}" autocomplete="address-level2" required>
                                <div class="invalid-feedback">{lang key='website/account/err-contact-city'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="as-prof-zip" class="form-label">{lang key='website/account/contacts-postcode'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="as-prof-zip" name="postcode" autocomplete="postal-code" required>
                                <div class="invalid-feedback">{lang key='website/account/err-contact-zip'}</div>
                            </div>

                            <div class="col-12">
                                <h3 class="as-modal-section">{lang key='website/account/contacts-settings'}</h3>
                            </div>
                            <div class="col-12">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="as-prof-default" name="set_default" value="1">
                                    <label class="form-check-label fs-7" for="as-prof-default">{lang key='website/account/contacts-set-as-default'}</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="as-prof-update-invoices" name="update_invoices" value="1">
                                    <label class="form-check-label fs-7" for="as-prof-update-invoices">{lang key='website/account/contacts-apply-invoices'}</label>
                                </div>
                            </div>

                            <div class="col-12">
                                <h3 class="as-modal-section">{lang key='website/account/contacts-notif-title'}</h3>
                                <p class="form-text">{lang key='website/account/contacts-notif-sub'}</p>
                                <div class="row g-2">
                                    <div class="col-md-6">
                                        <div class="as-notif-card">
                                            <div class="as-notif-head">
                                                <span class="fw-semibold fs-7"><i class="bi bi-envelope me-2"></i>{lang key='website/account/contacts-notif-email'}</span>
                                                <button type="button" class="btn btn-soft btn-sm fs-8" data-action="as-notif-toggle" data-target="#as-notif-email">{lang key='website/account/contacts-uncheck-all'}</button>
                                            </div>
                                            <div class="as-notif-body" id="as-notif-email">
                                                <div class="row g-1">
                                                    {foreach $notif_categories as $cat}
                                                    <div class="col-6"><div class="form-check"><input class="form-check-input" type="checkbox" id="as-notif-email-{$cat.suffix}" data-notif-email value="{$cat.bit}" checked><label class="form-check-label fs-7" for="as-notif-email-{$cat.suffix}">{$cat.label}</label></div></div>
                                                    {/foreach}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="as-notif-card">
                                            <div class="as-notif-head">
                                                <span class="fw-semibold fs-7"><i class="bi bi-chat-dots me-2"></i>{lang key='website/account/contacts-notif-sms'}</span>
                                                <button type="button" class="btn btn-soft btn-sm fs-8" data-action="as-notif-toggle" data-target="#as-notif-sms">{lang key='website/account/contacts-uncheck-all'}</button>
                                            </div>
                                            <div class="as-notif-body" id="as-notif-sms">
                                                <div class="row g-1">
                                                    {foreach $notif_categories as $cat}
                                                    <div class="col-6"><div class="form-check"><input class="form-check-input" type="checkbox" id="as-notif-sms-{$cat.suffix}" data-notif-sms value="{$cat.bit}" checked><label class="form-check-label fs-7" for="as-notif-sms-{$cat.suffix}">{$cat.label}</label></div></div>
                                                    {/foreach}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary" data-busy-text="{lang key='website/account/contacts-saving'}">{lang key='website/account/contacts-save'}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    {/if}
    {if $show_messages}
    <div class="modal fade" id="as-message-modal" tabindex="-1" aria-labelledby="as-message-modal-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon modal-icon--primary"><i class="bi bi-envelope-open"></i></span>
                    <div class="modal-titles">
                        <h2 class="modal-title h5" id="as-message-modal-title" data-role="as-msg-subject">{lang key='website/account/messages-modal-title'}</h2>
                        <p class="modal-subtitle" data-role="as-msg-meta"></p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/account/cancel'}"></button>
                </div>
                <div class="modal-body">
                    <div class="as-msg-frame-wrap rounded border overflow-hidden">
                        <iframe data-role="as-msg-frame" class="as-msg-frame d-none" title="{lang key='website/account/messages-modal-title'}" referrerpolicy="no-referrer" sandbox="allow-popups allow-popups-to-escape-sandbox"></iframe>
                        <div class="as-msg-body p-3 d-none" data-role="as-msg-text"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {/if}

    {if $show_2fa}
    {if $show_cards && $cards_add_enabled}
    <div class="modal fade" id="as-card-modal" tabindex="-1" aria-labelledby="as-card-modal-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon modal-icon--primary"><i class="bi bi-credit-card"></i></span>
                    <div class="modal-titles">
                        <h2 class="modal-title h5" id="as-card-modal-title">{lang key='website/account/card-modal-title'}</h2>
                        <p class="modal-subtitle">{lang key='website/account/card-modal-sub'}</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/account/card-modal-close'}"></button>
                </div>
                <form id="as-card-form" novalidate{if $cards_hosted_form} data-card-hosted="1"{/if}>
                    <div class="modal-body">
                        <div class="as-card-secure">
                            <i class="bi bi-shield-lock-fill" aria-hidden="true"></i>
                            <span>{lang key='website/account/card-secure'}</span>
                        </div>
                        {if $cards_hosted_form}
                        <div class="alert alert-info d-flex align-items-center mb-0" role="alert">
                            <i class="bi bi-box-arrow-up-right me-2"></i><div>{lang key='website/account/card-hosted-note'}</div>
                        </div>
                        {else}
                        <div class="mb-3">
                            <label for="as-card-number" class="form-label">{lang key='website/account/card-f-number'} <span class="text-danger" aria-hidden="true">*</span></label>
                            <div class="input-group as-card-number-group">
                                <span class="input-group-text"><i class="bi bi-credit-card"></i></span>
                                <input type="text" class="form-control num-tabular" id="as-card-number" name="card_number" inputmode="numeric" autocomplete="cc-number" placeholder="1234 5678 9012 3456" required>
                                <i class="fa-brands as-card-scheme" data-role="as-card-scheme" aria-hidden="true"></i>
                            </div>
                            <div class="invalid-feedback">{lang key='website/account/card-e-number'}</div>
                        </div>
                        <div class="row g-3">
                            <div class="col-6">
                                <label for="as-card-exp" class="form-label">{lang key='website/account/card-f-expiry'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control num-tabular" id="as-card-exp" name="card_expiry" inputmode="numeric" autocomplete="cc-exp" placeholder="MM / YY" required>
                                <div class="invalid-feedback">{lang key='website/account/card-e-expiry'}</div>
                            </div>
                            <div class="col-6">
                                <label for="as-card-cvc" class="form-label">{lang key='website/account/card-f-cvc'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control num-tabular" id="as-card-cvc" name="card_cvc" inputmode="numeric" autocomplete="cc-csc" placeholder="123" required>
                                <div class="invalid-feedback">{lang key='website/account/card-e-cvc'}</div>
                            </div>
                            <div class="col-12">
                                <label for="as-card-name" class="form-label">{lang key='website/account/card-f-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="as-card-name" name="card_name" autocomplete="cc-name" placeholder="Jane Cooper" required>
                                <div class="invalid-feedback">{lang key='website/account/card-e-name'}</div>
                            </div>
                        </div>
                        {/if}
                        {if $cards_autopay_enabled}
                        <div class="form-check mt-3">
                            <input class="form-check-input" type="checkbox" id="as-card-autopay-new" name="auto_pay" value="1">
                            <label class="form-check-label fs-7" for="as-card-autopay-new">{lang key='website/account/card-f-autopay'}</label>
                        </div>
                        {/if}
                    </div>
                    <div class="modal-footer">
                        {if $cards_hosted_form}
                        <button type="submit" class="btn btn-primary" data-busy-text="{lang key='website/account/card-adding'}"><i class="bi bi-box-arrow-up-right me-1"></i>{lang key='website/account/card-hosted-continue'}</button>
                        {else}
                        <button type="submit" class="btn btn-primary" data-busy-text="{lang key='website/account/card-adding'}"><i class="bi bi-plus-lg me-1"></i>{lang key='website/account/cards-add'}</button>
                        {/if}
                    </div>
                </form>
            </div>
        </div>
    </div>
    {/if}

    <div class="modal fade" id="as-2fa-modal" tabindex="-1" aria-labelledby="as-2fa-modal-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon modal-icon--primary"><i class="bi bi-shield-lock"></i></span>
                    <div class="modal-titles">
                        <h2 class="modal-title h5" id="as-2fa-modal-title">{lang key='website/account/2fa-modal-title'}</h2>
                        <p class="modal-subtitle" data-role="as-2fa-step-sub" data-step1="{lang key='website/account/2fa-step1-sub'}" data-step2="{lang key='website/account/2fa-step2-sub'}" data-step3="{lang key='website/account/2fa-step3-sub'}" data-step4="{lang key='website/account/2fa-step-done-sub'}">{lang key='website/account/2fa-step1-sub'}</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/account/cancel'}"></button>
                </div>
                <div class="modal-body">
                    <div data-2fa-step="1">
                        <p class="fs-7 text-body-secondary mb-3">{lang key='website/account/2fa-scan-intro'}</p>
                        <div class="as-2fa-qr">{if $twofa_totp_qr}<img src="{$twofa_totp_qr}" alt="{lang key='website/account/2fa-setup-key-aria'}" width="180" height="180">{/if}</div>
                        <p class="fs-8 text-body-secondary mb-1">{lang key='website/account/2fa-manual-key'}</p>
                        <div class="input-group">
                            <input type="text" class="form-control num-tabular as-secret" id="as-totp-secret" value="{$twofa_totp_secret_preview}" readonly aria-label="{lang key='website/account/2fa-setup-key-aria'}">
                            <button class="btn btn-soft" type="button" data-action="copy" data-copy-text="{$twofa_totp_secret}" aria-label="{lang key='website/account/2fa-copy'}" data-bs-toggle="tooltip" title="{lang key='website/account/2fa-copy'}"><i class="bi bi-clipboard"></i></button>
                        </div>
                    </div>
                    <div data-2fa-step="2" class="d-none text-center">
                        <p class="fs-7 text-body-secondary mb-3">{lang key='website/account/2fa-verify-intro'}</p>
                        <label class="form-label">{lang key='website/account/verification-code'}</label>
                        <div class="as-otp mx-auto" data-as-otp role="group" aria-label="{lang key='website/account/verification-code'}">
                            {for $i=1 to 6}<input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="{if $i == 1}one-time-code{else}off{/if}" maxlength="1" aria-label="{lang key='website/account/digit'} {$i}">{/for}
                        </div>
                        <p class="fs-8 text-body-secondary text-center mt-2 mb-0" data-role="otp-hint">{lang key='website/account/2fa-codes-refresh'}</p>
                        <div class="as-otp-result mt-2 d-none" data-role="otp-result" data-verifying-text="{lang key='website/account/2fa-verifying'}" data-verified-text="{lang key='website/account/2fa-code-verified'}" aria-live="polite"></div>
                    </div>
                    <div data-2fa-step="3" class="d-none">
                        <div class="as-backup-note"><i class="bi bi-info-circle me-2"></i>{lang key='website/account/2fa-recovery-note'}</div>
                        <ul class="as-backup-codes num-tabular" data-role="as-backup-codes"><li>{$twofa_totp_recovery_preview}</li></ul>
                        <div class="d-flex gap-2 mt-3">
                            <button type="button" class="btn btn-soft btn-sm" data-action="as-codes-download"><i class="bi bi-download me-1"></i>{lang key='website/account/2fa-download'}</button>
                            <button type="button" class="btn btn-soft btn-sm" data-action="copy" data-copy-text="{$twofa_totp_recovery}" data-bs-toggle="tooltip" title="{lang key='website/account/2fa-copy'}"><i class="bi bi-clipboard me-1"></i>{lang key='website/account/2fa-copy'}</button>
                        </div>
                    </div>
                    <div data-2fa-step="4" class="d-none text-center">
                        <span class="as-2fa-done-ico"><i class="bi bi-shield-check"></i></span>
                        <h3 class="h5 mt-3 mb-1">{lang key='website/account/2fa-done-title'}</h3>
                        <p class="fs-7 text-body-secondary mb-0">{lang key='website/account/2fa-done-sub'}</p>
                        <div class="as-2fa-trust-note"><i class="bi bi-laptop"></i><span>{lang key='website/account/2fa-trust-note'}</span></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-action="as-2fa-next" data-role="as-2fa-next" data-continue="{lang key='website/account/2fa-continue'}" data-enable="{lang key='website/account/2fa-enable-btn'}" data-done="{lang key='website/account/2fa-done-btn'}">{lang key='website/account/2fa-continue'}</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="as-2fa-disable-modal" tabindex="-1" aria-labelledby="as-2fa-disable-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form id="as-2fa-disable-form" novalidate>
                    <div class="modal-header">
                        <span class="modal-icon modal-icon--danger"><i class="bi bi-shield-exclamation"></i></span>
                        <div class="modal-titles">
                            <h2 class="modal-title h5" id="as-2fa-disable-title">{lang key='website/account/2fa-disable-title'}</h2>
                            <p class="modal-subtitle">{lang key='website/account/2fa-disable-sub'}</p>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/account/cancel'}"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="method" data-role="as-2fa-disable-method" value="{$twofa_active}">
                        {if $twofa_active == 'Totp'}
                        <div data-role="as-2fa-disable-code" class="text-center">
                            <p class="fs-7 text-body-secondary mb-3">{lang key='website/account/2fa-disable-code-intro'}</p>
                            <label class="form-label">{lang key='website/account/verification-code'}</label>
                            <div class="as-otp mx-auto" data-as-otp role="group" aria-label="{lang key='website/account/verification-code'}">
                                {for $i=1 to 6}<input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="{if $i == 1}one-time-code{else}off{/if}" maxlength="1" aria-label="{lang key='website/account/digit'} {$i}">{/for}
                            </div>
                            <p class="fs-8 text-body-secondary text-center mt-2 mb-0"><button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none" data-action="as-2fa-disable-recovery-toggle">{lang key='website/account/2fa-use-recovery'}</button></p>
                        </div>
                        <div data-role="as-2fa-disable-recovery-wrap" class="d-none">
                            <p class="fs-7 text-body-secondary mb-3">{lang key='website/account/2fa-recovery-intro'}</p>
                            <label class="form-label" for="as-2fa-disable-recovery">{lang key='website/account/2fa-recovery-label'}</label>
                            <input type="text" class="form-control num-tabular" id="as-2fa-disable-recovery" name="recovery" autocomplete="off" placeholder="{lang key='website/account/2fa-recovery-ph'}">
                            <p class="fs-8 text-body-secondary mt-2 mb-0"><button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none" data-action="as-2fa-disable-code-toggle">{lang key='website/account/2fa-use-code'}</button></p>
                        </div>
                        {else}
                        <div data-role="as-2fa-disable-send" class="text-center py-3">
                            <span class="icon-disc mb-3"><i class="bi bi-shield-lock"></i></span>
                            <p class="fs-7 text-body-secondary mb-0">{lang key='website/account/2fa-disable-send-intro'}</p>
                        </div>
                        <div data-role="as-2fa-disable-code" class="d-none text-center">
                            <p class="fs-7 text-body-secondary mb-3">{lang key='website/account/2fa-disable-code-sent'}</p>
                            <label class="form-label">{lang key='website/account/verification-code'}</label>
                            <div class="as-otp mx-auto" data-as-otp role="group" aria-label="{lang key='website/account/verification-code'}">
                                {for $i=1 to 6}<input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="{if $i == 1}one-time-code{else}off{/if}" maxlength="1" aria-label="{lang key='website/account/digit'} {$i}">{/for}
                            </div>
                            <p class="fs-8 text-body-secondary text-center mt-2 mb-0"><button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none" data-action="as-2fa-disable-send">{lang key='website/account/2fa-resend'}</button></p>
                        </div>
                        {/if}
                        <div data-role="as-2fa-disable-done" class="d-none text-center">
                            <span class="as-2fa-done-ico as-2fa-done-ico--off"><i class="bi bi-shield-slash"></i></span>
                            <h3 class="h5 mt-3 mb-1">{lang key='website/account/2fa-disabled-title'}</h3>
                            <p class="fs-7 text-body-secondary mb-0">{lang key='website/account/2fa-disabled-sub'}</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-soft" data-bs-dismiss="modal" data-role="as-2fa-disable-cancel">{lang key='website/account/cancel'}</button>
                        <button type="button" class="btn btn-primary{if $twofa_active == 'Totp'} d-none{/if}" data-action="as-2fa-disable-send" data-role="as-2fa-disable-send-btn" data-busy-text="{lang key='website/account/sending'}"><i class="bi bi-send me-1"></i>{lang key='website/account/2fa-send-code'}</button>
                        <button type="submit" class="btn btn-danger{if $twofa_active != 'Totp'} d-none{/if}" data-action="as-2fa-disable-confirm" data-role="as-2fa-disable-confirm-btn" data-busy-text="{lang key='website/account/saving'}">{lang key='website/account/2fa-disable-confirm'}</button>
                        <button type="button" class="btn btn-primary d-none" data-action="as-2fa-disable-done" data-role="as-2fa-disable-done-btn">{lang key='website/account/2fa-done-btn'}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="as-sms-modal" tabindex="-1" aria-labelledby="as-sms-modal-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon modal-icon--primary"><i class="bi bi-chat-dots"></i></span>
                    <div class="modal-titles">
                        <h2 class="modal-title h5" id="as-sms-modal-title">{lang key='website/account/2fa-sms-modal-title'}</h2>
                        <p class="modal-subtitle">{lang key='website/account/2fa-sms-modal-sub'}</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/account/cancel'}"></button>
                </div>
                <div class="modal-body">
                    <div data-sms-step="1">
                        <p class="fs-7 text-body-secondary mb-0">{lang key='website/account/2fa-sms-intro'}</p>
                    </div>
                    <div data-sms-step="2" class="d-none text-center">
                        <p class="fs-7 text-body-secondary mb-3">{lang key='website/account/2fa-sms-code-intro'}</p>
                        <label class="form-label">{lang key='website/account/verification-code'}</label>
                        <div class="as-otp mx-auto" data-as-otp role="group" aria-label="{lang key='website/account/verification-code'}">
                            {for $i=1 to 6}<input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="{if $i == 1}one-time-code{else}off{/if}" maxlength="1" aria-label="{lang key='website/account/digit'} {$i}">{/for}
                        </div>
                        <p class="fs-8 text-body-secondary text-center mt-2 mb-0" data-role="otp-hint"><button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none" data-action="as-sms-resend">{lang key='website/account/2fa-resend'}</button></p>
                        <div class="as-otp-result mt-2 d-none" data-role="otp-result" data-verifying-text="{lang key='website/account/2fa-verifying'}" data-verified-text="{lang key='website/account/2fa-code-verified'}" aria-live="polite"></div>
                    </div>
                    <div data-sms-step="3" class="d-none text-center">
                        <span class="as-2fa-done-ico"><i class="bi bi-shield-check"></i></span>
                        <h3 class="h5 mt-3 mb-1">{lang key='website/account/2fa-sms-done-title'}</h3>
                        <p class="fs-7 text-body-secondary mb-0">{lang key='website/account/2fa-sms-done-sub'}</p>
                        <div class="as-2fa-trust-note"><i class="bi bi-laptop"></i><span>{lang key='website/account/2fa-trust-note'}</span></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-action="as-sms-next" data-role="as-sms-next" data-send="{lang key='website/account/2fa-send-code'}" data-confirm="{lang key='website/account/2fa-confirm'}" data-done="{lang key='website/account/2fa-done-btn'}">{lang key='website/account/2fa-send-code'}</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="as-email2fa-modal" tabindex="-1" aria-labelledby="as-email2fa-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon modal-icon--primary"><i class="bi bi-envelope"></i></span>
                    <div class="modal-titles">
                        <h2 class="modal-title h5" id="as-email2fa-title">{lang key='website/account/2fa-email-modal-title'}</h2>
                        <p class="modal-subtitle">{lang key='website/account/2fa-email-modal-sub'}</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/account/cancel'}"></button>
                </div>
                <div class="modal-body">
                    <div data-email2fa-step="1">
                        <p class="fs-7 text-body-secondary mb-0">{$twofa_email_intro}</p>
                    </div>
                    <div data-email2fa-step="2" class="d-none text-center">
                        <p class="fs-7 text-body-secondary mb-3">{lang key='website/account/2fa-email-code-intro'}</p>
                        <label class="form-label">{lang key='website/account/verification-code'}</label>
                        <div class="as-otp mx-auto" data-as-otp role="group" aria-label="{lang key='website/account/verification-code'}">
                            {for $i=1 to 6}<input type="text" class="form-control as-otp-input" inputmode="numeric" autocomplete="{if $i == 1}one-time-code{else}off{/if}" maxlength="1" aria-label="{lang key='website/account/digit'} {$i}">{/for}
                        </div>
                        <p class="fs-8 text-body-secondary text-center mt-2 mb-0" data-role="otp-hint"><button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none" data-action="as-email2fa-resend">{lang key='website/account/2fa-resend'}</button></p>
                        <div class="as-otp-result mt-2 d-none" data-role="otp-result" data-verifying-text="{lang key='website/account/2fa-verifying'}" data-verified-text="{lang key='website/account/2fa-code-verified'}" aria-live="polite"></div>
                    </div>
                    <div data-email2fa-step="3" class="d-none text-center">
                        <span class="as-2fa-done-ico"><i class="bi bi-shield-check"></i></span>
                        <h3 class="h5 mt-3 mb-1">{lang key='website/account/2fa-email-done-title'}</h3>
                        <p class="fs-7 text-body-secondary mb-0">{lang key='website/account/2fa-email-done-sub'}</p>
                        <div class="as-2fa-trust-note"><i class="bi bi-laptop"></i><span>{lang key='website/account/2fa-trust-note'}</span></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-action="as-email2fa-next" data-role="as-email2fa-next" data-send="{lang key='website/account/2fa-send-code'}" data-confirm="{lang key='website/account/2fa-confirm'}" data-done="{lang key='website/account/2fa-done-btn'}">{lang key='website/account/2fa-send-code'}</button>
                </div>
            </div>
        </div>
    </div>
    {/if}
    {if $show_personal_data}
    <div class="modal fade" id="as-gdpr-modal" tabindex="-1" aria-labelledby="as-gdpr-modal-title" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-icon"><i class="bi bi-shield-lock"></i></span>
                    <div class="modal-titles">
                        <h2 class="modal-title h5" id="as-gdpr-modal-title">{lang key='website/account/pd-modal-title'}</h2>
                        <p class="modal-subtitle">{lang key='website/account/pd-modal-sub'}</p>
                    </div>
                </div>
                <div class="modal-body">
                    <p>{lang key='website/account/pd-modal-body'}</p>
                    <div class="form-check mt-3">
                        <input class="form-check-input" type="checkbox" id="as-gdpr-modal-check">
                        <label class="form-check-label" for="as-gdpr-modal-check">{lang key='website/account/pd-consent-label-pre'} <a href="{if $gdpr_contract_link}{$gdpr_contract_link}{else}#{/if}"{if $gdpr_contract_link} target="_blank" rel="noopener"{/if}>{lang key='website/account/pd-privacy-policy'}</a> {lang key='website/account/pd-consent-label-post'}</label>
                    </div>
                </div>
                <div class="modal-footer">
                    <a href="{link route='sign-out'}" class="btn btn-soft"><i class="bi bi-box-arrow-right me-1"></i>{lang key='website/account/pd-modal-logout'}</a>
                    <button type="button" class="btn btn-primary" data-action="as-gdpr-accept" data-role="as-gdpr-accept-btn" disabled><i class="bi bi-check-lg me-1"></i>{lang key='website/account/pd-modal-accept'}</button>
                </div>
            </div>
        </div>
    </div>
    {/if}
    <script src="{asset path='js/account-settings.js'}" defer></script>
{/block}
