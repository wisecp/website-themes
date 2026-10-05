{extends file='layouts/checkout.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='js/libs/tom-select/tom-select.bootstrap5.min.css'}">
    <link rel="stylesheet" href="{asset path='js/libs/intl-tel-input/css/intlTelInput.min.css'}">
    <link rel="stylesheet" href="{asset path='css/configure.css'}">
    <script src="{asset path='js/libs/tom-select/tom-select.complete.min.js'}" defer></script>
    <script src="{asset path='js/libs/intl-tel-input/js/intlTelInput.min.js'}" defer></script>
    {if ($ui_lang|default:'en') != 'en'}<script type="module">import i18n from "{$sadress}assets/plugins/intlTelInput/js/i18n/{$ui_lang}/index.js"; window.wcpItiI18n = i18n;</script>{/if}
{/block}

{block name=scripts}
    <script src="{asset path='js/configure.js'}" defer></script>
{/block}

{block name=content}

    <form id="configure-form" action="{link route='cart'}" method="post" novalidate data-configure data-product
          data-cart-op="{if $edit_item}update_item{else}add_item{/if}"
          data-txt-submit-failed="{lang key='website/configure/submit-failed'}"
          data-currency="{$currency}"
          data-billed-map="{$billed_map_json}"
          data-cycle-map="{$cycle_map_json}"
          data-save-text="{lang key='website/products/category-save'}"
          data-permonth-suffix="{lang key='website/products/category-per-month'}"
          data-renews-at="{lang key='website/configure/renews-at'}"
          data-one-time="{lang key='website/configure/one-time-renewal'}"
          {if $prorate.enabled}data-prorate-days="{$prorate.days}"
          data-prorate-date="{$prorate.date_long}"
          data-prorate-ratios="{$prorate.ratios_json}"
          data-prorate-note="{lang key='website/configure/prorate-note'}"
          {/if}
          {if $edit_item}data-adding-to-cart="{lang key='website/configure/edit-domain/updating'}"
          data-item-key="{$edit_item.key}"
          {else}data-adding-to-cart="{lang key='website/configure/adding-to-cart'}"
          {/if}{if $edit_domain}data-edit-domain="{$edit_domain.action}"
          data-domain-name="{$edit_domain.domain}"
          data-domain-years-map="{$edit_domain.years_map}"
          data-domain-years="{$edit_domain.years}"
          data-domain-renew="{$edit_domain.renew_raw}"
          data-domain-price="{$edit_domain.price_raw}"
          data-domain-addons="{$domain_addons_json}"
          data-domain-requirements="{$domain_requirements_json}"
          data-preset-addons="{$preset_addons_json}"
          data-req-values="{$req_values_json}"
          data-req-files="{$req_files_json}"
          {/if}{if $domain_section.visible && $domain_section.mode == 'chooser'}data-domain-check-url="{$domain_section.check_url}"
          data-domain-required="{if $domain_section.required}1{else}0{/if}"
          {if $domain_section.free_json}data-free-domain="{$domain_section.free_json}"{/if}
          data-txt-available-line="{lang key='website/configure/domain/available-line'}"
          data-txt-available-line-norenew="{lang key='website/configure/domain/available-line-norenew'}"
          data-txt-addon-included="{lang key='website/configure/domain/addon-included'}"
          data-txt-addon-per-year="{lang key='website/configure/domain/addon-per-year'}"
          data-txt-year-one="{lang key='website/configure/domain/year-one'}"
          data-txt-year-many="{lang key='website/configure/domain/year-many'}"
          data-txt-per-year="{lang key='website/configure/domain/per-year'}"
          data-txt-free="{lang key='website/configure/domain/free-label'}"
          data-txt-was="{lang key='website/configure/domain/was'}"
          data-txt-search-failed="{lang key='website/configure/domain/search-failed'}"
          data-txt-transfer-ok="{lang key='website/configure/domain/transfer-ok'}"
          data-txt-transfer-notreg="{lang key='website/configure/domain/transfer-not-registered'}"
          data-txt-transfer-unsupported="{lang key='website/configure/domain/transfer-unsupported'}"
          data-txt-domain-registration="{lang key='website/configure/domain/summary-registration'}"
          data-txt-domain-transfer="{lang key='website/configure/domain/summary-transfer'}"
          data-txt-first-year-sub="{lang key='website/configure/domain/summary-first-year'}"
          data-txt-transfer-sub="{lang key='website/configure/domain/summary-transfer-sub'}"
          data-txt-req-select="{lang key='website/configure/domain/req-select'}"
          data-txt-req-browse="{lang key='website/configure/domain/req-browse'}"
          data-txt-req-drop="{lang key='website/configure/domain/req-drop'}"
          {/if}{foreach $prices as $cycle => $amount} data-{$cycle}="{$amount}"{/foreach}{foreach $setups as $cycle => $amount} data-setup-{$cycle}="{$amount}"{/foreach} data-txt-setup-note="{lang key='website/configure/setup-note'}" data-txt-free-first="{lang key='website/configure/addons/free-first-summary'}" data-txt-first-term="{lang key='website/configure/addons/first-term'}" data-txt-free-first-note="{lang key='website/configure/addons/free-first-note'}" data-txt-addon-free="{lang key='website/configure/addons/free'}">
        <input type="hidden" name="product_id" value="{$product.id}">
        {if $edit_item}<input type="hidden" name="item_key" value="{$edit_item.key}">{/if}
        <div class="checkout-split">
            <div class="checkout-split-main">
                <div class="checkout-split-main-inner">

                    <div class="mb-4">
                        <span class="eyebrow" data-config-eyebrow>{$group_name}</span>
                        <h1 class="tracking-tight mt-1 mb-0" data-config-title>{lang key='website/configure/page-title'}</h1>
                    </div>

                    <div class="d-flex flex-column gap-4">

                            <div class="card" data-hosting-section>
                                <div class="card-body p-4 d-flex align-items-center gap-3">
                                    <span class="icon-disc{if $product.icon.kind == 'logo'} is-logo{/if}" aria-hidden="true">{if $product.icon.kind == 'logo'}<img src="{$product.icon.src}" alt="">{else}<i class="{$product.icon.class|default:'bi bi-hdd-stack'}"></i>{/if}</span>
                                    <div>
                                        <h2 class="h5 mb-1">{$product.title}</h2>
                                        {if $product.tagline}<p class="fs-7 text-body-secondary mb-0">{$product.tagline}</p>{/if}
                                    </div>
                                    <a class="btn btn-soft btn-sm ms-auto" href="{$group_link}">{lang key='website/configure/change-plan'}</a>
                                </div>
                            </div>

                            {if $cycles}
                            <div class="card" data-product-section>
                                <div class="card-body p-4">
                                    <div class="config-section-head">
                                        <span class="icon-disc"><i class="bi bi-calendar-check"></i></span>
                                        <div>
                                            <h2 class="h6 fw-semibold">{lang key='website/configure/billing-cycle'}</h2>
                                            <p class="fs-8 text-body-secondary mb-0">{lang key='website/configure/billing-cycle-desc'}</p>
                                        </div>
                                    </div>
                                    <div class="billing-cycle-grid" data-billing-cycles>
                                        {foreach $cycles as $cycle}
                                        <label class="option-card option-card-radio billing-cycle-card" data-billed="{$cycle.billed}" data-renew="{$cycle.renew}">
                                            <input class="form-check-input" type="radio" name="billing_cycle" value="{$cycle.key}"{if $cycle.key == $default_cycle} checked{/if}>
                                            <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-1">
                                                <span class="billing-cycle-name">{$cycle.label}</span>
                                                <span class="badge bg-success-subtle text-success-emphasis fw-semibold d-none" data-role="cycle-savings"></span>
                                            </div>
                                            <div class="billing-cycle-figures">
                                                <span class="billing-cycle-price" data-role="cycle-price"></span>
                                                <span class="billing-cycle-permonth fs-8 d-none" data-role="cycle-permonth"></span>
                                                <span class="fs-8 text-body-secondary d-none" data-role="cycle-setup"></span>
                                            </div>
                                        </label>
                                        {/foreach}
                                    </div>
                                </div>
                            </div>
                            {/if}

                            {if $domain_section.visible}
                            {if $domain_section.mode == 'license'}
                            <div class="card" data-software-section>
                                <div class="card-body p-4">
                                    <div class="config-section-head">
                                        <span class="icon-disc"><i class="bi bi-key"></i></span>
                                        <div>
                                            <h2 class="h6 fw-semibold">{lang key='website/configure/license/title'}</h2>
                                            <p class="fs-8 text-body-secondary mb-0">{if $domain_section.need_domain}{lang key='website/configure/license/desc-domain'}{else}{lang key='website/configure/license/desc-ip'}{/if}</p>
                                        </div>
                                    </div>
                                    <div class="row g-3">
                                        {if $domain_section.need_domain}
                                        <div class="col-sm-6">
                                            <label for="cfg-sw-domain" class="form-label d-flex align-items-center gap-2"><span class="label-media"><i class="bi bi-globe2"></i></span>{lang key='website/configure/license/domain-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                                            <input type="text" class="form-control" id="cfg-sw-domain" name="license_domain" placeholder="{lang key='website/configure/license/domain-placeholder'}" autocomplete="off" value="{$domain_preset.license_domain|default:''}" required>
                                            <div class="invalid-feedback">{lang key='website/configure/license/domain-invalid'}</div>
                                        </div>
                                        {/if}
                                        {if $domain_section.need_ip}
                                        <div class="col-sm-6">
                                            <label for="cfg-sw-ip" class="form-label d-flex align-items-center gap-2"><span class="label-media"><i class="bi bi-ethernet"></i></span>{lang key='website/configure/license/ip-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                                            <input type="text" class="form-control" id="cfg-sw-ip" name="license_ip" placeholder="198.51.100.10" autocomplete="off" inputmode="numeric" value="{$domain_preset.license_ip|default:''}" required>
                                            <div class="invalid-feedback">{lang key='website/configure/license/ip-invalid'}</div>
                                        </div>
                                        {/if}
                                    </div>
                                    <div class="form-text"><i class="bi bi-info-circle me-1"></i>{if $domain_section.need_domain}{lang key='website/configure/license/note-domain'} {if $domain_section.can_change}{lang key='website/configure/license/note-domain-change'}{else}{lang key='website/configure/license/note-domain-nochange'}{/if}{else}{lang key='website/configure/license/note-ip'} {if $domain_section.can_change}{lang key='website/configure/license/note-ip-change'}{else}{lang key='website/configure/license/note-ip-nochange'}{/if}{/if}</div>
                                </div>
                            </div>
                            {else}
                            <div class="card" data-domain-section>
                                <div class="card-body p-4">
                                    <div class="config-section-head">
                                        <span class="icon-disc"><i class="bi bi-globe2"></i></span>
                                        <div>
                                            <h2 class="h6 fw-semibold">{lang key='website/configure/domain/title'}{if $domain_section.required} <span class="text-danger" aria-hidden="true">*</span>{/if}</h2>
                                            <p class="fs-8 text-body-secondary mb-0">{lang key='website/configure/domain/desc'}</p>
                                        </div>
                                    </div>

                                    <div class="btn-group w-100{if $domain_section.tab_count <= 1} d-none{/if}" role="group" aria-label="Domain option">
                                        {if $domain_section.tabs.register}
                                        <input type="radio" class="btn-check" name="domain_option" id="dom-register" value="register"{if $domain_section.default_tab == 'register'} checked{/if}>
                                        <label class="btn btn-soft" for="dom-register">{lang key='website/configure/domain/tab-register'}</label>
                                        {/if}
                                        {if $domain_section.tabs.transfer}
                                        <input type="radio" class="btn-check" name="domain_option" id="dom-transfer" value="transfer" data-price="0"{if $domain_section.default_tab == 'transfer'} checked{/if}>
                                        <label class="btn btn-soft" for="dom-transfer">{lang key='website/configure/domain/tab-transfer'}</label>
                                        {/if}
                                        {if $domain_section.tabs.subdomain}
                                        <input type="radio" class="btn-check" name="domain_option" id="dom-subdomain" value="subdomain" data-price="0"{if $domain_section.default_tab == 'subdomain'} checked{/if}>
                                        <label class="btn btn-soft" for="dom-subdomain">{lang key='website/configure/domain/tab-subdomain'}</label>
                                        {/if}
                                        <input type="radio" class="btn-check" name="domain_option" id="dom-owned" value="owned" data-price="0"{if $domain_section.default_tab == 'owned'} checked{/if}>
                                        <label class="btn btn-soft" for="dom-owned">{lang key='website/configure/domain/tab-owned'}</label>
                                    </div>

                                    {if $domain_section.tabs.register || $domain_section.tabs.transfer}
                                    {csrf form='domain-check'}
                                    {captcha area='domain-check' tray='cfgDomainCaptcha'}
                                    {/if}

                                    {if $domain_section.tabs.register}
                                    <div class="pt-3{if $domain_section.default_tab != 'register'} d-none{/if}" data-domain-pane="register">
                                        <div data-domain-search-wrap>
                                            <label for="cfg-domain-search" class="form-label">{lang key='website/configure/domain/find-label'}</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="bi bi-search"></i></span>
                                                <input type="text" class="form-control" id="cfg-domain-search" placeholder="{lang key='website/configure/domain/search-placeholder'}" autocomplete="off" enterkeyhint="search">
                                                <button class="btn btn-primary" type="button" data-domain-check>{lang key='website/configure/domain/search-btn'}</button>
                                            </div>
                                            <div class="form-text">{lang key='website/configure/domain/search-help'}</div>
                                            <div class="invalid-feedback d-block d-none" data-domain-search-error></div>

                                            <div class="pt-3 d-none" data-domain-loading>
                                                <div class="domain-result">
                                                    <span class="basic-skeleton w-50"></span>
                                                    <span class="basic-skeleton w-25 ms-auto"></span>
                                                </div>
                                            </div>

                                            <div class="pt-3 d-none" data-domain-available>
                                                <div class="domain-result domain-result-available flex-wrap">
                                                    <i class="bi bi-check-circle-fill text-success fs-5" aria-hidden="true"></i>
                                                    <div class="me-auto">
                                                        <span class="fw-semibold" data-result-name></span>
                                                        <span class="badge bg-warning-subtle text-warning-emphasis d-none ms-1" data-role="badge-premium"><i class="bi bi-gem me-1"></i>{lang key='website/configure/domain/premium'}</span>
                                                        <span class="badge bg-success-subtle text-success-emphasis d-none ms-1" data-role="badge-sale"><i class="bi bi-tag me-1"></i>{lang key='website/configure/domain/sale'}</span>
                                                        <span class="fs-8 text-body-secondary d-block" data-role="result-price-line"></span>
                                                    </div>
                                                    <select class="form-select form-select-sm w-auto" data-domain-years aria-label="Registration period">
                                                        <option value="1" selected>1</option>
                                                        <option value="2">2</option>
                                                        <option value="3">3</option>
                                                        <option value="4">4</option>
                                                        <option value="5">5</option>
                                                        <option value="6">6</option>
                                                        <option value="7">7</option>
                                                        <option value="8">8</option>
                                                        <option value="9">9</option>
                                                        <option value="10">10</option>
                                                    </select>
                                                    <button class="btn btn-primary btn-sm" type="button" data-domain-select data-years="">{lang key='website/configure/domain/use-this'}</button>
                                                </div>
                                            </div>

                                            <div class="pt-3 d-none" data-domain-taken>
                                                <div class="domain-result domain-result-taken mb-2">
                                                    <i class="bi bi-x-circle-fill text-danger fs-5" aria-hidden="true"></i>
                                                    <div><span class="fw-semibold" data-result-name></span> <span class="fs-7 text-body-secondary">{lang key='website/configure/domain/taken-note'}</span></div>
                                                </div>
                                                <div class="domain-suggestions" data-domain-suggestions></div>
                                                <template data-role="suggestion-template">
                                                    <div class="domain-suggestion">
                                                        <span class="fw-semibold" data-suggestion-name></span>
                                                        <span class="badge bg-warning-subtle text-warning-emphasis d-none ms-1" data-role="badge-premium"><i class="bi bi-gem me-1"></i>{lang key='website/configure/domain/premium'}</span>
                                                        <span class="badge bg-success-subtle text-success-emphasis d-none ms-1" data-role="badge-sale"><i class="bi bi-tag me-1"></i>{lang key='website/configure/domain/sale'}</span>
                                                        <span class="fs-8 text-body-secondary ms-auto num-tabular" data-suggestion-price></span>
                                                        <button class="btn btn-soft btn-sm" type="button" data-domain-select data-years="">{lang key='website/configure/domain/select-btn'}</button>
                                                    </div>
                                                </template>
                                            </div>
                                        </div>

                                        <div class="d-none" data-domain-selected-box>
                                            <div class="domain-result domain-result-available flex-wrap">
                                                <i class="bi bi-check-circle-fill text-success fs-5" aria-hidden="true"></i>
                                                <div class="me-auto">
                                                    <span class="fw-semibold d-block" data-selected-name></span>
                                                    <span class="fs-8 text-body-secondary" data-role="selected-price-line"><span class="num-tabular" data-selected-price></span> <span data-role="selected-for">{lang key='website/configure/domain/selected-for'}</span> <span data-selected-years-label></span><span data-role="selected-with-plan">{lang key='website/configure/domain/selected-with-plan'}</span></span>
                                                </div>
                                                <select class="form-select form-select-sm w-auto" data-domain-years-selected aria-label="Registration period">
                                                    <option value="1" selected>1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                    <option value="6">6</option>
                                                    <option value="7">7</option>
                                                    <option value="8">8</option>
                                                    <option value="9">9</option>
                                                    <option value="10">10</option>
                                                </select>
                                                <button class="btn btn-soft btn-sm" type="button" data-domain-change>{lang key='website/configure/domain/change-btn'}</button>
                                            </div>
                                        </div>
                                        <input type="hidden" name="domain_name" id="cfg-domain-selected">
                                        <input type="hidden" name="domain_years" id="cfg-domain-years" value="1">
                                    </div>
                                    {/if}

                                    {if $domain_section.tabs.transfer}
                                    <div class="pt-3{if $domain_section.default_tab != 'transfer'} d-none{/if}" data-domain-pane="transfer">
                                        <div data-transfer-search-wrap>
                                            <label for="cfg-transfer-domain" class="form-label">{lang key='website/configure/domain/transfer-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="bi bi-search"></i></span>
                                                <input type="text" class="form-control" id="cfg-transfer-domain" name="transfer_domain" placeholder="{lang key='website/configure/domain/search-placeholder'}" autocomplete="off" enterkeyhint="search" value="{$domain_preset.transfer_domain|default:''}">
                                                <button class="btn btn-primary" type="button" data-transfer-check>{lang key='website/configure/domain/transfer-check'}</button>
                                            </div>
                                            <div class="form-text">{lang key='website/configure/domain/transfer-help'}</div>

                                            <div class="pt-3 d-none" data-transfer-loading>
                                                <div class="domain-result">
                                                    <span class="basic-skeleton w-50"></span>
                                                    <span class="basic-skeleton w-25 ms-auto"></span>
                                                </div>
                                            </div>

                                            <div class="alert d-flex align-items-center mb-0 mt-3 d-none" role="alert" data-role="transfer-status">
                                                <i class="bi me-2" data-role="transfer-status-icon" aria-hidden="true"></i>
                                                <div data-role="transfer-status-text"></div>
                                            </div>

                                            <div class="pt-3 d-none" data-transfer-actions>
                                                <label for="cfg-auth" class="form-label mb-1">{lang key='website/configure/domain/epp-label'}</label>
                                                <div class="input-group">
                                                    <input type="text" class="form-control" id="cfg-auth" name="auth_code" autocomplete="off" value="{$domain_preset.epp|default:''}">
                                                    <button class="btn btn-primary" type="button" data-transfer-confirm>{lang key='website/configure/domain/transfer-confirm'}</button>
                                                </div>
                                                <div class="form-text mt-1" data-role="transfer-epp-hint">{lang key='website/configure/domain/epp-help'}</div>
                                                <div class="form-text text-warning-emphasis mt-1 d-none" data-role="transfer-epp-required"><i class="bi bi-info-circle me-1"></i>{lang key='website/configure/domain/epp-required-note'}</div>
                                            </div>
                                        </div>

                                        <input type="hidden" name="transfer_confirmed" value="0" data-transfer-confirmed-flag>

                                        <div class="d-none" data-transfer-selected-box>
                                            <div class="domain-result domain-result-available flex-wrap">
                                                <i class="bi bi-check-circle-fill text-success fs-5" aria-hidden="true"></i>
                                                <div class="me-auto">
                                                    <span class="fw-semibold d-block" data-transfer-selected-name></span>
                                                    <span class="fs-8 text-body-secondary" data-role="transfer-selected-line"><span class="num-tabular" data-transfer-selected-price></span> <span data-role="transfer-selected-note">{lang key='website/configure/domain/transfer-selected-note'}</span></span>
                                                </div>
                                                <button class="btn btn-soft btn-sm" type="button" data-transfer-change>{lang key='website/configure/domain/change-btn'}</button>
                                            </div>
                                        </div>
                                        <p class="fs-8 text-body-secondary mt-2 mb-0"><i class="bi bi-info-circle me-1"></i>{lang key='website/configure/domain/transfer-note'}</p>
                                    </div>
                                    {/if}

                                    {if $domain_section.tabs.subdomain}
                                    <div class="pt-3{if $domain_section.default_tab != 'subdomain'} d-none{/if}" data-domain-pane="subdomain">
                                        <label for="cfg-subdomain" class="form-label">{lang key='website/configure/domain/subdomain-label'}</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="cfg-subdomain" name="subdomain" placeholder="{lang key='website/configure/domain/subdomain-placeholder'}" autocomplete="off" value="{$domain_preset.sub|default:''}">
                                            <select class="form-select flex-grow-0 w-auto fw-semibold" id="cfg-subdomain-base" name="subdomain_base" aria-label="Subdomain base">
                                                {foreach $domain_section.subdomains as $base}
                                                <option value="{$base}"{if ($domain_preset.base|default:'') == $base} selected{elseif ($domain_preset.base|default:'') == '' && $base@first} selected{/if}>{$base}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="form-text">{lang key='website/configure/domain/subdomain-help'}</div>
                                    </div>
                                    {/if}

                                    <div class="pt-3{if $domain_section.default_tab != 'owned'} d-none{/if}" data-domain-pane="owned">
                                        <label for="cfg-owned-domain" class="form-label">{lang key='website/configure/domain/owned-label'}</label>
                                        <input type="text" class="form-control" id="cfg-owned-domain" name="owned_domain" placeholder="{lang key='website/configure/domain/search-placeholder'}" autocomplete="off" value="{$domain_preset.owned|default:''}">
                                        {if $domain_section.nameservers}
                                        <div class="mt-3">
                                            <p class="fs-8 fw-semibold mb-2"><i class="bi bi-info-circle me-1"></i>{lang key='website/configure/domain/ns-note'}</p>
                                            <div class="ns-list">
                                                {foreach $domain_section.nameservers as $ns}
                                                <div class="ns-item">
                                                    <span class="ns-badge">NS{$ns@iteration}</span>
                                                    <span class="ns-host">{$ns}</span>
                                                    <button class="btn btn-ghost btn-sm ms-auto" type="button" data-action="copy" data-copy-text="{$ns}" data-bs-toggle="tooltip" title="{lang key='website/configure/domain/copy'}"><i class="bi bi-clipboard"></i></button>
                                                </div>
                                                {/foreach}
                                            </div>
                                            <p class="fs-8 text-body-secondary mt-2 mb-0">{lang key='website/configure/domain/ns-delay'}</p>
                                        </div>
                                        {/if}
                                    </div>

                                    {if $domain_section.required}
                                    <div class="invalid-feedback d-block d-none" data-domain-required-error>{lang key='website/configure/domain/required'}</div>
                                    {/if}

                                    {if $domain_section.tabs.register || $domain_section.tabs.transfer}
                                    {include file='components/configure-domain-settings.tpl' ds=$ds_preset}
                                    {/if}
                                </div>
                            </div>
                            {/if}
                            {/if}

                            {if $addons}
                            <div class="card" data-addons-card>
                                <div class="card-body p-4">
                                    <div class="config-section-head">
                                        <span class="icon-disc"><i class="bi bi-plus-square"></i></span>
                                        <div>
                                            <h2 class="h6 fw-semibold">{lang key='website/configure/addons/title'} <span class="text-body-secondary fw-normal fs-8">{lang key='website/configure/addons/optional'}</span></h2>
                                            <p class="fs-8 text-body-secondary mb-0">{lang key='website/configure/addons/subtitle'}</p>
                                        </div>
                                    </div>
                                    {assign var=addon_tab_count value=$addon_groups|@count}
                                    {if $hosting_crosssell}{assign var=addon_tab_count value=$addon_tab_count+1}{/if}
                                    {if $addon_tab_count > 1}{assign var=addons_tabbed value=true}{else}{assign var=addons_tabbed value=false}{/if}
                                    {if $addons_tabbed}
                                    <div class="addon-seg" role="tablist">
                                        {foreach $addon_groups as $grp}
                                        <button class="addon-seg-item{if $grp@first} active{/if}" id="addonGrp{$grp.id}-tab" data-bs-toggle="tab" data-bs-target="#addonGrp{$grp.id}" type="button" role="tab" aria-controls="addonGrp{$grp.id}" aria-selected="{if $grp@first}true{else}false{/if}">{$grp.name} <span class="seg-n">{$grp.count}</span></button>
                                        {/foreach}
                                        {if $hosting_crosssell}
                                        <button class="addon-seg-item" id="addonGrpHosting-tab" data-bs-toggle="tab" data-bs-target="#addonGrpHosting" type="button" role="tab" aria-controls="addonGrpHosting" aria-selected="false">{lang key='website/configure/hosting/title'} <span class="seg-n">{$hosting_plan_count}</span></button>
                                        {/if}
                                    </div>
                                    {/if}
                                    <div data-addons{if $addons_tabbed} class="tab-content"{/if}>
                                        {foreach $addon_groups as $grp}
                                        <div{if $addons_tabbed} class="tab-pane fade{if $grp@first} show active{/if}" id="addonGrp{$grp.id}" role="tabpanel" aria-labelledby="addonGrp{$grp.id}-tab" tabindex="0"{/if}>
                                        {foreach $grp.addons as $addon}
                                        <div class="wui-collapse wui-show addon-slot" data-addon-slot="{$addon.id}"><div class="wui-collapse-inner">
                                        <div class="addon-group" data-addon="{$addon.id}" data-addon-type="{$addon.type}" data-addon-name="{$addon.name}"{if $addon.compulsory} data-compulsory="1"{/if}{if $addon.show_by_pp} data-show-by-pp="1"{/if}{if $addon.offer_cycles} data-offer-cycles="{$addon.offer_cycles}"{/if}{if $addon.free_first} data-free-first="1"{/if}{if $addon.free_cycles} data-free-cycles="{$addon.free_cycles}"{/if}{if $addon.free_option_set} data-free-option="{$addon.free_option}"{/if}{if $addon.type == 'checkbox' && !$addon.compulsory} data-single="1"{/if}>

                                            {if $addon.type == 'select' || $addon.type == 'radio' || $addon.type == 'checkbox'}
                                            <div class="addon-row-head">
                                                {if $addon.icon}<span class="label-media">{if $addon.icon.type == 'image'}<img src="{$addon.icon.value}" alt="">{else}<i class="{$addon.icon.value}"></i>{/if}</span>{/if}
                                                <span class="addon-row-title fw-semibold">{$addon.name}{if $addon.compulsory} <span class="addon-row-badge">{lang key='website/configure/addons/required'}</span>{else} <span class="addon-row-badge" data-role="addon-badge" hidden>{lang key='website/configure/addons/included'}</span>{/if}</span>
                                                {if $addon.description || $addon.store_url|default:''}<span class="addon-row-desc fs-8 text-body-secondary">{if $addon.description}{$addon.description nofilter}{/if}{if $addon.store_url|default:''} <a class="addon-store-link" href="{$addon.store_url}" target="_blank" rel="noopener">{lang key='website/configure/addons/details'}</a>{/if}</span>{/if}
                                                <span class="addon-row-price" data-addon-from data-from-label="{lang key='website/configure/addons/from-label'}"><small class="d-block" data-role="from-label">{if $addon.from_count > 1}{lang key='website/configure/addons/from-label'}{elseif $addon.from_count == 1}{$addon.from_cycle_label}{/if}</small><b data-role="from-price">{if $addon.from_count == 1}{$addon.from_unit_fmt}{else}{$addon.from_price_fmt}{/if}</b></span>
                                                <span class="form-check form-switch addon-row-toggle"><input class="form-check-input" type="checkbox" role="switch" data-addon-switch aria-controls="addonBody-{$addon.id}" aria-label="{$addon.name}"{if $addon.expanded} checked{/if}{if $addon.compulsory} disabled{/if}></span>
                                            </div>
                                            <div class="wui-collapse{if $addon.expanded} wui-show{/if}" id="addonBody-{$addon.id}" data-addon-body><div class="wui-collapse-inner"><div class="addon-body">
                                            {if $addon.type == 'select'}
                                            <select class="form-select" id="addon-{$addon.id}" name="addons[{$addon.id}]" aria-label="{$addon.name}">
                                                {if $addon.allow_none}<option value="none" data-amount="0" hidden{if $addon.none_selected} selected{/if}>{lang key='website/configure/addons/none'}</option>{/if}
                                                {foreach $addon.options as $opt}
                                                <option value="{$opt.id}" data-amount="{$opt.amount}" data-cycle="{$opt.cycle}" data-label="{$opt.name}" data-price-fmt="{$opt.amount_fmt}" data-unit-fmt="{$opt.unit_fmt}" data-cycle-label="{$opt.cycle_label}"{if $opt.selected} selected{/if}>{$opt.name}{if !$opt.free} (+{$opt.amount_fmt}){/if}</option>
                                                {/foreach}
                                            </select>
                                            {else}
                                            {if $addon.allow_none}<span class="d-none"><input type="radio" name="addons[{$addon.id}]" value="none" data-amount="0" data-label="{$addon.name}"{if $addon.none_selected} checked{/if}></span>{/if}
                                            {if $addon.pills}
                                            <div class="addon-body-line">
                                            <div class="addon-pills" role="group" aria-label="{$addon.name}">
                                                {foreach $addon.options as $opt}
                                                <label class="addon-pill">
                                                    <input class="form-check-input" type="{if $addon.type == 'radio' || $addon.compulsory}radio{else}checkbox{/if}" name="addons[{$addon.id}]{if $addon.type == 'checkbox' && !$addon.compulsory}[]{/if}" value="{$opt.id}" data-amount="{$opt.amount}" data-cycle="{$opt.cycle}" data-label="{$opt.name}" data-price-fmt="{$opt.amount_fmt}" data-unit-fmt="{$opt.unit_fmt}" data-cycle-label="{$opt.cycle_label}"{if $opt.selected} checked{/if}>
                                                    <span data-role="pill-label">{if $addon.pill_cycle}{$opt.cycle_label}{else}{$opt.name}{/if}</span> <b data-role="pill-value" data-orig-text="{if $opt.free}{lang key='website/configure/addons/free'}{else}{$opt.unit_fmt}{/if}">{if $opt.free || ($addon.free_on_plan && $opt.id == $addon.free_target)}{lang key='website/configure/addons/free'}{else}{$opt.unit_fmt}{/if}</b> <small data-role="pill-save" hidden></small>
                                                </label>
                                                {/foreach}
                                            </div>
                                            {if $addon.free_first}<span class="fs-7 text-success-emphasis" data-role="free-note"><i class="bi bi-gift me-1"></i><span data-role="free-note-text">{lang key='website/configure/addons/free-first-note' cycle=$addon.free_note_cycle price=$addon.free_note_price}</span></span>{/if}
                                            </div>
                                            {else}
                                            <div class="{if $addon.list_template == 1}option-grid{else}d-grid gap-2{/if}">
                                                {foreach $addon.options as $opt}
                                                {if $addon.list_template == 1}
                                                <label class="option-card option-card-radio option-card-sm">
                                                    <input class="form-check-input" type="{if $addon.type == 'radio' || $addon.compulsory}radio{else}checkbox{/if}" name="addons[{$addon.id}]{if $addon.type == 'checkbox' && !$addon.compulsory}[]{/if}" value="{$opt.id}" data-amount="{$opt.amount}" data-cycle="{$opt.cycle}" data-label="{$opt.name}" data-price-fmt="{$opt.amount_fmt}" data-unit-fmt="{$opt.unit_fmt}" data-cycle-label="{$opt.cycle_label}"{if $opt.selected} checked{/if}>
                                                    <span class="d-flex align-items-center gap-2">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="fw-semibold">{$opt.name}</span></span>
                                                    {if $opt.description}<span class="fs-8 text-body-secondary d-block my-1">{$opt.description nofilter}</span>{/if}
                                                    {if $addon.type == 'radio' || !$opt.free}<span class="price-chip">{if $opt.free}{lang key='website/configure/addons/free'}{else}+{$opt.amount_fmt}{/if}</span>{/if}
                                                </label>
                                                {elseif $addon.type == 'radio'}
                                                <label class="option-card option-card-radio">
                                                    <input class="form-check-input" type="radio" name="addons[{$addon.id}]" value="{$opt.id}" data-amount="{$opt.amount}" data-cycle="{$opt.cycle}" data-label="{$opt.name}" data-price-fmt="{$opt.amount_fmt}" data-unit-fmt="{$opt.unit_fmt}" data-cycle-label="{$opt.cycle_label}"{if $opt.selected} checked{/if}>
                                                    <span class="d-flex align-items-center gap-3">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="me-auto"><span class="fw-semibold d-block">{$opt.name}</span>{if $opt.description}<span class="fs-8 text-body-secondary">{$opt.description nofilter}</span>{/if}</span><span class="price-chip">{if $opt.free}{lang key='website/configure/addons/free'}{else}+{$opt.amount_fmt}{/if}</span></span>
                                                </label>
                                                {else}
                                                <label class="option-card option-card-toggle">
                                                    {if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}
                                                    <span class="option-toggle-body">
                                                        <span class="fw-semibold d-block">{$opt.name}</span>
                                                        {if $opt.description}<span class="fs-8 text-body-secondary">{$opt.description nofilter}</span>{/if}
                                                    </span>
                                                    {if !$opt.free}<span class="price-chip">+{$opt.amount_fmt}</span>{/if}
                                                    <input class="form-check-input flex-shrink-0" type="{if $addon.compulsory}radio{else}checkbox{/if}" name="addons[{$addon.id}]{if !$addon.compulsory}[]{/if}" value="{$opt.id}" data-amount="{$opt.amount}" data-cycle="{$opt.cycle}" data-label="{$opt.name}" data-price-fmt="{$opt.amount_fmt}" data-unit-fmt="{$opt.unit_fmt}" data-cycle-label="{$opt.cycle_label}"{if $opt.selected} checked{/if}>
                                                </label>
                                                {/if}
                                                {/foreach}
                                            </div>
                                            {if $addon.free_first}<span class="fs-7 text-success-emphasis d-block mt-2" data-role="free-note"><i class="bi bi-gift me-1"></i><span data-role="free-note-text">{lang key='website/configure/addons/free-first-note' cycle=$addon.free_note_cycle price=$addon.free_note_price}</span></span>{/if}
                                            {/if}
                                            {/if}
                                            </div></div></div>

                                            {elseif $addon.type == 'quantity'}
                                            {assign var=qopt value=$addon.options[0]}
                                            {if $addon.compulsory}
                                            <div class="range-field">
                                                <div class="range-field-head">
                                                    <label class="fw-semibold d-flex align-items-center gap-2 mb-0 me-auto" for="addon-qty-{$addon.id}">{if $addon.icon}<span class="label-media">{if $addon.icon.type == 'image'}<img src="{$addon.icon.value}" alt="">{else}<i class="{$addon.icon.value}"></i>{/if}</span>{/if}{$addon.name}</label>
                                                    {if !$qopt.free}<span class="price-chip">{$qopt.amount_fmt} {lang key='website/configure/addons/each'}</span>{/if}
                                                    <input type="number" class="range-value num-tabular fw-semibold" data-qty-display value="{if $addon.preset_qty}{$addon.preset_qty}{else}{$addon.min}{/if}" min="{$addon.min}" max="{$addon.max}" step="{$addon.step}" inputmode="numeric" aria-label="{$addon.name}">
                                                </div>
                                                {if $addon.description || $addon.store_url|default:''}<span class="fs-8 text-body-secondary d-block mb-2">{if $addon.description}{$addon.description nofilter}{/if}{if $addon.store_url|default:''} <a class="addon-store-link" href="{$addon.store_url}" target="_blank" rel="noopener">{lang key='website/configure/addons/details'}</a>{/if}</span>{/if}
                                                <input type="range" class="form-range range-fill" id="addon-qty-{$addon.id}" name="addons_values[{$addon.id}]" min="{$addon.min}" max="{$addon.max}" step="{$addon.step}" value="{if $addon.preset_qty}{$addon.preset_qty}{else}{$addon.min}{/if}" data-amount="{$qopt.amount}" data-cycle="{$qopt.cycle}" data-label="{$addon.name}">
                                                <div class="range-ticks" aria-hidden="true"><span>{$addon.min}</span><span>{$addon.max}</span></div>
                                            </div>
                                            {else}
                                            <div class="addon-row-head">
                                                {if $addon.icon}<span class="label-media">{if $addon.icon.type == 'image'}<img src="{$addon.icon.value}" alt="">{else}<i class="{$addon.icon.value}"></i>{/if}</span>{/if}
                                                <span class="addon-row-title fw-semibold">{$addon.name}</span>
                                                {if $addon.description || $addon.store_url|default:''}<span class="addon-row-desc fs-8 text-body-secondary">{if $addon.description}{$addon.description nofilter}{/if}{if $addon.store_url|default:''} <a class="addon-store-link" href="{$addon.store_url}" target="_blank" rel="noopener">{lang key='website/configure/addons/details'}</a>{/if}</span>{/if}
                                                {if !$qopt.free}<span class="addon-row-price"><small class="d-block">{$qopt.cycle_label}</small><b data-qty-price>{$addon.qty_price_fmt} {lang key='website/configure/addons/each'}</b></span>{/if}
                                                <span class="form-check form-switch addon-row-toggle"><input class="form-check-input" type="checkbox" role="switch" data-qty-enable aria-controls="qtyField-{$addon.id}" aria-label="{$addon.name}"{if $addon.preset_qty} checked{/if}></span>
                                            </div>
                                            <div class="wui-collapse{if $addon.preset_qty} wui-show{/if}" id="qtyField-{$addon.id}" data-qty-field>
                                                    <div class="wui-collapse-inner"><div class="addon-body">
                                                        <div class="{if $addon.list_template == 1}option-grid{else}d-grid gap-2{/if} mb-2 d-none" data-qty-variants>
                                                            {foreach $addon.options as $opt}
                                                            {if $addon.list_template == 1}
                                                            <label class="option-card option-card-radio option-card-sm" data-qty-variant-cell data-cycle="{$opt.cycle}">
                                                                <input class="form-check-input" type="radio" name="addons[{$addon.id}]" value="{$opt.id}" data-qty-variant data-amount="{$opt.amount}" data-cycle="{$opt.cycle}" data-fmt="{$opt.unit_fmt}" data-cycle-label="{$opt.cycle_label}"{if $opt.selected} checked{/if}>
                                                                <span class="d-flex align-items-center gap-2">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="fw-semibold">{$opt.name}</span></span>
                                                                {if $opt.description}<span class="fs-8 text-body-secondary d-block my-1">{$opt.description nofilter}</span>{/if}
                                                                <span class="price-chip">{$opt.unit_fmt} {lang key='website/configure/addons/each'}</span>
                                                            </label>
                                                            {else}
                                                            <label class="option-card option-card-radio" data-qty-variant-cell data-cycle="{$opt.cycle}">
                                                                <input class="form-check-input" type="radio" name="addons[{$addon.id}]" value="{$opt.id}" data-qty-variant data-amount="{$opt.amount}" data-cycle="{$opt.cycle}" data-fmt="{$opt.unit_fmt}" data-cycle-label="{$opt.cycle_label}"{if $opt.selected} checked{/if}>
                                                                <span class="d-flex align-items-center gap-3">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="me-auto"><span class="fw-semibold d-block">{$opt.name}</span>{if $opt.description}<span class="fs-8 text-body-secondary">{$opt.description nofilter}</span>{/if}</span><span class="price-chip">{$opt.unit_fmt} {lang key='website/configure/addons/each'}</span></span>
                                                            </label>
                                                            {/if}
                                                            {/foreach}
                                                        </div>
                                                        <div class="range-field">
                                                            <div class="range-field-head">
                                                                <label class="fw-semibold mb-0 me-auto" for="addon-qty-{$addon.id}">{lang key='website/configure/addons/quantity'}</label>
                                                                <input type="number" class="range-value num-tabular fw-semibold" data-qty-display value="{if $addon.preset_qty}{$addon.preset_qty}{else}{$addon.min}{/if}" min="{$addon.min}" max="{$addon.max}" step="{$addon.step}" inputmode="numeric" aria-label="{$addon.name}">
                                                            </div>
                                                            <input type="range" class="form-range range-fill" id="addon-qty-{$addon.id}" name="addons_values[{$addon.id}]" min="{$addon.min}" max="{$addon.max}" step="{$addon.step}" value="{if $addon.preset_qty}{$addon.preset_qty}{else}{$addon.min}{/if}" data-amount="{$qopt.amount}" data-cycle="{$qopt.cycle}" data-label="{$addon.name}" data-each="{lang key='website/configure/addons/each'}"{if !$addon.preset_qty} disabled{/if}>
                                                            <div class="range-ticks" aria-hidden="true"><span>{$addon.min}</span><span>{$addon.max}</span></div>
                                                        </div>
                                                    </div></div>
                                                </div>
                                            {/if}
                                            {/if}
                                            {if $addon.free_first && $addon.type == 'quantity'}<span class="fs-7 text-success-emphasis d-block mt-2" data-role="free-note"><i class="bi bi-gift me-1"></i><span data-role="free-note-text">{lang key='website/configure/addons/free-first-note' cycle=$addon.free_note_cycle price=$addon.free_note_price}</span></span>{/if}
                                        </div>
                                        </div></div>
                                        {/foreach}
                                        </div>
                                        {/foreach}
                                        {if $hosting_crosssell && $addons_tabbed}
                                        <div class="tab-pane fade" id="addonGrpHosting" role="tabpanel" aria-labelledby="addonGrpHosting-tab" tabindex="0" data-hosting-crosssell>
                                            {include file='components/configure-hosting-crosssell.tpl' hosting_preset=$hosting_preset shell=false}
                                        </div>
                                        {/if}
                                    </div>

                                    {hook name='ui:client.configure.addons.after'}
                                </div>
                            </div>
                            {/if}

                            {if $metered_metrics}
                            <div class="card" data-metrics-card>
                                <div class="card-body p-4">
                                    <div class="config-section-head">
                                        <span class="icon-disc"><i class="bi bi-speedometer2"></i></span>
                                        <div>
                                            <h2 class="h6 fw-semibold">{lang key='website/configure/metrics/title'} <span class="text-body-secondary fw-normal fs-8">{lang key='website/configure/metrics/optional'}</span></h2>
                                            <p class="fs-8 text-body-secondary mb-0">{lang key='website/configure/metrics/subtitle'}</p>
                                        </div>
                                    </div>
                                    <div class="d-grid gap-2" data-metrics>
                                        {foreach $metered_metrics as $metric}
                                        <label class="option-card option-card-toggle" data-metric="{$metric.id}">
                                            <span class="option-toggle-body">
                                                <span class="fw-semibold d-block">{$metric.label}</span>
                                                <span class="fs-8 text-body-secondary">{$metric.included}{if $metric.unit} {$metric.unit}{/if} {lang key='website/configure/metrics/included'} · {lang key='website/configure/metrics/overage'} {$metric.unit_price_fmt}{if $metric.unit} / {$metric.unit}{/if}{if $metric.graduated} ({lang key='website/configure/metrics/tiered'}){/if}</span>
                                            </span>
                                            <input class="form-check-input flex-shrink-0" type="checkbox" name="metrics[{$metric.id}][enabled]" value="1"{if $metric.checked} checked{/if}>
                                        </label>
                                        {/foreach}
                                    </div>
                                </div>
                            </div>
                            {/if}

                            {if $requirements}
                            <div class="card{if !$has_static_requirement} d-none{/if}" data-configuration>
                                <div class="card-body p-4">
                                    <div class="config-section-head">
                                        <span class="icon-disc"><i class="bi bi-sliders"></i></span>
                                        <div>
                                            <h2 class="h6 fw-semibold">{lang key='website/configure/configuration/title'}</h2>
                                            <p class="fs-8 text-body-secondary mb-0">{lang key='website/configure/configuration/subtitle'}</p>
                                        </div>
                                    </div>
                                    <div data-config-options>
                                        {foreach $requirements as $req}
                                        <div class="addon-group{if $req.addon_ids} d-none{/if}"{if $req.addon_ids} data-addon-req="{$req.addon_ids}"{/if}>
                                            {if $req.type == 'input' || $req.type == 'password' || $req.type == 'textarea' || $req.type == 'file'}
                                            <label for="cfg-req-{$req.id}" class="form-label d-flex align-items-center gap-2">{if $req.icon}<span class="label-media">{if $req.icon.type == 'image'}<img src="{$req.icon.value}" alt="">{else}<i class="{$req.icon.value}"></i>{/if}</span>{/if}{$req.name}{if $req.required} <span class="text-danger" aria-hidden="true">*</span>{/if}</label>
                                            {if $req.type == 'textarea'}
                                            <textarea class="form-control" id="cfg-req-{$req.id}" name="requirements[{$req.id}]" rows="3" autocomplete="off"{if $req.required} required{/if}>{$req.value}</textarea>
                                            {elseif $req.type == 'file'}
                                            <div class="file-upload" data-file-upload data-txt-bad-type="{lang key='website/configure/configuration/file-bad-type'}" data-txt-too-large="{lang key='website/configure/configuration/file-too-large'}">
                                                <label class="file-upload-drop" for="cfg-req-{$req.id}">
                                                    <input type="file" id="cfg-req-{$req.id}" name="requirements[{$req.id}]" class="visually-hidden"{if $req.allowed_ext} accept="{$req.allowed_ext}"{/if}{if $req.max_file_size} data-max-mb="{$req.max_file_size}"{/if}{if $req.required && !$req.file_name} required{/if}>
                                                    <span class="icon-disc"><i class="bi bi-cloud-arrow-up"></i></span>
                                                    <span><span class="fw-semibold">{lang key='website/configure/configuration/browse'}</span> {lang key='website/configure/configuration/drop'}</span>
                                                    <span class="fs-8">{if $req.allowed_ext}{$req.allowed_ext}{/if}{if $req.allowed_ext && $req.max_file_size} · {/if}{if $req.max_file_size}{lang key='website/configure/configuration/file-max'} {$req.max_file_size} MB{/if}</span>
                                                </label>
                                                <ul class="file-upload-list" data-role="file-list">{if $req.file_name}<li class="file-upload-item">{if $req.file_is_image}<a class="file-upload-item-media" href="?file={$req.id}" target="_blank" rel="noopener" aria-label="{$req.file_name}"><img src="?file={$req.id}" alt="{$req.file_name}" loading="lazy"></a>{else}<span class="file-upload-item-media"><i class="bi bi-file-earmark" aria-hidden="true"></i></span>{/if}<span class="file-upload-item-body"><span class="file-upload-item-name" title="{$req.file_name}">{$req.file_name}</span><span class="file-upload-item-meta">{$req.file_ext}</span></span></li>{/if}</ul>
                                            </div>
                                            {elseif $req.type == 'password'}
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="cfg-req-{$req.id}" name="requirements[{$req.id}]" autocomplete="off" value="{$req.value}"{if $req.required} required{/if}>
                                                <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/configure/configuration/show'}"><i class="bi bi-eye"></i></button>
                                            </div>
                                            {else}
                                            <input type="text" class="form-control" id="cfg-req-{$req.id}" name="requirements[{$req.id}]" autocomplete="off" value="{$req.value}"{if $req.required} required{/if}>
                                            {/if}
                                            {if $req.description}<div class="form-text">{$req.description nofilter}</div>{/if}
                                            {if $req.required}<div class="invalid-feedback">{lang key='website/configure/configuration/required'}</div>{/if}

                                            {elseif $req.type == 'select'}
                                            <label for="cfg-req-{$req.id}" class="form-label d-flex align-items-center gap-2">{if $req.icon}<span class="label-media">{if $req.icon.type == 'image'}<img src="{$req.icon.value}" alt="">{else}<i class="{$req.icon.value}"></i>{/if}</span>{/if}{$req.name}{if $req.required} <span class="text-danger" aria-hidden="true">*</span>{/if}</label>
                                            <select class="form-select" id="cfg-req-{$req.id}" name="requirements[{$req.id}]"{if $req.required} required{/if}>
                                                {if !$req.required}<option value=""{if !$req.has_value} selected{/if}>{lang key='website/configure/configuration/select'}</option>{/if}
                                                {foreach $req.groups as $grp}{if $grp.multi}<optgroup label="{$grp.name}">{foreach $grp.options as $opt}<option value="{$opt.id}"{if $opt.selected} selected{/if}>{$opt.label}</option>{/foreach}</optgroup>{else}{foreach $grp.options as $opt}<option value="{$opt.id}"{if $opt.selected} selected{/if}>{$opt.name}</option>{/foreach}{/if}{/foreach}
                                            </select>
                                            {if $req.description}<div class="form-text">{$req.description nofilter}</div>{/if}
                                            {if $req.required}<div class="invalid-feedback">{lang key='website/configure/configuration/required-select'}</div>{/if}

                                            {elseif $req.type == 'radio'}
                                            <span class="form-label d-flex align-items-center gap-2">{if $req.icon}<span class="label-media">{if $req.icon.type == 'image'}<img src="{$req.icon.value}" alt="">{else}<i class="{$req.icon.value}"></i>{/if}</span>{/if}{$req.name}{if $req.required} <span class="text-danger" aria-hidden="true">*</span>{/if}</span>
                                            {if $req.description}<span class="fs-8 text-body-secondary d-block mb-2">{$req.description nofilter}</span>{/if}
                                            {* Options sharing a group fold into one FAMILY card (no input of its own); its
                                               version grid opens below the row and carries the real radios. configure.js
                                               openFamily() toggles the grids; the first version is checked on open. *}
                                            <div class="{if $req.list_template == 1}option-grid{else}d-grid gap-2{/if}" data-req-choices="{$req.id}">
                                                {foreach $req.groups as $grp}
                                                {if $grp.multi}
                                                <div class="option-card option-card-radio{if $req.list_template == 1} option-card-sm{/if}{if $grp.selected} option-card-active{/if}" data-req-family="{$req.id}-{$grp@index}" role="button" tabindex="0" aria-expanded="{if $grp.selected}true{else}false{/if}" aria-controls="cfg-req-{$req.id}-family-{$grp@index}">
                                                    <span class="d-flex align-items-center gap-{if $req.list_template == 1}2{else}3{/if}">{if $grp.icon}<span class="option-media">{if $grp.icon.type == 'image'}<img src="{$grp.icon.value}" alt="">{else}<i class="{$grp.icon.value}"></i>{/if}</span>{/if}<span class="me-auto"><span class="fw-semibold d-block">{$grp.name}</span><span class="fs-8 text-body-secondary">{lang key='website/configure/configuration/group-versions' count=$grp.options|count}</span></span></span>
                                                </div>
                                                {else}
                                                {foreach $grp.options as $opt}
                                                {if $req.list_template == 1}
                                                <label class="option-card option-card-radio option-card-sm">
                                                    <input class="form-check-input" type="radio" name="requirements[{$req.id}]" value="{$opt.id}"{if $opt.selected} checked{/if}>
                                                    <span class="d-flex align-items-center gap-2">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="fw-semibold">{$opt.name}</span></span>
                                                    {if $opt.description}<span class="fs-8 text-body-secondary d-block mt-1">{$opt.description nofilter}</span>{/if}
                                                </label>
                                                {else}
                                                <label class="option-card option-card-radio">
                                                    <input class="form-check-input" type="radio" name="requirements[{$req.id}]" value="{$opt.id}"{if $opt.selected} checked{/if}>
                                                    <span class="d-flex align-items-center gap-3">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="me-auto"><span class="fw-semibold d-block">{$opt.name}</span>{if $opt.description}<span class="fs-8 text-body-secondary">{$opt.description nofilter}</span>{/if}</span></span>
                                                </label>
                                                {/if}
                                                {/foreach}
                                                {/if}
                                                {/foreach}
                                            </div>
                                            {foreach $req.groups as $grp}{if $grp.multi}
                                            <div class="option-versions{if !$grp.selected} d-none{/if}" id="cfg-req-{$req.id}-family-{$grp@index}" data-req-versions="{$req.id}-{$grp@index}">
                                                <span class="fs-8 text-body-secondary d-block mb-2">{lang key='website/configure/configuration/group-pick' group=$grp.name}</span>
                                                <div class="option-grid">
                                                    {foreach $grp.options as $opt}
                                                    <label class="option-card option-card-radio option-card-sm">
                                                        <input class="form-check-input" type="radio" name="requirements[{$req.id}]" value="{$opt.id}"{if $opt.selected} checked{/if}>
                                                        <span class="fw-semibold">{$opt.label}</span>
                                                        {if $opt.description}<span class="fs-8 text-body-secondary d-block mt-1">{$opt.description nofilter}</span>{/if}
                                                    </label>
                                                    {/foreach}
                                                </div>
                                            </div>
                                            {/if}{/foreach}

                                            {elseif $req.type == 'checkbox'}
                                            <span class="fw-semibold d-flex align-items-center gap-2">{if $req.icon}<span class="label-media">{if $req.icon.type == 'image'}<img src="{$req.icon.value}" alt="">{else}<i class="{$req.icon.value}"></i>{/if}</span>{/if}{$req.name}</span>
                                            {if $req.description}<span class="fs-8 text-body-secondary d-block mb-2">{$req.description nofilter}</span>{/if}
                                            <div class="{if $req.list_template == 1}option-grid{else}d-grid gap-2{/if}">
                                                {foreach $req.options as $opt}
                                                {if $req.list_template == 1}
                                                <label class="option-card option-card-radio option-card-sm">
                                                    <input class="form-check-input" type="checkbox" name="requirements[{$req.id}][]" value="{$opt.id}"{if $opt.selected} checked{/if}>
                                                    <span class="d-flex align-items-center gap-2">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="fw-semibold">{$opt.name}</span></span>
                                                    {if $opt.description}<span class="fs-8 text-body-secondary d-block mt-1">{$opt.description nofilter}</span>{/if}
                                                </label>
                                                {else}
                                                <label class="option-card option-card-toggle">
                                                    {if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}
                                                    <span class="option-toggle-body">
                                                        <span class="fw-semibold d-block">{$opt.name}</span>
                                                        {if $opt.description}<span class="fs-8 text-body-secondary">{$opt.description nofilter}</span>{/if}
                                                    </span>
                                                    <input class="form-check-input flex-shrink-0" type="checkbox" name="requirements[{$req.id}][]" value="{$opt.id}"{if $opt.selected} checked{/if}>
                                                </label>
                                                {/if}
                                                {/foreach}
                                            </div>
                                            {/if}
                                        </div>
                                        {/foreach}
                                    </div>
                                </div>
                            </div>
                            {/if}

                            {if $hosting_crosssell && !($addons_tabbed|default:false)}
                            {include file='components/configure-hosting-crosssell.tpl' hosting_preset=$hosting_preset}
                            {/if}

                            {hook name='ui:client.configure.sections.after'}

                    </div>
                </div>
            </div>

            <aside class="checkout-split-aside">
                <div class="checkout-split-aside-inner">
                    <div class="order-summary">
                        <div class="card-body p-4">
                                <h2 class="h6 fw-semibold mb-3">{lang key='website/configure/order-summary'}</h2>

                                <div class="order-summary-line" data-product-section>
                                    <span class="summary-label"><span data-role="summary-product">{$product.title}</span><span class="summary-sub d-block" data-role="summary-cycle"></span></span>
                                    <span class="summary-value" data-role="summary-plan"></span>
                                </div>

                                <div class="wui-collapse summary-slot"><div class="wui-collapse-inner">
                                <div class="order-summary-line summary-addon" data-role="summary-setup-line">
                                    <span class="summary-label">{lang key='website/configure/setup-fee'}</span>
                                    <span class="summary-value" data-role="summary-setup"></span>
                                </div>
                                </div></div>

                                {if $addons}
                                {foreach $addons as $addon}
                                <div class="wui-collapse summary-slot"><div class="wui-collapse-inner">
                                <div class="order-summary-line rail-addon" data-summary-addon="{$addon.id}">
                                    <span class="summary-sub" data-role="addon-name"></span>
                                    <span class="summary-value num-tabular" data-role="addon-value"></span>
                                </div>
                                </div></div>
                                {/foreach}
                                {/if}

                                {if $hosting_crosssell}
                                <div class="wui-collapse summary-slot"><div class="wui-collapse-inner">
                                <div class="order-summary-line summary-addon" data-summary-addon="hosting">
                                    <span class="summary-label"><span data-role="addon-name"></span><span class="summary-sub d-block" data-role="addon-cycle"></span></span>
                                    <span class="summary-value" data-role="addon-value"></span>
                                </div>
                                </div></div>
                                {/if}

                                {if $domain_section.visible && $domain_section.mode == 'chooser'}
                                <div class="wui-collapse summary-slot"><div class="wui-collapse-inner">
                                <div class="order-summary-line summary-addon" data-role="summary-domain-line">
                                    <span class="summary-label" data-role="summary-domain-label">{lang key='website/configure/domain/title'}<span class="summary-sub d-block">{lang key='website/configure/domain/summary-first-year'}</span></span>
                                    <span class="summary-value" data-role="summary-domain"></span>
                                </div>
                                </div></div>
                                <div class="wui-collapse summary-slot"><div class="wui-collapse-inner">
                                <div class="order-summary-line summary-addon" data-summary-addon="whois_privacy">
                                    <span class="summary-label"><span data-role="addon-name"></span><span class="summary-sub d-block" data-role="addon-cycle"></span></span>
                                    <span class="summary-value" data-role="addon-value"></span>
                                </div>
                                </div></div>
                                <div class="wui-collapse summary-slot"><div class="wui-collapse-inner">
                                <div class="order-summary-line summary-addon" data-summary-addon="dns_manage">
                                    <span class="summary-label"><span data-role="addon-name"></span><span class="summary-sub d-block" data-role="addon-cycle"></span></span>
                                    <span class="summary-value" data-role="addon-value"></span>
                                </div>
                                </div></div>
                                <div class="wui-collapse summary-slot"><div class="wui-collapse-inner">
                                <div class="order-summary-line summary-addon" data-summary-addon="forwarding">
                                    <span class="summary-label"><span data-role="addon-name"></span><span class="summary-sub d-block" data-role="addon-cycle"></span></span>
                                    <span class="summary-value" data-role="addon-value"></span>
                                </div>
                                </div></div>
                                {/if}

                                <hr class="my-3">
                                <div class="order-summary-line order-summary-total mb-0">
                                    <span class="summary-label">{lang key='website/configure/total-due'}</span>
                                    <span class="summary-value" data-role="summary-total"></span>
                                </div>
                                <p class="fs-8 text-body-secondary mt-1 mb-3" data-role="summary-renewal"></p>

                                <span class="d-none" data-configure-token>{csrf form='configure'}</span>
                                <div class="alert alert-danger d-flex align-items-center d-none mb-3" role="alert" data-configure-error>
                                    <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                                    <div data-role="configure-error-text"></div>
                                </div>
                                <div class="d-grid{if $edit_item} gap-2{/if}">
                                    {if $edit_item}
                                    <button class="btn btn-primary" type="submit" form="configure-form" data-add-to-cart><i class="bi bi-check2 me-2"></i>{lang key='website/configure/edit-domain/update'}</button>
                                    <a class="btn btn-soft" href="{link route='cart'}"><i class="bi bi-arrow-left me-2"></i>{lang key='website/configure/edit-domain/back'}</a>
                                    {else}
                                    <button class="btn btn-primary" type="submit" form="configure-form" data-add-to-cart><i class="bi bi-cart-plus me-2"></i>{lang key='website/configure/add-to-cart'}</button>
                                    {/if}
                                </div>
                                {assign var=tax_mode value=$tax_note|default:'exclusive'}
                                <p class="fs-8 text-body-secondary text-center mt-3 mb-0">{lang key='website/configure/prices-shown-in'} <span data-role="currency-label">{$currency}</span>{if $tax_mode == 'inclusive'}{lang key='website/configure/including-tax'}{elseif $tax_mode == 'none'}{lang key='website/configure/prices-shown-end'}{else}{lang key='website/configure/excluding-tax'}{/if}</p>
                                {if $tax_mode == 'exclusive'}<p class="fs-8 text-body-secondary text-center mb-0">{lang key='website/configure/taxes-at-checkout'}</p>{/if}

                                {hook name='ui:client.configure.summary.bottom'}
                            </div>
                        </div>
                    </div>
            </aside>
        </div>
    </form>

{/block}

{block name=body_end}
<div class="checkout-actionbar" data-checkout-actionbar>
    <div class="checkout-actionbar-inner">
        <span class="checkout-actionbar-total">
            <span class="checkout-actionbar-label">{lang key='website/configure/total-due'}</span>
            <span class="checkout-actionbar-value num-tabular" data-role="actionbar-total"></span>
        </span>
        {if $edit_item}
        <button class="btn btn-primary checkout-actionbar-cta" type="submit" form="configure-form"><i class="bi bi-check2 me-2"></i>{lang key='website/configure/edit-domain/update'}</button>
        {else}
        <button class="btn btn-primary checkout-actionbar-cta" type="submit" form="configure-form"><i class="bi bi-cart-plus me-2"></i>{lang key='website/configure/add-to-cart'}</button>
        {/if}
    </div>
</div>

{if $hosting_crosssell}
{/if}
{/block}
