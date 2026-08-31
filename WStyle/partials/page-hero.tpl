{assign var=hero_image value=$image|default:$header_background|default:''}
<section class="page-hero chrome-dark{if !$hero_image} page-hero-plain{/if}">
    {if $hero_image}
    <img class="page-hero-media" src="{$hero_image}" alt="">
    <span class="page-hero-scrim" aria-hidden="true"></span>
    {/if}
    <div class="container">
        <nav aria-label="{lang key='website/index/breadcrumb-aria'}" class="mb-3">
            <ol class="breadcrumb fs-7 mb-0">
                {if $home_crumb|default:true}<li class="breadcrumb-item"><a href="{link route='home'}">{lang key='website/index/breadcrumb-home'}</a></li>{/if}
                {if $crumbs|default:[]}
                    {foreach $crumbs as $bc}
                    {if $bc@last}<li class="breadcrumb-item active" aria-current="page">{$bc.title}</li>
                    {else}<li class="breadcrumb-item"><a href="{$bc.url}">{$bc.title}</a></li>{/if}
                    {/foreach}
                {else}
                <li class="breadcrumb-item active" aria-current="page">{$title}</li>
                {/if}
            </ol>
        </nav>
        {if $pill|default:[]}<span class="ref-hero-cat reveal">{if $pill.icon.type|default:'' == 'image'}<img src="{$pill.icon.value}" alt="">{elseif $pill.icon.value|default:''}<i class="{$pill.icon.value}" aria-hidden="true"></i>{/if}{$pill.title}</span>{/if}
        {if ($heading|default:'h1') == 'p'}<p class="page-hero-title reveal mb-2">{$title}</p>
        {else}<h1 class="page-hero-title reveal mb-2">{$title}</h1>{/if}
        {if $lead|default:''}<p class="page-hero-lead reveal reveal-2 {if $actions|default:[]}mb-3{else}mb-0{/if}">{$lead}</p>{/if}
        {if $actions|default:[]}
        <div class="d-flex flex-wrap gap-2 reveal reveal-2">
            {foreach $actions as $act}
            <a class="btn btn-{$act.variant|default:'soft'} rounded-pill px-4" href="{$act.url}">{if $act.icon|default:''}<i class="{$act.icon} me-1"></i>{/if}{$act.text}</a>
            {/foreach}
        </div>
        {/if}
        {if $badges|default:[]}
        <div class="d-flex flex-wrap align-items-center gap-2 gap-md-3 fs-7 mt-3 reveal reveal-3">
            {foreach $badges as $badge}
            <span class="d-inline-flex align-items-center gap-1"><i class="{$badge.icon}"></i>{$badge.text}</span>
            {/foreach}
        </div>
        {/if}
    </div>
</section>
