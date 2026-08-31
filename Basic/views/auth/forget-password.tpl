{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/auth.css'}">
{/block}

{block name=content}

    <section class="py-5">
        <div class="container">
            <div class="auth-card mx-auto">

                <div data-auth-step="request">
                    <div class="text-center mb-4">
                        <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/forget-heading'}</h1>
                        <p class="text-body-secondary mb-0">{lang key='website/sign/forget-subtitle'}</p>
                    </div>
                    <div class="card">
                        <div class="card-body p-4">
                            <form action="{link route='sign-forget'}" method="post" novalidate data-auth-form="request">
                                <div class="mb-3">
                                    <label for="fp-email" class="form-label">{lang key='website/sign/email-label'}</label>
                                    <input type="email" class="form-control" id="fp-email" name="email" placeholder="{lang key='website/sign/email-placeholder'}" autocomplete="email" required>
                                    <div class="invalid-feedback">{lang key='website/sign/email-invalid'}</div>
                                </div>
                                {csrf form='sign-forget'}
                                {captcha area='sign-forget'}
                                <button class="btn btn-primary w-100" type="submit">{lang key='website/sign/forget-submit'}</button>
                            </form>
                            {hook name='ui:client.auth.forget.form.bottom'}
                        </div>
                    </div>
                    <p class="text-center fs-7 text-body-secondary mt-4 mb-0">{lang key='website/sign/forget-remembered'} <a class="fw-semibold text-decoration-none" href="{link route='sign-in'}">{lang key='website/sign/forget-login'}</a></p>
                </div>

                <div class="d-none" data-auth-step="sent">
                    <div class="text-center mb-4">
                        <span class="auth-icon"><i class="bi bi-envelope-check"></i></span>
                        <h2 class="h3 tracking-tight mb-2">{lang key='website/sign/forget-sent-heading'}</h2>
                        <p class="text-body-secondary mb-0">{lang key='website/sign/forget-sent-subtitle'} <strong data-role="reset-email">{lang key='website/sign/email-placeholder'}</strong>{lang key='website/sign/forget-sent-subtitle-2'}</p>
                    </div>
                    <div class="card">
                        <div class="card-body p-4 text-center">
                            <p class="fs-7 text-body-secondary mb-3">{lang key='website/sign/forget-sent-note'}</p>
                            <button class="btn btn-soft w-100" type="button" data-action="auth-resend-email">{lang key='website/sign/forget-sent-resend'}</button>
                            <p class="fs-8 text-success fw-semibold d-none mt-2 mb-0" data-role="resend-confirm"><i class="bi bi-check-circle me-1"></i>{lang key='website/sign/forget-sent-resent'}</p>
                        </div>
                    </div>
                    <p class="text-center fs-7 text-body-secondary mt-4 mb-0"><a class="fw-semibold text-decoration-none" href="{link route='sign-in'}">{lang key='website/sign/back-to-login'}</a></p>
                </div>

            </div>
        </div>
    </section>

{/block}

{block name=body_end}
<script src="{asset path='js/auth.js'}" defer></script>
{/block}
