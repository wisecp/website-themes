{if $plan_rack.tabs|default:false}
<section class="plans-rack chrome-dark py-5{if $plan_rack.background.image || $plan_rack.background.video} has-band-bg{/if}" data-billing="{$plan_rack.default_cycle}" data-price-mode="{$price_mode}" data-save-text="{lang key='website/products/category-save'}" data-reveal>
    {include file='components/band-bg.tpl' bg=$plan_rack.background}
    <div class="container">
        <div class="section-head">
            <span class="eyebrow">{lang key='home_plans_eyebrow'}</span>
            <h2 class="tracking-tight">{if $plan_rack.title}{$plan_rack.title}{else}{lang key='home_plans_title'}{/if}</h2>
            <p class="section-lead">{if $plan_rack.description}{$plan_rack.description}{else}{lang key='home_plans_lead'}{/if}</p>
        </div>
        <div class="rack-shell">
            <div class="rack-bar">
                <ul class="nav nav-pills gap-1 mb-0" role="tablist">
                    {foreach $plan_rack.tabs as $tab}
                    <li class="nav-item" role="presentation"><button class="nav-link{if $tab@first} active{/if}" id="home-tab-{$tab.id}" data-bs-toggle="tab" data-bs-target="#home-pane-{$tab.id}" type="button" role="tab" aria-controls="home-pane-{$tab.id}" aria-selected="{if $tab@first}true{else}false{/if}" data-cat-link="{$tab.link}"><i class="{$tab.icon} me-1"></i>{$tab.title}</button></li>
                    {/foreach}
                </ul>
                {if count($plan_rack.cycles) > 1}
                <div class="billing-toggle" data-billing-toggle role="group" aria-label="{lang key='home_billing_aria'}">
                    {foreach $plan_rack.cycles as $cycle}
                    <button class="billing-option{if $cycle.key == $plan_rack.default_cycle} active{/if}" type="button" data-action="set-billing" data-cycle="{$cycle.key}">{$cycle.label}</button>
                    {/foreach}
                </div>
                {/if}
            </div>
            <div class="tab-content">
                {foreach $plan_rack.tabs as $tab}
                <div class="tab-pane fade{if $tab@first} show active{/if}" id="home-pane-{$tab.id}" role="tabpanel" aria-labelledby="home-tab-{$tab.id}" tabindex="0">
                    {if $tab.layout == 'rows'}
                    {include file='components/plan-rows.tpl' plans=$tab.plans billing_cycles=$plan_rack.cycles}
                    {else}
                    {include file='components/plan-grid.tpl' plans=$tab.plans billing_cycles=$plan_rack.cycles}
                    {/if}
                </div>
                {/foreach}
            </div>
        </div>
        <div class="text-center mt-4">
            <a class="link-arrow fs-7" data-role="rack-view-all" href="{$plan_rack.tabs[0].link|default:''}">{lang key='home_plans_view_all'}<i class="bi bi-arrow-right"></i></a>
        </div>
    </div>
</section>
{/if}
