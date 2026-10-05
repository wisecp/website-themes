{* Guest only (never in the member fragment render — the controller passes
   guest_account_fields on the guest page render alone): the account the
   deferred registration creates is Individual or Company; company reveals
   the billing company + tax fields Auth::register persists. *}
{if $guest_account_fields}
<div class="mb-3">
    <span class="form-label d-block mb-2">{lang key='website/account/type-title'}</span>
    <div class="btn-group" role="group" aria-label="{lang key='website/account/type-title'}">
        <input type="radio" class="btn-check" name="account_type" id="co-type-individual" value="individual" autocomplete="off" checked>
        <label class="btn btn-soft" for="co-type-individual"><i class="bi bi-person me-1"></i>{lang key='website/account/type-individual'}</label>
        <input type="radio" class="btn-check" name="account_type" id="co-type-company" value="company" autocomplete="off">
        <label class="btn btn-soft" for="co-type-company"><i class="bi bi-building me-1"></i>{lang key='website/account/type-company'}</label>
    </div>
</div>
<div class="wui-collapse" data-guest-company-fields>
    <div class="wui-collapse-inner">
        <div class="pb-3">
            <div class="row g-3">
                <div class="col-12">
                    <label for="co-company-name" class="form-label">{lang key='website/account/company-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                    <input type="text" class="form-control" id="co-company-name" name="company_name" autocomplete="organization" required>
                    <div class="invalid-feedback">{lang key='website/account/err-company-name'}</div>
                </div>
                <div class="col-sm-6">
                    <label for="co-tax-number" class="form-label">{lang key='website/account/vat'}{if $guest_tax_number_required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                    <input type="text" class="form-control" id="co-tax-number" name="tax_number" autocomplete="off"{if $guest_tax_number_required} required{/if}>
                </div>
                <div class="col-sm-6">
                    <label for="co-tax-office" class="form-label">{lang key='website/account/tax-office'}{if $guest_tax_office_required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                    <input type="text" class="form-control" id="co-tax-office" name="tax_office" autocomplete="off"{if $guest_tax_office_required} required{/if}>
                </div>
            </div>
        </div>
    </div>
</div>
{/if}

{if $billing_profiles}
<div class="wui-collapse wui-show" data-billing-profiles id="billingProfilesList">
    <div class="wui-collapse-inner">
        <div class="d-flex flex-column gap-2">
            <span class="form-label mb-0">{lang key='website/checkout/billing-profile'}</span>
            {foreach $billing_profiles as $p}
            <label class="option-card option-card-radio option-card-sm d-flex align-items-center gap-3">
                <input class="form-check-input" type="radio" name="billing_profile" value="{$p.id}"{if $p.default} checked{/if}>
                <span class="option-media"><i class="bi {if $p.corporate}bi-building{else}bi-person-vcard{/if}"></i></span>
                <span class="me-auto">
                    <span class="fw-semibold d-block">{$p.name}{if $p.default} <span class="badge bg-primary-subtle text-primary-emphasis ms-1"><i class="bi bi-star-fill me-1"></i>{lang key='website/checkout/billing-default'}</span>{/if}</span>
                    <span class="fs-8 text-body-secondary">{$p.line}</span>
                </span>
            </label>
            {/foreach}
            <label class="option-card option-card-radio option-card-sm d-flex align-items-center gap-3">
                <input class="form-check-input" type="radio" name="billing_profile" value="new" data-new-billing-trigger>
                <span class="option-media"><i class="bi bi-plus-lg"></i></span>
                <span class="fw-semibold">{lang key='website/checkout/billing-new'}</span>
            </label>
        </div>
    </div>
</div>
{else}
<input type="hidden" name="billing_profile" value="new">
{/if}

<div class="wui-collapse{if !$billing_profiles} wui-show{/if}" data-new-billing>
    <div class="wui-collapse-inner">
        <div class="billing-new-fields">
            {if !$guest_account_fields}
            <div class="mb-3">
                <span class="form-label d-block mb-2">{lang key='website/account/type-title'}</span>
                <div class="btn-group" role="group" aria-label="{lang key='website/account/type-title'}">
                    <input type="radio" class="btn-check" name="account_type" id="co-billing-type-individual" value="individual" autocomplete="off"{if !($billing_prefill.corporate|default:false)} checked{/if}>
                    <label class="btn btn-soft" for="co-billing-type-individual"><i class="bi bi-person me-1"></i>{lang key='website/account/type-individual'}</label>
                    <input type="radio" class="btn-check" name="account_type" id="co-billing-type-company" value="company" autocomplete="off"{if $billing_prefill.corporate|default:false} checked{/if}>
                    <label class="btn btn-soft" for="co-billing-type-company"><i class="bi bi-building me-1"></i>{lang key='website/account/type-company'}</label>
                </div>
            </div>
            <div class="wui-collapse{if $billing_prefill.corporate|default:false} wui-show{/if}" data-billing-company-fields>
                <div class="wui-collapse-inner">
                    <div class="pb-3">
                        <div class="row g-3">
                            <div class="col-12">
                                <label for="co-billing-company-name" class="form-label">{lang key='website/account/company-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="co-billing-company-name" name="company_name" autocomplete="organization" value="{$billing_prefill.company_name|default:''}">
                                <div class="invalid-feedback">{lang key='website/account/err-company-name'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="co-billing-tax-number" class="form-label">{lang key='website/account/vat'}{if $guest_tax_number_required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                <input type="text" class="form-control" id="co-billing-tax-number" name="tax_number" autocomplete="off" value="{$billing_prefill.tax_number|default:''}">
                            </div>
                            <div class="col-sm-6">
                                <label for="co-billing-tax-office" class="form-label">{lang key='website/account/tax-office'}{if $guest_tax_office_required} <span class="text-danger" aria-hidden="true">*</span>{else} <span class="text-body-secondary fw-normal">{lang key='website/account/optional'}</span>{/if}</label>
                                <input type="text" class="form-control" id="co-billing-tax-office" name="tax_office" autocomplete="off" value="{$billing_prefill.tax_office|default:''}">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {/if}
            <div class="row g-3 mb-3">
                <div class="col-sm-6">
                    <label for="co-first" class="form-label">{lang key='website/sign/register-first-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                    <input type="text" class="form-control" id="co-first" name="first_name" autocomplete="given-name" value="{$billing_prefill.first_name|default:''}" required>
                    <div class="invalid-feedback">{lang key='website/checkout/error-first-name'}</div>
                </div>
                <div class="col-sm-6">
                    <label for="co-last" class="form-label">{lang key='website/sign/register-last-name'} <span class="text-danger" aria-hidden="true">*</span></label>
                    <input type="text" class="form-control" id="co-last" name="last_name" autocomplete="family-name" value="{$billing_prefill.last_name|default:''}" required>
                    <div class="invalid-feedback">{lang key='website/checkout/error-last-name'}</div>
                </div>
            </div>
            <div class="mb-3">
                <label for="co-address1" class="form-label">{lang key='website/sign/register-address'} <span class="text-danger" aria-hidden="true">*</span></label>
                <input type="text" class="form-control" id="co-address1" name="address1" autocomplete="address-line1" required>
                <div class="invalid-feedback">{lang key='website/checkout/error-address'}</div>
            </div>
            <div class="row g-3 mb-3">
                <div class="col-sm-6">
                    <label for="co-country" class="form-label">{lang key='website/sign/register-country'} <span class="text-danger" aria-hidden="true">*</span></label>
                    <select class="form-select" id="co-country" name="country" autocomplete="country" data-basic-select data-flag-select required>
                        <option value="">{lang key='website/sign/register-country-placeholder'}</option>
                        {foreach $countries as $c}
                        <option value="{$c.a2_iso}"{if $c.id == ($billing_prefill.country_id|default:0)} selected{/if}>{$c.name}</option>
                        {/foreach}
                    </select>
                    <div class="invalid-feedback">{lang key='website/checkout/error-country'}</div>
                </div>
                <div class="col-sm-6">
                    <label for="co-state" class="form-label">{lang key='website/sign/register-state'} <span class="text-body-secondary fw-normal">{lang key='website/sign/register-optional'}</span></label>
                    <select class="form-select" id="co-state" name="state" data-basic-select data-placeholder="{lang key='website/sign/register-state-placeholder'}" disabled>
                        <option value="">{lang key='website/sign/register-state-placeholder'}</option>
                    </select>
                    <input type="text" class="form-control d-none" id="co-state-text" name="state_text" autocomplete="address-level1" placeholder="{lang key='website/sign/register-state'}">
                </div>
            </div>
            <div class="row g-3">
                <div class="col-sm-6">
                    <label for="co-city" class="form-label">{lang key='website/sign/register-city'} <span class="text-danger" aria-hidden="true">*</span></label>
                    <select class="form-select" id="co-city" name="city" data-basic-select data-placeholder="{lang key='website/sign/register-city-placeholder'}" disabled>
                        <option value="">{lang key='website/sign/register-city-placeholder'}</option>
                    </select>
                    <input type="text" class="form-control d-none" id="co-city-text" name="city_text" autocomplete="address-level2" placeholder="{lang key='website/sign/register-city'}">
                    <div class="invalid-feedback">{lang key='website/checkout/error-city'}</div>
                </div>
                <div class="col-sm-6">
                    <label for="co-postal" class="form-label">{lang key='website/sign/register-postal'} <span class="text-danger" aria-hidden="true">*</span></label>
                    <input type="text" class="form-control" id="co-postal" name="postal_code" autocomplete="postal-code" required>
                    <div class="invalid-feedback">{lang key='website/checkout/error-postal-code'}</div>
                </div>
            </div>
        </div>
    </div>
</div>
