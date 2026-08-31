{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/references.css'}">
<link rel="stylesheet" href="{asset path='css/reference-detail.css'}">
{/block}

{block name=content}

    <section class="container py-4 py-lg-5">

        <nav aria-label="{lang key='website/references/breadcrumb'}">
            <ol class="breadcrumb mb-3">
                <li class="breadcrumb-item"><a href="{$references_link}">{lang key='website/references/breadcrumb'}</a></li>
                <li class="breadcrumb-item active" aria-current="page">{$reference.title}</li>
            </ol>
        </nav>

        <div class="ref-detail"{if $reference.category && $reference.category.color} style="--ref-accent: {$reference.category.color}"{/if}>

            <header class="ref-detail-head mb-4">
                {if $reference.category}<span class="ref-detail-cat">{if $reference.category.icon.type == 'image'}<img src="{$reference.category.icon.value}" alt="">{else}<i class="{$reference.category.icon.value}"></i>{/if}{$reference.category.title}</span>{/if}
                <h1 class="ref-detail-title reveal">{$reference.title}</h1>
                {if $reference.lead}<p class="ref-detail-lead text-body-secondary reveal reveal-2 mb-0">{$reference.lead}</p>{/if}
            </header>

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

                            <hr class="ref-spec-sep">
                            <div class="ref-share">
                                <span class="ref-share-label">{lang key='website/references/share-label'}</span>
                                <div class="ref-share-btns">
                                    <a class="ref-share-btn" href="{$share_facebook}" target="_blank" rel="noopener" aria-label="{lang key='website/references/share-facebook'}"><i class="bi bi-facebook"></i></a>
                                    <a class="ref-share-btn" href="{$share_twitter}" target="_blank" rel="noopener" aria-label="{lang key='website/references/share-x'}"><i class="bi bi-twitter-x"></i></a>
                                    <a class="ref-share-btn" href="{$share_linkedin}" target="_blank" rel="noopener" aria-label="{lang key='website/references/share-linkedin'}"><i class="bi bi-linkedin"></i></a>
                                </div>
                            </div>
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
    </section>

    {if $related}
    <section class="container pb-5">
        <h2 class="ref-section-title mb-4">{lang key='website/references/other-title'}</h2>
        <div class="reference-grid">
            {foreach $related as $r}
            {include file='components/reference-card.tpl' card=$r}
            {/foreach}
        </div>
    </section>
    {/if}

    {include file='components/cta-band.tpl'
        cta_title_key='website/references/cta-title'
        cta_text_key='website/references/cta-sub'
        cta_primary_key='website/references/cta-primary'
        cta_secondary_key='website/references/cta-secondary'
        cta_gate=false}

{/block}
