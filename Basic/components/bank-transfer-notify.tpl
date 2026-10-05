<div class="row g-3 mt-1" data-bank-notify>
    {if $accounts}
    <div class="col-sm-6">
        <label class="form-label" for="{$prefix}-bank-account">{lang key='website/invoices/pay/bank-account-label'}</label>
        <select class="form-select" id="{$prefix}-bank-account" data-role="bank-account">
            {foreach $accounts as $b}<option value="{$b.id}">{$b.name}</option>{/foreach}
        </select>
    </div>
    {/if}
    <div class="col-sm-6">
        <label class="form-label" for="{$prefix}-bank-sender">{lang key='website/invoices/pay/bank-sender-label'} <span class="text-danger" aria-hidden="true">*</span></label>
        <input type="text" class="form-control" id="{$prefix}-bank-sender" data-role="bank-sender" autocomplete="name" placeholder="{lang key='website/invoices/pay/bank-sender-ph'}">
        <div class="invalid-feedback">{lang key='website/invoices/pay/error-bank-sender'}</div>
    </div>
</div>
