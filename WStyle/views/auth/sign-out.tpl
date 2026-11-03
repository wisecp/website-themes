{extends file='layouts/auth.tpl'}

{block name=stage_title}{lang key='auth_stage_login_title'}{/block}
{block name=stage_text}{lang key='auth_stage_login_text'}{/block}

{block name=content}

    <div class="text-center mb-4">
        <span class="auth-icon"><i class="bi bi-box-arrow-right"></i></span>
        <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/out-heading'}</h1>
        <p class="text-body-secondary mb-0">{lang key='website/sign/out-subtitle'}</p>
    </div>
    <form action="{$sign_out_action}" method="post">
        {csrf form='sign-out'}
        <button class="btn btn-primary w-100" type="submit">{lang key='website/index/account-logout'}</button>
    </form>
    <p class="text-center fs-7 text-body-secondary mt-4 mb-0"><a class="fw-semibold text-decoration-none" href="{$stay_link}">{lang key='website/sign/out-stay'}</a></p>

{/block}
