{extends file='layouts/default.tpl'}

{block name=body_class}chrome-overlay{/block}

{block name=head}
<link rel="stylesheet" href="{asset path='css/references.css'}">
<script src="{asset path='js/references.js'}" defer></script>
{/block}

{block name=bands}
{include file='partials/band-newsletter.tpl'}
{/block}

{block name=content}

    {include file='partials/page-hero.tpl'
        title="{lang key='website/references/hero-title'}"
        lead="{lang key='website/references/hero-lead'}"
        crumbs=[['title' => "{lang key='website/references/hero-title'}"]]}

    <section class="py-5 bg-surface" data-reveal>
        <div class="container">

        <div class="section-head">
            <span class="eyebrow">{lang key='website/references/section-eyebrow'}</span>
            <h2 class="tracking-tight">{lang key='website/references/section-title'}</h2>
            <p class="section-lead">{lang key='website/references/section-lead'}</p>
        </div>

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
        <div class="wstyle-empty-state">
            <i class="bi bi-collection" aria-hidden="true"></i>
            <p class="fw-semibold mb-1">{lang key='website/references/empty-title'}</p>
            <p class="fs-7 mb-0">{lang key='website/references/empty-text'}</p>
        </div>
        {/if}

        </div>
    </section>

{/block}
