<div class="plan-grid pt-3">
    {foreach $plans as $plan}
    <div>
        <div class="card plan-card h-100{if $plan.popular} plan-popular{/if}{if !$plan.in_stock} plan-soldout{/if}" data-currency="{$plan.currency}" data-monthly="{$plan.prices.monthly|default:''}" data-quarterly="{$plan.prices.quarterly|default:''}" data-semiannually="{$plan.prices.semiannually|default:''}" data-annual="{$plan.prices.annual|default:''}" data-biennial="{$plan.prices.biennial|default:''}" data-triennial="{$plan.prices.triennial|default:''}" data-onetime="{$plan.prices.onetime|default:''}">
            {if $plan.popular}<div class="plan-badge"><span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-fire me-1"></i>{lang key='website/products/popular'}</span></div>{/if}
            <div class="card-body d-flex flex-column gap-3 p-4">
                <div>
                    <h4 class="mb-1">{$plan.title}</h4>
                    {if $plan.tagline}<p class="fs-7 text-body-secondary mb-0">{$plan.tagline}</p>{/if}
                </div>
                <div class="plan-price price-band">
                    <div class="wui-collapse" data-role="save-band"><div class="wui-collapse-inner"><div class="d-flex align-items-center justify-content-between column-gap-2">
                        <del class="price-was num-tabular fs-7 text-body-secondary fw-semibold d-none" data-role="price-was"></del>
                        <span class="badge bg-success-subtle text-success-emphasis fw-semibold d-none" data-role="savings"></span>
                    </div></div></div>
                    <div><span class="price-now num-tabular" data-role="price-now">{$plan.price_now|default:''}</span><span class="fs-7 text-body-secondary{if $plan.is_period} d-none{/if}" data-role="price-suffix">{lang key='website/products/category-per-month'}</span><span class="badge bg-secondary-subtle text-secondary-emphasis fs-8 ms-1{if !($plan.is_onetime|default:false)} d-none{/if}" data-role="price-onetime"><i class="bi bi-tag me-1"></i>{lang key='date/cycles/onetime'}</span></div>
                    <button class="btn btn-link btn-sm p-0 mt-1 fs-8 fw-semibold text-decoration-none billing-compare collapsed" type="button" data-wui-toggle data-wui-target="#planBilling{$plan.id}" aria-expanded="false">{lang key='website/products/category-compare-billing'}<i class="bi bi-chevron-down ms-1"></i></button>
                    <div class="wui-collapse" id="planBilling{$plan.id}">
                        <div class="wui-collapse-inner">
                            <div class="table-responsive mt-2">
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
                {if $plan.features}
                <ul class="plan-features fs-7">
                    {foreach $plan.features as $feat}
                    <li><i class="bi bi-check2"></i>{$feat}</li>
                    {/foreach}
                </ul>
                {/if}
                {if $plan.in_stock}
                <a class="btn {if $plan.popular}btn-primary{else}btn-soft{/if} mt-auto" href="{$plan.link}"{if $plan.external|default:false} rel="nofollow noopener"{/if}>{if $plan.cta_label|default:''}{$plan.cta_label}{else}{lang key='website/products/category-get-started'}{/if}</a>
                {else}
                <button class="btn btn-soft mt-auto" type="button" disabled>{lang key='website/products/out-of-stock'}</button>
                {/if}
                {hook name='ui:client.plan_card.footer'}
            </div>
        </div>
    </div>
    {/foreach}
</div>
