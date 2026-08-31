{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/knowledgebase.css'}">
<script src="{asset path='js/knowledgebase.js'}" defer></script>
{/block}

{block name=content}

    <section class="page-hero text-center">
        <div class="container">
            <h1 class="page-hero-title reveal mb-3">{lang key='website/knowledgebase/hero-title'}</h1>
            <p class="page-hero-lead text-body-secondary reveal reveal-2 mb-4">{lang key='website/knowledgebase/hero-lead'}</p>

            <div class="page-hero-search reveal reveal-3">
                <form action="{$kb_link}" method="get" data-kb-search role="search">
                    <div class="kb-search">
                        <label for="kb-query" class="visually-hidden">{lang key='website/knowledgebase/search-label'}</label>
                        <i class="bi bi-search kb-search-icon" aria-hidden="true"></i>
                        <input type="search" class="form-control" id="kb-query" name="q" value="{$kb_query}" placeholder="{lang key='website/knowledgebase/search-placeholder'}" autocomplete="off">
                        <button class="btn btn-primary" type="submit"><i class="bi bi-search me-1"></i>{lang key='website/knowledgebase/search-button'}</button>
                    </div>
                </form>
                {hook name='ui:client.kb_landing.search.after'}
                {if $popular}
                <p class="kb-search-hint fs-7 text-body-secondary mt-3 mb-0">{lang key='website/knowledgebase/search-popular'} {foreach $popular as $p name=hint}{if $smarty.foreach.hint.index < 3}<a href="{$p.link}">{$p.title}</a>{if $smarty.foreach.hint.index < 2 && $smarty.foreach.hint.total > $smarty.foreach.hint.index+1}, {/if}{/if}{/foreach}</p>
                {/if}
            </div>
        </div>
    </section>

    <section class="container py-5">

        <div class="d-none" id="kb-results">
            <div class="wui-collapse-inner">
                <div class="pb-2">
                    <div class="kb-results-head" data-reveal>
                        <h2 class="kb-results-title">{lang key='website/knowledgebase/results-for'} "<span class="kb-results-query" data-role="kb-query-echo"></span>"</h2>
                        <p class="kb-results-count" role="status" data-role="kb-results-count" data-count-label="{lang key='website/knowledgebase/results-count'}"></p>
                    </div>

                    <div class="kb-article-grid d-none" data-role="kb-skeleton" aria-hidden="true">
                        <div class="kb-article"><span class="basic-skeleton kb-article-ico"></span><div class="kb-article-body"><span class="basic-skeleton d-block w-75 mb-2"></span><span class="basic-skeleton d-block w-50"></span></div></div>
                        <div class="kb-article"><span class="basic-skeleton kb-article-ico"></span><div class="kb-article-body"><span class="basic-skeleton d-block w-75 mb-2"></span><span class="basic-skeleton d-block w-50"></span></div></div>
                        <div class="kb-article"><span class="basic-skeleton kb-article-ico"></span><div class="kb-article-body"><span class="basic-skeleton d-block w-75 mb-2"></span><span class="basic-skeleton d-block w-50"></span></div></div>
                        <div class="kb-article"><span class="basic-skeleton kb-article-ico"></span><div class="kb-article-body"><span class="basic-skeleton d-block w-75 mb-2"></span><span class="basic-skeleton d-block w-50"></span></div></div>
                    </div>

                    <div class="kb-article-grid d-none" data-role="kb-matches" data-reveal data-reveal-stagger></div>

                    <div class="docs-results-foot d-none reveal reveal-2" data-role="kb-results-foot">
                        <button type="button" class="btn btn-soft btn-sm" data-action="kb-clear"><i class="bi bi-arrow-left me-1"></i>{lang key='website/knowledgebase/back-to-all'}</button>
                    </div>

                    <div class="basic-empty-state d-none" data-role="kb-no-result">
                        <i class="bi bi-search" aria-hidden="true"></i>
                        <span class="fw-semibold">{lang key='website/knowledgebase/no-result-title'}</span>
                        <span class="fs-7">{lang key='website/knowledgebase/no-result-text'}</span>
                        <button type="button" class="btn btn-soft btn-sm mt-2" data-action="kb-clear"><i class="bi bi-grid me-1"></i>{lang key='website/knowledgebase/browse-categories'}</button>
                    </div>

                    <template data-role="kb-result-template">
                        <a class="kb-article">
                            <span class="kb-article-ico"><i data-role="icon" class="bi bi-journal-text"></i></span>
                            <div class="kb-article-body">
                                <span class="kb-article-title" data-role="title"></span>
                                <div class="kb-article-meta"><span data-role="cat-wrap"><i class="bi bi-folder2 me-1"></i><span data-role="category"></span></span><span><i class="bi bi-eye me-1"></i><span data-role="views"></span> {lang key='website/knowledgebase/views'}</span></div>
                            </div>
                            <i class="bi bi-chevron-right kb-article-arrow"></i>
                        </a>
                    </template>
                </div>
            </div>
        </div>

        <div data-kb-landing>
            {hook name='ui:client.kb_landing.content.top'}
            {if $popular}
            <div class="mb-5">
                <h2 class="kb-section-title">{lang key='website/knowledgebase/popular-articles'}</h2>
                <div class="kb-article-grid">
                    {foreach $popular as $a}
                    <a href="{$a.link}" class="kb-article">
                        <span class="kb-article-ico"><i class="{if $a.icon}{$a.icon}{else}bi bi-journal-text{/if}"></i></span>
                        <div class="kb-article-body">
                            <span class="kb-article-title">{$a.title}</span>
                            <div class="kb-article-meta">{if $a.category_name}<span><i class="bi bi-folder2 me-1"></i>{$a.category_name}</span>{/if}<span><i class="bi bi-eye me-1"></i>{$a.views_display} {lang key='website/knowledgebase/views'}</span></div>
                        </div>
                        <i class="bi bi-chevron-right kb-article-arrow"></i>
                    </a>
                    {/foreach}
                </div>
            </div>
            {/if}

            {if $categories}
            <div>
                <h2 class="kb-section-title">{lang key='website/knowledgebase/browse-by-category'}</h2>
                <div class="row g-4">
                    {foreach $categories as $c}
                    <div class="col-sm-6 col-lg-4">
                        <a href="{$c.link}" class="kb-cat-card">
                            <span class="kb-cat-ico"><i class="{if $c.icon}{$c.icon}{else}bi bi-journal-text{/if}"></i></span>
                            <div class="kb-cat-name">{$c.title}</div>
                            {if $c.sub_title}<p class="kb-cat-desc">{$c.sub_title}</p>{/if}
                            <span class="kb-cat-count"><i class="bi bi-file-earmark-text me-1"></i>{$c.count} {lang key='website/knowledgebase/articles'}</span>
                        </a>
                    </div>
                    {/foreach}
                </div>
            </div>
            {/if}

            {if !$popular && !$categories}
            <div class="basic-empty-state">
                <i class="bi bi-journal-text" aria-hidden="true"></i>
                <span class="fw-semibold">{lang key='website/knowledgebase/empty-title'}</span>
                <span class="fs-7">{lang key='website/knowledgebase/empty-text'}</span>
            </div>
            {/if}
            {hook name='ui:client.kb_landing.content.bottom'}
        </div>

        <div class="kb-help-cta">
            <div class="kb-help-cta-text">
                <div class="kb-help-cta-title">{lang key='website/knowledgebase/help-title'}</div>
                <p class="kb-help-cta-sub">{lang key='website/knowledgebase/help-sub'}</p>
            </div>
            <div class="kb-help-actions">
                <a href="{link route='contact'}" class="btn btn-soft"><i class="bi bi-envelope me-1"></i>{lang key='website/knowledgebase/help-contact'}</a>
                <a href="{link route='ticket-create'}" class="btn btn-primary"><i class="bi bi-life-preserver me-1"></i>{lang key='website/knowledgebase/help-ticket'}</a>
            </div>
        </div>

    </section>

{/block}
