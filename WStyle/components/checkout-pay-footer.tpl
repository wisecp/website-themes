<div class="checkout-pay-footer d-flex flex-column gap-3" data-pay-footer>

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
        <input class="form-check-input flex-shrink-0" type="checkbox" id="co-apply-balance" name="apply_balance" value="1" data-apply-balance aria-label="{lang key='website/checkout/apply-balance-title'}">
    </label>
    {/if}

    <div>
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-2">
            <div class="form-check mb-0">
                <input class="form-check-input" type="checkbox" id="co-terms" name="terms" value="1" required>
                <label class="form-check-label fs-7" for="co-terms">{$terms_html nofilter} <span class="text-danger" aria-hidden="true">*</span></label>
                <div class="invalid-feedback">{lang key='website/checkout/error-terms'}</div>
            </div>
            <button class="btn btn-soft btn-sm" type="button" data-wui-toggle data-wui-target="#coNote" aria-expanded="false" aria-controls="coNote">
                <i class="bi bi-sticky me-1"></i>{lang key='website/checkout/add-note'}
            </button>
        </div>
        <div class="wui-collapse" id="coNote">
            <div class="wui-collapse-inner">
                <div class="pt-3">
                    <label for="co-order-note" class="form-label">{lang key='website/checkout/note-label'} <span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span></label>
                    <textarea class="form-control" id="co-order-note" name="order_notes" rows="3" placeholder="{lang key='website/checkout/note-placeholder'}"></textarea>
                </div>
            </div>
        </div>
    </div>

    {hook name='ui:client.checkout.terms.after'}

    <div class="alert alert-danger d-flex align-items-center d-none mb-0" role="alert" data-checkout-error>
        <i class="bi bi-exclamation-circle me-2 flex-shrink-0" aria-hidden="true"></i>
        <div class="text-break" data-role="checkout-error-text"></div>
    </div>

    <div class="d-grid">
        <button class="btn btn-primary btn-lg" type="submit" data-checkout-submit data-busy-text="{lang key='website/checkout/placing-order'}"><i class="bi bi-lock-fill me-2"></i><span data-role="pay-label">{lang key='website/checkout/place-order'}</span><span class="checkout-pay-btn-amount num-tabular" data-role="pay-amount">{$checkout_summary.total_fmt}</span></button>
    </div>
    <p class="fs-8 text-body-secondary text-center mb-0">{lang key='website/checkout/confirm-note'}</p>
</div>
