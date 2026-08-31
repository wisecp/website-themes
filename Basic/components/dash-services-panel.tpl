<div class="dash-panel-head">
    <h2 class="dash-panel-title">{lang key='website/dashboard/panel-services'}</h2>
    <a class="dash-panel-link" href="{link route='services'}">{lang key='website/dashboard/view-all'}<i class="bi bi-arrow-right" aria-hidden="true"></i></a>
</div>
{if $dash_services}
<div data-dash-filled>
    {foreach $dash_services as $svc}
    <div class="dash-service">
        <div class="dash-service-main">
            <div class="dash-service-head">
                <a class="dash-service-name" href="{$svc.link}">{$svc.name}</a>
                {if !empty($svc.term_expired)}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-calendar-x me-1"></i>{lang key='website/dashboard/st-expired'}</span>
                {elseif $svc.badge == 'pending'}<span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-gear-fill wcp-status-spin me-1"></i>{lang key='website/dashboard/st-pending'}</span>
                {elseif $svc.badge == 'suspended'}<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-pause-circle me-1"></i>{lang key='website/dashboard/st-suspended'}</span>
                {elseif $svc.badge == 'cancelled'}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/dashboard/st-cancelled'}</span>
                {elseif $svc.badge == 'expired'}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-calendar-x me-1"></i>{lang key='website/dashboard/st-expired'}</span>
                {else}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/dashboard/st-active'}</span>{/if}
            </div>
            <span class="dash-service-meta">{$svc.meta}</span>
        </div>
        {if $svc.badge == 'pending'}
        <span class="dash-service-pending"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/dashboard/awaiting-activation'}</span>
        {elseif !empty($svc.gauge_load)}
        <div class="dash-service-usage" data-gauge-service="{$svc.gauge_load}"{if !empty($svc.term.lifetime)} data-lifetime{else} data-start="{$svc.term.start}" data-end="{$svc.term.end}"{/if}>
            <div class="dash-service-gauges" aria-hidden="true">
                <span class="dash-gauge dash-gauge-skeleton"></span>
                <span class="dash-gauge dash-gauge-skeleton"></span>
            </div>
        </div>
        {else}
        <div class="dash-service-term" data-term{if !empty($svc.term.lifetime)} data-lifetime{else} data-start="{$svc.term.start}" data-end="{$svc.term.end}"{/if}>
            <span class="dash-service-term-label num-tabular" data-role="term-label"></span>
            <span class="dash-meter" data-role="term-meter" aria-hidden="true"><span></span></span>
        </div>
        {/if}
        {if !empty($manage)}<a class="btn btn-sm btn-soft dashx-service-manage{if $svc.badge == 'pending'} disabled{/if}" href="{$svc.link}"{if $svc.badge == 'pending'} aria-disabled="true" tabindex="-1"{/if}>{lang key='website/dashboard/manage'}</a>{/if}
    </div>
    {/foreach}
</div>
{else}
<div class="dash-empty" data-dash-empty>
    <span class="dash-empty-ico"><i class="bi bi-hdd-stack" aria-hidden="true"></i></span>
    <span class="dash-empty-title">{lang key='website/dashboard/empty-services-title'}</span>
    <span class="dash-empty-text">{lang key='website/dashboard/empty-services-text'}</span>
    <a class="btn btn-sm btn-soft mt-2" href="{$order_service_link}"><i class="bi bi-plus-lg me-1"></i>{lang key='website/dashboard/empty-services-cta'}</a>
</div>
{/if}
