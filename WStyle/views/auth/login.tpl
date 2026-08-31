{extends file='layouts/auth.tpl'}


{block name=stage_title}{lang key='auth_stage_login_title'}{/block}
{block name=stage_text}{lang key='auth_stage_login_text'}{/block}
{block name=stage_foot}{if $registration_enabled}{lang key='auth_stage_login_foot'} <a href="{link route='sign-up'}">{lang key='auth_stage_login_foot_link'}</a>{/if}{/block}

{block name=content}
{if $login_enabled}

    <div data-auth-step="login">
        <div class="text-center mb-4">
            <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/login-heading'}</h1>
            <p class="text-body-secondary mb-0">{lang key='website/sign/login-subtitle'}</p>
        </div>
        {if !empty($sso_error)}
            <div class="auth-alert auth-alert-danger mb-3" role="alert">{$sso_error}</div>
        {/if}
        {if $social_providers || $jetpass_enabled || $passkey_enabled}
        <div class="d-grid gap-2" data-social-providers>
            {if $social_providers}{foreach $social_providers as $p}{$p.button nofilter}{/foreach}{/if}
            {if $passkey_enabled}<button class="btn btn-soft d-inline-flex align-items-center justify-content-center" type="button" data-action="auth-passkey"><i class="bi bi-fingerprint me-2"></i>{lang key='website/sign/login-passkey-cta'}</button>{/if}
            {if $jetpass_enabled}<button class="btn btn-soft d-inline-flex align-items-center justify-content-center" type="button" data-action="auth-code-login"><i class="bi bi-lightning-charge me-2"></i>{lang key='website/sign/login-otc-cta'}</button>{/if}
        </div>
        {if $passkey_enabled}
        <div data-auth-passkey>
            {csrf form='passkey'}
        </div>
        {/if}
        {if $jetpass_enabled}
        <div data-auth-alt>
            {csrf form='jetpass'}
            {captcha area='jetpass' tray='jetpassCaptchaTray'}
        </div>
        {/if}
        <div class="auth-divider my-4" aria-hidden="true"><span>{lang key='website/sign/or'}</span></div>
        {/if}
        <form action="{link route='sign-in'}" method="post" novalidate data-auth-form="login-email">
            <div class="mb-3">
                <label for="login-email" class="form-label">{lang key='website/sign/email-label'}</label>
                <input type="email" class="form-control" id="login-email" name="email"{if $demo_mode} value="{$demo_credentials.client.email}"{/if} placeholder="{lang key='website/sign/email-placeholder'}" autocomplete="username" required>
                <div class="invalid-feedback">{lang key='website/sign/email-invalid'}</div>
            </div>
            <button class="btn btn-primary w-100" type="submit">{lang key='website/sign/login-continue'}</button>
        </form>
        {hook name='ui:client.login.form.bottom'}
        {if $registration_enabled}<p class="text-center fs-7 text-body-secondary mt-4 mb-0 d-lg-none">{lang key='website/sign/login-new-here'} <a class="fw-semibold text-decoration-none" href="{link route='sign-up'}">{lang key='website/sign/login-create-account'}</a></p>{/if}
    </div>

    <div class="d-none" data-auth-step="password">
        <div class="text-center mb-4">
            <span class="auth-icon"><i class="bi bi-person"></i></span>
            <h2 class="h3 tracking-tight mb-2">{lang key='website/sign/login-password-heading'}</h2>
            <p class="fs-7 text-body-secondary mb-0">{lang key='website/sign/login-password-as'} <strong data-role="login-email-echo">{lang key='website/sign/email-placeholder'}</strong>. <button class="btn btn-link btn-sm fs-7 p-0 fw-semibold text-decoration-none align-baseline" type="button" data-action="auth-step" data-step="login">{lang key='website/sign/login-not-you'}</button></p>
        </div>
        <form action="{link route='sign-in'}" method="post" novalidate data-auth-form="login">
            <div class="auth-alert auth-alert-danger d-none mb-3" role="alert" data-role="login-error">
                <i class="bi bi-exclamation-triangle-fill"></i>
                <span>{lang key='website/sign/login-error'}</span>
            </div>
            <div class="auth-alert auth-alert-warning d-none mb-3" role="alert" data-role="login-lock">
                <i class="bi bi-shield-lock-fill"></i>
                <span>{lang key='website/sign/login-lock-before'} <span class="num-tabular fw-semibold" data-role="login-lock-timer">0:30</span>.</span>
            </div>
            <div class="mb-3">
                <div class="d-flex align-items-baseline justify-content-between">
                    <label for="login-password" class="form-label">{lang key='website/sign/password-label'}</label>
                    <a class="fs-8 fw-semibold text-decoration-none" href="{link route='sign-forget'}">{lang key='website/sign/login-forgot'}</a>
                </div>
                <div class="input-group">
                    <input type="password" class="form-control" id="login-password" name="password"{if $demo_mode} value="{$demo_credentials.client.password}"{/if} autocomplete="current-password" required>
                    <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/sign/password-show'}"><i class="bi bi-eye"></i></button>
                </div>
                <div class="invalid-feedback">{lang key='website/sign/login-password-required'}</div>
            </div>
            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" id="login-remember" name="remember">
                <label class="form-check-label fs-7" for="login-remember">{lang key='website/sign/login-remember'}</label>
            </div>
            {csrf form='sign-in'}
            {captcha area='sign-in'}
            <button class="btn btn-primary w-100" type="submit" data-success="{lang key='website/sign/login-success'}">{lang key='website/sign/login-submit'}</button>
        </form>
    </div>

    <div class="d-none" data-auth-step="totp">
        <div class="text-center mb-4">
            <span class="auth-icon"><i class="bi bi-shield-lock"></i></span>
            <h2 class="h3 tracking-tight mb-2">{lang key='website/sign/totp-heading'}</h2>
            <p class="text-body-secondary mb-0">{lang key='website/sign/totp-subtitle'}</p>
        </div>
        <form action="{link route='sign-in'}" method="post" novalidate data-auth-form="totp">
            <fieldset class="mb-3" data-role="totp-code">
                <legend class="visually-hidden">{lang key='website/sign/otp-legend'}</legend>
                <div class="otp-group" dir="ltr" data-otp>
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="one-time-code" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 1">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 2">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 3">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 4">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 5">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 6">
                </div>
                <div class="invalid-feedback text-center mt-2" data-role="otp-feedback" data-msg-empty="{lang key='website/sign/otp-feedback-empty'}" data-msg-wrong="{lang key='website/sign/otp-feedback-wrong-app'}">{lang key='website/sign/otp-feedback-empty'}</div>
                <div class="valid-feedback text-center mt-2" data-role="otp-valid">{lang key='website/sign/otp-valid'}</div>
            </fieldset>
            <div class="mb-3 d-none" data-role="totp-recovery">
                <p class="fs-7 text-body-secondary mb-2">{lang key='website/sign/totp-recovery-intro'}</p>
                <label class="form-label" for="totp-recovery-key">{lang key='website/sign/totp-recovery-label'}</label>
                <input type="text" class="form-control num-tabular" id="totp-recovery-key" name="recovery_key" autocomplete="off" placeholder="{lang key='website/sign/totp-recovery-ph'}">
                <div class="invalid-feedback" data-role="recovery-feedback">{lang key='website/sign/totp-recovery-invalid'}</div>
            </div>
            {if $trust_window > 0}
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="totp-trust" name="trust_device" value="1" data-role="trust-device">
                    <label class="form-check-label fs-7" for="totp-trust">{$trust_label}</label>
                </div>
            {/if}
            {csrf form='sign-in'}
            {captcha area='sign-in'}
            <button class="btn btn-primary w-100" type="submit">{lang key='website/sign/otp-verify'}</button>
        </form>
        <p class="fs-7 text-body-secondary text-center mt-3 mb-0"><button class="btn btn-link btn-sm p-0 fs-7 fw-semibold text-decoration-none align-baseline" type="button" data-action="totp-recovery-toggle" data-role="totp-to-recovery">{lang key='website/sign/totp-recovery'}</button><button class="btn btn-link btn-sm p-0 fs-7 fw-semibold text-decoration-none align-baseline d-none" type="button" data-action="totp-recovery-toggle" data-role="totp-to-code">{lang key='website/sign/totp-use-code'}</button></p>
        <p class="text-center fs-7 text-body-secondary mt-4 mb-0"><button class="btn btn-link btn-sm p-0 fs-7 fw-semibold text-decoration-none align-baseline" type="button" data-action="auth-step" data-step="login">{lang key='website/sign/back-to-login'}</button></p>
    </div>

    <div class="d-none" data-auth-step="sms">
        <div class="text-center mb-4">
            <span class="auth-icon"><i class="bi bi-chat-dots"></i></span>
            <h2 class="h3 tracking-tight mb-2">{lang key='website/sign/sms-heading'}</h2>
            <p class="text-body-secondary mb-0">{lang key='website/sign/sms-subtitle'} <span class="num-tabular">0199</span>.</p>
        </div>
        <form action="{link route='sign-in'}" method="post" novalidate data-auth-form="sms">
            <fieldset class="mb-3">
                <legend class="visually-hidden">{lang key='website/sign/otp-legend'}</legend>
                <div class="otp-group" dir="ltr" data-otp>
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="one-time-code" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 1">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 2">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 3">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 4">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 5">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 6">
                </div>
                <div class="invalid-feedback text-center mt-2" data-role="otp-feedback" data-msg-empty="{lang key='website/sign/otp-feedback-empty'}" data-msg-wrong="{lang key='website/sign/otp-feedback-wrong-sms'}">{lang key='website/sign/otp-feedback-empty'}</div>
                <div class="valid-feedback text-center mt-2" data-role="otp-valid">{lang key='website/sign/otp-valid'}</div>
            </fieldset>
            {if $trust_window > 0}
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="sms-trust" name="trust_device" value="1" data-role="trust-device">
                    <label class="form-check-label fs-7" for="sms-trust">{$trust_label}</label>
                </div>
            {/if}
            {csrf form='sign-in'}
            {captcha area='sign-in'}
            <button class="btn btn-primary w-100" type="submit">{lang key='website/sign/otp-verify'}</button>
        </form>
        <p class="fs-7 text-body-secondary text-center mt-3 mb-0">{lang key='website/sign/sms-resend-prompt'} <button class="btn btn-link btn-sm p-0 fs-7 fw-semibold text-decoration-none align-baseline" type="button" data-action="auth-resend" disabled>{lang key='website/sign/otp-resend'}</button><span class="num-tabular" data-role="resend-timer"> (30)</span></p>
        <p class="fs-8 text-success fw-semibold text-center d-none mt-2 mb-0" data-role="resend-confirm"><i class="bi bi-check-circle me-1"></i>{lang key='website/sign/otp-resent'}</p>
        <p class="text-center fs-7 text-body-secondary mt-4 mb-0"><button class="btn btn-link btn-sm p-0 fs-7 fw-semibold text-decoration-none align-baseline" type="button" data-action="auth-step" data-step="login">{lang key='website/sign/back-to-login'}</button></p>
    </div>

    <div class="d-none" data-auth-step="email">
        <div class="text-center mb-4">
            <span class="auth-icon"><i class="bi bi-envelope-paper"></i></span>
            <h2 class="h3 tracking-tight mb-2">{lang key='website/sign/email-heading'}</h2>
            <p class="text-body-secondary mb-0">{lang key='website/sign/email-subtitle'} <span class="fw-semibold" data-role="masked-email">j•••@example.com</span>.</p>
        </div>
        <form action="{link route='sign-in'}" method="post" novalidate data-auth-form="email">
            <fieldset class="mb-3">
                <legend class="visually-hidden">{lang key='website/sign/otp-legend'}</legend>
                <div class="otp-group" dir="ltr" data-otp>
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="one-time-code" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 1">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 2">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 3">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 4">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 5">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 6">
                </div>
                <div class="invalid-feedback text-center mt-2" data-role="otp-feedback" data-msg-empty="{lang key='website/sign/otp-feedback-empty'}" data-msg-wrong="{lang key='website/sign/otp-feedback-wrong-email'}">{lang key='website/sign/otp-feedback-empty'}</div>
                <div class="valid-feedback text-center mt-2" data-role="otp-valid">{lang key='website/sign/otp-valid'}</div>
            </fieldset>
            {if $trust_window > 0}
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="email-trust" name="trust_device" value="1" data-role="trust-device">
                    <label class="form-check-label fs-7" for="email-trust">{$trust_label}</label>
                </div>
            {/if}
            {csrf form='sign-in'}
            {captcha area='sign-in'}
            <button class="btn btn-primary w-100" type="submit">{lang key='website/sign/otp-verify'}</button>
        </form>
        <p class="fs-7 text-body-secondary text-center mt-3 mb-0">{lang key='website/sign/sms-resend-prompt'} <button class="btn btn-link btn-sm p-0 fs-7 fw-semibold text-decoration-none align-baseline" type="button" data-action="auth-resend" disabled>{lang key='website/sign/otp-resend'}</button><span class="num-tabular" data-role="resend-timer"> (30)</span></p>
        <p class="fs-8 text-success fw-semibold text-center d-none mt-2 mb-0" data-role="resend-confirm"><i class="bi bi-check-circle me-1"></i>{lang key='website/sign/otp-resent'}</p>
        <p class="text-center fs-7 text-body-secondary mt-4 mb-0"><button class="btn btn-link btn-sm p-0 fs-7 fw-semibold text-decoration-none align-baseline" type="button" data-action="auth-step" data-step="login">{lang key='website/sign/back-to-login'}</button></p>
    </div>

    <div class="d-none" data-auth-step="code-login">
        <div class="text-center mb-4">
            <span class="auth-icon"><i class="bi bi-envelope-paper"></i></span>
            <h2 class="h3 tracking-tight mb-2">{lang key='website/sign/codelogin-heading'}</h2>
            <p class="text-body-secondary mb-0">{lang key='website/sign/codelogin-subtitle'} <span class="fw-semibold" data-role="masked-email">j•••@example.com</span>. {lang key='website/sign/codelogin-subtitle-2'}</p>
        </div>
        <form action="{link route='sign-in'}" method="post" novalidate data-auth-form="code-login">
            <fieldset class="mb-3">
                <legend class="visually-hidden">{lang key='website/sign/codelogin-legend'}</legend>
                <div class="otp-group" dir="ltr" data-otp>
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="one-time-code" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 1">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 2">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 3">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 4">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 5">
                    <input type="text" class="form-control otp-input" inputmode="numeric" autocomplete="off" maxlength="1" aria-label="{lang key='website/sign/otp-digit'} 6">
                </div>
                <div class="invalid-feedback text-center mt-2" data-role="otp-feedback" data-msg-empty="{lang key='website/sign/otp-feedback-empty'}" data-msg-wrong="{lang key='website/sign/otp-feedback-wrong-email'}">{lang key='website/sign/otp-feedback-empty'}</div>
                <div class="valid-feedback text-center mt-2" data-role="otp-valid">{lang key='website/sign/otp-valid'}</div>
            </fieldset>
            {csrf form='jetpass'}
            {captcha area='jetpass'}
            <button class="btn btn-primary w-100" type="submit">{lang key='website/sign/codelogin-submit'}</button>
        </form>
        <p class="fs-7 text-body-secondary text-center mt-3 mb-0">{lang key='website/sign/sms-resend-prompt'} <button class="btn btn-link btn-sm p-0 fs-7 fw-semibold text-decoration-none align-baseline" type="button" data-action="auth-resend" disabled>{lang key='website/sign/otp-resend'}</button><span class="num-tabular" data-role="resend-timer"> (30)</span></p>
        <p class="fs-8 text-success fw-semibold text-center d-none mt-2 mb-0" data-role="resend-confirm"><i class="bi bi-check-circle me-1"></i>{lang key='website/sign/otp-resent'}</p>
        <p class="text-center fs-7 text-body-secondary mt-4 mb-0"><button class="btn btn-link btn-sm p-0 fs-7 fw-semibold text-decoration-none align-baseline" type="button" data-action="auth-step" data-step="login">{lang key='website/sign/back-to-login'}</button></p>
    </div>

    <div class="d-none" data-auth-step="restricted">
        <div class="text-center mb-4">
            <span class="auth-icon auth-icon-danger"><i class="bi bi-shield-exclamation"></i></span>
            <h2 class="h3 tracking-tight mb-2">{lang key='website/sign/restricted-heading'}</h2>
            <p class="text-body-secondary mb-0" data-role="restricted-reason">{lang key='website/sign/restricted-reason-line1'}<br>{lang key='website/sign/restricted-reason-line2'}</p>
        </div>
        <div class="d-grid gap-2">
            <a class="btn btn-primary" href="{link route='contact'}"><i class="bi bi-headset me-2"></i>{lang key='website/sign/restricted-contact'}</a>
            <button class="btn btn-soft" type="button" data-action="auth-step" data-step="login">{lang key='website/sign/back-to-login'}</button>
        </div>
    </div>

{else}
    <div class="text-center">
        <span class="auth-icon"><i class="bi bi-pause-circle"></i></span>
        <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/login-disabled-heading'}</h1>
        <p class="text-body-secondary mb-4">{lang key='website/sign/login-disabled-text'}</p>
        <a class="btn btn-primary" href="{link route='home'}">{lang key='website/sign/login-disabled-home'}</a>
    </div>
{/if}
{/block}
