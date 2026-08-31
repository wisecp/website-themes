{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/account-settings.css'}">
    <link rel="stylesheet" href="{asset path='css/checkout.css'}">
    <link rel="stylesheet" href="{asset path='css/libs/wcp-table/table.css'}">
    <link rel="stylesheet" href="{asset path='css/balance.css'}">
{/block}

{block name=scripts}
    <script src="{asset path='js/libs/wcp-table/table.js'}" defer></script>
    <script src="{asset path='js/balance.js'}" defer></script>
{/block}

{block name=content}
<section class="pt-4 pb-5" data-account-page data-account-url="{$account_url}" data-funds-result="{$bal_funds_result}" data-txt-busy="{lang key='website/account/busy-generic'}" data-txt-saved="{lang key='website/balance/saved'}" data-txt-statement="{lang key='website/balance/statement-toast'}" data-txt-funds-added="{lang key='website/balance/funds-added'}" data-txt-funds-failed="{lang key='website/balance/funds-failed'}">
    <div class="container">

        <nav aria-label="{lang key='website/account/breadcrumb-aria'}">
            <ol class="breadcrumb mb-1">
                <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/balance/breadcrumb-dashboard'}</a></li>
                <li class="breadcrumb-item active" aria-current="page">{lang key='website/balance/title'}</li>
            </ol>
        </nav>
        <div class="as-pagehead">
            <h1 class="list-title mb-0">{lang key='website/balance/title'}</h1>
            <p class="text-body-secondary mb-0">{lang key='website/balance/lead'}</p>
        </div>

        <div class="row g-4 mt-1">
            <div class="col-lg-3">
                <div class="as-rail">
                    <ul class="nav as-vtabs" role="tablist" aria-orientation="vertical" data-basic-tabs="account-balance">
                        <li class="nav-item" role="presentation"><button class="nav-link active" id="bal-overview-tab" data-tab-hash="overview" data-bs-toggle="tab" data-bs-target="#bal-overview" type="button" role="tab" aria-controls="bal-overview" aria-selected="true"><i class="bi bi-wallet2"></i><span>{lang key='website/balance/tab-overview'}</span></button></li>
                        <li class="nav-item" role="presentation"><button class="nav-link" id="bal-add-tab" data-tab-hash="add-funds" data-bs-toggle="tab" data-bs-target="#bal-add" type="button" role="tab" aria-controls="bal-add" aria-selected="false"><i class="bi bi-plus-circle"></i><span>{lang key='website/balance/tab-add-funds'}</span></button></li>
                        {if $bal_autopay_available}
                        <li class="nav-item" role="presentation"><button class="nav-link" id="bal-autopay-tab" data-tab-hash="automatic-payments" data-bs-toggle="tab" data-bs-target="#bal-autopay" type="button" role="tab" aria-controls="bal-autopay" aria-selected="false"><i class="bi bi-arrow-repeat"></i><span>{lang key='website/balance/tab-autopay'}</span></button></li>
                        {/if}
                        <li class="nav-item" role="presentation"><button class="nav-link" id="bal-alert-tab" data-tab-hash="low-balance" data-bs-toggle="tab" data-bs-target="#bal-alert" type="button" role="tab" aria-controls="bal-alert" aria-selected="false"><i class="bi bi-bell"></i><span>{lang key='website/balance/tab-alert'}</span></button></li>
                        <li class="nav-item" role="presentation"><button class="nav-link" id="bal-history-tab" data-tab-hash="history" data-bs-toggle="tab" data-bs-target="#bal-history" type="button" role="tab" aria-controls="bal-history" aria-selected="false"><i class="bi bi-clock-history"></i><span>{lang key='website/balance/tab-history'}</span></button></li>
                    </ul>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="tab-content">

                    <div class="tab-pane fade show active" id="bal-overview" role="tabpanel" aria-labelledby="bal-overview-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/balance/overview-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/balance/overview-sub'}</p>
                            </div>
                        </div>

                        {if $bal_low}
                        <div class="bal-low-warning" data-role="low-warning">
                            <span class="bal-low-ico"><i class="bi bi-exclamation-triangle"></i></span>
                            <div class="me-auto">
                                <span class="fw-semibold d-block">{lang key='website/balance/low-warning-title'}</span>
                                <span class="fs-7">{lang key='website/balance/low-warning-text'}</span>
                            </div>
                            <button type="button" class="btn btn-outline-warning btn-sm flex-shrink-0" data-action="bal-goto-add"><i class="bi bi-plus-circle me-1"></i>{lang key='website/balance/add-funds'}</button>
                        </div>
                        {/if}

                        <div class="bal-hero">
                            <div class="bal-hero-balance">
                                <span class="bal-hero-ico"><i class="bi bi-wallet2"></i></span>
                                <div>
                                    <span class="bal-hero-label">{lang key='website/balance/hero-label'}</span>
                                    <span class="bal-hero-value num-tabular">{$bal_amount_fmt}</span>
                                    <span class="bal-hero-note">{lang key='website/balance/hero-note' currency=$bal_currency_code}</span>
                                </div>
                            </div>
                            <div class="bal-hero-benefits">
                                <span class="bal-hero-benefits-title">{lang key='website/balance/benefits-title'}</span>
                                <ul class="bal-benefits">
                                    <li><i class="bi bi-receipt"></i>{lang key='website/balance/benefit-invoices'}</li>
                                    <li><i class="bi bi-arrow-repeat"></i>{lang key='website/balance/benefit-renewals'}</li>
                                    <li><i class="bi bi-lightning-charge"></i>{lang key='website/balance/benefit-checkout'}</li>
                                </ul>
                            </div>
                        </div>

                        <div class="d-flex flex-wrap gap-2 mt-4">
                            <button type="button" class="btn btn-primary" data-action="bal-goto-add"><i class="bi bi-plus-circle me-2"></i>{lang key='website/balance/add-funds'}</button>
                            <button type="button" class="btn btn-soft" data-action="bal-goto-history"><i class="bi bi-clock-history me-2"></i>{lang key='website/balance/view-transactions'}</button>
                        </div>
                        {hook name='ui:client.balance_overview.bottom'}
                    </div>

                    <div class="tab-pane fade" id="bal-add" role="tabpanel" aria-labelledby="bal-add-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/balance/addfunds-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/balance/addfunds-sub' balance=$bal_amount_fmt}</p>
                            </div>
                        </div>
                        <form id="bal-addfunds-form" action="{$account_url}" method="post" novalidate data-balance-form data-min="{$bal_min}"
                              data-txt-error="{lang key='website/balance/err-generic'}">
                            {csrf form='account-balance'}
                            <input type="hidden" name="operation" value="buy_credit">
                            <input type="hidden" name="amount" value="{$bal_amount_default}" data-amount-value>
                            {if $bal_source}<input type="hidden" name="source" value="{$bal_source}">{/if}
                            <section class="as-card">
                                <div>
                                    <label class="form-label">{lang key='website/balance/amount-label'}</label>
                                    <div class="bal-amounts" data-amount-presets>
                                        {foreach $bal_presets as $p}
                                        <button type="button" class="bal-amount{if $p.active} is-active{/if}" data-action="set-amount" data-amount="{$p.value}" aria-pressed="{if $p.active}true{else}false{/if}">{$p.fmt}</button>
                                        {/foreach}
                                        <button type="button" class="bal-amount" data-action="amount-other" aria-pressed="false" aria-controls="balCustom" aria-expanded="false">{lang key='website/balance/amount-other'}</button>
                                    </div>
                                    <div class="wui-collapse" id="balCustom">
                                        <div class="wui-collapse-inner">
                                            <div class="pt-3">
                                                <label for="bal-custom" class="form-label">{lang key='website/balance/amount-custom-label'}</label>
                                                <div class="input-group bal-amount-custom">
                                                    {if $bal_currency_position != 'RIGHT'}<span class="input-group-text" data-currency-affix>{$bal_currency_symbol}</span>{/if}
                                                    <input type="text" class="form-control num-tabular" id="bal-custom" inputmode="decimal" placeholder="0.00" data-amount-input aria-describedby="bal-custom-help">
                                                    {if $bal_currency_position == 'RIGHT'}<span class="input-group-text" data-currency-affix>{$bal_currency_symbol}</span>{/if}
                                                    <div class="invalid-feedback">{lang key='website/balance/amount-min-error' min=$bal_min_fmt}</div>
                                                </div>
                                                <div class="form-text" id="bal-custom-help">{lang key='website/balance/amount-custom-help' min=$bal_min_fmt currency=$bal_currency_code}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                {if $bal_fx_mismatch}
                                <div class="pt-3">
                                    <div class="bal-fx">
                                        <i class="bi bi-currency-exchange" aria-hidden="true"></i>
                                        <p class="mb-0">{lang key='fx_note' wallet=$bal_currency_code store=$bal_fx_store_code}</p>
                                    </div>
                                </div>
                                {/if}

                                {if $bal_pay_methods}
                                <hr class="as-divider">

                                <div class="checkout-head">
                                    <span class="icon-disc"><i class="bi bi-credit-card"></i></span>
                                    <div>
                                        <h3 class="h6 fw-semibold mb-0">{lang key='website/checkout/payment-title'}</h3>
                                        <p class="fs-8 text-body-secondary mb-0">{lang key='website/checkout/payment-sub'}</p>
                                    </div>
                                </div>
                                <div class="d-flex flex-column gap-2" data-payment-methods>
                                    {foreach $bal_pay_methods as $m}
                                    <div class="payment-option">
                                        <label class="payment-option-head">
                                            <input class="form-check-input" type="radio" name="pmethod" value="{$m.name}" data-fee-rate="{$m.fee_rate}"{if $m.name == $bal_pay_default} checked{/if}>
                                            <span class="option-media">
                                                {if $m.icon_type == 'font'}<i class="{$m.icon}"></i>
                                                {elseif $m.icon_type == 'image'}<img src="{$m.icon}" alt="">
                                                {elseif $m.kind == 'paypal'}<i class="fa-brands fa-paypal"></i>
                                                {elseif $m.kind == 'bank'}<i class="bi bi-bank"></i>
                                                {elseif $m.kind == 'card'}<i class="bi bi-credit-card-2-front"></i>
                                                {else}<i class="bi bi-globe2"></i>{/if}
                                            </span>
                                            <span class="me-auto">
                                                <span class="fw-semibold d-block">{$m.title}</span>
                                                {if $m.desc}<span class="fs-8 text-body-secondary">{$m.desc}</span>{/if}
                                            </span>
                                            {if $m.kind == 'card'}<span class="checkout-pay-icons" aria-hidden="true"><i class="fa-brands fa-cc-visa"></i><i class="fa-brands fa-cc-mastercard"></i><i class="fa-brands fa-cc-amex"></i></span>{/if}
                                            {if $m.fee_rate > 0}<span class="price-chip fw-normal">+{$m.fee_rate}% {lang key='website/checkout/fee-suffix'}</span>{/if}
                                        </label>
                                        <div class="wui-collapse{if $m.name == $bal_pay_default} wui-show{/if}" data-method-panel="{$m.name}">
                                            <div class="wui-collapse-inner">
                                                <div class="payment-option-body">
                                                    {if $m.kind == 'bank'}
                                                    <span class="form-label d-block mb-2">{lang key='website/checkout/bank-accounts-label'}</span>
                                                    <div class="bank-account-grid" data-bank-accounts>
                                                        {foreach $m.bank_accounts as $b}
                                                        <div class="card bank-account">
                                                            <div class="bank-account-head">
                                                                {if $b.image}<img class="bank-logo" src="{$b.image}" alt="">{/if}
                                                                <span class="bank-account-name">{$b.name}</span>
                                                            </div>
                                                            {if $b.buyer_name}
                                                            <div class="bank-line">
                                                                <span class="bank-line-label">{lang key='website/checkout/bank-holder'}</span>
                                                                <span class="bank-line-value">{$b.buyer_name}</span>
                                                            </div>
                                                            {/if}
                                                            {if $b.iban}
                                                            <div class="bank-line">
                                                                <span class="bank-line-label">IBAN</span>
                                                                <span class="bank-line-value num-tabular">{$b.iban}</span>
                                                            </div>
                                                            {/if}
                                                            {if $b.account_number}
                                                            <div class="bank-line">
                                                                <span class="bank-line-label">{lang key='website/checkout/bank-account-no'}</span>
                                                                <span class="bank-line-value num-tabular">{$b.account_number}</span>
                                                            </div>
                                                            {/if}
                                                            {if $b.swift}
                                                            <div class="bank-line">
                                                                <span class="bank-line-label">SWIFT / BIC</span>
                                                                <span class="bank-line-value num-tabular">{$b.swift}</span>
                                                            </div>
                                                            {/if}
                                                        </div>
                                                        {/foreach}
                                                    </div>
                                                    <p class="fs-8 text-body-secondary mt-3 mb-0"><i class="bi bi-info-circle me-1"></i>{lang key='website/balance/bank-note'}</p>
                                                    {elseif $m.name == 'CreditCard' && $bal_card_panel && $bal_card_panel.inline}
                                                    <div data-card-pane
                                                         data-txt-paying="{lang key='website/payment/paying'}"
                                                         data-txt-error="{lang key='website/payment/error-generic'}">
                                                        {if $bal_card_panel.cards}
                                                        <div class="d-flex flex-column gap-2 mb-3" data-saved-cards id="balSavedCards">
                                                            <span class="form-label mb-0">{lang key='website/payment/saved-cards'}</span>
                                                            {foreach $bal_card_panel.cards as $c}
                                                            <label class="option-card option-card-radio option-card-sm d-flex align-items-center gap-3">
                                                                <input class="form-check-input" type="radio" name="stored_card" value="{$c.id}"{if $c@first} checked{/if}>
                                                                <span class="option-media">
                                                                    {if $c.schema == 'visa'}<i class="fa-brands fa-cc-visa"></i>
                                                                    {elseif $c.schema == 'mastercard'}<i class="fa-brands fa-cc-mastercard"></i>
                                                                    {elseif $c.schema == 'amex'}<i class="fa-brands fa-cc-amex"></i>
                                                                    {else}<i class="bi bi-credit-card-2-front"></i>{/if}
                                                                </span>
                                                                <span class="me-auto">
                                                                    <span class="fw-semibold d-block">{if $c.brand}{$c.brand} {/if}•••• {$c.ln4}</span>
                                                                    <span class="fs-8 text-body-secondary">{$c.name}{if $c.expiry} · {$c.expiry}{/if}</span>
                                                                </span>
                                                            </label>
                                                            {/foreach}
                                                            <label class="option-card option-card-radio option-card-sm d-flex align-items-center gap-3">
                                                                <input class="form-check-input" type="radio" name="stored_card" value="new"{if !$bal_card_panel.cards} checked{/if}>
                                                                <span class="option-media"><i class="bi bi-plus-lg"></i></span>
                                                                <span class="fw-semibold">{lang key='website/payment/use-new-card'}</span>
                                                            </label>
                                                        </div>
                                                        {/if}
                                                        <div class="wui-collapse{if !$bal_card_panel.cards} wui-show{/if}" data-new-card>
                                                            <div class="wui-collapse-inner">
                                                                <div class="pt-1">
                                                                    {include file='components/checkout-card-fields.tpl' prefix='baladd' can_store=$bal_card_panel.can_store can_autopay=false}
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="alert alert-danger d-flex align-items-center d-none mt-3 mb-0" role="alert" data-card-error>
                                                            <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                                                            <div data-role="card-error-text"></div>
                                                        </div>
                                                    </div>
                                                    {elseif $m.flow == 'merchant'}
                                                    <div data-card-pane
                                                         data-txt-paying="{lang key='website/payment/paying'}"
                                                         data-txt-error="{lang key='website/payment/error-generic'}">
                                                        {include file='components/checkout-card-fields.tpl' prefix=$m.name can_store=false can_autopay=false}
                                                        <div class="alert alert-danger d-flex align-items-center d-none mt-3 mb-0" role="alert" data-card-error>
                                                            <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                                                            <div data-role="card-error-text"></div>
                                                        </div>
                                                    </div>
                                                    {elseif ($m.flow == 'area' || $m.flow == 'legacy') && !$m.embed}
                                                    <p class="fs-8 text-body-secondary mb-0"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/gateway-note'}</p>
                                                    {elseif $m.flow == 'area' || $m.flow == 'legacy'}
                                                    <div data-area-pane
                                                         data-txt-error="{lang key='website/checkout/area-error'}">
                                                        <div class="text-center py-3 d-none" data-role="area-loading">
                                                            <span class="spinner-border spinner-border-sm me-2 align-middle" role="status" aria-hidden="true"></span>
                                                            <span class="fs-8 text-body-secondary align-middle">{lang key='website/checkout/area-loading'}</span>
                                                        </div>
                                                        <div class="wui-collapse" data-role="area-content">
                                                            <div class="wui-collapse-inner">
                                                                <div class="pt-1" data-role="area-content-body"></div>
                                                            </div>
                                                        </div>
                                                        <p class="fs-8 text-body-secondary d-none mb-0" data-role="area-fallback"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/gateway-note'}</p>
                                                        <div class="alert alert-warning d-flex align-items-center d-none mb-0" role="alert" data-area-error>
                                                            <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                                                            <div data-role="area-error-text"></div>
                                                        </div>
                                                    </div>
                                                    {elseif $m.kind == 'card'}
                                                    <p class="fs-8 text-body-secondary mb-0"><i class="bi bi-shield-lock me-1"></i>{lang key='website/checkout/card-note'}</p>
                                                    {else}
                                                    <p class="fs-8 text-body-secondary mb-0"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/gateway-note'}</p>
                                                    {/if}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    {/foreach}
                                </div>

                                <div class="checkout-pay-footer d-flex flex-column gap-3" data-pay-footer>
                                    <div>
                                        <div class="order-summary-line">
                                            <span class="summary-label">{lang key='website/balance/pay-base'}</span>
                                            <span class="summary-value num-tabular" data-role="addfunds-base">{$bal_totals.base_fmt}</span>
                                        </div>
                                        <div class="order-summary-line" data-role="tax-line"{if !$bal_totals.tax_fmt} hidden{/if}>
                                            <span class="summary-label">{lang key='website/balance/pay-tax'} <span class="text-body-secondary" data-role="tax-label">{$bal_totals.tax_label}</span></span>
                                            <span class="summary-value num-tabular" data-role="tax-value">{$bal_totals.tax_fmt}</span>
                                        </div>
                                        <div class="order-summary-line" data-role="fee-line"{if !$bal_totals.fee_fmt} hidden{/if}>
                                            <span class="summary-label">{lang key='website/balance/pay-fee'} <span class="text-body-secondary" data-role="fee-label">{$bal_totals.fee_label}</span></span>
                                            <span class="summary-value num-tabular" data-role="fee-value">{$bal_totals.fee_fmt}</span>
                                        </div>
                                        <div class="order-summary-line order-summary-total mb-0">
                                            <span class="summary-label">{lang key='website/balance/pay-total'}</span>
                                            <span class="summary-value num-tabular" data-role="grand-total">{$bal_totals.total_fmt}</span>
                                        </div>
                                    </div>
                                    <div class="alert alert-danger d-flex align-items-center d-none mb-0" role="alert" data-balance-error>
                                        <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                                        <div data-role="balance-error-text"></div>
                                    </div>
                                    <div class="d-grid">
                                        <button class="btn btn-primary btn-lg" type="submit" data-balance-submit data-busy-text="{lang key='website/balance/adding-funds'}"><i class="bi bi-plus-circle me-2"></i><span data-role="pay-label">{lang key='website/balance/add-funds'}</span><span class="checkout-pay-btn-amount num-tabular" data-role="pay-amount">{$bal_totals.total_fmt}</span></button>
                                    </div>
                                    <p class="fs-8 text-body-secondary text-center mb-0"><i class="bi bi-shield-lock me-1"></i>{lang key='website/balance/addfunds-secure'}</p>
                                </div>
                                {else}
                                <hr class="as-divider">
                                <div class="alert alert-warning d-flex align-items-center mb-0" role="alert">
                                    <i class="bi bi-exclamation-circle me-2" aria-hidden="true"></i>
                                    <div>{lang key='website/balance/no-methods'}</div>
                                </div>
                                {/if}
                            </section>
                        </form>
                        {hook name='ui:client.add_funds.bottom'}
                    </div>

                    {if $bal_autopay_available}
                    <div class="tab-pane fade" id="bal-autopay" role="tabpanel" aria-labelledby="bal-autopay-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/balance/autopay-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/balance/autopay-sub'}</p>
                            </div>
                        </div>
                        <div class="as-panel" data-autopay-panel>
                            <section class="as-section as-section-mid">
                                <div class="as-section-aside">
                                    <h3 class="as-section-title">{lang key='website/balance/autopay-status-title'}</h3>
                                    <p class="as-section-note">{lang key='website/balance/autopay-status-note'}</p>
                                </div>
                                <div class="as-section-body">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" role="switch" id="ap-enable" name="auto_payment_by_credit" value="1" aria-controls="apBody" aria-expanded="{if $bal_autopay}true{else}false{/if}"{if $bal_autopay} checked{/if}>
                                        <label class="form-check-label" for="ap-enable">{lang key='website/balance/autopay-enable'}</label>
                                    </div>
                                </div>
                            </section>
                            <div class="wui-collapse{if $bal_autopay} wui-show{/if}" id="apBody">
                                <div class="wui-collapse-inner">
                                    <section class="as-section">
                                        <div class="as-section-aside">
                                            <h3 class="as-section-title">{if $bal_cards || $bal_card_gateway}{lang key='website/balance/autopay-order-title-multi'}{else}{lang key='website/balance/autopay-order-title'}{/if}</h3>
                                            <p class="as-section-note">{if $bal_cards || $bal_card_gateway}{lang key='website/balance/autopay-order-note-multi'}{else}{lang key='website/balance/autopay-order-note'}{/if}</p>
                                        </div>
                                        <div class="as-section-body">
                                            <ol class="bal-priority mb-0">
                                                <li>
                                                    <div class="bal-priority-body">
                                                        <span class="bal-priority-name"><i class="bi bi-wallet2 me-1"></i>{lang key='website/balance/autopay-priority-name'}</span>
                                                        <span class="bal-priority-sub">{lang key='website/balance/autopay-priority-sub'}</span>
                                                    </div>
                                                </li>
                                                {if $bal_cards}
                                                <li>
                                                    <div class="bal-priority-body">
                                                        <span class="bal-priority-name"><i class="bi bi-credit-card me-1"></i>{lang key='website/balance/autopay-priority-card-name'}</span>
                                                        <span class="bal-priority-sub">{lang key='website/balance/autopay-priority-card-sub'}</span>
                                                    </div>
                                                </li>
                                                {elseif $bal_card_gateway}
                                                <li>
                                                    <div class="bal-priority-body">
                                                        <span class="bal-priority-name"><i class="bi bi-credit-card me-1"></i>{lang key='website/balance/autopay-priority-card-name'}</span>
                                                        <span class="bal-priority-sub">{lang key='website/balance/autopay-card-cta'} <a href="{link route='info'}#cards">{lang key='website/balance/autopay-card-cta-link'}</a></span>
                                                    </div>
                                                </li>
                                                {/if}
                                            </ol>
                                            {if !$bal_cards && !$bal_card_gateway}
                                            <div class="form-text mt-2"><i class="bi bi-info-circle me-1"></i>{lang key='website/balance/autopay-hint'}</div>
                                            {/if}
                                        </div>
                                    </section>
                                    {if $bal_cards}
                                    <section class="as-section">
                                        <div class="as-section-aside">
                                            <h3 class="as-section-title">{lang key='website/balance/autopay-card-title'}</h3>
                                            <p class="as-section-note">{lang key='website/balance/autopay-card-note'}</p>
                                        </div>
                                        <div class="as-section-body">
                                            <label class="form-label" for="ap-card">{lang key='website/balance/autopay-card-label'}</label>
                                            <select class="form-select" id="ap-card" name="autopay_card">
                                                <option value="0"{if !$bal_card_has_autopay} selected{/if}>{lang key='website/balance/autopay-card-none'}</option>
                                                {foreach $bal_cards as $c}
                                                <option value="{$c.id}"{if $c.auto_pay} selected{/if}{if $c.expired} disabled{/if}>{$c.label}{if $c.expired} · {lang key='website/balance/autopay-card-expired'}{/if}</option>
                                                {/foreach}
                                            </select>
                                            <div class="form-text"><a href="{link route='info'}#cards">{lang key='website/balance/autopay-card-manage'}</a></div>
                                        </div>
                                    </section>
                                    {/if}
                                </div>
                            </div>
                            <div class="as-panel-foot">
                                <button type="button" class="btn btn-primary" data-action="save-autopay" data-busy-text="{lang key='website/account/busy-generic'}"><i class="bi bi-check2 me-1"></i>{lang key='website/balance/save'}</button>
                            </div>
                        </div>
                    </div>
                    {/if}

                    <div class="tab-pane fade" id="bal-alert" role="tabpanel" aria-labelledby="bal-alert-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/balance/alert-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/balance/alert-sub'}</p>
                            </div>
                        </div>
                        <div class="as-panel" data-alert-panel>
                            <section class="as-section as-section-mid">
                                <div class="as-section-aside">
                                    <h3 class="as-section-title">{lang key='website/balance/alert-status-title'}</h3>
                                    <p class="as-section-note">{lang key='website/balance/alert-status-note'}</p>
                                </div>
                                <div class="as-section-body">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" role="switch" id="lb-enable" name="alert_enabled" value="1" aria-controls="lbBody" aria-expanded="{if $bal_alert_enabled}true{else}false{/if}"{if $bal_alert_enabled} checked{/if}>
                                        <label class="form-check-label" for="lb-enable">{lang key='website/balance/alert-enable'}</label>
                                    </div>
                                </div>
                            </section>
                            <div class="wui-collapse{if $bal_alert_enabled} wui-show{/if}" id="lbBody">
                                <div class="wui-collapse-inner">
                                    <section class="as-section">
                                        <div class="as-section-aside">
                                            <h3 class="as-section-title">{lang key='website/balance/alert-threshold-title'}</h3>
                                            <p class="as-section-note">{lang key='website/balance/alert-threshold-note'}</p>
                                        </div>
                                        <div class="as-section-body">
                                            <label class="form-label" for="lb-threshold">{lang key='website/balance/alert-threshold-label'}</label>
                                            <div class="input-group bal-amount-custom">
                                                {if $bal_currency_position != 'RIGHT'}<span class="input-group-text">{$bal_currency_symbol}</span>{/if}
                                                <input type="text" class="form-control num-tabular" id="lb-threshold" name="balance_min" inputmode="decimal" value="{$bal_threshold_input}" data-lb-threshold>
                                                {if $bal_currency_position == 'RIGHT'}<span class="input-group-text">{$bal_currency_symbol}</span>{/if}
                                            </div>
                                        </div>
                                    </section>
                                    <section class="as-section">
                                        <div class="as-section-aside">
                                            <h3 class="as-section-title">{lang key='website/balance/recipients-title'}</h3>
                                            <p class="as-section-note">{lang key='website/balance/recipients-note'}</p>
                                        </div>
                                        <div class="as-section-body">
                                            <div class="bal-recipients">
                                                {foreach $bal_recipients as $r}
                                                {if $r.owner}
                                                <div class="bal-recipient bal-recipient-fixed">
                                                    <span class="bal-recipient-always" title="{lang key='website/balance/recipient-owner-hint'}"><i class="bi bi-check-circle-fill"></i></span>
                                                    <span class="bal-recipient-body">
                                                        <span class="bal-recipient-name">{$r.name}</span>
                                                        <span class="bal-recipient-email">{$r.email}</span>
                                                    </span>
                                                    <span class="bal-recipient-role">{lang key='website/balance/recipient-owner'}</span>
                                                </div>
                                                {else}
                                                <label class="bal-recipient">
                                                    <input class="form-check-input" type="checkbox" name="alert_recipients[]" value="{$r.id}"{if $r.checked} checked{/if}>
                                                    <span class="bal-recipient-body">
                                                        <span class="bal-recipient-name">{$r.name}</span>
                                                        <span class="bal-recipient-email">{$r.email}</span>
                                                    </span>
                                                    <span class="bal-recipient-role">{lang key='website/balance/recipient-contact'}</span>
                                                </label>
                                                {/if}
                                                {/foreach}
                                            </div>
                                            <div class="form-text"><i class="bi bi-people me-1"></i><a href="{link route='info'}#contacts">{lang key='website/balance/recipients-manage'}</a></div>
                                        </div>
                                    </section>
                                </div>
                            </div>
                            <div class="as-panel-foot">
                                <button type="button" class="btn btn-primary" data-action="save-alert" data-busy-text="{lang key='website/account/busy-generic'}"><i class="bi bi-check2 me-1"></i>{lang key='website/balance/save'}</button>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="bal-history" role="tabpanel" aria-labelledby="bal-history-tab" tabindex="0">
                        <div class="as-pane-head">
                            <div>
                                <h2 class="as-pane-title">{lang key='website/balance/history-title'}</h2>
                                <p class="as-pane-sub">{lang key='website/balance/history-sub'}</p>
                            </div>
                            {if $has_transactions}
                            <div class="as-pane-tools">
                                <select class="form-select form-select-sm as-activity-filter" data-table-filter="account-ledger" data-filter-column="type" aria-label="{lang key='website/balance/th-type'}">
                                    <option value="" selected>{lang key='website/balance/history-filter-all'}</option>
                                    <option value="up">{lang key='website/balance/history-filter-up'}</option>
                                    <option value="down">{lang key='website/balance/history-filter-down'}</option>
                                </select>
                                <button type="button" class="btn btn-soft btn-sm" data-action="bal-statement"><i class="bi bi-download me-1"></i>{lang key='website/balance/download-statement'}</button>
                            </div>
                            {/if}
                        </div>

                        {hook name='ui:client.balance_history.top'}

                        {if $has_transactions}
                        <section class="as-card bal-ledger">
                            <div class="wcp-table" data-name="account-ledger"{if $bal_ledger_ajax} data-ajax="{$bal_ledger_ajax}"{/if}>
                                <div class="wcp-table-header">
                                    <label class="wcp-entries-label fs-8 text-body-secondary mb-0">
                                        <select class="form-select form-select-sm wcp-entries-select" aria-label="{lang key='website/balance/entries-per-page'}">
                                            <option value="10">10</option>
                                            <option value="25">25</option>
                                            <option value="50">50</option>
                                            <option value="-1">{lang key='website/balance/entries-all'}</option>
                                        </select>
                                        {lang key='website/balance/entries-per-page'}
                                    </label>
                                    <div class="as-table-search input-group input-group-sm">
                                        <label class="input-group-text" for="bal-ledger-search"><i class="bi bi-search"></i></label>
                                        <input type="search" class="form-control wcp-search-input" id="bal-ledger-search" placeholder="{lang key='website/balance/history-search'}" aria-label="{lang key='website/balance/history-search'}" autocomplete="off">
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead>
                                            <tr>
                                                <th scope="col" data-sortable="desc" data-column="date">{lang key='website/balance/th-date'}</th>
                                                <th scope="col">{lang key='website/balance/th-description'}</th>
                                                <th scope="col">{lang key='website/balance/th-type'}</th>
                                                <th scope="col" class="text-end">{lang key='website/balance/th-amount'}</th>
                                            </tr>
                                        </thead>
                                        <tbody class="wcp-table-body">
                                            {$bal_transactions_html nofilter}
                                        </tbody>
                                        <tbody class="wcp-table-loader-body d-none">
                                            <tr><td colspan="4" class="text-center py-4"><span class="wcp-table-loader spinner-border spinner-border-sm text-secondary" role="status" aria-hidden="true"></span></td></tr>
                                        </tbody>
                                        <tbody class="wcp-table-no-result-body d-none">
                                            <tr><td colspan="4"><div class="wcp-table-no-result basic-empty-state py-4"><i class="bi bi-wallet2" aria-hidden="true"></i><span class="fw-semibold">{lang key='website/balance/empty-filter-title'}</span><span class="fs-7">{lang key='website/balance/empty-filter-text'}</span></div></td></tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="wcp-table-footer">
                                    <div class="wcp-table-info fs-8 text-body-secondary" data-msg1="{lang key='website/balance/info-none'}" data-msg2="{lang key='website/balance/info-filtered'}" data-msg3="{lang key='website/balance/info-showing'}"></div>
                                    <nav class="wcp-table-pagination" aria-label="{lang key='website/balance/history-title'}">
                                        <ul class="pagination pagination-sm mb-0"></ul>
                                    </nav>
                                </div>
                            </div>
                        </section>
                        {else}
                        <div class="basic-empty-state">
                            <i class="bi bi-wallet2" aria-hidden="true"></i>
                            <span class="fw-semibold">{lang key='website/balance/empty-title'}</span>
                            <span class="fs-7">{lang key='website/balance/empty-text'}</span>
                            <button type="button" class="btn btn-primary btn-sm mt-2" data-action="bal-goto-add"><i class="bi bi-plus-circle me-1"></i>{lang key='website/balance/add-funds'}</button>
                        </div>
                        {/if}
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>
{/block}
