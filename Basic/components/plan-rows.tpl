<div class="plan-rows pt-3">
    {foreach $plans as $plan}
    <div>
        <div class="card plan-row{if $plan.popular} plan-popular{/if}{if !$plan.in_stock} plan-soldout{/if}" data-currency="{$plan.currency}" data-monthly="{$plan.prices.monthly|default:''}" data-quarterly="{$plan.prices.quarterly|default:''}" data-semiannually="{$plan.prices.semiannually|default:''}" data-annual="{$plan.prices.annual|default:''}" data-biennial="{$plan.prices.biennial|default:''}" data-triennial="{$plan.prices.triennial|default:''}" data-onetime="{$plan.prices.onetime|default:''}">
            <div class="plan-row-main">
                <div class="plan-row-id">
                    <h4 class="h6 mb-1">{$plan.title}{if $plan.popular}<span class="badge bg-success-subtle text-success-emphasis ms-2"><i class="bi bi-fire me-1"></i>{lang key='website/products/popular'}</span>{/if}{if !$plan.in_stock}<span class="badge bg-danger-subtle text-danger-emphasis ms-2"><i class="bi bi-slash-circle me-1"></i>{lang key='website/products/out-of-stock'}</span>{/if}</h4>
                    {if $plan.tagline}<p class="fs-8 text-body-secondary mb-0">{$plan.tagline}</p>{/if}
                </div>
                {foreach $plan.specs as $spec}
                <div class="plan-row-spec"><span class="d-block fw-semibold">{$spec.value}</span><span class="fs-8 text-body-secondary">{$spec.label}</span></div>
                {/foreach}
                <div class="plan-row-price">
                    <div class="wui-collapse" data-role="save-band"><div class="wui-collapse-inner"><div class="d-flex align-items-center column-gap-2">
                        <del class="price-was num-tabular fs-8 text-body-secondary fw-semibold d-none" data-role="price-was"></del>
                        <span class="badge bg-success-subtle text-success-emphasis fw-semibold d-none" data-role="savings"></span>
                    </div></div></div>
                    <div><span class="price-now num-tabular" data-role="price-now">{$plan.price_now|default:''}</span><span class="fs-8 text-body-secondary{if $plan.is_period} d-none{/if}">{lang key='website/products/category-per-month'}</span><span class="badge bg-secondary-subtle text-secondary-emphasis fs-8 ms-1{if !($plan.is_onetime|default:false)} d-none{/if}" data-role="price-onetime"><i class="bi bi-tag me-1"></i>{lang key='date/cycles/onetime'}</span></div>
                </div>
                <div class="plan-row-actions d-flex align-items-center gap-2">
                    {if $plan.in_stock}<a class="btn {if $plan.popular}btn-primary{else}btn-soft{/if} btn-sm" href="{$plan.link}"{if $plan.external|default:false} rel="nofollow noopener"{/if}>{if $plan.cta_label|default:''}{$plan.cta_label}{else}{lang key='website/products/category-configure'}{/if}</a>
                    {else}<button class="btn btn-soft btn-sm" type="button" disabled>{lang key='website/products/out-of-stock'}</button>{/if}
                    <button class="btn btn-soft btn-sm billing-compare collapsed" type="button" data-wui-toggle data-wui-target="#planRow{$plan.id}" aria-expanded="false" aria-label="{lang key='website/products/category-show-details'}"><i class="bi bi-chevron-down"></i></button>
                </div>
            </div>
            {hook name='ui:client.plan_card.footer'}
            <div class="wui-collapse" id="planRow{$plan.id}">
                <div class="wui-collapse-inner">
                    <div class="plan-row-details">
                        {if $plan.chips}
                        <div class="plan-row-chips d-flex flex-wrap align-content-start gap-2">
                            {foreach $plan.chips as $chip}<span class="plan-chip"><i class="bi bi-check2"></i>{$chip}</span>{/foreach}
                        </div>
                        {/if}
                        <div class="plan-row-billing">
                            <div class="fs-8 fw-semibold text-body-secondary mb-1">{lang key='website/products/category-billing-options'}</div>
                            <div class="table-responsive">
                                <table class="table table-sm align-middle plan-billing-table fs-8 mb-0">
                                    <thead>
                                        <tr><th scope="col">{lang key='website/products/category-th-cycle'}</th><th scope="col" class="text-end">{lang key='website/products/category-th-total'}</th><th scope="col" class="text-end">{lang key='website/products/category-th-permonth'}</th></tr>
                                    </thead>
                                    <tbody>
                                        {foreach $billing_cycles as $c}
                                        <tr data-cycle="{$c.key}"><td>{$c.label}</td><td class="num-tabular text-end" data-role="cycle-total"></td><td class="num-tabular text-end" data-role="cycle-mo"></td></tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {/foreach}
</div>
