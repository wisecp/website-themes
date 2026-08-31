{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/auth.css'}">
{/block}

{block name=content}

    <section class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-sm-10 col-md-8 col-lg-5">
                    <div class="auth-card mx-auto text-center">
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
                </div>
            </div>
        </div>
    </section>

{/block}
