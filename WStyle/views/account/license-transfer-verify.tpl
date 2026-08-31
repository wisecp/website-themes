{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/checkout.css'}">
{/block}

{block name=bands}{/block}

{block name=content}
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-md-10 col-lg-8 col-xl-7">
            <div class="card">
                <div class="card-body p-4 p-sm-5 text-center">
                    <i class="bi {$v.icon} {$v.tone} checkout-result-icon" aria-hidden="true"></i>
                    <h1 class="h3 tracking-tight mt-3 mb-3">{$v.title}</h1>
                    <p class="text-body-secondary mb-4">{$v.desc}</p>
                    {if $v.error}<div class="alert alert-danger d-flex align-items-center text-start mb-4" role="alert"><i class="bi bi-exclamation-triangle me-2"></i>{$v.error}</div>{/if}
                    {if $v.injected}{$v.injected nofilter}{/if}
                    {if $v.summary}
                    <div class="pay-detail-list is-page mb-4">
                        <div class="pay-detail"><span class="pay-detail-label">{lang key='website/verify-license-transfer/summary-service'}</span><span class="pay-detail-value ms-auto">{$v.summary.service}</span></div>
                        <div class="pay-detail"><span class="pay-detail-label">{lang key='website/verify-license-transfer/summary-current-owner'}</span><span class="pay-detail-value ms-auto">{$v.summary.from}</span></div>
                        <div class="pay-detail"><span class="pay-detail-label">{lang key='website/verify-license-transfer/summary-new-owner'}</span><span class="pay-detail-value ms-auto">{$v.summary.to}</span></div>
                        <div class="pay-detail"><span class="pay-detail-label">{lang key='website/verify-license-transfer/summary-your-role'}</span><span class="pay-detail-value ms-auto">{$v.summary.role}</span></div>
                        <div class="pay-detail"><span class="pay-detail-label">{lang key='website/verify-license-transfer/summary-fee'}</span><span class="pay-detail-value ms-auto num-tabular">{$v.summary.fee}</span></div>
                    </div>
                    {/if}
                    {if $v.confirm}
                    <form method="post" action="{$v.action}" class="mb-3">
                        {csrf form=$v.csrf_key}
                        <input type="hidden" name="op" value="confirm">
                        <input type="hidden" name="utoken" value="{$v.utoken}">
                        <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg me-2"></i>{$v.btn}</button>
                    </form>
                    {/if}
                    <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                        {if $v.invoice}
                        <a class="btn btn-primary" href="{$v.invoice}"><i class="bi bi-receipt me-2"></i>{lang key='website/verify-license-transfer/pay-invoice-link'}</a>
                        {/if}
                        <a class="btn {if $v.invoice}btn-soft{else}btn-primary{/if}" href="{link route='home'}"><i class="bi bi-house me-2"></i>{lang key='website/verify-license-transfer/home-link'}</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{/block}
