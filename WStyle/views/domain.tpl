{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/domain.css'}">
{/block}

{block name=scripts}
<script src="{asset path='js/libs/wcp-table/table.js'}" defer></script>
<script src="{asset path='js/domain.js'}" defer></script>
{/block}

{block name=body_class}chrome-overlay{/block}

{block name=content}

    {capture assign=dm_badge_whois}{if $whois_privacy_free}{lang key='website/domain/hero-badge-whois'}{else}{lang key='website/domain/hero-badge-whois-paid'}{/if}{/capture}
    {capture assign=dm_badge_instant}{lang key='website/domain/hero-badge-instant'}{/capture}
    {capture assign=dm_badge_renewal}{lang key='website/domain/hero-badge-renewal'}{/capture}
    {capture assign=dm_hero_title}{lang key='website/domain/hero-title'}{/capture}
    {capture assign=dm_hero_lead}{lang key='website/domain/hero-lead'}{/capture}
    {include file='partials/page-hero.tpl'
        title=$dm_hero_title
        lead=$dm_hero_lead
        badges=[['icon' => 'bi bi-incognito', 'text' => $dm_badge_whois], ['icon' => 'bi bi-lightning-charge', 'text' => $dm_badge_instant], ['icon' => 'bi bi-tag', 'text' => $dm_badge_renewal]]}

    <section class="py-5" data-reveal>
        <div class="container">
            <div class="domain-tool">
                {if $visibility_cart}
                <span class="d-none" data-cart-add-url="{link route='cart'}"
                      data-cart-link="{link route='cart'}"
                      data-txt-cart-added="{lang key='website/domain/cart-added'}"
                      data-txt-cart-view="{lang key='website/domain/view-cart'}"
                      data-txt-cart-failed="{lang key='website/domain/cart-failed'}">{csrf form='cart'}</span>
                {/if}

                <ul class="nav nav-pills gap-1 mb-3" role="tablist">
                    <li class="nav-item" role="presentation"><button class="nav-link active" id="domain-tab-register" data-bs-toggle="tab" data-bs-target="#domain-pane-register" type="button" role="tab" aria-controls="domain-pane-register" aria-selected="true"><i class="bi bi-search me-1"></i>{lang key='website/domain/tab-register'}</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" id="domain-tab-transfer" data-bs-toggle="tab" data-bs-target="#domain-pane-transfer" type="button" role="tab" aria-controls="domain-pane-transfer" aria-selected="false"><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/domain/tab-transfer'}</button></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="domain-pane-register" role="tabpanel" aria-labelledby="domain-tab-register" tabindex="0">
                        <form action="{link route='domain'}" method="post" data-results="#domain-reg-results" data-check>
                            <div class="domain-search">
                                <label for="domain-reg-query" class="visually-hidden">{lang key='website/domain/search-label'}</label>
                                <input type="text" class="form-control" id="domain-reg-query" name="q" placeholder="{lang key='website/domain/search-placeholder'}" autocomplete="off" data-captcha-trigger="#domain-reg-captcha">
                                <button class="btn btn-primary" type="submit"><i class="bi bi-search me-1"></i>{lang key='website/domain/search-button'}</button>
                            </div>
                            {csrf form='domain-check'}
                            {captcha area='domain-check' tray='domain-reg-captcha'}
                        </form>

                        <div class="collapse" id="domain-reg-results">
                            <div class="search-results text-start mt-3">
                                <div class="card d-none" data-role="results-loading" aria-hidden="true">
                                    <div class="card-body p-3 p-md-4">
                                        <span class="wstyle-skeleton d-block w-50 mb-3"></span>
                                        <span class="wstyle-skeleton d-block w-100 mb-2"></span>
                                        <span class="wstyle-skeleton d-block w-75 mb-2"></span>
                                        <span class="wstyle-skeleton d-block w-25"></span>
                                    </div>
                                </div>
                                <div data-role="results-body">
                                    <div class="card result-primary" data-role="result-available">
                                        <div class="card-body d-flex flex-wrap align-items-center gap-3 p-3 p-md-4">
                                            <div class="me-auto">
                                                <div class="result-domain fw-bold num-tabular fs-4 mb-1"><span data-role="result-sld">example</span><span data-role="result-tld">.com</span></div>
                                                <div class="d-flex flex-wrap align-items-center gap-2">
                                                    <span class="badge bg-success-subtle text-success-emphasis" data-role="badge-available"><i class="bi bi-check-circle me-1"></i>{lang key='website/domain/result-available'}</span>
                                                    <span class="badge bg-warning-subtle text-warning-emphasis d-none" data-role="badge-premium"><i class="bi bi-gem me-1"></i>{lang key='website/domain/result-premium'}</span>
                                                    <span class="fs-8 text-body-secondary d-none" data-role="result-whois"><i class="bi bi-incognito me-1"></i>{lang key='website/domain/result-whois-free'}</span>
                                                </div>
                                            </div>
                                            <div class="text-end">
                                                <div class="num-tabular fw-bold fs-5"><span data-role="result-price">$5.99</span><span class="fs-8 text-body-secondary fw-normal">{lang key='website/domain/per-year'}</span><s class="price-was d-none" data-role="result-was"><span class="visually-hidden">{lang key='website/domain/was'} </span><span data-role="result-was-amount">$9.99</span></s></div>
                                                <div class="fs-8 text-body-secondary" data-role="result-renew-row">{lang key='website/domain/renews-at'} <span class="num-tabular" data-role="result-renew">$11.99</span>{lang key='website/domain/per-year'}</div>
                                            </div>
                                            <button class="btn btn-primary" type="button" data-action="result-add" data-variant="btn-primary" data-label-added="{lang key='website/domain/in-cart'}"><i class="bi bi-cart-plus me-1"></i>{lang key='website/domain/add-to-cart'}</button>
                                        </div>
                                    </div>
                                    <div class="card result-primary d-none" data-role="result-taken" aria-hidden="true">
                                        <div class="card-body d-flex flex-wrap align-items-center gap-3 p-3 p-md-4">
                                            <div class="me-auto">
                                                <div class="result-domain fw-bold num-tabular fs-4 mb-1" data-role="taken-domain">example.com</div>
                                                <div class="d-flex flex-wrap align-items-center gap-2">
                                                    <span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/domain/result-taken'}</span>
                                                    <span class="fs-8 text-body-secondary">{lang key='website/domain/result-taken-hint'}</span>
                                                </div>
                                            </div>
                                            <button class="btn btn-soft" type="button" data-action="whois-lookup"><i class="bi bi-card-list me-1"></i>{lang key='website/domain/whois-lookup'}</button>
                                        </div>
                                    </div>
                                    <div class="card result-primary d-none" data-role="result-unknown" aria-hidden="true">
                                        <div class="card-body d-flex flex-wrap align-items-center gap-3 p-3 p-md-4">
                                            <div class="me-auto">
                                                <div class="result-domain fw-bold num-tabular fs-4 mb-1" data-role="unknown-domain">example.com</div>
                                                <div class="d-flex flex-wrap align-items-center gap-2">
                                                    <span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-exclamation-triangle me-1"></i>{lang key='website/domain/result-unknown'}</span>
                                                    <span class="fs-8 text-body-secondary">{lang key='website/domain/result-unknown-hint'}</span>
                                                </div>
                                            </div>
                                            <button class="btn btn-soft" type="button" data-action="result-retry"><i class="bi bi-arrow-clockwise me-1"></i>{lang key='website/domain/retry'}</button>
                                        </div>
                                    </div>
                                    <div class="card mt-2 d-none" data-role="suggestions-card">
                                        <ul class="list-group list-group-flush" data-role="suggestions"></ul>
                                        <div class="border-top p-2 text-center">
                                            <a class="link-arrow fs-8" href="#tld-pricing">{lang key='website/domain/see-all-pricing'}<i class="bi bi-arrow-right"></i></a>
                                        </div>
                                    </div>
                                    <template data-role="suggestion-template">
                                        <li class="list-group-item d-flex flex-wrap align-items-center gap-3 p-3" data-role="result-suggestion">
                                            <span class="result-domain num-tabular" data-role="sug-domain"></span>
                                            <span class="badge bg-success-subtle text-success-emphasis d-none" data-role="sug-badge-available"><i class="bi bi-check-circle me-1"></i>{lang key='website/domain/result-available'}</span>
                                            <span class="badge bg-secondary-subtle text-secondary-emphasis d-none" data-role="sug-badge-taken"><i class="bi bi-x-circle me-1"></i>{lang key='website/domain/result-taken'}</span>
                                            <span class="badge bg-warning-subtle text-warning-emphasis d-none" data-role="sug-badge-unknown"><i class="bi bi-exclamation-triangle me-1"></i>{lang key='website/domain/result-unknown'}</span>
                                            <div class="ms-auto d-flex align-items-center gap-2">
                                                <span class="num-tabular fw-semibold d-none" data-role="sug-price-wrap"><span data-role="sug-price"></span><span class="fs-8 text-body-secondary fw-normal">{lang key='website/domain/per-year'}</span></span>
                                                <button class="btn btn-soft btn-sm d-none" type="button" data-action="result-add" data-variant="btn-soft" data-label-added="{lang key='website/domain/in-cart'}" data-role="sug-add"><i class="bi bi-cart-plus me-1"></i>{lang key='website/domain/add-to-cart'}</button>
                                                <button class="btn btn-soft btn-sm d-none" type="button" data-action="whois-lookup" data-role="sug-whois"><i class="bi bi-card-list me-1"></i>{lang key='website/domain/whois-lookup'}</button>
                                            </div>
                                        </li>
                                    </template>
                                    <div class="card selection-summary d-none mt-2" data-role="selection-summary" data-label-singular="{lang key='website/domain/summary-singular'}" data-label-plural="{lang key='website/domain/summary-plural'}" data-cart-url="{link route='cart'}" data-configure-url="{link route='configure-edit' p1='__KEY__'}" data-txt-view-cart="{lang key='website/domain/view-cart'}" data-txt-configure="{lang key='website/domain/configure'}">
                                        <div class="card-body d-flex flex-wrap align-items-center gap-2 p-3">
                                            <span class="fw-semibold"><span class="num-tabular" data-role="summary-count">0</span> <span data-role="summary-label">{lang key='website/domain/summary-plural'}</span></span>
                                            <span class="fs-7 text-body-secondary" data-role="summary-domains"></span>
                                            <span class="ms-auto fw-bold num-tabular"><span data-role="summary-total">$0.00</span><span class="fs-8 text-body-secondary fw-normal">{lang key='website/domain/per-year'}</span></span>
                                            <a class="btn btn-primary btn-sm" href="{link route='cart'}" data-role="summary-action"><i class="bi bi-cart3 me-1"></i>{lang key='website/domain/view-cart'}</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="domain-pane-transfer" role="tabpanel" aria-labelledby="domain-tab-transfer" tabindex="0">
                        <form action="{link route='domain'}" method="post" data-results="#domain-tr-results" data-price-column="transfer" data-check>
                            <input type="hidden" name="type" value="transfer">
                            <div class="domain-search">
                                <label for="domain-tr-query" class="visually-hidden">{lang key='website/domain/transfer-label'}</label>
                                <input type="text" class="form-control" id="domain-tr-query" name="q" placeholder="{lang key='website/domain/transfer-placeholder'}" autocomplete="off" data-captcha-trigger="#domain-tr-captcha">
                                <button class="btn btn-primary" type="submit"><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/domain/transfer-button'}</button>
                            </div>
                            {csrf form='domain-check'}
                            {captcha area='domain-check' tray='domain-tr-captcha'}
                        </form>

                        <div class="collapse" id="domain-tr-results">
                            <div class="search-results text-start mt-3">
                                <div class="card d-none" data-role="results-loading" aria-hidden="true">
                                    <div class="card-body p-3 p-md-4">
                                        <span class="wstyle-skeleton d-block w-50 mb-3"></span>
                                        <span class="wstyle-skeleton d-block w-100 mb-2"></span>
                                        <span class="wstyle-skeleton d-block w-25"></span>
                                    </div>
                                </div>
                                <div data-role="results-body">
                                    <div class="card result-primary" data-role="result-available">
                                        <div class="card-body d-flex flex-wrap align-items-center gap-3 p-3 p-md-4">
                                            <div class="me-auto">
                                                <div class="result-domain fw-bold num-tabular fs-4 mb-1"><span data-role="result-sld">example</span><span data-role="result-tld">.com</span></div>
                                                <div class="d-flex flex-wrap align-items-center gap-2">
                                                    <span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-arrow-down-circle me-1"></i>{lang key='website/domain/result-transfer-in'}</span>
                                                    <span class="fs-8 text-body-secondary"><i class="bi bi-calendar-plus me-1"></i>{lang key='website/domain/transfer-extension'}</span>
                                                </div>
                                            </div>
                                            <div class="text-end">
                                                <div class="num-tabular fw-bold fs-5"><span data-role="result-price">$9.59</span><span class="fs-8 text-body-secondary fw-normal"> {lang key='website/domain/one-time'}</span></div>
                                                <div class="fs-8 text-body-secondary" data-role="result-renew-row">{lang key='website/domain/renews-at'} <span class="num-tabular" data-role="result-renew">$11.99</span>{lang key='website/domain/per-year'}</div>
                                            </div>
                                            <button class="btn btn-primary" type="button" data-action="result-add" data-variant="btn-primary" data-label-added="{lang key='website/domain/in-cart'}"><i class="bi bi-cart-plus me-1"></i>{lang key='website/domain/add-to-cart'}</button>
                                        </div>
                                        <div class="border-top p-3">
                                            <label for="domain-tr-auth" class="form-label fs-7 fw-semibold mb-1">{lang key='website/domain/auth-code-label'}</label>
                                            <input type="text" class="form-control transfer-auth-input" id="domain-tr-auth" placeholder="{lang key='website/domain/auth-code-placeholder'}" autocomplete="off" data-role="transfer-auth">
                                            <div class="invalid-feedback">{lang key='website/domain/auth-code-invalid'}</div>
                                            <div class="form-text fs-8">{lang key='website/domain/auth-code-hint'}</div>
                                        </div>
                                        <div class="border-top px-3 py-2 d-flex flex-wrap gap-3 fs-8 text-body-secondary">
                                            <span><i class="bi bi-key me-1"></i>{lang key='website/domain/transfer-req-epp'}</span>
                                            <span><i class="bi bi-unlock me-1"></i>{lang key='website/domain/transfer-req-unlock'}</span>
                                            <span><i class="bi bi-clock-history me-1"></i>{lang key='website/domain/transfer-req-time'}</span>
                                        </div>
                                    </div>
                                    <div class="card result-primary d-none" data-role="result-taken" aria-hidden="true">
                                        <div class="card-body p-3 p-md-4">
                                            <div class="d-flex flex-wrap align-items-center gap-2">
                                                <div class="result-domain fw-bold num-tabular fs-4 me-auto" data-role="taken-domain">example.com</div>
                                                <span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-exclamation-triangle me-1"></i>{lang key='website/domain/transfer-ineligible'}</span>
                                            </div>
                                            <span class="fs-8 text-body-secondary d-block mt-2">{lang key='website/domain/transfer-ineligible-hint'}</span>
                                        </div>
                                    </div>
                                    <div class="card result-primary d-none" data-role="result-unknown" aria-hidden="true">
                                        <div class="card-body d-flex flex-wrap align-items-center gap-3 p-3 p-md-4">
                                            <div class="me-auto">
                                                <div class="result-domain fw-bold num-tabular fs-4 mb-1" data-role="unknown-domain">example.com</div>
                                                <div class="d-flex flex-wrap align-items-center gap-2">
                                                    <span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-exclamation-triangle me-1"></i>{lang key='website/domain/result-unknown'}</span>
                                                    <span class="fs-8 text-body-secondary">{lang key='website/domain/result-unknown-hint'}</span>
                                                </div>
                                            </div>
                                            <button class="btn btn-soft" type="button" data-action="result-retry"><i class="bi bi-arrow-clockwise me-1"></i>{lang key='website/domain/retry'}</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <p class="fs-8 text-body-secondary mt-2 mb-0">{lang key='website/domain/transfer-note'}</p>
                    </div>
                </div>
            </div>

            {hook name='ui:client.domain.search.after'}
        </div>
    </section>

    <section class="py-5 bg-surface" id="tld-pricing" data-reveal>
        <div class="container">
            <div class="section-head">
                <span class="eyebrow">{lang key='website/domain/pricing-eyebrow'}</span>
                <h2 class="tracking-tight">{lang key='website/domain/pricing-heading'}</h2>
                <p class="section-lead">{lang key='website/domain/pricing-subtitle'}</p>
            </div>

            {if $tlds}
            <div class="wcp-table" data-name="tld-pricing">
                <div class="d-flex flex-wrap align-items-center gap-2 mb-3">
                    <ul class="nav nav-pills gap-1" data-role="tld-categories">
                        <li class="nav-item"><button class="nav-link active" type="button" data-action="tld-category" data-category="all">{lang key='website/domain/category-all'}</button></li>
                        {foreach $tld_categories as $cat}
                        <li class="nav-item"><button class="nav-link" type="button" data-action="tld-category" data-category="{$cat.key}">{$cat.label}</button></li>
                        {/foreach}
                    </ul>
                    <input type="hidden" id="tld-category-filter" data-table-filter="tld-pricing" data-filter-column="category" data-filter-source="row" data-filter-type="list">
                    <div class="tld-search ms-auto">
                        <label for="tld-search-input" class="visually-hidden">{lang key='website/domain/filter-label'}</label>
                        <input type="search" class="form-control wcp-search-input" id="tld-search-input" placeholder="{lang key='website/domain/filter-placeholder'}" data-role="tld-search" autocomplete="off">
                    </div>
                </div>

                <div class="card">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0 tld-table" data-role="tld-table">
                            <thead>
                                <tr>
                                    <th scope="col" data-column="extension">{lang key='website/domain/th-extension'}</th>
                                    <th scope="col" class="text-end" data-column="register" data-sortable="true">{lang key='website/domain/th-register'}</th>
                                    <th scope="col" class="text-end" data-column="transfer" data-sortable="true">{lang key='website/domain/th-transfer'}</th>
                                    <th scope="col" class="text-end" data-column="renew" data-sortable="true">{lang key='website/domain/th-renew'}</th>
                                    <th scope="col" class="text-end"><span class="visually-hidden">{lang key='website/domain/th-actions'}</span></th>
                                </tr>
                            </thead>
                            <tbody class="wcp-table-body">
                                {foreach $tlds as $t}
                                <tr{if $t.register.was} class="sale-row"{/if} data-tld=".{$t.name}" data-filter-category="{$t.categories}">
                                    <th scope="row" class="tld-name num-tabular" data-value="{$t.name}"><bdi>.{$t.name}</bdi>{if $t.register.was}<span class="badge bg-success-subtle text-success-emphasis ms-2"><i class="bi bi-tag me-1"></i>{lang key='website/domain/badge-sale'}</span>{/if}</th>
                                    <td class="text-end num-tabular" data-value="{$t.register.amount}">{$t.register.display}{if $t.register.was}<s class="price-was"><span class="visually-hidden">{lang key='website/domain/was'} </span>{$t.register.was_display}</s>{/if}</td>
                                    <td class="text-end num-tabular" data-value="{if $t.transfer}{$t.transfer.amount}{else}0{/if}">{if $t.transfer}{$t.transfer.display}{else}<span class="text-body-secondary">-</span>{/if}</td>
                                    <td class="text-end num-tabular" data-value="{if $t.renewal}{$t.renewal.amount}{else}0{/if}">{if $t.renewal}{$t.renewal.display}{else}<span class="text-body-secondary">-</span>{/if}</td>
                                    <td class="text-end"><button class="btn btn-soft btn-sm" type="button" data-action="tld-register">{lang key='website/domain/btn-register'}</button></td>
                                </tr>
                                {/foreach}
                            </tbody>
                            <tbody class="wcp-table-loader-body d-none">
                                <tr>
                                    <td colspan="5">
                                        <div class="wcp-table-loader"><div class="spinner-border text-secondary" role="status"><span class="visually-hidden">{lang key='website/domain/loading'}</span></div></div>
                                    </td>
                                </tr>
                            </tbody>
                            <tbody class="wcp-table-no-result-body d-none">
                                <tr>
                                    <td colspan="5">
                                        <div class="wcp-table-no-result wcp-empty-state">
                                            <i class="bi bi-search"></i>
                                            <p class="mb-0">{lang key='website/domain/no-extensions'}</p>
                                            <button class="btn btn-soft btn-sm" type="button" data-action="tld-clear">{lang key='website/domain/clear-search'}</button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="wcp-table-footer d-flex flex-wrap justify-content-between align-items-center gap-2 mt-3">
                    <div class="wcp-table-info num-tabular fs-7 text-body-secondary" data-msg1="{lang key='website/domain/info-none'}" data-msg2="{lang key='website/domain/info-filtered'}" data-msg3="{lang key='website/domain/info-showing'}"></div>
                    <div class="d-flex flex-wrap align-items-center gap-3">
                        <div class="d-flex align-items-center gap-2">
                            <label for="tld-per-page" class="fs-7 text-body-secondary mb-0">{lang key='website/domain/per-page'}</label>
                            <select class="form-select form-select-sm w-auto wcp-entries-select" id="tld-per-page" aria-label="{lang key='website/domain/per-page'}">
                                <option value="10">10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="-1">{lang key='website/domain/per-page-all'}</option>
                            </select>
                        </div>
                        <nav class="wcp-table-pagination" aria-label="{lang key='website/domain/pagination-aria'}">
                            <ul class="pagination pagination-sm mb-0"></ul>
                        </nav>
                    </div>
                </div>
            </div>
            <p class="fs-8 text-body-secondary mt-2 mb-0">{lang key='website/domain/prices-in'} <span data-role="currency-label">{$selected_currency_code}</span>. {lang key='website/domain/prices-promo-note'}</p>
            {else}
            <div class="card">
                <div class="card-body wcp-empty-state">
                    <i class="bi bi-globe2"></i>
                    <p class="mb-0">{lang key='website/domain/no-tlds'}</p>
                </div>
            </div>
            {/if}
        </div>
    </section>

    <section class="band-dark chrome-dark py-5" data-reveal>
        <div class="container">
            {if $includes_content}{content var=$includes_content}{else}
            <div class="section-head">
                <span class="eyebrow">{lang key='website/domain/included-eyebrow'}</span>
                <h2 class="tracking-tight">{lang key='website/domain/included-heading'}</h2>
                <p class="section-lead">{if $includes_no_extra_cost}{lang key='website/domain/included-subtitle'}{else}{lang key='website/domain/included-subtitle-paid'}{/if}</p>
            </div>
            <div class="row g-3">
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-incognito"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{if $whois_privacy_free}{lang key='website/domain/included-1-title'}{else}{lang key='website/domain/included-1-title-paid'}{/if}{if !$whois_privacy_free}<span class="badge bg-secondary-subtle text-secondary-emphasis ms-2"><i class="bi bi-plus-circle me-1"></i>{lang key='website/domain/included-badge-addon'}</span>{/if}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/domain/included-1-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-diagram-3"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{lang key='website/domain/included-2-title'}{if !$dns_manage_free}<span class="badge bg-secondary-subtle text-secondary-emphasis ms-2"><i class="bi bi-plus-circle me-1"></i>{lang key='website/domain/included-badge-addon'}</span>{/if}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/domain/included-2-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-arrow-repeat"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{lang key='website/domain/included-3-title'}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/domain/included-3-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-shield-lock"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{lang key='website/domain/included-4-title'}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/domain/included-4-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {/if}
        </div>
    </section>

    {if $faqs}
    <section class="py-5" data-reveal>
        <div class="container">
            <div class="row g-4 g-lg-5">
                <div class="col-lg-4">
                    <div class="section-head section-head-start mb-3">
                        <span class="eyebrow">{lang key='website/domain/faq-eyebrow'}</span>
                        <h2 class="tracking-tight">{lang key='website/domain/faq-heading'}</h2>
                    </div>
                    <a class="link-arrow fs-7" href="{link route='kbase'}">{lang key='website/products/category-faq-kb'}<i class="bi bi-arrow-right"></i></a>
                </div>
                <div class="col-lg-8">
                    <div class="accordion domain-faq" id="domain-faq">
                        {foreach $faqs as $i => $f}
                        <div class="accordion-item">
                            <h3 class="accordion-header">
                                <button class="accordion-button fw-semibold{if $i > 0} collapsed{/if}" type="button" data-wui-toggle data-wui-target="#faq-{$i}" aria-expanded="{if $i == 0}true{else}false{/if}" aria-controls="faq-{$i}">{$f.title}</button>
                            </h3>
                            <div id="faq-{$i}" class="wui-collapse{if $i == 0} wui-show{/if}" data-wui-parent="#domain-faq"><div class="wui-collapse-inner">
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

{block name=body_end}
    <div class="modal fade" id="whoisModal" tabindex="-1" aria-labelledby="whoisModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title h5 mb-0" id="whoisModalLabel"><i class="bi bi-card-list me-2"></i>{lang key='website/domain/whois-modal-title'} <span class="num-tabular fw-bold" data-role="whois-domain"></span></h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/domain/whois-close'}"></button>
                </div>
                <div class="modal-body">
                    <div class="d-flex align-items-center gap-2 text-body-secondary" data-role="whois-loading">
                        <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                        <span>{lang key='website/domain/whois-loading'}</span>
                    </div>
                    <pre class="whois-record d-none mb-0" data-role="whois-record"></pre>
                    <div class="wcp-empty-state d-none" data-role="whois-empty">
                        <i class="bi bi-search"></i>
                        <p class="mb-0">{lang key='website/domain/whois-empty'}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}
