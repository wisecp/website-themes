{extends file='layouts/default.tpl'}

{block name=body_class}chrome-overlay{/block}

{block name=head}
<link rel="stylesheet" href="{asset path='css/references.css'}">
<link rel="stylesheet" href="{asset path='css/reference-detail.css'}">
{/block}

{block name=bands}
{include file='partials/band-newsletter.tpl'}
{/block}

{block name=content}

    {include file='partials/page-hero.tpl'
        title=$reference.title
        lead=$reference.lead|default:''
        pill=$reference.category|default:[]
        crumbs=[
            ['title' => "{lang key='website/references/breadcrumb'}", 'url' => $references_link],
            ['title' => $reference.title]
        ]}

    <section class="py-5" data-reveal>
        <div class="container">

        <div class="ref-detail"{if $reference.category && $reference.category.color} style="--ref-accent: {$reference.category.color}"{/if}>

            <div class="row g-4 g-lg-5">

                <div class="col-lg-4 order-lg-2">
                    <aside class="ref-aside">
                        <div class="ref-spec">
                            {if $reference.website}<a class="btn btn-primary w-100 ref-spec-cta" href="{$reference.website}" target="_blank" rel="noopener noreferrer">{lang key='website/references/review-website'}<i class="bi bi-box-arrow-up-right ms-2" aria-hidden="true"></i></a>{/if}

                            {if $reference.category}
                            <div class="ref-spec-row">
                                <span class="ref-spec-key">{lang key='website/references/category'}</span>
                                <span class="ref-cat-pill">{if $reference.category.icon.type == 'image'}<img src="{$reference.category.icon.value}" alt="">{else}<i class="{$reference.category.icon.value}"></i>{/if}{$reference.category.title}</span>
                            </div>
                            {/if}

                            {if $reference.featured}
                            <hr class="ref-spec-sep">
                            <div>
                                <h2 class="ref-spec-title mb-3">{lang key='website/references/delivered-title'}</h2>
                                <ul class="ref-feature-list list-unstyled">
                                    {foreach $reference.featured as $feature}
                                    <li><i class="bi bi-check-circle-fill"></i>{$feature}</li>
                                    {/foreach}
                                </ul>
                            </div>
                            {/if}

                            {if $reference.technical}
                            <hr class="ref-spec-sep">
                            <div>
                                <h2 class="ref-spec-title mb-3">{lang key='website/references/technical-title'}</h2>
                                <ul class="ref-tech-list list-unstyled">
                                    {foreach $reference.technical as $tech}
                                    <li><i class="bi bi-chevron-right"></i>{$tech}</li>
                                    {/foreach}
                                </ul>
                            </div>
                            {/if}

                        </div>
                    </aside>
                </div>

                <div class="col-lg-8 order-lg-1">
                    {if $reference.screenshot}
                    <figure class="ref-shot mb-4">
                        <div class="ref-shot-bar">
                            <span class="ref-shot-dots" aria-hidden="true"><span></span><span></span><span></span></span>
                            {if $reference.domain}<span class="ref-shot-addr"><i class="bi bi-lock-fill" aria-hidden="true"></i><span class="ref-shot-domain">{$reference.domain}</span></span>{/if}
                        </div>
                        <img class="ref-shot-img" src="{$reference.screenshot}" alt="{$reference.title} {lang key='website/references/screenshot-alt'}" fetchpriority="high">
                    </figure>
                    {/if}
                    <div class="ref-prose">{if $reference.content}{$reference.content nofilter}{else}<p class="text-body-secondary mb-0">{lang key='website/references/no-content'}</p>{/if}</div>

                    {hook name='ui:client.reference_detail.content.after'}
                </div>

            </div>
        </div>
        </div>
    </section>

    {if $related}
    <section class="py-5 bg-surface" data-reveal>
        <div class="container">
            <div class="section-head">
                <span class="eyebrow">{lang key='website/references/other-eyebrow'}</span>
                <h2 class="tracking-tight">{lang key='website/references/other-title'}</h2>
                <p class="section-lead">{lang key='website/references/other-lead'}</p>
            </div>
            <div class="reference-grid">
                {foreach $related as $r}
                {include file='components/reference-card.tpl' card=$r}
                {/foreach}
            </div>
        </div>
    </section>
    {/if}

{/block}
