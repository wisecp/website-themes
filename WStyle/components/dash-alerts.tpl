{if $dash_alerts}
<div class="dash-alerts">
    {foreach $dash_alerts as $al}
    {if $al.type == 'invoice'}
    <div class="dash-alert dash-alert-danger" role="alert" data-alert-id="{$al.id}">
        <i class="bi bi-exclamation-octagon-fill" aria-hidden="true"></i>
        <div class="dash-alert-body"><a href="{$al.link}"><strong>{$al.label}</strong></a> {$al.text}</div>
        <a class="btn btn-sm btn-outline-danger flex-shrink-0" href="{$al.link}">{lang key='website/dashboard/alert-pay-now'}</a>
        <button type="button" class="wstyle-alert-close" data-action="dismiss-alert" aria-label="{lang key='website/dashboard/alert-dismiss'}"><i class="bi bi-x-lg" aria-hidden="true"></i></button>
    </div>
    {elseif $al.type == 'domain'}
    <div class="dash-alert dash-alert-danger" role="alert" data-alert-expiring="single" data-alert-id="{$al.id}">
        <i class="bi bi-exclamation-circle-fill" aria-hidden="true"></i>
        <div class="dash-alert-body"><a href="{$al.link}"><strong>{$al.label}</strong></a> {$al.text}</div>
        <a class="btn btn-sm btn-outline-danger flex-shrink-0" href="{$al.link}">{lang key='website/dashboard/alert-renew'}</a>
        <button type="button" class="wstyle-alert-close" data-action="dismiss-alert" aria-label="{lang key='website/dashboard/alert-dismiss'}"><i class="bi bi-x-lg" aria-hidden="true"></i></button>
    </div>
    {elseif $al.type == 'domains'}
    <div class="dash-alert dash-alert-{$al.tone|default:'warning'}" role="alert" data-alert-expiring="multiple" data-alert-id="{$al.id}">
        <i class="bi bi-exclamation-triangle-fill" aria-hidden="true"></i>
        <div class="dash-alert-body"><a href="{$al.link}"><strong>{$al.label}</strong></a> {$al.text}</div>
        <a class="btn btn-sm btn-outline-{$al.tone|default:'warning'} flex-shrink-0" href="{$al.link}">{lang key='website/dashboard/alert-doms-cta'}</a>
        <button type="button" class="wstyle-alert-close" data-action="dismiss-alert" aria-label="{lang key='website/dashboard/alert-dismiss'}"><i class="bi bi-x-lg" aria-hidden="true"></i></button>
    </div>
    {/if}
    {/foreach}
</div>
{/if}
