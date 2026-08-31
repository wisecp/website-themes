{if $card}
<a class="reference-card hover-lift" href="{$card.link}"{if $card.category} data-cat="{$card.category.slug}"{/if}{if $card.category && $card.category.color} style="--ref-accent: {$card.category.color}"{/if}>
    <span class="reference-frame">
        <span class="reference-frame-dots" aria-hidden="true"><span></span><span></span><span></span></span>
        {if $card.domain}<span class="reference-frame-addr"><i class="bi bi-lock-fill" aria-hidden="true"></i><span class="reference-frame-domain">{$card.domain}</span></span>{/if}
    </span>
    <span class="reference-cover">
        {if $card.cover}<img class="reference-cover-img" src="{$card.cover}" alt="{$card.title} {lang key='website/references/screenshot-alt'}" loading="lazy">{elseif $card.category && $card.category.icon.type == 'image'}<img class="reference-cover-img" src="{$card.category.icon.value}" alt="{$card.title} {lang key='website/references/screenshot-alt'}" loading="lazy">{else}<span class="reference-cover-ico"><i class="{if $card.category}{$card.category.icon.value}{else}bi bi-globe2{/if}"></i></span>{/if}
    </span>
    <span class="reference-body">
        {if $card.category}<span class="reference-cat-label">{if $card.category.icon.type == 'image'}<img src="{$card.category.icon.value}" alt="">{else}<i class="{$card.category.icon.value}"></i>{/if}{$card.category.title}</span>{/if}
        <span class="reference-title">{$card.title}</span>
        {if $card.excerpt}<span class="reference-desc">{$card.excerpt}</span>{/if}
        <span class="reference-visit">{lang key='website/references/visit-case-study'}<i class="bi bi-arrow-right" aria-hidden="true"></i></span>
    </span>
</a>
{/if}
