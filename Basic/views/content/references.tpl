{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/references.css'}">
<script src="{asset path='js/references.js'}" defer></script>
{/block}

{block name=content}

    <section class="page-hero text-center">
        <div class="container">
            <span class="eyebrow reveal d-inline-block mb-2">{lang key='website/references/hero-eyebrow'}</span>
            <h1 class="page-hero-title reveal reveal-2 mb-3">{lang key='website/references/hero-title'}</h1>
            <p class="page-hero-lead text-body-secondary reveal reveal-3 mb-0">{lang key='website/references/hero-lead'}</p>
        </div>
    </section>

    {if $stats}
    <section class="container">
        <ul class="reference-stats list-unstyled mb-0">
            {foreach $stats as $stat}
            <li class="reference-stat">
                <span class="reference-stat-num num-tabular">{$stat.num}</span>
                <span class="reference-stat-label">{$stat.label}</span>
            </li>
            {/foreach}
        </ul>
    </section>
    {/if}

    <section class="container py-4 py-lg-5">

        {if $categories}
        <div class="reference-filters" role="group" data-ref-filter aria-label="{lang key='website/references/filter-aria'}">
            <button class="reference-chip active" type="button" data-cat="all" aria-pressed="true"><i class="bi bi-grid"></i><span>{lang key='website/references/filter-all'}</span><span class="reference-chip-count num-tabular">{$total_count}</span></button>
            {foreach $categories as $cat}
            <button class="reference-chip" type="button" data-cat="{$cat.slug}" aria-pressed="false">{if $cat.icon.type == 'image'}<img src="{$cat.icon.value}" alt="">{else}<i class="{$cat.icon.value}"></i>{/if}<span>{$cat.title}</span><span class="reference-chip-count num-tabular">{$cat.count}</span></button>
            {/foreach}
        </div>
        {/if}

        {if $items}
        <div class="reference-grid" data-ref-list
             data-ref-count-all="{lang key='website/references/count-all'}"
             data-ref-count-some="{lang key='website/references/count-some'}">
            {foreach $items as $item}
            {include file='components/reference-card.tpl' card=$item}
            {/foreach}
        </div>

        <p class="reference-count num-tabular" data-role="ref-count" aria-live="polite"></p>
        {else}
        <div class="basic-empty-state">
            <i class="bi bi-collection" aria-hidden="true"></i>
            <p class="fw-semibold mb-1">{lang key='website/references/empty-title'}</p>
            <p class="fs-7 mb-0">{lang key='website/references/empty-text'}</p>
        </div>
        {/if}

    </section>

    {include file='components/cta-band.tpl'
        cta_title_key='website/references/cta-title'
        cta_text_key='website/references/cta-sub'
        cta_primary_key='website/references/cta-primary'
        cta_secondary_key='website/references/cta-secondary'
        cta_gate=false}

{/block}
