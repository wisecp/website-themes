{extends file='layouts/auth.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='js/libs/tom-select/tom-select.bootstrap5.min.css'}">
<link rel="stylesheet" href="{asset path='js/libs/intl-tel-input/css/intlTelInput.min.css'}">
<script src="{asset path='js/libs/tom-select/tom-select.complete.min.js'}" defer></script>
<script src="{asset path='js/libs/intl-tel-input/js/intlTelInput.min.js'}" defer></script>
<script src="{asset path='js/geo-country.js'}" defer></script>
{/block}

{block name=scripts}<script src="{asset path='js/register.js'}" defer></script>{/block}

{block name=split_class} is-form-heavy{/block}
{block name=inner_class} auth-form-inner-wide{/block}

{block name=stage_title}{lang key='auth_stage_register_title'}{/block}
{block name=stage_text}{lang key='auth_stage_register_text'}{/block}
{block name=stage_foot}{if $login_enabled}{lang key='auth_stage_register_foot'} <a href="{link route='sign-in'}">{lang key='auth_stage_register_foot_link'}</a>{/if}{/block}

{block name=content}
{if $registration_enabled || !empty($verify_pending)}

    <div data-register-step="form"{if !empty($verify_pending)} class="d-none"{/if}>
        <div class="auth-head">
            <h1 class="auth-title">{lang key='website/sign/register-heading'}</h1>
        </div>
        {if $social_providers}
        <hr>
        <div class="d-grid d-sm-flex gap-2 mb-3" data-social-providers>
            {foreach $social_providers as $p}{$p.button nofilter}{/foreach}
        </div>
        <div class="auth-divider mb-1" aria-hidden="true"><span>{lang key='auth_register_or_email'}</span></div>
        {/if}
        <form action="{link route='sign-up'}" method="post" novalidate data-register-form data-password-min="{$registration.password_min_length}" data-msg-invalid="{lang key='website/sign/register-form-invalid'}">

            {if $registration.account_type_visible}
            <section class="reg-step">
                <div class="reg-step-head">
                    <span class="reg-step-num num-tabular" aria-hidden="true"><span class="reg-step-n"></span><i class="bi bi-check-lg reg-step-done-icon"></i></span>
                    <h2 class="h6 fw-semibold mb-0">{lang key='website/sign/register-acct-title'}</h2>
                </div>
                <div class="btn-group w-100" role="group" aria-label="{lang key='website/sign/register-acct-title'}">
                    <input type="radio" class="btn-check" name="account_type" id="acct-individual" value="individual" checked>
                    <label class="btn btn-soft" for="acct-individual"><i class="bi bi-person me-1"></i>{lang key='website/sign/register-acct-individual'}</label>
                    <input type="radio" class="btn-check" name="account_type" id="acct-company" value="company">
                    <label class="btn btn-soft" for="acct-company"><i class="bi bi-building me-1"></i>{lang key='website/sign/register-acct-company'}</label>
                </div>
                <div class="wui-collapse" id="company-fields"><div class="wui-collapse-inner">
                    <div class="pt-3">
                        <div class="mb-3">
                            <label for="reg-company" class="form-label">{lang key='website/sign/register-company-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                            <input type="text" class="form-control" id="reg-company" name="company_name" autocomplete="organization">
                            <div class="invalid-feedback">{lang key='website/sign/register-company-name-invalid'}</div>
                        </div>
                        <div class="row g-3">
                            <div class="col-sm-6">
                                <label for="reg-tax" class="form-label">{lang key='website/sign/register-tax'} {if $registration.tax_number_required}<span class="text-danger" aria-hidden="true">*</span>{else}<span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span>{/if}</label>
                                <input type="text" class="form-control" id="reg-tax" name="tax_number" autocomplete="off"{if $registration.tax_number_required} data-required="1"{/if}>
                            </div>
                            <div class="col-sm-6">
                                <label for="reg-tax-office" class="form-label">{lang key='website/sign/register-tax-office'} {if $registration.tax_office_required}<span class="text-danger" aria-hidden="true">*</span>{else}<span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span>{/if}</label>
                                <input type="text" class="form-control" id="reg-tax-office" name="tax_office" autocomplete="off"{if $registration.tax_office_required} data-required="1"{/if}>
                            </div>
                        </div>
                    </div>
                </div></div>
            </section>
            {else}
            <input type="hidden" name="account_type" value="individual">
            {/if}

            <section class="reg-step">
                <div class="reg-step-head">
                    <span class="reg-step-num num-tabular" aria-hidden="true"><span class="reg-step-n"></span><i class="bi bi-check-lg reg-step-done-icon"></i></span>
                    <h2 class="h6 fw-semibold mb-0">{lang key='website/sign/register-details-title'}</h2>
                </div>
                <div class="row g-3 mb-3">
                    <div class="col-sm-6">
                        <label for="reg-first-name" class="form-label">{lang key='website/sign/register-first-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                        <input type="text" class="form-control" id="reg-first-name" name="first_name" autocomplete="given-name" required>
                        <div class="invalid-feedback">{lang key='website/sign/register-first-name-invalid'}</div>
                    </div>
                    <div class="col-sm-6">
                        <label for="reg-last-name" class="form-label">{lang key='website/sign/register-last-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                        <input type="text" class="form-control" id="reg-last-name" name="last_name" autocomplete="family-name" required>
                        <div class="invalid-feedback">{lang key='website/sign/register-last-name-invalid'}</div>
                    </div>
                </div>
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label for="reg-email" class="form-label">{lang key='website/sign/email-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                        <input type="email" class="form-control" id="reg-email" name="email" placeholder="{lang key='website/sign/email-placeholder'}" autocomplete="email" required>
                        <div class="invalid-feedback">{lang key='website/sign/email-invalid'}</div>
                    </div>
                    {if $registration.phone_visible}
                    <div class="col-sm-6">
                        <label for="reg-phone" class="form-label">{lang key='website/sign/register-phone'} {if $registration.phone_required}<span class="text-danger" aria-hidden="true">*</span>{else}<span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span>{/if}</label>
                        <input type="tel" class="form-control" id="reg-phone" autocomplete="tel"{if $registration.phone_required} data-required="1"{/if}>
                        <div class="invalid-feedback">{lang key='website/sign/register-phone-invalid'}</div>
                        <input type="hidden" name="phone" id="reg-phone-full">
                    </div>
                    {/if}
                </div>
                {if $registration.landline_visible}
                <div class="row g-3 mt-0">
                    <div class="col-sm-6">
                        <label for="reg-landline" class="form-label">{lang key='website/sign/register-landline'} {if $registration.landline_required}<span class="text-danger" aria-hidden="true">*</span>{else}<span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span>{/if}</label>
                        <input type="tel" class="form-control" id="reg-landline" name="landline_phone" autocomplete="tel"{if $registration.landline_required} data-required="1"{/if}>
                        <div class="invalid-feedback">{lang key='website/sign/register-landline-invalid'}</div>
                    </div>
                </div>
                {/if}
            </section>

            <section class="reg-step">
                <div class="reg-step-head">
                    <span class="reg-step-num num-tabular" aria-hidden="true"><span class="reg-step-n"></span><i class="bi bi-check-lg reg-step-done-icon"></i></span>
                    <h2 class="h6 fw-semibold mb-0">{lang key='website/sign/register-billing-title'}</h2>
                </div>
                <div class="mb-3">
                    <label for="reg-address1" class="form-label">{lang key='website/sign/register-address'} <span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span></label>
                    <input type="text" class="form-control" id="reg-address1" name="address1" autocomplete="address-line1">
                    <div class="invalid-feedback">{lang key='website/sign/register-address-invalid'}</div>
                </div>
                <div class="row g-3 mb-3">
                    <div class="col-sm-6">
                        <label for="reg-country" class="form-label">{lang key='website/sign/register-country'} <span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span></label>
                        <select class="form-select" id="reg-country" name="country" data-wstyle-select data-flag-select autocomplete="country">
                            {foreach $countries as $c}
                            <option value="{$c.a2_iso}">{$c.name}</option>
                            {/foreach}
                        </select>
                        <div class="invalid-feedback">{lang key='website/sign/register-country-invalid'}</div>
                    </div>
                    <div class="col-sm-6">
                        <label for="reg-state" class="form-label">{lang key='website/sign/register-state'} <span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span></label>
                        <select class="form-select" id="reg-state" name="state" data-wstyle-select disabled>
                            <option value="">{lang key='website/sign/register-state-placeholder'}</option>
                        </select>
                        <input type="text" class="form-control d-none" id="reg-state-text" name="state_text" autocomplete="address-level1" placeholder="{lang key='website/sign/register-state'}">
                    </div>
                </div>
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label for="reg-city" class="form-label">{lang key='website/sign/register-city'} <span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span></label>
                        <select class="form-select" id="reg-city" name="city" data-wstyle-select disabled>
                            <option value="">{lang key='website/sign/register-city-placeholder'}</option>
                        </select>
                        <input type="text" class="form-control d-none" id="reg-city-text" name="city_text" autocomplete="address-level2" placeholder="{lang key='website/sign/register-city'}">
                    </div>
                    <div class="col-sm-6">
                        <label for="reg-postal" class="form-label">{lang key='website/sign/register-postal'} <span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span></label>
                        <input type="text" class="form-control" id="reg-postal" name="postal_code" autocomplete="postal-code">
                        <div class="invalid-feedback">{lang key='website/sign/register-postal-invalid'}</div>
                    </div>
                </div>
            </section>

            {if $registration.identity_visible || $custom_fields}
            <section class="reg-step">
                <div class="reg-step-head">
                    <span class="reg-step-num num-tabular" aria-hidden="true"><span class="reg-step-n"></span><i class="bi bi-check-lg reg-step-done-icon"></i></span>
                    <h2 class="h6 fw-semibold mb-0">{lang key='website/sign/register-additional-title'}</h2>
                </div>
                <div class="row g-3 align-items-end">
                    {if $registration.identity_visible}
                    <div class="col-sm-6">
                        <label for="reg-national-id" class="form-label mb-0">{lang key='website/sign/register-national-id'} {if $registration.identity_required}<span class="text-danger" aria-hidden="true">*</span>{else}<span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span>{/if}</label>
                        <button class="btn btn-link p-0 ms-1 fs-7 align-baseline" type="button" data-bs-toggle="tooltip" title="{lang key='website/sign/register-national-id-tip'}"><i class="bi bi-info-circle"></i></button>
                        <input type="text" class="form-control mt-2" id="reg-national-id" name="identity" autocomplete="off"{if $registration.identity_required} data-required="1"{/if}>
                    </div>
                    {/if}
                    {foreach $custom_fields as $field}
                    <div class="{if $field.type == 'textarea'}col-12{else}col-sm-6{/if}">
                        {if $field.type == 'checkbox'}
                        <div class="form-check pt-4 mt-1">
                            <input class="form-check-input" type="checkbox" id="custom-field-{$field.id}" name="field_{$field.id}" value="1"{if $field.required} data-required="1"{/if}>
                            <label class="form-check-label fs-7" for="custom-field-{$field.id}">{$field.name}{if $field.required} <span class="text-danger" aria-hidden="true">*</span>{/if}</label>
                        </div>
                        {else}
                        <label for="custom-field-{$field.id}" class="form-label">{$field.name} {if $field.required}<span class="text-danger" aria-hidden="true">*</span>{else}<span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span>{/if}</label>
                        {if $field.type == 'textarea'}
                        <textarea class="form-control" id="custom-field-{$field.id}" name="field_{$field.id}" rows="3"{if $field.required} data-required="1"{/if}></textarea>
                        {elseif $field.type == 'select'}
                        <select class="form-select" id="custom-field-{$field.id}" name="field_{$field.id}" data-wstyle-select{if $field.required} data-required="1"{/if}>
                            <option value="">{lang key='website/sign/register-select-placeholder'}</option>
                            {foreach $field.options_list as $option}
                            <option value="{$option}">{$option}</option>
                            {/foreach}
                        </select>
                        {elseif $field.type == 'radio'}
                        <div class="d-flex flex-wrap gap-3 pt-1">
                            {foreach $field.options_list as $index => $option}
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="field_{$field.id}" id="custom-field-{$field.id}-{$index}" value="{$option}">
                                <label class="form-check-label" for="custom-field-{$field.id}-{$index}">{$option}</label>
                            </div>
                            {/foreach}
                        </div>
                        {elseif $field.type == 'date'}
                        <input type="date" class="form-control" id="custom-field-{$field.id}" name="field_{$field.id}"{if $field.required} data-required="1"{/if}>
                        {else}
                        <input type="text" class="form-control" id="custom-field-{$field.id}" name="field_{$field.id}"{if $field.required} data-required="1"{/if}>
                        {/if}
                        {/if}
                    </div>
                    {/foreach}
                </div>
            </section>
            {/if}

            <section class="reg-step">
                <div class="reg-step-head">
                    <span class="reg-step-num num-tabular" aria-hidden="true"><span class="reg-step-n"></span><i class="bi bi-check-lg reg-step-done-icon"></i></span>
                    <h2 class="h6 fw-semibold mb-0">{lang key='website/sign/register-security-title'}</h2>
                </div>
                <div data-password-field>
                    <label for="reg-password" class="form-label">{lang key='website/sign/password-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="reg-password" name="password" autocomplete="new-password" required>
                        <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/sign/password-show'}"><i class="bi bi-eye"></i></button>
                        <button class="btn btn-soft" type="button" data-action="password-generate" data-bs-toggle="tooltip" title="{lang key='website/sign/password-generate'}"><i class="bi bi-stars"></i></button>
                        <button class="btn btn-soft" type="button" data-action="password-copy" data-bs-toggle="tooltip" title="{lang key='website/sign/password-copy'}"><i class="bi bi-clipboard"></i></button>
                    </div>
                    <div class="wstyle-password-strength" data-strength="0" data-labels="|{lang key='website/sign/password-strength-weak'}|{lang key='website/sign/password-strength-fair'}|{lang key='website/sign/password-strength-good'}|{lang key='website/sign/password-strength-strong'}">
                        <span class="strength-bar"></span><span class="strength-bar"></span>
                        <span class="strength-bar"></span><span class="strength-bar"></span>
                    </div>
                    <small class="text-body-secondary" data-role="strength-label"></small>
                    <div class="invalid-feedback">{lang key='website/sign/register-password-invalid'}</div>
                </div>
            </section>

            <section class="reg-step">
                <div class="reg-step-head">
                    <span class="reg-step-num num-tabular" aria-hidden="true"><span class="reg-step-n"></span><i class="bi bi-check-lg reg-step-done-icon"></i></span>
                    <h2 class="h6 fw-semibold mb-0">{lang key='website/sign/register-comm-title'}</h2>
                </div>
                <div class="form-check mb-2">
                    <input class="form-check-input" type="checkbox" id="reg-consent-email" name="marketing_email">
                    <label class="form-check-label fs-7" for="reg-consent-email">{lang key='website/sign/register-marketing-email'}</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="reg-consent-sms" name="marketing_sms">
                    <label class="form-check-label fs-7" for="reg-consent-sms">{lang key='website/sign/register-marketing-sms'}</label>
                </div>
            </section>

            <section class="reg-step">
                <span class="reg-step-num" aria-hidden="true"><i class="bi bi-check-lg"></i></span>
                {if $contracts}
                <div class="reg-step-head">
                    <h2 class="h6 fw-semibold mb-0">{lang key='website/sign/register-contracts-title'}</h2>
                </div>
                <div class="accordion accordion-flush border rounded overflow-hidden mb-3" id="reg-contracts">
                    {foreach $contracts as $contract}
                    <div class="accordion-item">
                        <h3 class="accordion-header">
                            <button class="accordion-button collapsed fs-7 fw-semibold py-2" type="button" data-wui-toggle data-wui-target="#contract-{$contract.id}" aria-expanded="false" aria-controls="contract-{$contract.id}">
                                <i class="bi bi-file-earmark-text me-2"></i>{$contract.title}
                            </button>
                        </h3>
                        <div id="contract-{$contract.id}" class="wui-collapse" data-wui-parent="#reg-contracts"><div class="wui-collapse-inner">
                            <div class="accordion-body contract-scroll overflow-auto">{$contract.content nofilter}</div>
                        </div></div>
                    </div>
                    {/foreach}
                </div>
                {capture name=contract_links}{foreach $contracts as $contract}<a class="fw-semibold text-decoration-none" href="{$contract.link}" target="_blank" rel="noopener">{$contract.title}</a>{if !$contract@last}, {/if}{/foreach}{/capture}
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="reg-terms" name="terms" required>
                    <label class="form-check-label fs-7" for="reg-terms">{lang key='website/sign/register-contracts-accept' contracts=$smarty.capture.contract_links} <span class="text-danger" aria-hidden="true">*</span></label>
                    <div class="invalid-feedback">{lang key='website/sign/register-terms-invalid'}</div>
                </div>
                {/if}
                {csrf form='sign-up'}
                {captcha area='sign-up'}
                <div class="wui-collapse" data-role="reg-alert">
                    <div class="wui-collapse-inner">
                        <div class="pb-3">
                            <div class="auth-alert auth-alert-danger" role="alert" aria-live="assertive" data-role="reg-alert-box">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                <span data-role="reg-alert-msg"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="btn btn-primary w-100" type="submit">{lang key='website/sign/register-submit'}</button>
            </section>

        </form>
        {hook name='ui:client.register.form.bottom'}
        {if $login_enabled}<p class="text-center fs-7 text-body-secondary mt-4 mb-0 d-lg-none">{lang key='website/sign/register-have-account'} <a class="fw-semibold text-decoration-none" href="{link route='sign-in'}">{lang key='website/sign/register-login'}</a></p>{/if}
    </div>

    <div data-register-step="verify"{if empty($verify_pending)} class="d-none"{/if}>
        <div class="auth-card mx-auto">
        <div class="text-center mb-4">
            <span class="auth-icon"><i class="bi bi-envelope-check"></i></span>
            <h2 class="h3 tracking-tight mb-2">{lang key='website/sign/register-verify-heading'}</h2>
            <p class="text-body-secondary mb-0">{lang key='website/sign/register-verify-subtitle'} <strong data-role="register-email-echo">{if !empty($verify_email)}{$verify_email}{else}{lang key='website/sign/email-placeholder'}{/if}</strong>. {lang key='website/sign/register-verify-subtitle-2'}</p>
        </div>
        <form data-verify-form>
            <label for="reg-verify-code" class="form-label">{lang key='website/sign/register-verify-code-label'}</label>
            <div class="input-group mb-3">
                <input type="text" inputmode="numeric" autocomplete="one-time-code" class="form-control" id="reg-verify-code" name="code" maxlength="6" placeholder="------">
                <button class="btn btn-primary" type="submit" data-done-label="{lang key='website/sign/register-verify-code-done'}">{lang key='website/sign/register-verify-code-submit'}</button>
            </div>
            <input type="hidden" name="email" data-role="verify-email" value="{if !empty($verify_email)}{$verify_email}{/if}">
            {csrf form='sign-verify'}
        </form>
        <div class="card">
            <div class="card-body p-4 text-center">
                <p class="fs-7 text-body-secondary mb-3">{lang key='website/sign/register-verify-note'}</p>
                <div class="wui-collapse" data-role="verify-alert">
                    <div class="wui-collapse-inner">
                        <div class="pb-3">
                            <div class="auth-alert auth-alert-danger" role="alert" aria-live="assertive">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                <span></span>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="btn btn-soft w-100" type="button" data-action="register-resend" data-wait-label="{lang key='website/sign/register-verify-resend-wait'}">{lang key='website/sign/register-verify-resend'}</button>
                <p class="fs-8 text-success fw-semibold d-none mt-2 mb-0" data-role="resend-confirm"><i class="bi bi-check-circle me-1"></i>{lang key='website/sign/register-verify-resent'}</p>
            </div>
        </div>
        </div>
    </div>

    <div class="d-none" data-register-step="ready">
        <div class="auth-card mx-auto">
        <div class="text-center mb-4">
            <span class="auth-icon auth-icon-success"><i class="bi bi-check-circle"></i></span>
            <h2 class="h3 tracking-tight mb-2">{lang key='website/sign/register-ready-heading'}</h2>
            <p class="text-body-secondary mb-0">{lang key='website/sign/register-ready-subtitle'} <strong data-role="register-name-echo">{if !empty($verify_name)}{$verify_name}{/if}</strong>! {lang key='website/sign/register-ready-subtitle-2'}</p>
        </div>
        <div class="card mb-4">
            <div class="card-body p-4 d-flex align-items-center gap-3 text-start">
                <span class="icon-disc"><i class="bi bi-rocket-takeoff"></i></span>
                <div>
                    <span class="fw-semibold d-block">{lang key='website/sign/register-ready-launch-title'}</span>
                    <span class="fs-8 text-body-secondary">{lang key='website/sign/register-ready-launch-desc'}</span>
                </div>
            </div>
        </div>
        <div class="d-grid">
            <a class="btn btn-primary" href="{link route='my-account'}" data-role="register-dashboard-link">{lang key='website/sign/register-ready-cta'}<i class="bi bi-arrow-right ms-2"></i></a>
        </div>
        <p class="fs-8 text-body-secondary text-center mt-3 mb-0"><span class="spinner-border spinner-border-sm me-2" aria-hidden="true"></span>{lang key='website/sign/register-ready-redirect'}</p>
        </div>
    </div>

{else}
    <div class="text-center">
        <span class="auth-icon"><i class="bi bi-pause-circle"></i></span>
        <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/register-disabled-heading'}</h1>
        <p class="text-body-secondary mb-4">{lang key='website/sign/register-disabled-text'}</p>
        <a class="btn btn-primary" href="{link route='sign-in'}">{lang key='website/sign/register-disabled-login'}</a>
    </div>
{/if}
{/block}
