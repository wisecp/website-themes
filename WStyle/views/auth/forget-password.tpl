{extends file='layouts/auth.tpl'}


{block name=stage_title}{lang key='auth_stage_forget_title'}{/block}
{block name=stage_text}{lang key='auth_stage_forget_text'}{/block}

{block name=content}

    <div data-auth-step="request">
        <div class="text-center mb-4">
            <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/forget-heading'}</h1>
            <p class="text-body-secondary mb-0">{lang key='website/sign/forget-subtitle'}</p>
        </div>
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
        <p class="text-center fs-7 text-body-secondary mt-4 mb-0">{lang key='website/sign/forget-remembered'} <a class="fw-semibold text-decoration-none" href="{link route='sign-in'}">{lang key='website/sign/forget-login'}</a></p>
    </div>

    <div class="d-none" data-auth-step="sent">
        <div class="text-center mb-4">
            <span class="auth-icon"><i class="bi bi-envelope-check"></i></span>
            <h2 class="h3 tracking-tight mb-2">{lang key='website/sign/forget-sent-heading'}</h2>
            <p class="text-body-secondary mb-0">{lang key='website/sign/forget-sent-subtitle'} <strong data-role="reset-email">{lang key='website/sign/email-placeholder'}</strong>{lang key='website/sign/forget-sent-subtitle-2'}</p>
        </div>
        <div class="text-center">
            <p class="fs-7 text-body-secondary mb-3">{lang key='website/sign/forget-sent-note'}</p>
            <button class="btn btn-soft w-100" type="button" data-action="auth-resend-email">{lang key='website/sign/forget-sent-resend'}</button>
            <p class="fs-8 text-success fw-semibold d-none mt-2 mb-0" data-role="resend-confirm"><i class="bi bi-check-circle me-1"></i>{lang key='website/sign/forget-sent-resent'}</p>
        </div>
        <p class="text-center fs-7 text-body-secondary mt-4 mb-0"><a class="fw-semibold text-decoration-none" href="{link route='sign-in'}">{lang key='website/sign/back-to-login'}</a></p>
    </div>

{/block}
