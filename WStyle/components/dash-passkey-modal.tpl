{if empty($verify_modal) && $dashboard_modal == 'passkey-offer'}
<div class="modal fade dash-modal" id="modalPasskeyOffer" data-dashboard-modal-id="passkey-offer" tabindex="-1" aria-labelledby="modalPasskeyOfferTitle" aria-hidden="true"
     data-passkey-url="{$passkey_offer_url}" data-passkey-token="{$passkey_offer_token}"
     data-txt-unsupported="{lang key='website/account/passkeys-unsupported'}"
     data-txt-failed="{lang key='website/account/passkey-failed'}">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center p-5">
                <span class="dash-modal-ico bg-primary-subtle text-primary-emphasis"><i class="bi bi-fingerprint" aria-hidden="true"></i></span>
                <h2 class="h5 mt-3 mb-2" id="modalPasskeyOfferTitle">{lang key='website/account/passkey-offer-title'}</h2>
                <p class="text-body-secondary mb-0">{lang key='website/account/passkey-offer-text'}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-action="passkey-offer-later" data-bs-dismiss="modal">{lang key='website/account/passkey-offer-later'}</button>
                <button type="button" class="btn btn-primary" data-action="passkey-offer-create"><i class="bi bi-fingerprint me-1"></i>{lang key='website/account/passkey-offer-action'}</button>
            </div>
        </div>
    </div>
</div>
{/if}
