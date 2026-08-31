{extends file='layouts/default.tpl'}

{block name=scripts}
    <script src="{asset path='js/service-transfer.js'}" defer></script>
{/block}

{block name=content}
<div class="container py-4" data-service-transfer-approve
     data-transfer-url="{link route='services'}"
     data-txt-accepting="{lang key='website/services/service-transfer/js-accepting'}"
     data-txt-rejecting="{lang key='website/services/service-transfer/js-rejecting'}"
     data-txt-reject-title="{lang key='website/services/service-transfer/js-reject-title'}"
     data-txt-reject-msg="{lang key='website/services/service-transfer/js-reject-msg'}"
     data-txt-reject-action="{lang key='website/services/service-transfer/js-reject-action'}"
     data-txt-cancel-btn="{lang key='website/services/service-transfer/js-cancel-btn'}">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            {if $valid}
            <section class="card">
                <div class="card-body p-4 p-md-5">
                    <div class="text-center mb-4">
                        <span class="icon-disc mb-3"><i class="bi bi-arrow-left-right"></i></span>
                        <h1 class="h4 mb-2">{lang key='website/services/service-transfer/approve-title'}</h1>
                        <p class="text-body-secondary mb-0">{lang key='website/services/service-transfer/approve-intro' from=$t.from_name}</p>
                    </div>

                    <div class="sd-party mb-4">
                        <div class="sd-party-head">
                            <span class="sd-party-avatar"><i class="bi bi-box-seam"></i></span>
                            <div class="sd-party-id">
                                <span class="sd-party-role">{$t.service_name}</span>
                                {if $t.product_name && $t.product_name != $t.service_name}<span class="sd-party-email">{$t.product_name}</span>{/if}
                            </div>
                        </div>
                    </div>

                    <div class="alert alert-info d-flex align-items-center mb-4">
                        <i class="bi bi-info-circle me-2"></i>
                        <span class="fs-7">{lang key='website/services/service-transfer/approve-note'}</span>
                    </div>

                    {hook name='ui:client.service_transfer_approve.body'}

                    {csrf form='service-transfer'}
                    <input type="hidden" data-role="transfer-token" value="{$transfer_token}">
                    <div class="d-flex flex-wrap justify-content-center gap-2">
                        <button type="button" class="btn btn-soft" data-action="reject-transfer"><i class="bi bi-x-circle me-1"></i>{lang key='website/services/service-transfer/approve-reject'}</button>
                        <button type="button" class="btn btn-primary" data-action="approve-transfer"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/service-transfer/approve-accept'}</button>
                    </div>
                </div>
            </section>
            {else}
            <section class="card">
                <div class="card-body p-4 p-md-5 text-center">
                    <span class="icon-disc mb-3"><i class="bi bi-exclamation-triangle"></i></span>
                    <h1 class="h4 mb-2">{lang key='website/services/service-transfer/approve-unavailable-title'}</h1>
                    <p class="text-body-secondary mb-4">{if $expired}{lang key='website/services/service-transfer/approve-expired'}{elseif $blocked}{lang key='website/services/service-transfer/approve-service-state'}{else}{lang key='website/services/service-transfer/approve-invalid'}{/if}</p>
                    <a href="{link route='services'}" class="btn btn-primary"><i class="bi bi-grid me-1"></i>{lang key='website/services/service-transfer/approve-goto-services'}</a>
                </div>
            </section>
            {/if}
        </div>
    </div>
</div>
{/block}
