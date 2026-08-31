{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/auth.css'}">
{/block}

{block name=content}

    <section class="py-5">
        <div class="container">
            <div class="auth-card mx-auto" data-invite-page data-invite-url="{link route='accept-invite' p1=$invite_token}" data-home-url="{link route='home'}" data-dashboard-url="{link route='my-account'}" data-signin-url="{link route='sign-in'}">

                {if $invite_state == 'invalid'}
                <div class="text-center mb-4">
                    <span class="auth-icon auth-icon-danger"><i class="bi bi-link-45deg"></i></span>
                    <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/invite-invalid-heading'}</h1>
                    <p class="text-body-secondary mb-0">{lang key='website/sign/invite-invalid-text'}</p>
                </div>
                <div class="card">
                    <div class="card-body p-4">
                        <a class="btn btn-primary w-100" href="{link route='home'}">{lang key='website/sign/invite-go-home'}</a>
                    </div>
                </div>

                {elseif $invite_state == 'mismatch'}
                <div class="text-center mb-4">
                    <span class="auth-icon auth-icon-danger"><i class="bi bi-person-x"></i></span>
                    <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/invite-mismatch-heading'}</h1>
                    <p class="text-body-secondary mb-0">{lang key='website/sign/invite-mismatch-text' email=$invite_email current=$invite_current_email}</p>
                </div>
                <div class="card">
                    <div class="card-body p-4">
                        <div class="d-grid gap-2">
                            <a class="btn btn-primary" href="{link route='sign-out'}"><i class="bi bi-box-arrow-right me-2"></i>{lang key='website/sign/invite-logout-switch'}</a>
                            <a class="btn btn-soft" href="{link route='my-account'}">{lang key='website/sign/invite-go-dashboard'}</a>
                        </div>
                    </div>
                </div>

                {elseif $invite_state == 'confirm'}
                <div class="text-center mb-4">
                    <span class="auth-icon"><i class="bi bi-person-check"></i></span>
                    <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/invite-confirm-heading'}</h1>
                    <p class="text-body-secondary mb-0">{lang key='website/sign/invite-confirm-subtitle' owner=$invite_owner}</p>
                </div>
                <div class="card">
                    <div class="card-body p-4">
                        {include file='components/invite-access.tpl'}
                        <form data-invite-form="confirm" novalidate>
                            <input type="hidden" name="operation" value="accept_invite">
                            <input type="hidden" name="invite" value="{$invite_token}">
                            {csrf form='accept-invite'}
                            <button class="btn btn-primary w-100" type="submit"><i class="bi bi-check-lg me-1"></i>{lang key='website/sign/invite-accept-cta'}</button>
                        </form>
                        <p class="text-center fs-8 text-body-secondary mt-3 mb-0"><a class="text-decoration-none" href="{link route='my-account'}">{lang key='website/sign/invite-decline'}</a></p>
                        {hook name='ui:client.auth.invite.actions.after'}
                    </div>
                </div>

                {elseif $invite_state == 'signin'}
                <div class="text-center mb-4">
                    <span class="auth-icon"><i class="bi bi-box-arrow-in-right"></i></span>
                    <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/invite-signin-heading'}</h1>
                    <p class="text-body-secondary mb-0">{lang key='website/sign/invite-signin-subtitle' owner=$invite_owner email=$invite_email}</p>
                </div>
                <div class="card">
                    <div class="card-body p-4">
                        {include file='components/invite-access.tpl'}
                        <form data-invite-form="signin" novalidate>
                            <div class="auth-alert auth-alert-danger d-none mb-3" role="alert" data-role="invite-error">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                <span data-role="invite-error-text">{lang key='website/sign/invite-signin-error'}</span>
                            </div>
                            <div class="mb-3">
                                <label for="invite-email" class="form-label">{lang key='website/sign/email-label'}</label>
                                <input type="email" class="form-control" id="invite-email" name="email" value="{$invite_email}" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="invite-password" class="form-label">{lang key='website/sign/password-label'}</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="invite-password" name="password" autocomplete="current-password" required>
                                    <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/sign/password-show'}"><i class="bi bi-eye"></i></button>
                                </div>
                                <div class="invalid-feedback">{lang key='website/sign/login-password-required'}</div>
                            </div>
                            <input type="hidden" name="operation" value="login">
                            {csrf form='sign-in'}
                            <button class="btn btn-primary w-100" type="submit">{lang key='website/sign/invite-signin-cta'}</button>
                        </form>
                        <p class="text-center fs-8 text-body-secondary mt-3 mb-0"><a class="text-decoration-none" href="{link route='sign-forget'}">{lang key='website/sign/login-forgot'}</a></p>
                    </div>
                </div>

                {else}
                <div class="text-center mb-4">
                    <span class="auth-icon"><i class="bi bi-person-plus"></i></span>
                    <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/invite-register-heading'}</h1>
                    <p class="text-body-secondary mb-0">{lang key='website/sign/invite-register-subtitle' owner=$invite_owner}</p>
                </div>
                <div class="card">
                    <div class="card-body p-4">
                        {include file='components/invite-access.tpl'}
                        <form data-invite-form="register" novalidate data-txt-password-short="{lang key='website/sign/invite-password-short' min=$password_min_length}" data-txt-password-mismatch="{lang key='website/sign/invite-password-mismatch'}">
                            <div class="auth-alert auth-alert-danger d-none mb-3" role="alert" data-role="invite-error">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                <span data-role="invite-error-text"></span>
                            </div>
                            <div class="mb-3">
                                <label for="invite-reg-email" class="form-label">{lang key='website/sign/email-label'}</label>
                                <input type="email" class="form-control" id="invite-reg-email" value="{$invite_email}" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="invite-reg-name" class="form-label">{lang key='website/sign/invite-name-label'}</label>
                                <input type="text" class="form-control" id="invite-reg-name" name="name" autocomplete="name" placeholder="{lang key='website/sign/invite-name-placeholder'}">
                            </div>
                            <div class="mb-3" data-password-field>
                                <label for="invite-reg-password" class="form-label">{lang key='website/sign/invite-password-label'}</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="invite-reg-password" name="password" autocomplete="new-password" minlength="{$password_min_length}" required>
                                    <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/sign/password-show'}"><i class="bi bi-eye"></i></button>
                                    <button class="btn btn-soft" type="button" data-action="password-generate" data-bs-toggle="tooltip" title="{lang key='website/sign/password-generate'}"><i class="bi bi-stars"></i></button>
                                    <button class="btn btn-soft" type="button" data-action="password-copy" data-bs-toggle="tooltip" title="{lang key='website/sign/password-copy'}"><i class="bi bi-clipboard"></i></button>
                                </div>
                                <div class="basic-password-strength" data-strength="0" data-labels="|{lang key='website/sign/password-strength-weak'}|{lang key='website/sign/password-strength-fair'}|{lang key='website/sign/password-strength-good'}|{lang key='website/sign/password-strength-strong'}">
                                    <span class="strength-bar"></span><span class="strength-bar"></span>
                                    <span class="strength-bar"></span><span class="strength-bar"></span>
                                </div>
                                <small class="text-body-secondary" data-role="strength-label"></small>
                                <div class="form-text">{lang key='website/sign/invite-password-hint' min=$password_min_length}</div>
                            </div>
                            <div class="mb-3">
                                <label for="invite-reg-password2" class="form-label">{lang key='website/sign/invite-password-confirm-label'}</label>
                                <input type="password" class="form-control" id="invite-reg-password2" name="password_confirm" autocomplete="new-password" required>
                            </div>
                            <input type="hidden" name="operation" value="accept_invite_register">
                            <input type="hidden" name="invite" value="{$invite_token}">
                            {csrf form='accept-invite'}
                            <button class="btn btn-primary w-100" type="submit"><i class="bi bi-check-lg me-1"></i>{lang key='website/sign/invite-register-cta'}</button>
                        </form>
                    </div>
                </div>
                {/if}

            </div>
        </div>
    </section>

{/block}

{block name=body_end}
<script src="{asset path='js/accept-invite.js'}" defer></script>
{/block}
