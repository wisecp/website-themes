{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='js/libs/tom-select/tom-select.bootstrap5.min.css'}">
<link rel="stylesheet" href="{asset path='js/libs/intl-tel-input/css/intlTelInput.min.css'}">
<link rel="stylesheet" href="{asset path='css/category-sms-international.css'}">
<script src="{asset path='js/libs/tom-select/tom-select.complete.min.js'}" defer></script>
<script src="{asset path='js/category-sms-international.js'}" defer></script>
{/block}

{block name=content}

    <section class="page-hero text-center">
        <div class="container">
            <h1 class="page-hero-title reveal mb-3">{lang key='website/sms/hero-title'}</h1>
            <p class="page-hero-lead text-body-secondary reveal reveal-2 mb-4">{lang key='website/sms/hero-lead'}</p>
            <div class="d-flex flex-wrap justify-content-center gap-4 fs-8 text-body-secondary reveal reveal-3">
                <span><i class="bi bi-globe-americas me-1 text-success"></i>{lang key='website/sms/hero-badge-countries'}</span>
                <span><i class="bi bi-send me-1 text-success"></i>{lang key='website/sms/hero-badge-speed'}</span>
                <span><i class="bi bi-graph-up me-1 text-success"></i>{lang key='website/sms/hero-badge-reports'}</span>
            </div>
        </div>
    </section>

    <section class="pb-5">
        <div class="container">
            <div class="card sms-calc mx-auto" data-currency="{$selected_currency_code}">
                <div class="card-body p-4 p-lg-5">
                    <div class="text-center mb-4">
                        <span class="eyebrow">{lang key='website/sms/calc-eyebrow'}</span>
                        <h2 class="h4 tracking-tight mt-1 mb-1">{lang key='website/sms/calc-title'}</h2>
                        <p class="fs-7 text-body-secondary mb-0">{lang key='website/sms/calc-subtitle'}</p>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-12 col-md-8 col-lg-7">
                            <label for="sms-calc-country" class="form-label">{lang key='website/sms/calc-country-label'}</label>
                            <select class="form-select" id="sms-calc-country" data-basic-select data-flag-select data-search-placeholder="{lang key='website/sms/calc-search'}">
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

    <section class="py-5 border-top" id="rate-table">
        <div class="container">
            <div class="text-center mb-4">
                <span class="eyebrow">{lang key='website/sms/table-eyebrow'}</span>
                <h2 class="tracking-tight mt-1 mb-2">{lang key='website/sms/table-title'}</h2>
                <p class="text-body-secondary mb-0">{lang key='website/sms/table-subtitle'}</p>
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
                                    <div class="basic-empty-state">
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

    <section class="py-5 border-top border-bottom">
        <div class="container">
            <div class="text-center mb-5">
                <span class="eyebrow">{lang key='website/sms/incl-eyebrow'}</span>
                <h2 class="tracking-tight mt-1 mb-2">{lang key='website/sms/incl-title'}</h2>
                <p class="text-body-secondary mb-0">{lang key='website/sms/incl-subtitle'}</p>
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
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <span class="eyebrow">{lang key='website/sms/faq-eyebrow'}</span>
                <h2 class="tracking-tight mt-1 mb-0">{lang key='website/sms/faq-heading'}</h2>
            </div>
            <div class="accordion page-faq" id="sms-intl-faq">
                {foreach $faqs as $i => $f}
                <div class="accordion-item">
                    <h3 class="accordion-header">
                        <button class="accordion-button fw-semibold{if $i > 0} collapsed{/if}" type="button" data-bs-toggle="collapse" data-bs-target="#sms-intl-faq-{$i}" aria-expanded="{if $i == 0}true{else}false{/if}" aria-controls="sms-intl-faq-{$i}">{$f.title}</button>
                    </h3>
                    <div id="sms-intl-faq-{$i}" class="accordion-collapse collapse{if $i == 0} show{/if}" data-bs-parent="#sms-intl-faq">
                        <div class="accordion-body">{$f.description nofilter}</div>
                    </div>
                </div>
                {/foreach}
            </div>
        </div>
    </section>
    {/if}

    {include file='components/cta-band.tpl'
        cta_title_key='website/sms/cta-title'
        cta_text_key='website/sms/cta-text'
        cta_primary_key='website/sms/cta-primary'
        cta_secondary_key='website/sms/cta-secondary'}

{/block}
