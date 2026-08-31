<div class="row g-4">
    <div class="col-lg-7">
        <div class="row g-3">
            <div class="col-12">
                <label for="cc-{$prefix}-number" class="form-label">{lang key='website/payment/card-number'} <span class="text-danger" aria-hidden="true">*</span></label>
                <div class="input-group card-number-group">
                    <span class="input-group-text"><i class="bi bi-credit-card"></i></span>
                    <input type="text" class="form-control num-tabular" id="cc-{$prefix}-number" data-role="card-number" inputmode="numeric" autocomplete="cc-number" placeholder="1234 5678 9012 3456">
                    <i class="fa-brands card-scheme-icon" data-role="card-scheme" aria-hidden="true"></i>
                </div>
                <div class="invalid-feedback">{lang key='website/payment/error-card-number'}</div>
            </div>
            <div class="col-6">
                <label for="cc-{$prefix}-exp" class="form-label">{lang key='website/payment/card-expiry'} <span class="text-danger" aria-hidden="true">*</span></label>
                <input type="text" class="form-control num-tabular" id="cc-{$prefix}-exp" data-role="card-exp" inputmode="numeric" autocomplete="cc-exp" placeholder="MM / YY">
                <div class="invalid-feedback">{lang key='website/payment/error-card-expiry'}</div>
            </div>
            <div class="col-6">
                <label for="cc-{$prefix}-cvc" class="form-label">CVC <span class="text-danger" aria-hidden="true">*</span></label>
                <input type="text" class="form-control num-tabular" id="cc-{$prefix}-cvc" data-role="card-cvc" inputmode="numeric" autocomplete="cc-csc" placeholder="123">
                <div class="invalid-feedback">{lang key='website/payment/error-card-cvc'}</div>
            </div>
            <div class="col-12">
                <label for="cc-{$prefix}-name" class="form-label">{lang key='website/payment/card-holder'} <span class="text-danger" aria-hidden="true">*</span></label>
                <input type="text" class="form-control" id="cc-{$prefix}-name" data-role="card-name" autocomplete="cc-name">
                <div class="invalid-feedback">{lang key='website/payment/error-card-holder'}</div>
            </div>
            {if $can_store}
            <div class="col-12">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="cc-{$prefix}-save" data-role="save-card" value="1">
                    <label class="form-check-label fs-7" for="cc-{$prefix}-save">{lang key='website/payment/save-card'}</label>
                </div>
                {if $can_autopay}
                <div class="form-check mt-2">
                    <input class="form-check-input" type="checkbox" id="cc-{$prefix}-autopay" data-role="auto-pay" value="1">
                    <label class="form-check-label fs-7" for="cc-{$prefix}-autopay">{lang key='website/payment/auto-pay'}</label>
                </div>
                {/if}
            </div>
            {/if}
        </div>
    </div>
    <div class="col-lg-5">
        <div class="checkout-secure-cover">
            <i class="bi bi-shield-lock checkout-secure-cover-icon" aria-hidden="true"></i>
            <p class="fw-semibold mb-0">{lang key='website/payment/secure-title'}</p>
            <p class="fs-8 text-body-secondary mb-0">{lang key='website/payment/secure-sub'}</p>
            <ul class="checkout-secure-points">
                <li><i class="bi bi-check2"></i>{lang key='website/payment/secure-point1'}</li>
                <li><i class="bi bi-check2"></i>{lang key='website/payment/secure-point2'}</li>
                <li><i class="bi bi-check2"></i>{lang key='website/payment/secure-point3'}</li>
            </ul>
        </div>
    </div>
</div>
