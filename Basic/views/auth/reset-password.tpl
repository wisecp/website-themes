{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/auth.css'}">
{/block}

{block name=content}

    <section class="py-5">
        <div class="container">
            <div class="auth-card mx-auto">

                {if $reset_valid}
                <div data-auth-step="reset">
                    <div class="text-center mb-4">
                        <span class="auth-icon"><i class="bi bi-key"></i></span>
                        <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/reset-heading'}</h1>
                        <p class="text-body-secondary mb-0">{lang key='website/sign/reset-subtitle'}</p>
                    </div>
                    <div class="card">
                        <div class="card-body p-4">
                            <form action="{link route='sign-reset'}" method="post" novalidate data-auth-form="reset">
                                <input type="hidden" name="verify" value="{$verify_key}">
                                <div class="mb-3" data-password-field>
                                    <label for="reset-password" class="form-label">{lang key='website/sign/reset-new-password'}</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="reset-password" name="password" autocomplete="new-password" required>
                                        <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/sign/password-show'}"><i class="bi bi-eye"></i></button>
                                        <button class="btn btn-soft" type="button" data-action="password-generate" data-bs-toggle="tooltip" title="{lang key='website/sign/password-generate'}"><i class="bi bi-stars"></i></button>
                                        <button class="btn btn-soft" type="button" data-action="password-copy" data-bs-toggle="tooltip" title="{lang key='website/sign/password-copy'}"><i class="bi bi-clipboard"></i></button>
                                    </div>
                                    <div class="basic-password-strength" data-strength="0" data-labels="|{lang key='website/sign/password-strength-weak'}|{lang key='website/sign/password-strength-fair'}|{lang key='website/sign/password-strength-good'}|{lang key='website/sign/password-strength-strong'}">
                                        <span class="strength-bar"></span><span class="strength-bar"></span>
                                        <span class="strength-bar"></span><span class="strength-bar"></span>
                                    </div>
                                    <small class="text-body-secondary" data-role="strength-label"></small>
                                    <div class="invalid-feedback">{lang key='website/sign/reset-password-invalid'}</div>
                                </div>
                                <div class="mb-3">
                                    <label for="reset-confirm" class="form-label">{lang key='website/sign/reset-confirm'}</label>
                                    <input type="password" class="form-control" id="reset-confirm" name="password_confirm" autocomplete="new-password" required>
                                    <div class="invalid-feedback">{lang key='website/sign/reset-confirm-invalid'}</div>
                                </div>
                                {csrf form='sign-reset'}
                                <button class="btn btn-primary w-100" type="submit">{lang key='website/sign/reset-submit'}</button>
                            </form>
                            {hook name='ui:client.auth.reset.form.bottom'}
                        </div>
                    </div>
                </div>
                {else}
                <div data-auth-step="invalid">
                    <div class="text-center mb-4">
                        <span class="auth-icon auth-icon-danger"><i class="bi bi-x-octagon"></i></span>
                        <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/reset-invalid-heading'}</h1>
                        <p class="text-body-secondary mb-0">{lang key='website/sign/reset-invalid-subtitle'}</p>
                    </div>
                    <a class="btn btn-primary w-100" href="{link route='sign-forget'}">{lang key='website/sign/reset-invalid-action'}</a>
                </div>
                {/if}

                <div class="d-none" data-auth-step="done">
                    <div class="text-center mb-4">
                        <span class="auth-icon auth-icon-success"><i class="bi bi-check-circle"></i></span>
                        <h2 class="h3 tracking-tight mb-2">{lang key='website/sign/reset-done-heading'}</h2>
                        <p class="text-body-secondary mb-0">{lang key='website/sign/reset-done-subtitle'}</p>
                    </div>
                    <a class="btn btn-primary w-100" href="{link route='sign-in'}">{lang key='website/sign/reset-done-login'}</a>
                </div>

            </div>
        </div>
    </section>

{/block}

{block name=body_end}
<script src="{asset path='js/auth.js'}" defer></script>
{/block}
