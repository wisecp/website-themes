{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/reseller-program.css'}">
{/block}

{block name=scripts}
    <script src="{asset path='js/reseller-program.js'}" defer></script>
{/block}

{block name=content}

<section class="page-hero text-center">
    <div class="container">
        <span class="eyebrow reveal">{lang key='website/reseller/prog-eyebrow'}</span>
        <h1 class="page-hero-title tracking-tight reveal reveal-2 mt-1 mb-3">{lang key='website/reseller/prog-hero-title'}</h1>
        <p class="page-hero-lead text-body-secondary reveal reveal-3 mb-4">{lang key='website/reseller/prog-hero-lead'}</p>
        <div class="d-flex flex-wrap justify-content-center gap-2 reveal reveal-4 mb-4">
            <a class="btn btn-primary rounded-pill px-4" href="{$cta_primary_link}"><i class="bi bi-shop me-1"></i>{$cta_primary_text}</a>
            <a class="btn btn-soft rounded-pill px-4" href="{$cta_secondary_link}">{$cta_secondary_text}</a>
        </div>
        <div class="d-flex flex-wrap justify-content-center gap-4 fs-8 text-body-secondary reveal reveal-5">
            <span><i class="bi bi-percent me-1 text-success"></i>{lang key='website/reseller/prog-hl-tiered'}</span>
            <span><i class="bi bi-lightning-charge me-1 text-success"></i>{lang key='website/reseller/prog-hl-auto'}</span>
            <span><i class="bi bi-arrow-repeat me-1 text-success"></i>{lang key='website/reseller/prog-hl-renewals'}</span>
        </div>
    </div>
</section>

<section class="pb-5">
    <div class="container">
        <div class="rsp-metrics">
            <div class="rsp-metric">
                <span class="rsp-metric-ico"><i class="bi bi-percent"></i></span>
                <span class="rsp-metric-value">{lang key='website/reseller/prog-m1-value'}</span>
                <span class="rsp-metric-label">{lang key='website/reseller/prog-m1-label'}</span>
            </div>
            <div class="rsp-metric">
                <span class="rsp-metric-ico"><i class="bi bi-bar-chart-line"></i></span>
                <span class="rsp-metric-value num-tabular">{lang key='website/reseller/prog-m2-value'}</span>
                <span class="rsp-metric-label">{lang key='website/reseller/prog-m2-label'}</span>
            </div>
            <div class="rsp-metric">
                <span class="rsp-metric-ico"><i class="bi bi-arrow-repeat"></i></span>
                <span class="rsp-metric-value">{lang key='website/reseller/prog-m3-value'}</span>
                <span class="rsp-metric-label">{lang key='website/reseller/prog-m3-label'}</span>
            </div>
            <div class="rsp-metric">
                <span class="rsp-metric-ico"><i class="bi bi-code-slash"></i></span>
                <span class="rsp-metric-value">{lang key='website/reseller/prog-m4-value'}</span>
                <span class="rsp-metric-label">{lang key='website/reseller/prog-m4-label'}</span>
            </div>
        </div>
    </div>
</section>

<section class="py-5 border-top">
    <div class="container">
        <div class="text-center mb-5">
            <span class="eyebrow">{lang key='website/reseller/prog-how-eyebrow'}</span>
            <h2 class="tracking-tight mt-1 mb-2">{lang key='website/reseller/prog-how-title'}</h2>
            <p class="text-body-secondary mb-0">{lang key='website/reseller/prog-how-lead'}</p>
        </div>
        <div class="rsp-steps">
            <div class="rsp-step">
                <span class="rsp-step-num num-tabular">1</span>
                <h3 class="rsp-step-title">{lang key='website/reseller/prog-step1-title'}</h3>
                <p class="rsp-step-text">{lang key='website/reseller/prog-step1-text'}</p>
            </div>
            <div class="rsp-step">
                <span class="rsp-step-num num-tabular">2</span>
                <h3 class="rsp-step-title">{lang key='website/reseller/prog-step2-title'}</h3>
                <p class="rsp-step-text">{lang key='website/reseller/prog-step2-text'}</p>
            </div>
            <div class="rsp-step">
                <span class="rsp-step-num num-tabular">3</span>
                <h3 class="rsp-step-title">{lang key='website/reseller/prog-step3-title'}</h3>
                <p class="rsp-step-text">{lang key='website/reseller/prog-step3-text'}</p>
            </div>
        </div>
    </div>
</section>

{if $prog_tiers}
<section class="py-5 border-top">
    <div class="container">
        <div class="text-center mb-5">
            <span class="eyebrow">{lang key='website/reseller/prog-tiers-eyebrow'}</span>
            <h2 class="tracking-tight mt-1 mb-2">{lang key='website/reseller/prog-tiers-title'}</h2>
            <p class="text-body-secondary mb-0">{lang key='website/reseller/prog-tiers-lead'}</p>
            {if $prog_tiers|@count > 1}
            <div class="rsp-product-wrap">
                <div class="rsp-product-toggle" data-rsp-product-toggle role="group" aria-label="{lang key='website/reseller/prog-tiers-aria'}">
                    {foreach $prog_tiers as $t}
                    <button class="rsp-product-option{if $t@first} active{/if}" type="button" data-action="rsp-product" data-product="{$t.key}" aria-pressed="{if $t@first}true{else}false{/if}"><i class="bi bi-grid"></i>{$t.full_name}</button>
                    {/foreach}
                </div>
            </div>
            {/if}
        </div>
        {foreach $prog_tiers as $t}
        <div class="rsp-tiers{if !$t@first} d-none{/if}" data-rsp-tiers="{$t.key}">
            {foreach $t.items as $it}
            <div class="rsp-tier{if $it.top} rsp-tier-top{/if}">
                {if $it.top}<span class="badge bg-primary-subtle text-primary-emphasis rsp-tier-badge"><i class="bi bi-arrow-up-circle me-1"></i>{lang key='website/reseller/prog-highest-tier'}</span>{/if}
                <span class="rsp-tier-rate num-tabular">{$it.rate}%<span class="rsp-tier-rate-unit">{lang key='website/reseller/off'}</span></span>
                <span class="rsp-tier-range num-tabular">{$it.from} - {$it.to} {lang key='website/reseller/prog-tier-unit'}</span>
            </div>
            {/foreach}
        </div>
        {/foreach}
    </div>
</section>
{/if}

<section class="py-5 border-top">
    <div class="container">
        <div class="text-center mb-5">
            <span class="eyebrow">{lang key='website/reseller/prog-why-eyebrow'}</span>
            <h2 class="tracking-tight mt-1 mb-2">{lang key='website/reseller/prog-why-title'}</h2>
            <p class="text-body-secondary mb-0">{lang key='website/reseller/prog-why-lead'}</p>
        </div>
        <div class="row g-3">
            <div class="col-md-6 col-xl-4">
                <div class="rsp-benefit hover-lift">
                    <span class="icon-disc"><i class="bi bi-graph-up-arrow"></i></span>
                    <div>
                        <h3 class="rsp-benefit-title">{lang key='website/reseller/prog-b1-title'}</h3>
                        <p class="rsp-benefit-text">{lang key='website/reseller/prog-b1-text'}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-4">
                <div class="rsp-benefit hover-lift">
                    <span class="icon-disc"><i class="bi bi-arrow-repeat"></i></span>
                    <div>
                        <h3 class="rsp-benefit-title">{lang key='website/reseller/prog-b2-title'}</h3>
                        <p class="rsp-benefit-text">{lang key='website/reseller/prog-b2-text'}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-4">
                <div class="rsp-benefit hover-lift">
                    <span class="icon-disc"><i class="bi bi-lightning-charge"></i></span>
                    <div>
                        <h3 class="rsp-benefit-title">{lang key='website/reseller/prog-b3-title'}</h3>
                        <p class="rsp-benefit-text">{lang key='website/reseller/prog-b3-text'}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-4">
                <div class="rsp-benefit hover-lift">
                    <span class="icon-disc"><i class="bi bi-tags"></i></span>
                    <div>
                        <h3 class="rsp-benefit-title">{lang key='website/reseller/prog-b4-title'}</h3>
                        <p class="rsp-benefit-text">{lang key='website/reseller/prog-b4-text'}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-4">
                <div class="rsp-benefit hover-lift">
                    <span class="icon-disc"><i class="bi bi-code-slash"></i></span>
                    <div>
                        <h3 class="rsp-benefit-title">{lang key='website/reseller/prog-b5-title'}</h3>
                        <p class="rsp-benefit-text">{lang key='website/reseller/prog-b5-text'}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xl-4">
                <div class="rsp-benefit hover-lift">
                    <span class="icon-disc"><i class="bi bi-shop"></i></span>
                    <div>
                        <h3 class="rsp-benefit-title">{lang key='website/reseller/prog-b6-title'}</h3>
                        <p class="rsp-benefit-text">{lang key='website/reseller/prog-b6-text'}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="py-5 border-top">
    <div class="container">
        <div class="text-center mb-4">
            <span class="eyebrow">{lang key='website/reseller/prog-calc-eyebrow'}</span>
            <h2 class="tracking-tight mt-1 mb-2">{lang key='website/reseller/prog-calc-title'}</h2>
        </div>
        <div class="rsp-calc">
            <div class="rsp-calc-flow">
                <div class="rsp-calc-part">
                    <span class="rsp-calc-num num-tabular">{lang key='website/reseller/prog-calc-in'}<span class="rsp-calc-unit">{lang key='website/reseller/prog-calc-permonth'}</span></span>
                    <span class="rsp-calc-cap">{lang key='website/reseller/prog-calc-in-cap'}</span>
                </div>
                <i class="bi bi-arrow-right rsp-calc-arrow" aria-hidden="true"></i>
                <div class="rsp-calc-part is-result">
                    <span class="rsp-calc-num num-tabular">{lang key='website/reseller/prog-calc-out'}<span class="rsp-calc-unit">{lang key='website/reseller/prog-calc-permonth'}</span></span>
                    <span class="rsp-calc-cap">{lang key='website/reseller/prog-calc-out-cap'}</span>
                </div>
            </div>
            <p class="rsp-calc-note">{lang key='website/reseller/prog-calc-note'}</p>
        </div>
    </div>
</section>

<section class="py-5 border-top">
    <div class="container">
        <div class="text-center mb-5">
            <span class="eyebrow">{lang key='website/reseller/prog-faq-eyebrow'}</span>
            <h2 class="tracking-tight mt-1 mb-0">{lang key='website/reseller/prog-faq-title'}</h2>
        </div>
        <div class="accordion page-faq" id="reseller-faq">
            <div class="accordion-item">
                <h3 class="accordion-header">
                    <button class="accordion-button fw-semibold" type="button" data-wui-toggle data-wui-target="#rsp-faq-1" aria-expanded="true" aria-controls="rsp-faq-1">{lang key='website/reseller/prog-faq-q1'}</button>
                </h3>
                <div id="rsp-faq-1" class="wui-collapse wui-show" data-wui-parent="#reseller-faq"><div class="wui-collapse-inner">
                    <div class="accordion-body">{lang key='website/reseller/prog-faq-a1'}</div>
                </div></div>
            </div>
            <div class="accordion-item">
                <h3 class="accordion-header">
                    <button class="accordion-button fw-semibold collapsed" type="button" data-wui-toggle data-wui-target="#rsp-faq-2" aria-expanded="false" aria-controls="rsp-faq-2">{lang key='website/reseller/prog-faq-q2'}</button>
                </h3>
                <div id="rsp-faq-2" class="wui-collapse" data-wui-parent="#reseller-faq"><div class="wui-collapse-inner">
                    <div class="accordion-body">{lang key='website/reseller/prog-faq-a2'}</div>
                </div></div>
            </div>
            <div class="accordion-item">
                <h3 class="accordion-header">
                    <button class="accordion-button fw-semibold collapsed" type="button" data-wui-toggle data-wui-target="#rsp-faq-3" aria-expanded="false" aria-controls="rsp-faq-3">{lang key='website/reseller/prog-faq-q3'}</button>
                </h3>
                <div id="rsp-faq-3" class="wui-collapse" data-wui-parent="#reseller-faq"><div class="wui-collapse-inner">
                    <div class="accordion-body">{lang key='website/reseller/prog-faq-a3'}</div>
                </div></div>
            </div>
            <div class="accordion-item">
                <h3 class="accordion-header">
                    <button class="accordion-button fw-semibold collapsed" type="button" data-wui-toggle data-wui-target="#rsp-faq-4" aria-expanded="false" aria-controls="rsp-faq-4">{lang key='website/reseller/prog-faq-q4'}</button>
                </h3>
                <div id="rsp-faq-4" class="wui-collapse" data-wui-parent="#reseller-faq"><div class="wui-collapse-inner">
                    <div class="accordion-body">{lang key='website/reseller/prog-faq-a4'}</div>
                </div></div>
            </div>
            <div class="accordion-item">
                <h3 class="accordion-header">
                    <button class="accordion-button fw-semibold collapsed" type="button" data-wui-toggle data-wui-target="#rsp-faq-5" aria-expanded="false" aria-controls="rsp-faq-5">{lang key='website/reseller/prog-faq-q5'}</button>
                </h3>
                <div id="rsp-faq-5" class="wui-collapse" data-wui-parent="#reseller-faq"><div class="wui-collapse-inner">
                    <div class="accordion-body">{lang key='website/reseller/prog-faq-a5'}</div>
                </div></div>
            </div>
            <div class="accordion-item">
                <h3 class="accordion-header">
                    <button class="accordion-button fw-semibold collapsed" type="button" data-wui-toggle data-wui-target="#rsp-faq-6" aria-expanded="false" aria-controls="rsp-faq-6">{lang key='website/reseller/prog-faq-q6'}</button>
                </h3>
                <div id="rsp-faq-6" class="wui-collapse" data-wui-parent="#reseller-faq"><div class="wui-collapse-inner">
                    <div class="accordion-body">{lang key='website/reseller/prog-faq-a6'}</div>
                </div></div>
            </div>
        </div>
    </div>
</section>

<section class="py-5">
    <div class="container">
        <div class="cta-band">
            <h2 class="cta-title mb-2">{lang key='website/reseller/prog-cta-title'}</h2>
            <p class="mb-4 opacity-75">{lang key='website/reseller/prog-cta-lead'}</p>
            <div class="d-flex flex-wrap justify-content-center gap-2">
                <a class="btn btn-light rounded-pill px-4" href="{$cta_primary_link}">{$cta_primary_text}</a>
                <a class="btn btn-outline-light rounded-pill px-4" href="{$cta_secondary_link}">{$cta_secondary_text}</a>
            </div>
        </div>
    </div>
</section>
{/block}
