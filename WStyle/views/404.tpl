{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/404.css'}">
{/block}

{block name=bands}{/block}

{block name=content}

    <section class="error-hero py-5 my-lg-5">
        <div class="container">
            <div class="row justify-content-center text-center">
                <div class="col-12 col-lg-8">
                    <div class="error-code reveal" aria-hidden="true">404</div>
                    <h1 class="h2 mb-2 reveal reveal-2">{lang key='website/404/heading'}</h1>
                    <p class="error-lead text-body-secondary mx-auto mb-4 reveal reveal-2">{lang key='website/404/lead'}</p>
                    <div class="d-flex flex-wrap justify-content-center gap-2 reveal reveal-3">
                        <a class="btn btn-primary" href="{link route='home'}"><i class="bi bi-house me-1"></i>{lang key='website/404/back-home'}</a>
                        {if $kbase_enabled}<a class="btn btn-soft" href="{link route='kbase'}"><i class="bi bi-journal-text me-1"></i>{lang key='website/404/knowledge-base'}</a>{/if}
                        <a class="btn btn-soft" href="{if $support_enabled}{link route='ticket-create'}{else}{link route='contact'}{/if}"><i class="bi bi-headset me-1"></i>{lang key='website/404/contact-support'}</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

{/block}
