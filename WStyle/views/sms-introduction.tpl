{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='js/libs/tom-select/tom-select.bootstrap5.min.css'}">
<link rel="stylesheet" href="{asset path='js/libs/intl-tel-input/css/intlTelInput.min.css'}">
<link rel="stylesheet" href="{asset path='css/category-sms-international.css'}">
<script src="{asset path='js/libs/tom-select/tom-select.complete.min.js'}" defer></script>
{/block}

{block name=scripts}
<script src="{asset path='js/category-sms-international.js'}" defer></script>
{/block}

{block name=body_class}chrome-overlay{/block}

{block name=content}

    {capture assign=sms_hero_title}{lang key='website/sms/hero-title'}{/capture}
    {capture assign=sms_hero_lead}{lang key='website/sms/hero-lead'}{/capture}
    {capture assign=sms_badge_countries}{lang key='website/sms/hero-badge-countries'}{/capture}
    {capture assign=sms_badge_speed}{lang key='website/sms/hero-badge-speed'}{/capture}
    {capture assign=sms_badge_reports}{lang key='website/sms/hero-badge-reports'}{/capture}
    {include file='partials/page-hero.tpl'
        title=$sms_hero_title
        lead=$sms_hero_lead
        badges=[['icon' => 'bi bi-globe-americas', 'text' => $sms_badge_countries], ['icon' => 'bi bi-send', 'text' => $sms_badge_speed], ['icon' => 'bi bi-graph-up', 'text' => $sms_badge_reports]]}

    <section class="py-5" data-reveal>
        <div class="container">
            <div class="card sms-calc mx-auto" data-currency="{$selected_currency_code}">
                <div class="card-body p-4 p-lg-5">
                    <div class="section-head">
                        <span class="eyebrow">{lang key='website/sms/calc-eyebrow'}</span>
                        <h2 class="h4 tracking-tight">{lang key='website/sms/calc-title'}</h2>
                        <p class="section-lead fs-7">{lang key='website/sms/calc-subtitle'}</p>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-12 col-md-8 col-lg-7">
                            <label for="sms-calc-country" class="form-label">{lang key='website/sms/calc-country-label'}</label>
                            <select class="form-select" id="sms-calc-country" data-wstyle-select data-flag-select data-search-placeholder="{lang key='website/sms/calc-search'}">
                                {foreach $rates as $r}
                                <option value="{$r.code}" data-rate="{$r.rate}"{if $r.prereg} data-senderid="1"{/if}{if $r.code == $default_country} selected{/if}>{$r.name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="sms-calc-result mt-4">
                        <div class="row g-3 text-center">
                            <div class="col-6">
                                <div class="sms-calc-figure">
                                    <span class="sms-calc-value num-tabular" data-role="calc-each">{$default_rate_display}</span>
                                    <span class="sms-calc-label">{lang key='website/sms/calc-per-sms'}</span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="sms-calc-figure">
                                    <span class="sms-calc-value num-tabular" data-role="calc-bulk">{$default_bulk_display}</span>
                                    <span class="sms-calc-label">{lang key='website/sms/calc-bulk'}</span>
                                </div>
                            </div>
                        </div>
                        <p class="fs-8 text-warning-emphasis text-center mt-3 mb-0{if !$default_prereg} d-none{/if}" data-role="senderid-note"><i class="bi bi-info-circle me-1"></i>{lang key='website/sms/calc-senderid-note'}</p>
                    </div>
                    <p class="fs-8 text-body-secondary text-center mt-3 mb-0">{lang key='website/sms/calc-rates-in'} <span data-role="currency-label">{$selected_currency_code}</span> {lang key='website/sms/calc-per-message'} <a href="#rate-table">{lang key='website/sms/calc-see-list'}</a></p>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 bg-surface" id="rate-table" data-reveal>
        <div class="container">
            <div class="section-head">
                <span class="eyebrow">{lang key='website/sms/table-eyebrow'}</span>
                <h2 class="tracking-tight">{lang key='website/sms/table-title'}</h2>
                <p class="section-lead">{lang key='website/sms/table-subtitle'}</p>
            </div>

            <div class="d-flex flex-wrap align-items-center gap-2 mb-3">
                <div class="sms-rate-search ms-auto">
                    <label for="sms-rate-search-input" class="visually-hidden">{lang key='website/sms/table-filter-label'}</label>
                    <input type="search" class="form-control" id="sms-rate-search-input" placeholder="{lang key='website/sms/table-filter'}" data-role="rate-search" autocomplete="off">
                </div>
            </div>

            <div class="card">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0 sms-rate-table" data-role="rate-table">
                        <thead>
                            <tr>
                                <th scope="col">{lang key='website/sms/table-th-country'}</th>
                                <th scope="col" class="text-end">{lang key='website/sms/table-th-per-sms'}</th>
                                <th scope="col" class="text-end">{lang key='website/sms/table-th-per-bulk'}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $rates as $r}
                            <tr data-country="{$r.name}">
                                <th scope="row" class="sms-rate-country"><span class="iti__flag iti__{$r.code}"></span><bdi>{$r.name}</bdi>{if $r.prereg}<span class="text-warning-emphasis ms-1">*</span>{/if}</th>
                                <td class="text-end num-tabular">{$r.rate_display}</td>
                                <td class="text-end num-tabular">{$r.bulk_display}</td>
                            </tr>
                            {/foreach}
                            <tr class="d-none" data-role="rate-empty">
                                <td colspan="3">
                                    <div class="wcp-empty-state">
                                        <i class="bi bi-search"></i>
                                        <p class="mb-0">{lang key='website/sms/table-empty'}</p>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="text-center border-top p-3" data-role="rate-more">
                    <button class="btn btn-soft btn-sm" type="button" data-action="rate-show-all">{lang key='website/sms/table-show-all'} <span class="num-tabular" data-role="rate-more-count">{$rate_count}</span> {lang key='website/sms/table-show-all-suffix'}</button>
                </div>
            </div>
            <p class="fs-8 text-body-secondary mt-2 mb-0"><span class="text-warning-emphasis">*</span> {lang key='website/sms/table-foot-prereg'} {lang key='website/sms/table-foot-rates-in'} <span data-role="currency-label">{$selected_currency_code}</span> {lang key='website/sms/table-foot-per-delivered'}</p>
        </div>
    </section>

    <section class="band-dark chrome-dark py-5" data-reveal>
        <div class="container">
            <div class="section-head">
                <span class="eyebrow">{lang key='website/sms/incl-eyebrow'}</span>
                <h2 class="tracking-tight">{lang key='website/sms/incl-title'}</h2>
                <p class="section-lead">{lang key='website/sms/incl-subtitle'}</p>
            </div>
            <div class="row g-3">
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-globe-americas"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{lang key='website/sms/incl-1-title'}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/sms/incl-1-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-person-badge"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{lang key='website/sms/incl-2-title'}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/sms/incl-2-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-cash-coin"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{lang key='website/sms/incl-3-title'}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/sms/incl-3-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-graph-up"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{lang key='website/sms/incl-4-title'}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/sms/incl-4-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    {if $faqs}
    <section class="py-5" data-reveal>
        <div class="container">
            <div class="row g-4 g-lg-5">
                <div class="col-lg-4">
                    <div class="section-head section-head-start mb-3">
                        <span class="eyebrow">{lang key='website/sms/faq-eyebrow'}</span>
                        <h2 class="tracking-tight">{lang key='website/sms/faq-heading'}</h2>
                    </div>
                    <a class="link-arrow fs-7" href="{link route='kbase'}">{lang key='website/products/category-faq-kb'}<i class="bi bi-arrow-right"></i></a>
                </div>
                <div class="col-lg-8">
                    <div class="accordion page-faq" id="sms-intl-faq">
                        {foreach $faqs as $i => $f}
                        <div class="accordion-item">
                            <h3 class="accordion-header">
                                <button class="accordion-button fw-semibold{if $i > 0} collapsed{/if}" type="button" data-wui-toggle data-wui-target="#sms-intl-faq-{$i}" aria-expanded="{if $i == 0}true{else}false{/if}" aria-controls="sms-intl-faq-{$i}">{$f.title}</button>
                            </h3>
                            <div id="sms-intl-faq-{$i}" class="wui-collapse{if $i == 0} wui-show{/if}" data-wui-parent="#sms-intl-faq"><div class="wui-collapse-inner">
                                <div class="accordion-body">{$f.description nofilter}</div>
                            </div></div>
                        </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    </section>
    {/if}

{/block}
