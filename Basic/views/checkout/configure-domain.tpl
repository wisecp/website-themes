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
          data-cart-op="update_item"
          data-item-key="{$edit_item.key}"
          data-config-mode="domain-{$edit_item.action}"
          data-domain-name="{$edit_item.domain}"
          data-domain-years-map="{$edit_item.years_map}"
          data-domain-years="{$edit_item.years}"
          data-domain-renew="{$edit_item.renew_raw}"
          data-domain-price="{$edit_item.price_raw}"
          data-domain-addons="{$domain_addons_json}"
          data-domain-requirements="{$domain_requirements_json}"
          data-preset-addons="{$preset_addons_json}"
          data-req-values="{$req_values_json}"
          data-req-files="{$req_files_json}"
          data-cycle-fallback="annually"
          data-billed-fallback="{lang key='website/configure/cycle-billed/annually'}"
          data-renew-word-year="{lang key='website/configure/cycle-renew/annually'}"
          data-currency="{$currency}"
          data-renews-at="{lang key='website/configure/renews-at'}"
          data-one-time="{lang key='website/configure/one-time-renewal'}"
          data-adding-to-cart="{lang key='website/configure/edit-domain/updating'}"
          data-txt-submit-failed="{lang key='website/configure/submit-failed'}"
          data-txt-addon-included="{lang key='website/configure/domain/addon-included'}"
          data-txt-addon-per-year="{lang key='website/configure/domain/addon-per-year'}"
          data-txt-year-one="{lang key='website/configure/domain/year-one'}"
          data-txt-year-many="{lang key='website/configure/domain/year-many'}"
          data-txt-free="{lang key='website/configure/domain/free-label'}"
          data-txt-domain-registration="{lang key='website/configure/domain/summary-registration'}"
          data-txt-domain-transfer="{lang key='website/configure/domain/summary-transfer'}"
          data-txt-first-year-sub="{lang key='website/configure/domain/summary-first-year'}"
          data-txt-transfer-sub="{lang key='website/configure/domain/summary-transfer-sub'}"
          data-txt-req-select="{lang key='website/configure/domain/req-select'}"
          data-txt-req-browse="{lang key='website/configure/domain/req-browse'}"
          data-txt-req-drop="{lang key='website/configure/domain/req-drop'}"
          data-txt-period-total="{lang key='website/configure/edit-domain/period-total'}"
          data-txt-period-per-year="{lang key='website/configure/edit-domain/period-per-year'}">
        <input type="hidden" name="item_key" value="{$edit_item.key}">
        <span class="d-none"><input type="radio" name="domain_option" value="{$edit_item.action}" checked></span>

        <div class="checkout-split">
            <div class="checkout-split-main">
                <div class="checkout-split-main-inner">

                    <div class="mb-4">
                        <span class="eyebrow" data-config-eyebrow>{if $edit_item.action == 'transfer'}{lang key='website/configure/edit-domain/eyebrow-transfer'}{else}{lang key='website/configure/edit-domain/eyebrow-register'}{/if}</span>
                        <h1 class="tracking-tight mt-1 mb-0" data-config-title>{lang key='website/configure/edit-domain/title'}</h1>
                    </div>

                    <div class="d-flex flex-column gap-4">

                            <div class="card" data-domain-section>
                                <div class="card-body p-4">
                                    <div class="config-section-head">
                                        <span class="icon-disc"><i class="bi bi-globe2"></i></span>
                                        <div>
                                            <h2 class="h6 fw-semibold">{lang key='website/configure/edit-domain/name-title'}</h2>
                                            <p class="fs-8 text-body-secondary mb-0">{lang key='website/configure/edit-domain/name-locked'}</p>
                                        </div>
                                    </div>

                                    <div data-domain-pane="{$edit_item.action}">
                                        <div data-domain-selected-box>
                                            <div class="domain-result domain-result-available flex-wrap">
                                                <i class="bi bi-check-circle-fill text-success fs-5" aria-hidden="true"></i>
                                                <div class="me-auto">
                                                    <span class="fw-semibold d-block" data-selected-name>{$edit_item.domain}</span>
                                                    {if $edit_item.premium}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-gem me-1"></i>{lang key='website/configure/domain/premium'}</span>{/if}
                                                    {if $edit_item.action == 'transfer'}<span class="fs-8 text-body-secondary" data-role="transfer-selected-line"><span class="num-tabular" data-transfer-selected-price>{$edit_item.price_fmt}</span> <span data-role="transfer-selected-note">{lang key='website/configure/domain/transfer-selected-note'}</span></span>{/if}
                                                </div>
                                            </div>
                                        </div>

                                        {if $edit_item.action == 'register'}
                                        <div class="pt-3" data-domain-period>
                                            <label for="cfg-domain-period" class="form-label d-flex align-items-center gap-2"><span class="label-media"><i class="bi bi-calendar-check"></i></span>{lang key='website/configure/edit-domain/period-title'}</label>
                                            <div class="d-flex flex-wrap align-items-center gap-2">
                                                <select class="form-select w-auto" id="cfg-domain-period" name="domain_period">
                                                    <option value="1">1</option>
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
                                                <span class="price-chip" data-role="period-price"></span>
                                                <span class="fs-8 text-body-secondary" data-role="period-note"></span>
                                            </div>
                                            <div class="form-text">{lang key='website/configure/edit-domain/period-desc'}</div>
                                        </div>
                                        {else}
                                        <div class="pt-3">
                                            <label for="cfg-auth" class="form-label d-flex align-items-center gap-2"><span class="label-media"><i class="bi bi-key"></i></span>{lang key='website/configure/domain/epp-label'}</label>
                                            <input type="text" class="form-control" id="cfg-auth" name="auth_code" autocomplete="off" value="{$ds_preset.epp|default:''}">
                                            {if $edit_item.epp_required}
                                            <div class="form-text text-warning-emphasis"><i class="bi bi-info-circle me-1"></i>{lang key='website/configure/domain/epp-required-note'}</div>
                                            {else}
                                            <div class="form-text">{lang key='website/configure/domain/epp-help'}</div>
                                            {/if}
                                        </div>
                                        {/if}

                                        {include file='components/configure-domain-settings.tpl' ds=$ds_preset}
                                    </div>
                                </div>
                            </div>

                            {if $hosting_crosssell}
                            {include file='components/configure-hosting-crosssell.tpl' hosting_preset=$hosting_preset}
                            {/if}

                    </div>
                </div>
            </div>

            <aside class="checkout-split-aside">
                <div class="checkout-split-aside-inner">
                    <div class="order-summary">
                        <div class="card-body p-4">
                                <h2 class="h6 fw-semibold mb-3">{lang key='website/configure/order-summary'}</h2>

                                <div class="order-summary-line summary-addon" data-role="summary-domain-line" hidden>
                                    <span class="summary-label" data-role="summary-domain-label">{lang key='website/configure/domain/title'}<span class="summary-sub d-block">{lang key='website/configure/domain/summary-first-year'}</span></span>
                                    <span class="summary-value" data-role="summary-domain"></span>
                                </div>
                                <div class="order-summary-line summary-addon" data-summary-addon="whois_privacy" hidden>
                                    <span class="summary-label"><span data-role="addon-name"></span><span class="summary-sub d-block" data-role="addon-cycle"></span></span>
                                    <span class="summary-value" data-role="addon-value"></span>
                                </div>
                                <div class="order-summary-line summary-addon" data-summary-addon="dns_manage" hidden>
                                    <span class="summary-label"><span data-role="addon-name"></span><span class="summary-sub d-block" data-role="addon-cycle"></span></span>
                                    <span class="summary-value" data-role="addon-value"></span>
                                </div>
                                <div class="order-summary-line summary-addon" data-summary-addon="forwarding" hidden>
                                    <span class="summary-label"><span data-role="addon-name"></span><span class="summary-sub d-block" data-role="addon-cycle"></span></span>
                                    <span class="summary-value" data-role="addon-value"></span>
                                </div>
                                {if $hosting_crosssell}
                                <div class="order-summary-line summary-addon" data-summary-addon="hosting" hidden>
                                    <span class="summary-label"><span data-role="addon-name"></span><span class="summary-sub d-block" data-role="addon-cycle"></span></span>
                                    <span class="summary-value" data-role="addon-value"></span>
                                </div>
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
                                <div class="d-grid gap-2">
                                    <button class="btn btn-primary" type="submit" form="configure-form" data-add-to-cart><i class="bi bi-check2 me-2"></i>{lang key='website/configure/edit-domain/update'}</button>
                                    <a class="btn btn-soft" href="{link route='cart'}"><i class="bi bi-arrow-left me-2"></i>{lang key='website/configure/edit-domain/back'}</a>
                                </div>
                                {assign var=tax_mode value=$tax_note|default:'exclusive'}
                                <p class="fs-8 text-body-secondary text-center mt-3 mb-0">{lang key='website/configure/prices-shown-in'} <span data-role="currency-label">{$currency}</span>{if $tax_mode == 'inclusive'}{lang key='website/configure/including-tax'}{elseif $tax_mode == 'none'}{lang key='website/configure/prices-shown-end'}{else}{lang key='website/configure/excluding-tax'}{/if}</p>
                                {if $tax_mode == 'exclusive'}<p class="fs-8 text-body-secondary text-center mb-0">{lang key='website/configure/taxes-at-checkout'}</p>{/if}
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
        <button class="btn btn-primary checkout-actionbar-cta" type="submit" form="configure-form"><i class="bi bi-check2 me-2"></i>{lang key='website/configure/edit-domain/update'}</button>
    </div>
</div>

{if $hosting_crosssell}
{/if}
{/block}
