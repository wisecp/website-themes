{if $payment_methods}
<div class="card">
    <div class="card-body p-4">
        <div class="checkout-head">
            <span class="icon-disc"><i class="bi bi-credit-card"></i></span>
            <div>
                <h2 class="h6 fw-semibold mb-0">{lang key='website/checkout/payment-title'}</h2>
                <p class="fs-8 text-body-secondary mb-0">{lang key='website/checkout/payment-sub'}</p>
            </div>
        </div>

        {hook name='ui:client.checkout.payment.before'}

        {include file='components/payment-methods.tpl'}

        {include file='components/checkout-pay-footer.tpl'}
    </div>
</div>
{else}
<div class="card">
    <div class="card-body p-4">
        <div class="checkout-head">
            <span class="icon-disc"><i class="bi bi-cart-check"></i></span>
            <div>
                <h2 class="h6 fw-semibold mb-0">{lang key='website/checkout/review-title'}</h2>
                <p class="fs-8 text-body-secondary mb-0">{lang key='website/checkout/review-sub'}</p>
            </div>
        </div>

        {include file='components/checkout-pay-footer.tpl'}
    </div>
</div>
{/if}
