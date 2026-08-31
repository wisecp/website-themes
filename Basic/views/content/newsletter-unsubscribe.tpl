{extends file='layouts/default.tpl'}

{block name=title}{lang key='website/newsletter/meta/title'}{/block}

{block name=head}
<link rel="stylesheet" href="{asset path='css/auth.css'}">
{/block}

{block name=content}
<section class="py-5">
    <div class="container">
        <div class="auth-card mx-auto">

            {if $unsub_mode == 'confirm'}
                <div class="text-center mb-4">
                    <span class="auth-icon"><i class="bi bi-envelope-dash"></i></span>
                    <h1 class="h3 tracking-tight mb-2">{lang key='website/newsletter/confirm-title'}</h1>
                    <p class="text-body-secondary mb-0">{lang key='website/newsletter/confirm-desc'}</p>
                </div>
                <div class="card"><div class="card-body p-4">
                    {if $request_error}<div class="alert alert-danger d-flex align-items-center mb-3" role="alert"><i class="bi bi-exclamation-triangle me-2"></i>{$request_error}</div>{/if}
                    <div class="nl-address-row mb-3">
                        <span class="nl-address-label">{lang key='website/newsletter/confirm-email-label'}</span>
                        <span class="nl-address-value">{$unsub_email}</span>
                    </div>
                    <form method="post" action="{$canonical_link}">
                        {csrf form='newsletter-unsub'}
                        <input type="hidden" name="op" value="confirm">
                        <input type="hidden" name="utoken" value="{$unsub_token}">
                        <button class="btn btn-primary w-100" type="submit">{lang key='website/newsletter/confirm-button'}</button>
                    </form>
                    <p class="fs-7 text-body-secondary text-center mt-3 mb-0">{lang key='website/newsletter/confirm-note'}</p>
                </div></div>

            {elseif $unsub_mode == 'success'}
                <div class="text-center mb-4">
                    <span class="auth-icon auth-icon-success"><i class="bi bi-check-lg"></i></span>
                    <h1 class="h3 tracking-tight mb-2">{lang key='website/newsletter/unsub-success-title'}</h1>
                    <p class="text-body-secondary mb-0">{if $success_exact}{lang key='website/newsletter/unsub-success-desc'}{else}{lang key='website/newsletter/request-success-desc' email=$success_email}{/if}</p>
                </div>
                <div class="card"><div class="card-body p-4">
                    <div class="nl-address-row mb-3">
                        <span class="nl-address-label">{lang key='website/newsletter/success-removed-label'}</span>
                        <span class="nl-address-value">{$success_email}</span>
                    </div>
                    <a href="{link route='home'}" class="btn btn-soft w-100">{lang key='website/newsletter/back-home'}</a>
                </div></div>

            {elseif $unsub_mode == 'invalid'}
                <div class="text-center mb-4">
                    <span class="auth-icon auth-icon-danger"><i class="bi bi-x-lg"></i></span>
                    <h1 class="h3 tracking-tight mb-2">{lang key='website/newsletter/unsub-invalid-title'}</h1>
                    <p class="text-body-secondary mb-0">{lang key='website/newsletter/unsub-invalid-desc'}</p>
                </div>
                <div class="card"><div class="card-body p-4">
                    <a href="{$canonical_link}" class="btn btn-primary w-100 mb-2">{lang key='website/newsletter/invalid-request-button'}</a>
                    <a href="{link route='home'}" class="btn btn-soft w-100">{lang key='website/newsletter/back-home'}</a>
                </div></div>

            {else}
                <div class="text-center mb-4">
                    <span class="auth-icon"><i class="bi bi-envelope-dash"></i></span>
                    <h1 class="h3 tracking-tight mb-2">{lang key='website/newsletter/request-title'}</h1>
                    <p class="text-body-secondary mb-0">{lang key='website/newsletter/request-desc'}</p>
                </div>
                <div class="card"><div class="card-body p-4">
                    {if $request_error}<div class="alert alert-danger d-flex align-items-center mb-3" role="alert"><i class="bi bi-exclamation-triangle me-2"></i>{$request_error}</div>{/if}
                    <form method="post" action="{$canonical_link}">
                        {csrf form='newsletter-unsub'}
                        <input type="hidden" name="op" value="request">
                        <div class="mb-3">
                            <label class="form-label" for="nl-unsub-email">{lang key='website/newsletter/request-email-label'}</label>
                            <input type="email" class="form-control" id="nl-unsub-email" name="email" placeholder="{lang key='website/newsletter/request-email-placeholder'}" autocomplete="email" required>
                        </div>
                        {captcha area='newsletter' tray='nlUnsubCaptchaTray'}
                        <button class="btn btn-primary w-100" type="submit">{lang key='website/newsletter/request-button'}</button>
                    </form>
                    <p class="fs-7 text-body-secondary text-center mt-3 mb-0">{lang key='website/newsletter/confirm-note'}</p>
                </div></div>
            {/if}

        </div>
    </div>
</section>
{/block}
