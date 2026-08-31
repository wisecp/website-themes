{foreach $checkout_items as $item}
{assign var=railAddons value=[]}
{foreach $item.breakdown as $r}{if $r.addon}{append var=railAddons value=$r}{/if}{/foreach}
<div class="order-summary-line">
    <span class="summary-label">{$item.title}{if $item.sub}<span class="summary-sub d-block">{$item.sub}</span>{/if}{if $railAddons}<button class="rail-addons-toggle collapsed" type="button" data-wui-toggle data-wui-target="#railAddons-{$item.key}" aria-expanded="false" aria-controls="railAddons-{$item.key}"><span>{if $railAddons|count == 1}{lang key='website/checkout/rail-addons-one'}{else}{lang key='website/checkout/rail-addons-many' n=$railAddons|count}{/if}</span><i class="bi bi-chevron-down rail-addons-caret" aria-hidden="true"></i></button>{/if}</span>
    <span class="summary-value num-tabular">{$item.total_fmt}</span>
</div>
{if $railAddons}
<div class="wui-collapse rail-addons" id="railAddons-{$item.key}">
    <div class="wui-collapse-inner">
        {foreach $railAddons as $r}
        <div class="order-summary-line rail-addon">
            <span class="summary-sub">{$r.label}</span>
            <span class="summary-value num-tabular">{$r.value}</span>
        </div>
        {/foreach}
    </div>
</div>
{/if}
{/foreach}
