<div class="invoice-pay-footer d-flex flex-column gap-3" data-pay-footer>

    <div class="invoice-pay-total">
        <div class="order-summary-line">
            <span class="summary-label" data-role="pay-base-label">{if !empty($pay_base_label)}{$pay_base_label}{else}{lang key='website/invoices/detail/balance-due'}{/if}</span>
            <span class="summary-value num-tabular" data-role="pay-base-value">{$pay_due_fmt}</span>
        </div>
        <div class="wui-collapse" data-role="fee-collapse">
            <div class="wui-collapse-inner">
                <div class="order-summary-line" data-role="fee-line">
                    <span class="summary-label">{lang key='website/invoices/pay/fee-label'} <span class="text-body-secondary" data-role="fee-label"></span></span>
                    <span class="summary-value num-tabular" data-role="fee-value"></span>
                </div>
            </div>
        </div>
        <div class="wui-collapse" data-role="credit-collapse">
            <div class="wui-collapse-inner">
                <div class="pay-credit-row">
                    <div class="order-summary-line mb-0" data-role="credit-line">
                        <span class="summary-label text-success-emphasis"><i class="bi bi-wallet2 me-1"></i>{lang key='website/invoices/pay/credit-label'}</span>
                        <span class="summary-value num-tabular text-success-emphasis" data-role="credit-value"></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="wui-collapse" data-role="installment-collapse">
            <div class="wui-collapse-inner">
                <div class="order-summary-line" data-role="installment-line">
                    <span class="summary-label">{lang key='website/invoices/pay/installment-fee'} <span class="text-body-secondary" data-role="installment-label"></span></span>
                    <span class="summary-value num-tabular" data-role="installment-value"></span>
                </div>
            </div>
        </div>
        <div class="order-summary-line order-summary-total mb-0">
            <span class="summary-label">{lang key='website/invoices/detail/fact-amount-due'}</span>
            <span class="summary-value num-tabular" data-role="grand-total" data-base-total="{$pay_bare_raw}" data-base-total-fmt="{$pay_bare_fmt}">{$pay_due_fmt}</span>
        </div>
    </div>

    {if $checkout_balance}
    <label class="option-card option-card-toggle d-none" data-balance-apply-wrap
           data-available="{$checkout_balance.available_raw}"
           data-txt-note="{lang key='website/checkout/apply-balance-desc'}">
        <span class="option-media"><i class="bi bi-wallet2"></i></span>
        <span class="option-toggle-body">
            <span class="fw-semibold d-block">{lang key='website/checkout/apply-balance-title'}</span>
            <span class="fs-8 text-body-secondary" data-role="apply-balance-note">{lang key='website/checkout/apply-balance-desc'}</span>
        </span>
        <span class="price-chip">{$checkout_balance.available_fmt} {lang key='website/checkout/balance-available'}</span>
        <input class="form-check-input flex-shrink-0" type="checkbox" id="inv-apply-balance" name="apply_balance" value="1" data-apply-balance aria-label="{lang key='website/checkout/apply-balance-title'}">
    </label>
    {/if}

    {if $show_partial|default:true}
    <div class="invoice-partial">
        <div class="invoice-partial-panel">
            <button class="invoice-partial-head collapsed" type="button" data-wui-toggle data-wui-target="#invPartial" aria-expanded="false" aria-controls="invPartial">
                <span class="invoice-partial-title"><i class="bi bi-sliders" aria-hidden="true"></i>{lang key='website/invoices/pay/partial-title'}</span>
                <i class="bi bi-chevron-down invoice-partial-caret" aria-hidden="true"></i>
            </button>
            <div class="wui-collapse" id="invPartial">
                <div class="wui-collapse-inner">
                    <div class="invoice-partial-body">
                        <label class="form-label" for="inv-partial-amount">{lang key='website/invoices/pay/partial-label'}</label>
                        <div class="invoice-partial-row">
                            <div class="input-group invoice-partial-input">
                                <span class="input-group-text">{$pay_currency_code}</span>
                                <input type="text" class="form-control num-tabular text-end" id="inv-partial-amount" name="partial_amount" inputmode="decimal" placeholder="0.00" data-partial-amount data-partial-max="{$pay_bare_raw}" aria-describedby="inv-partial-help">
                            </div>
                            <div class="invoice-partial-remain" id="inv-partial-help" data-role="partial-remaining" data-txt-remain-label="{lang key='website/invoices/pay/partial-remain-label'}" data-txt-hint="{lang key='website/invoices/pay/partial-hint'}">
                                <span data-role="partial-remain-label">{lang key='website/invoices/pay/partial-hint'}</span>
                                <span class="num-tabular fw-semibold" data-role="partial-remain-value"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {/if}

    <div class="alert alert-danger d-flex align-items-center d-none mb-0" role="alert" data-checkout-error>
        <i class="bi bi-exclamation-circle me-2 flex-shrink-0" aria-hidden="true"></i>
        <div class="text-break" data-role="checkout-error-text"></div>
    </div>

    <div class="d-grid">
        <button class="btn btn-primary btn-lg" type="submit" data-checkout-submit data-busy-text="{lang key='website/invoices/pay/paying'}"><i class="bi bi-lock-fill me-2"></i><span data-role="pay-label">{if !empty($pay_button_label)}{$pay_button_label}{else}{lang key='website/invoices/pay/pay-button'}{/if}</span><span class="invoice-pay-btn-amount num-tabular" data-role="pay-amount">{$pay_due_fmt}</span></button>
    </div>
    <p class="invoice-pay-secure"><i class="bi bi-shield-lock me-1"></i>{lang key='website/invoices/pay/secure-note'}</p>
</div>
