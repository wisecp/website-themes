<div class="dash-panel-head">
    <h2 class="dash-panel-title">{lang key='website/dashboard/panel-domains'}</h2>
    <a class="dash-panel-link" href="{link route='domains'}">{lang key='website/dashboard/view-all'}<i class="bi bi-arrow-right" aria-hidden="true"></i></a>
</div>
{if $dash_domains}
<div data-dash-filled>
    {foreach $dash_domains as $d}
    <div class="dash-row" data-domain data-start="{$d.start}" data-end="{$d.end}">
        <div class="dash-row-main">
            <div class="dash-service-head">
                <a class="dash-row-title" href="{$d.link}">{$d.name}</a>
                <span class="badge" data-role="domain-badge"></span>
            </div>
            <span class="dash-row-sub num-tabular">{$d.expires_fmt}</span>
        </div>
        <div class="dash-service-term">
            <span class="dash-service-term-label num-tabular" data-role="domain-label"></span>
            <span class="dash-meter" data-role="domain-meter" aria-hidden="true"><span></span></span>
        </div>
        {if !empty($manage)}<a class="btn btn-sm btn-soft dashx-service-manage" href="{$d.link}">{lang key='website/dashboard/manage'}</a>{/if}
    </div>
    {/foreach}
</div>
{else}
<div class="dash-empty" data-dash-empty>
    <span class="dash-empty-ico"><i class="bi bi-globe2" aria-hidden="true"></i></span>
    <span class="dash-empty-title">{lang key='website/dashboard/empty-domains-title'}</span>
    <span class="dash-empty-text">{lang key='website/dashboard/empty-domains-text'}</span>
    <a class="btn btn-sm btn-soft mt-2" href="{link route='domain'}"><i class="bi bi-search me-1"></i>{lang key='website/dashboard/empty-domains-cta'}</a>
</div>
{/if}
