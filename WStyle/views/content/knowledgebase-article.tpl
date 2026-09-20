{extends file='layouts/default.tpl'}

{block name=body_class}chrome-overlay{/block}

{block name=head}
{if !empty($canonical_link)}<link rel="alternate" type="text/markdown" href="{$canonical_link}.md">{/if}
<link rel="stylesheet" href="{asset path='css/libs/prism/prism-tomorrow.min.css'}">
<link rel="stylesheet" href="{asset path='css/knowledgebase.css'}">
<script src="{asset path='js/libs/prism/prism.min.js'}" defer></script>
<script src="{asset path='js/libs/prism/prism-langs.min.js'}" defer></script>
<script src="{asset path='js/knowledgebase-article.js'}" defer></script>
<script src="{asset path='js/knowledgebase-sidebar.js'}" defer></script>
{/block}

{block name=bands}{/block}

{block name=content}

    {include file='partials/page-hero.tpl'
        title="{lang key='website/knowledgebase/hero-title'}"
        lead="{lang key='website/knowledgebase/hero-lead'}"
        heading='p'
        home_crumb=false
        crumbs=$hero_crumbs}

    <section class="container py-4 py-lg-5">

        <div class="row g-4 g-lg-5">

            {if $show_sidebar}{include file='components/kb-sidebar.tpl'}{/if}

            <div class="col-12 col-lg-{$article_col}">
                <article class="kb-article-doc">

                    <div class="kb-article-sheet">
                        <header class="kb-doc-header">
                            <h1 class="kb-doc-title">{$article.title}</h1>
                            <div class="kb-doc-meta">
                                {if $article_category}<a class="kb-meta-chip" href="{$article_category.link}"><i class="bi bi-folder2 me-1"></i>{$article_category.title}</a>{/if}
                                <span><i class="bi bi-eye me-1"></i>{$article.views_display} {lang key='website/knowledgebase/views'}</span>
                                {if !empty($canonical_link)}<a class="kb-meta-chip" href="{$canonical_link}.md" target="_blank" rel="noopener" title="{lang key='website/knowledgebase/markdown-title'}"><i class="bi bi-markdown me-1"></i>{lang key='website/knowledgebase/markdown'}</a>{/if}
                            </div>
                        </header>

                        <div class="kb-prose">{if $article.content}{content var=$article.content}{else}<p class="text-body-secondary mb-0">{lang key='website/knowledgebase/no-content'}</p>{/if}</div>
                    </div>

                    {hook name='ui:client.kb_article.content.after'}

                    <div class="kb-helpful" data-kb-helpful data-vote-url="{$vote_url}" data-thanks-yes="{lang key='website/knowledgebase/helpful-thanks-yes'}" data-thanks-no="{lang key='website/knowledgebase/helpful-thanks-no'}">
                        <div class="wui-collapse wui-show" id="helpfulAsk" data-role="helpful-ask">
                            <div class="wui-collapse-inner">
                                <div class="kb-helpful-ask">
                                    <span class="kb-helpful-q">{lang key='website/knowledgebase/helpful-q'}</span>
                                    <div class="kb-helpful-actions">
                                        <button type="button" class="btn btn-soft" data-action="kb-helpful" data-vote="yes"><i class="bi bi-hand-thumbs-up me-1"></i>{lang key='website/knowledgebase/helpful-yes'}</button>
                                        <button type="button" class="btn btn-soft" data-action="kb-helpful" data-vote="no"><i class="bi bi-hand-thumbs-down me-1"></i>{lang key='website/knowledgebase/helpful-no'}</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="wui-collapse" id="helpfulResult" data-role="helpful-result" aria-live="polite">
                            <div class="wui-collapse-inner">
                                <div class="kb-helpful-result">
                                    <p class="kb-helpful-thanks"><i class="bi bi-check-circle-fill me-2"></i><span data-role="helpful-thanks-text">{lang key='website/knowledgebase/helpful-thanks'}</span></p>
                                </div>
                            </div>
                        </div>
                    </div>

                    {hook name='ui:client.kb_article.footer'}

                    {if $adjacent.prev || $adjacent.next}
                    <nav class="kb-article-nav" aria-label="{lang key='website/knowledgebase/article-nav-label'}">
                        {if $adjacent.prev}
                        <a class="kb-article-nav-link kb-article-nav-prev" href="{$adjacent.prev.link}">
                            <span class="kb-article-nav-dir"><i class="bi bi-arrow-left"></i>{lang key='website/knowledgebase/prev'}</span>
                            <span class="kb-article-nav-title">{$adjacent.prev.title}</span>
                        </a>
                        {else}<span></span>{/if}
                        {if $adjacent.next}
                        <a class="kb-article-nav-link kb-article-nav-next" href="{$adjacent.next.link}">
                            <span class="kb-article-nav-dir">{lang key='website/knowledgebase/next'}<i class="bi bi-arrow-right"></i></span>
                            <span class="kb-article-nav-title">{$adjacent.next.title}</span>
                        </a>
                        {else}<span></span>{/if}
                    </nav>
                    {/if}

                </article>
            </div>

            {if $toc}
            <aside class="col-lg-2 d-none d-lg-block">
                <nav class="kb-toc" aria-label="{lang key='website/knowledgebase/on-this-page'}">
                    <span class="kb-toc-title">{lang key='website/knowledgebase/on-this-page'}</span>
                    <ul class="kb-toc-nav">
                        {foreach $toc as $t}<li><a class="kb-toc-link{if $t.level == 3} ps-3{/if}" href="#{$t.id}">{$t.text}</a></li>{/foreach}
                    </ul>
                </nav>
            </aside>
            {/if}
            {hook name='ui:client.kb_article.toc.after'}

        </div>

        <div class="kb-help-cta">
            <div class="kb-help-cta-text">
                <div class="kb-help-cta-title">{lang key='website/knowledgebase/help-title'}</div>
                <p class="kb-help-cta-sub">{lang key='website/knowledgebase/help-sub'}</p>
            </div>
            <div class="kb-help-actions">
                <a href="{link route='contact'}" class="btn btn-soft"><i class="bi bi-envelope me-1"></i>{lang key='website/knowledgebase/help-contact'}</a>
                {if $support_enabled}<a href="{link route='ticket-create'}" class="btn btn-primary"><i class="bi bi-life-preserver me-1"></i>{lang key='website/knowledgebase/help-ticket'}</a>{/if}
            </div>
        </div>

    </section>

{/block}

{block name=body_end}
<div class="kb-lightbox" data-role="kb-lightbox" role="dialog" aria-modal="true" aria-label="{lang key='website/knowledgebase/lightbox-label'}" hidden>
    <button type="button" class="kb-lightbox-close" data-action="kb-lightbox-close" aria-label="{lang key='website/knowledgebase/lightbox-close'}"><i class="bi bi-x-lg"></i></button>
    <img class="kb-lightbox-img" data-role="kb-lightbox-img" src="" alt="">
    <p class="kb-lightbox-caption" data-role="kb-lightbox-caption"></p>
</div>
{/block}
