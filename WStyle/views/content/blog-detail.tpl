{extends file='layouts/default.tpl'}

{block name=body_class}chrome-overlay{/block}

{block name=head}
<link rel="stylesheet" href="{asset path='css/knowledgebase.css'}">
<link rel="stylesheet" href="{asset path='css/news.css'}">
<link rel="stylesheet" href="{asset path='css/blog.css'}">
<script src="{asset path='js/news.js'}" defer></script>
<script src="{asset path='js/blog.js'}" defer></script>
{/block}

{block name=bands}
{include file='partials/band-newsletter.tpl'}
{/block}

{block name=content}

    {include file='partials/page-hero.tpl'
        title="{lang key='website/articles/hero-title'}"
        lead="{lang key='website/articles/hero-lead'}"
        heading='p'
        crumbs=[
            ['title' => "{lang key='website/articles/breadcrumb'}", 'url' => $blog_link],
            ['title' => $article.title]
        ]}

    <section class="container py-4 py-lg-5">

        <div class="row g-4 g-lg-5">

            <div class="col-12 col-lg-{if $show_sidebar}8{else}12{/if}">
                <article class="kb-article-doc">
                    <div class="kb-article-sheet">
                        <header class="kb-doc-header">
                            {if $article.category}
                            <div class="news-meta mb-2"{if $article.category.color} style="--cat-color: {$article.category.color}"{/if}>
                                {include file='components/blog-cat-badge.tpl' cat=$article.category}
                            </div>
                            {/if}
                            <h1 class="kb-doc-title">{$article.title}</h1>
                            <div class="kb-doc-meta">
                                <span class="num-tabular"><i class="bi bi-calendar3 me-1"></i>{$article.date_display}</span>
                                <span class="num-tabular"><i class="bi bi-clock me-1"></i>{$article.read_time} {lang key='website/articles/min-read'}</span>
                            </div>
                        </header>

                        <div class="news-share">
                            <span class="news-share-label fs-7 text-body-secondary">{lang key='website/articles/share-label'}</span>
                            <div class="news-share-actions">
                                <button type="button" class="btn btn-soft btn-sm bs-tooltip" data-action="copy" data-copy-text="{$share_url}" title="{lang key='website/articles/share-copy'}"><i class="bi bi-link-45deg"></i></button>
                                <a class="btn btn-soft btn-sm" href="{$share_twitter}" aria-label="{lang key='website/articles/share-x'}" target="_blank" rel="noopener"><i class="bi bi-twitter-x"></i></a>
                                <a class="btn btn-soft btn-sm" href="{$share_linkedin}" aria-label="{lang key='website/articles/share-linkedin'}" target="_blank" rel="noopener"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>

                        <div class="kb-prose">{if $article.content}{$article.content nofilter}{else}<p class="text-body-secondary mb-0">{lang key='website/articles/no-content'}</p>{/if}</div>

                        {if $tags}
                        <div class="blog-tags">
                            <span class="blog-tags-label"><i class="bi bi-tags me-1"></i>{lang key='website/articles/tags-label'}</span>
                            {foreach $tags as $tag}<a class="blog-tag" href="{$blog_link}">{$tag}</a>{/foreach}
                        </div>
                        {/if}
                    </div>

                    {hook name='ui:client.blog_detail.content.after'}

                    {include file='components/blog-comments.tpl'}

                    {if $adjacent.prev || $adjacent.next}
                    <nav class="kb-article-nav" aria-label="{lang key='website/articles/article-nav-label'}">
                        {if $adjacent.prev}
                        <a class="kb-article-nav-link kb-article-nav-prev" href="{$adjacent.prev.link}">
                            <span class="kb-article-nav-dir"><i class="bi bi-arrow-left"></i>{lang key='website/articles/prev'}</span>
                            <span class="kb-article-nav-title">{$adjacent.prev.title}</span>
                        </a>
                        {else}<span></span>{/if}
                        {if $adjacent.next}
                        <a class="kb-article-nav-link kb-article-nav-next" href="{$adjacent.next.link}">
                            <span class="kb-article-nav-dir">{lang key='website/articles/next'}<i class="bi bi-arrow-right"></i></span>
                            <span class="kb-article-nav-title">{$adjacent.next.title}</span>
                        </a>
                        {else}<span></span>{/if}
                    </nav>
                    {/if}
                </article>
            </div>

            {if $show_sidebar}
            <aside class="col-12 col-lg-4 order-first order-lg-0">
                <button class="btn btn-soft d-lg-none blog-sidebar-toggle" type="button" data-bs-toggle="offcanvas" data-bs-target="#blogSidebar" aria-controls="blogSidebar"><i class="bi bi-list me-2"></i>{lang key='website/articles/browse'}</button>
                <div class="offcanvas-lg offcanvas-start blog-sidebar-offcanvas" tabindex="-1" id="blogSidebar" aria-labelledby="blogSidebarTitle">
                    <div class="offcanvas-header d-lg-none">
                        <h2 class="offcanvas-title h6 mb-0" id="blogSidebarTitle">{lang key='website/articles/browse'}</h2>
                        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#blogSidebar" aria-label="{lang key='website/articles/close'}"></button>
                    </div>
                    <div class="offcanvas-body">
                        <div class="news-detail-aside">
                            {if $categories}
                            <h2 class="news-sidebar-title">{lang key='website/articles/categories-title'}</h2>
                            <div class="news-cats">
                                <a class="news-cat" href="{$blog_link}"><span class="news-cat-label"><i class="bi bi-grid"></i>{lang key='website/articles/all'}</span></a>
                                {foreach $categories as $cat}
                                <a class="news-cat" href="{$blog_link}?cat={$cat.slug}"{if $cat.color} style="--cat-color: {$cat.color}"{/if}><span class="news-cat-label">{if $cat.icon.type == 'image'}<img src="{$cat.icon.value}" alt="">{else}<i class="{$cat.icon.value}"></i>{/if}{$cat.title}</span><span class="news-cat-count num-tabular">{$cat.count}</span></a>
                                {/foreach}
                            </div>
                            {/if}

                            {if $recent}
                            <h2 class="news-sidebar-title">{lang key='website/articles/recent-title'}</h2>
                            <div class="news-recent">
                                {foreach $recent as $r}
                                <a class="news-recent-item" href="{$r.link}">
                                    <span class="news-recent-title">{$r.title}</span>
                                    <span class="news-recent-date num-tabular"><i class="bi bi-calendar3 me-1"></i>{$r.date_display}</span>
                                </a>
                                {/foreach}
                            </div>
                            {/if}
                        </div>
                    </div>
                </div>
            </aside>
            {/if}

        </div>

        {if $related}
        <section class="news-related">
            <h2 class="h4 mb-3">{lang key='website/articles/related-title'}</h2>
            <div class="row g-3">
                {foreach $related as $r}
                <div class="col-md-4">
                    <a class="news-card hover-lift" href="{$r.link}"{if $r.category && $r.category.color} style="--cat-color: {$r.category.color}"{/if}>
                        {if $r.category}<span class="news-meta mb-1">{include file='components/blog-cat-badge.tpl' cat=$r.category}</span>{/if}
                        <span class="news-date num-tabular">{$r.date_display}</span>
                        <span class="news-title">{$r.title}</span>
                        {if $r.excerpt}<span class="fs-7 text-body-secondary">{$r.excerpt}</span>{/if}
                    </a>
                </div>
                {/foreach}
            </div>
        </section>
        {/if}

        <div class="news-cta" data-newsletter>
            <div class="news-cta-text">
                <div class="news-cta-title">{lang key='website/articles/newsletter-title'}</div>
                <p class="news-cta-sub">{lang key='website/articles/newsletter-sub'}</p>
            </div>
            <div class="news-cta-sub-wrap">
                <form data-role="newsletter-form" action="{$subscribe_url}" method="post" novalidate>
                    <div class="wui-collapse wui-show" data-role="newsletter-step-email">
                        <div class="wui-collapse-inner">
                            <label for="blog-email-detail" class="visually-hidden">{lang key='website/articles/newsletter-email-label'}</label>
                            <div class="news-cta-form">
                                <input type="email" class="form-control" id="blog-email-detail" placeholder="{lang key='website/articles/newsletter-email-placeholder'}" autocomplete="email" required data-role="newsletter-email">
                                <button class="btn btn-primary" type="submit"><i class="bi bi-envelope-check me-1"></i>{lang key='website/articles/newsletter-subscribe'}</button>
                            </div>
                            <div class="form-check mt-2">
                                <input class="form-check-input" type="checkbox" id="blog-consent-detail" required data-role="newsletter-consent">
                                <label class="form-check-label fs-8" for="blog-consent-detail">{lang key='website/articles/newsletter-consent-pre'} {if $privacy_contract_link}<a href="{$privacy_contract_link}" target="_blank" rel="noopener">{lang key='website/articles/newsletter-privacy'}</a>{else}{lang key='website/articles/newsletter-privacy'}{/if}{lang key='website/articles/newsletter-consent-post'}</label>
                            </div>
                        </div>
                    </div>
                    <div class="wui-collapse" data-role="newsletter-step-captcha">
                        <div class="wui-collapse-inner">
                            {captcha area='newsletter'}
                            <button class="btn btn-primary w-100 mt-2" type="submit"><i class="bi bi-shield-check me-1"></i>{lang key='website/articles/newsletter-verify-subscribe'}</button>
                        </div>
                    </div>
                    {csrf form='newsletter'}
                </form>
                <div class="wui-collapse" data-role="newsletter-ok">
                    <div class="wui-collapse-inner">
                        <p class="news-subscribe-ok mb-0"><i class="bi bi-check-circle-fill"></i><span>{lang key='website/articles/newsletter-success'}</span></p>
                    </div>
                </div>
            </div>
        </div>

    </section>

{/block}
