<div class="dash-panel-head">
    <h2 class="dash-panel-title">{lang key='website/dashboard/panel-activity'}</h2>
    <a class="dash-panel-link" href="#">{lang key='website/dashboard/view-all'}<i class="bi bi-arrow-right" aria-hidden="true"></i></a>
</div>
{if $dash_feed}
<ul class="dash-feed" data-dash-filled>
    {foreach $dash_feed as $item}
    <li class="dash-feed-item">
        <span class="dash-feed-ico bg-{$item.tone}-subtle text-{$item.tone}-emphasis"><i class="bi {$item.icon}" aria-hidden="true"></i></span>
        <div class="dash-feed-text">{$item.text}<span class="dash-feed-time">{$item.time_ago}</span></div>
    </li>
    {/foreach}
</ul>
{else}
<div class="dash-empty" data-dash-empty>
    <span class="dash-empty-ico"><i class="bi bi-clock-history" aria-hidden="true"></i></span>
    <span class="dash-empty-title">{lang key='website/dashboard/empty-activity-title'}</span>
    <span class="dash-empty-text">{lang key='website/dashboard/empty-activity-text'}</span>
</div>
{/if}
