{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/auth.css'}">
{/block}

{block name=content}

    <section class="py-5">
        <div class="container">
            <div class="auth-card mx-auto">

                <div class="text-center mb-4">
                    <span class="auth-icon"><i class="bi bi-box-arrow-right"></i></span>
                    <h1 class="h3 tracking-tight mb-2">{lang key='website/sign/out-heading'}</h1>
                    <p class="text-body-secondary mb-0">{lang key='website/sign/out-subtitle'}</p>
                </div>
                <div class="card">
                    <div class="card-body p-4">
                        <form action="{$sign_out_action}" method="post">
                            {csrf form='sign-out'}
                            <button class="btn btn-primary w-100" type="submit">{lang key='website/index/account-logout'}</button>
                        </form>
                    </div>
                </div>
                <p class="text-center fs-7 text-body-secondary mt-4 mb-0"><a class="fw-semibold text-decoration-none" href="{$stay_link}">{lang key='website/sign/out-stay'}</a></p>

            </div>
        </div>
    </section>

{/block}
