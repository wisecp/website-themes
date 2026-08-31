{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/knowledgebase.css'}">
<link rel="stylesheet" href="{asset path='css/news.css'}">
<script src="{asset path='js/news.js'}" defer></script>
{/block}

{block name=content}

    <section class="container py-4 py-lg-5">

        <nav aria-label="{lang key='website/news/breadcrumb'}">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{$news_link}">{lang key='website/news/breadcrumb'}</a></li>
                <li class="breadcrumb-item active" aria-current="page">{$article.title}</li>
            </ol>
        </nav>

        <div class="row g-4 g-lg-5">

            <div class="col-12 col-lg-{if $show_sidebar}8{else}12{/if}">
                <article class="kb-article-doc">
                    <div class="kb-article-sheet">
                        <header class="kb-doc-header">
                            <h1 class="kb-doc-title">{$article.title}</h1>
                            <div class="kb-doc-meta">
                                <span><i class="bi bi-calendar3 me-1"></i>{lang key='website/news/published'} {$article.date_display}</span>
                                <span><i class="bi bi-clock me-1"></i>{$article.read_time} {lang key='website/news/min-read'}</span>
                            </div>
                        </header>

                        <div class="news-share">
                            <span class="news-share-label fs-7 text-body-secondary">{lang key='website/news/share-label'}</span>
                            <div class="news-share-actions">
                                <button type="button" class="btn btn-soft btn-sm bs-tooltip" data-action="copy" data-copy-text="{$share_url}" title="{lang key='website/news/share-copy'}"><i class="bi bi-link-45deg"></i></button>
                                <a class="btn btn-soft btn-sm" href="{$share_twitter}" aria-label="{lang key='website/news/share-x'}" target="_blank" rel="noopener"><i class="bi bi-twitter-x"></i></a>
                                <a class="btn btn-soft btn-sm" href="{$share_linkedin}" aria-label="{lang key='website/news/share-linkedin'}" target="_blank" rel="noopener"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>

                        <div class="kb-prose">{if $article.content}{content var=$article.content}{else}<p class="text-body-secondary mb-0">{lang key='website/news/no-content'}</p>{/if}</div>
                    </div>

                    {if $adjacent.prev || $adjacent.next}
                    <nav class="kb-article-nav" aria-label="{lang key='website/news/article-nav-label'}">
                        {if $adjacent.prev}
                        <a class="kb-article-nav-link kb-article-nav-prev" href="{$adjacent.prev.link}">
                            <span class="kb-article-nav-dir"><i class="bi bi-arrow-left"></i>{lang key='website/news/prev'}</span>
                            <span class="kb-article-nav-title">{$adjacent.prev.title}</span>
                        </a>
                        {else}<span></span>{/if}
                        {if $adjacent.next}
                        <a class="kb-article-nav-link kb-article-nav-next" href="{$adjacent.next.link}">
                            <span class="kb-article-nav-dir">{lang key='website/news/next'}<i class="bi bi-arrow-right"></i></span>
                            <span class="kb-article-nav-title">{$adjacent.next.title}</span>
                        </a>
                        {else}<span></span>{/if}
                    </nav>
                    {/if}
                </article>
            </div>

            {if $show_sidebar}
            <aside class="col-12 col-lg-4">
                <div class="news-detail-aside">
                    {if $recent}
                    <h2 class="news-sidebar-title">{lang key='website/news/recent-title'}</h2>
                    <div class="news-recent">
                        {foreach $recent as $r}
                        <a class="news-recent-item" href="{$r.link}">
                            <span class="news-recent-title">{$r.title}</span>
                            <span class="news-recent-date num-tabular"><i class="bi bi-calendar3 me-1"></i>{$r.date_display}</span>
                        </a>
                        {/foreach}
                    </div>
                    {/if}

                    {include file='components/news-newsletter.tpl' idsuffix='detail' subscribe_url=$subscribe_url}

                </div>
            </aside>
            {/if}

        </div>

    </section>

{/block}
