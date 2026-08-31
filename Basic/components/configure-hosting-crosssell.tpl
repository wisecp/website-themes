{assign var=hcShell value=$shell|default:true}
{if $hcShell}<div class="card" data-hosting-crosssell>
    <div class="card-body p-4">{/if}
        <div class="{if $hcShell}config-section-head{else}addon-row-head{/if} hosting-head">
            {if $hcShell}
            <span class="icon-disc"><i class="bi bi-hdd-stack"></i></span>
            <div class="hosting-head-body">
                <h2 class="h6 fw-semibold">{lang key='website/configure/hosting/title'}</h2>
                <p class="fs-8 text-body-secondary mb-0">{lang key='website/configure/hosting/subtitle'}</p>
            </div>
            {else}
            <span class="label-media"><i class="bi bi-hdd-stack"></i></span>
            <span class="addon-row-title fw-semibold">{lang key='website/configure/hosting/row-title'}</span>
            <span class="addon-row-desc fs-8 text-body-secondary">{lang key='website/configure/hosting/subtitle'}</span>
            {/if}
            <span class="addon-row-price">
                <small class="d-block">{lang key='website/configure/hosting/from-label'}</small>
                <b data-role="hosting-from">{$hosting_from_fmt[$default_cycle]|default:''}</b>
            </span>
            <span class="form-check form-switch addon-row-toggle">
                <input class="form-check-input" type="checkbox" role="switch" name="hosting_choice" value="add" id="hostingChoice" aria-controls="hostingPlanList" aria-label="{lang key='website/configure/hosting/title'}"{if $hosting_preset|default:0} checked{/if}>
            </span>
        </div>
        <div data-hosting-plans>
            <div class="wui-collapse{if $hosting_preset|default:0} wui-show{/if}" id="hostingPlanList"><div class="wui-collapse-inner">
                <div class="wcp-acc" id="hostingCatAccordion">
                    {foreach $hosting_crosssell as $cat}
                    <div class="wcp-acc-item" data-hosting-cat="{$cat.id}">
                        <h3 class="wcp-acc-header">
                            <button class="wcp-acc-head{if !$cat@first} collapsed{/if}" type="button" data-wui-toggle data-wui-target="#hostCat{$cat.id}" data-wui-parent="#hostingCatAccordion" aria-expanded="{if $cat@first}true{else}false{/if}" aria-controls="hostCat{$cat.id}">
                                <span class="wcp-acc-ico">{if $cat.icon.type == 'image'}<img src="{$cat.icon.value}" alt=""> {else}<i class="{$cat.icon.value}"></i>{/if}</span>
                                <span class="wcp-acc-title">{$cat.name}</span>
                                <span class="wcp-acc-state">
                                    <span class="host-cat-count" data-role="hosting-cat-count"{foreach $cat.count_fmt as $pc => $pf} data-fmt-{$pc}="{$pf}"{/foreach}>{$cat.count_fmt[$default_cycle]|default:''}</span>
                                    <span>{lang key='website/configure/hosting/from-label'} <b data-role="hosting-cat-min"{foreach $cat.min_fmt as $pc => $pf} data-fmt-{$pc}="{$pf}"{/foreach}>{$cat.min_fmt[$default_cycle]|default:''}</b></span>
                                </span>
                                <i class="bi bi-chevron-down wcp-acc-caret" aria-hidden="true"></i>
                            </button>
                        </h3>
                        <div id="hostCat{$cat.id}" class="wui-collapse{if $cat@first} wui-show{/if}" data-wui-parent="#hostingCatAccordion"><div class="wui-collapse-inner">
                            <div class="wcp-acc-body">
                                <div class="d-grid gap-2">
                                    {foreach $cat.plans as $hp}
                                    {assign var=hpChecked value=(($hosting_preset|default:0) && $hosting_preset == $hp.id) || (!($hosting_preset|default:0) && $cat@first && $hp@first)}
                                    <label class="option-card option-card-radio">
                                        <input class="form-check-input" type="radio" name="hosting_plan" value="{$hp.id}" data-label="{$hp.name}"{foreach $hp.prices as $pc => $pa} data-{$pc}="{$pa}"{/foreach}{foreach $hp.prices_fmt as $pc => $pf} data-fmt-{$pc}="{$pf}"{/foreach}{foreach $hp.cycle_of as $pc => $c} data-cycle-{$pc}="{$c}"{/foreach}{if $hpChecked} checked{/if}>
                                        <span class="d-flex align-items-center gap-3">
                                            <span class="option-media"><i class="bi bi-hdd"></i></span>
                                            <span class="me-auto">
                                                <span class="fw-semibold d-block">{$hp.name}</span>
                                                {if $hp.tagline}<span class="fs-8 text-body-secondary">{$hp.tagline}</span>{/if}
                                            </span>
                                            <span class="price-chip" data-role="hosting-price">{$hp.prices_fmt[$default_cycle]|default:''}</span>
                                        </span>
                                        {if $hp.features}
                                        <span class="wui-collapse{if $hpChecked} wui-show wui-shown{/if}" data-hosting-feat><span class="wui-collapse-inner">
                                            <span class="host-feat-list">
                                                {foreach $hp.features as $feat}<span class="host-feat-item"><i class="bi bi-check-lg"></i>{$feat}</span>{/foreach}
                                            </span>
                                        </span></span>
                                        {/if}
                                    </label>
                                    {/foreach}
                                </div>
                            </div>
                        </div></div>
                    </div>
                    {/foreach}
                </div>
            </div></div>
        </div>
        <p class="fs-8 text-body-secondary mt-3 mb-0"><i class="bi bi-info-circle me-1"></i>{lang key='website/configure/hosting/note'}</p>
{if $hcShell}    </div>
</div>{/if}
