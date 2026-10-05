{extends file='layouts/default.tpl'}

{block name=body_class}chrome-overlay{/block}

{block name=head}
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
        crumbs=[['title' => "{lang key='website/articles/hero-title'}"]]}

    <section class="container py-4 py-lg-5">
        <div class="row g-4 g-lg-5">

            <div class="col-12 col-lg-8">

                {if $featured}
                <div data-news-pinned>
                    <a class="news-feature" href="{$featured.link}"{if $featured.category && $featured.category.color} style="--cat-color: {$featured.category.color}"{/if}>
                        <span class="news-thumb">{if $featured.cover}<img class="news-thumb-img" src="{$featured.cover}" alt="">{elseif $featured.category && $featured.category.icon.type == 'image'}<img class="news-thumb-img" src="{$featured.category.icon.value}" alt="">{elseif $featured.category}<i class="{$featured.category.icon.value}"></i>{else}<i class="bi bi-journal-richtext"></i>{/if}</span>
                        <div class="news-feature-body">
                            <div class="news-meta">
                                {include file='components/blog-cat-badge.tpl' cat=$featured.category}
                                <span class="news-date num-tabular"><i class="bi bi-calendar3 me-1"></i>{$featured.date_display}</span>
                                <span class="news-readtime"><i class="bi bi-clock me-1"></i>{$featured.read_time} {lang key='website/articles/min-read'}</span>
                            </div>
                            <h2 class="news-feature-title">{$featured.title}</h2>
                            {if $featured.excerpt}<p class="news-feature-excerpt">{$featured.excerpt}</p>{/if}
                            <span class="link-arrow fs-7">{lang key='website/articles/read-more'}<i class="bi bi-arrow-right"></i></span>
                        </div>
                    </a>
                </div>
                {/if}

                <h2 class="news-section-title" data-role="news-heading">{lang key='website/articles/latest-title'}</h2>
                <div class="news-list{if !$items} d-none{/if}" data-news-list
                     data-news-heading-all="{lang key='website/articles/latest-title'}"
                     data-news-heading-search="{lang key='website/articles/search-results'}"
                     data-news-noun="{lang key='website/articles/noun'}"
                     data-news-noun-plural="{lang key='website/articles/noun-plural'}"
                     data-news-count="{lang key='website/articles/count-template'}"
                     data-news-count-empty="{lang key='website/articles/count-empty'}"
                     data-news-page-size="{$page_size}">
                    {foreach $items as $item}
                    <a class="news-item" href="{$item.link}"{if $item.category} data-cat="{$item.category.slug}"{/if}{if $item.category && $item.category.color} style="--cat-color: {$item.category.color}"{/if}{if $item@index == 0} data-pinned{/if}>
                        <span class="news-thumb">{if $item.cover}<img class="news-thumb-img" src="{$item.cover}" alt="">{elseif $item.category && $item.category.icon.type == 'image'}<img class="news-thumb-img" src="{$item.category.icon.value}" alt="">{elseif $item.category}<i class="{$item.category.icon.value}"></i>{else}<i class="bi bi-journal-richtext"></i>{/if}</span>
                        <div class="news-item-main">
                            <div class="news-meta">
                                {include file='components/blog-cat-badge.tpl' cat=$item.category}
                                <span class="news-date num-tabular"><i class="bi bi-calendar3 me-1"></i>{$item.date_display}</span>
                                <span class="news-readtime"><i class="bi bi-clock me-1"></i>{$item.read_time} {lang key='website/articles/min-read'}</span>
                            </div>
                            <h3 class="news-item-title">{$item.title}</h3>
                            {if $item.excerpt}<p class="news-item-excerpt">{$item.excerpt}</p>{/if}
                        </div>
                        <span class="news-item-arrow" aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
                    </a>
                    {/foreach}
                </div>

                <div class="news-empty wstyle-empty-state{if $items} d-none{/if}" data-role="news-empty">
                    <i class="bi bi-journal-richtext" aria-hidden="true"></i>
                    <p class="fw-semibold mb-1">{lang key='website/articles/empty-title'}</p>
                    <p class="fs-7 mb-3">{lang key='website/articles/empty-text'}</p>
                    <button type="button" class="btn btn-soft btn-sm" data-action="news-clear"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/articles/clear-filters'}</button>
                </div>

                <div class="list-foot" data-role="news-foot">
                    <p class="list-count num-tabular" data-role="news-count" aria-live="polite"></p>
                    <nav class="list-pagination" aria-label="{lang key='website/articles/pagination-label'}" data-role="news-pagination">
                        <ul class="pagination pagination-sm m-0"></ul>
                    </nav>
                </div>

                {hook name='ui:client.blog_list.feed.after'}

            </div>

            <aside class="col-12 col-lg-4 order-first order-lg-0">
                <button class="btn btn-soft d-lg-none blog-sidebar-toggle" type="button" data-bs-toggle="offcanvas" data-bs-target="#blogListSidebar" aria-controls="blogListSidebar"><i class="bi bi-list me-2"></i>{lang key='website/articles/browse'}</button>
                <div class="offcanvas-lg offcanvas-start blog-sidebar-offcanvas" tabindex="-1" id="blogListSidebar" aria-labelledby="blogListSidebarTitle">
                    <div class="offcanvas-header d-lg-none">
                        <h2 class="offcanvas-title h6 mb-0" id="blogListSidebarTitle">{lang key='website/articles/browse'}</h2>
                        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#blogListSidebar" aria-label="{lang key='website/articles/close'}"></button>
                    </div>
                    <div class="offcanvas-body">
                        <div class="news-sidebar">

                            <div class="news-search">
                                <i class="bi bi-search news-search-icon" aria-hidden="true"></i>
                                <label for="blog-q" class="visually-hidden">{lang key='website/articles/search-label'}</label>
                                <input type="search" class="form-control" id="blog-q" placeholder="{lang key='website/articles/search-placeholder'}" autocomplete="off" data-role="news-search-input">
                            </div>

                            {if $categories}
                            <h2 class="news-sidebar-title">{lang key='website/articles/categories-title'}</h2>
                            <div class="news-cats" role="group" data-news-filter aria-label="{lang key='website/articles/categories-aria'}">
                                <button class="news-cat{if !$active_category} active{/if}" type="button" data-cat="all" aria-pressed="{if $active_category}false{else}true{/if}"><span class="news-cat-label"><i class="bi bi-grid"></i>{lang key='website/articles/all'}</span><span class="news-cat-count num-tabular">{$total_count}</span></button>
                                {foreach $categories as $cat}
                                <button class="news-cat{if $active_category && $cat.slug == $active_category} active{/if}" type="button" data-cat="{$cat.slug}" aria-pressed="{if $active_category && $cat.slug == $active_category}true{else}false{/if}"{if $cat.color} style="--cat-color: {$cat.color}"{/if}><span class="news-cat-label">{if $cat.icon.type == 'image'}<img src="{$cat.icon.value}" alt="">{else}<i class="{$cat.icon.value}"></i>{/if}{$cat.title}</span><span class="news-cat-count num-tabular">{$cat.count}</span></button>
                                {/foreach}
                            </div>
                            {/if}

                            {if $popular}
                            <h2 class="news-sidebar-title">{lang key='website/articles/popular-title'}</h2>
                            <div class="news-recent">
                                {foreach $popular as $p}
                                <a class="news-recent-item" href="{$p.link}">
                                    <span class="news-recent-title">{$p.title}</span>
                                    <span class="news-recent-date num-tabular"><i class="bi bi-calendar3 me-1"></i>{$p.date_display}</span>
                                </a>
                                {/foreach}
                            </div>
                            {/if}

                        </div>
                    </div>
                </div>
            </aside>

        </div>

    </section>

{/block}
