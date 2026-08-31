{extends file='layouts/default.tpl'}


{block name=content}
<section class="pt-4 pb-4 pt-lg-4 pb-lg-5">
    <div class="container list-page">

        <div class="basic-empty-state is-page" data-switch-url="{link route='my-account'}">
            <i class="bi bi-shield-lock" aria-hidden="true"></i>
            <span class="fw-semibold">{lang key='website/denied/title'}</span>
            <span class="fs-7">{$denied_text}</span>
            <span class="fs-8 text-body-secondary">{lang key='website/denied/hint'}</span>
            <div class="d-flex flex-wrap justify-content-center gap-2 mt-1">
                {if $denied_account}
                <button type="button" class="btn btn-primary btn-sm" data-action="switch-account" data-account-id="0"><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/denied/back-own'}</button>
                {/if}
                <a class="btn btn-soft btn-sm" href="{link route='my-account'}"><i class="bi bi-speedometer2 me-1"></i>{lang key='website/denied/dashboard'}</a>
            </div>
            {csrf form='account-switch'}
        </div>

    </div>
</section>
{/block}
