{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/auth.css'}">
{/block}

{block name=content}

    <section class="py-5">
        <div class="container">
            <div class="auth-card mx-auto">

                {if $secure_valid}
                <div data-auth-step="done">
                    <div class="text-center mb-4">
                        <span class="auth-icon auth-icon-success"><i class="bi bi-shield-check"></i></span>
                        <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/secure-done-heading'}</h1>
                        <p class="text-body-secondary mb-0">{lang key='website/sign/secure-done-subtitle'}</p>
                    </div>
                    <a class="btn btn-primary w-100" href="{link route='sign-forget'}">{lang key='website/sign/secure-done-action'}</a>
                </div>
                {else}
                <div data-auth-step="invalid">
                    <div class="text-center mb-4">
                        <span class="auth-icon auth-icon-danger"><i class="bi bi-x-octagon"></i></span>
                        <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/secure-invalid-heading'}</h1>
                        <p class="text-body-secondary mb-0">{lang key='website/sign/secure-invalid-subtitle'}</p>
                    </div>
                    <a class="btn btn-primary w-100" href="{link route='sign-in'}">{lang key='website/sign/secure-invalid-action'}</a>
                </div>
                {/if}

            </div>
        </div>
    </section>

{/block}
