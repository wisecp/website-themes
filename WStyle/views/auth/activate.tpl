{extends file='layouts/auth.tpl'}

{block name=stage_title}{lang key='auth_stage_login_title'}{/block}
{block name=stage_text}{lang key='auth_stage_login_text'}{/block}

{block name=content}

    <div class="text-center">
        {if !empty($activation_done)}
        <span class="auth-icon"><i class="bi bi-check-circle"></i></span>
        <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/activate-done-heading'}</h1>
        <p class="text-body-secondary mb-4">{lang key='website/sign/verify-success'}</p>
        <a class="btn btn-primary" href="{link route='my-account'}">{lang key='website/sign/activate-go-account'}</a>
        {else}
        <span class="auth-icon"><i class="bi bi-x-circle"></i></span>
        <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/activate-invalid-heading'}</h1>
        <p class="text-body-secondary mb-4">{lang key='website/sign/activate-invalid-text'}</p>
        <a class="btn btn-primary" href="{link route='sign-in'}">{lang key='website/sign/activate-back-to-login'}</a>
        {/if}
    </div>

{/block}
