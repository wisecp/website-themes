{if !empty($pay_choices_note)}<p class="fw-semibold text-center mb-4">{$pay_choices_note}</p>{/if}
<div class="d-grid gap-3 col-md-8 mx-auto">
    {foreach $pay_choices as $choice}
    <a class="btn {if !empty($choice.variant)}btn-{$choice.variant}{elseif $pay_choices|@count == 1}btn-primary{else}btn-soft{/if} btn-lg" href="{$choice.url}">
        {if !empty($choice.icon)}<i class="bi {$choice.icon} me-2"></i>{elseif !empty($choice.image)}<img src="{$choice.image}" alt="" height="20" class="me-2">{/if}{$choice.label}
    </a>
    {/foreach}
</div>
