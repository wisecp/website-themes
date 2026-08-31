{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/news.css'}">
<script src="{asset path='js/news.js'}" defer></script>
{/block}

{block name=content}

    <section class="page-hero text-center">
        <div class="container">
            <h1 class="page-hero-title reveal mb-3">{lang key='website/news/hero-title'}</h1>
            <p class="page-hero-lead text-body-secondary reveal reveal-2 mb-0">{lang key='website/news/hero-lead'}</p>
        </div>
    </section>

    <section class="container py-4 py-lg-5">
        <div class="row g-4 g-lg-5">

            <div class="col-12 col-lg-8">

                {if $featured}
                <div data-news-pinned>
                    <a class="news-feature" href="{$featured.link}">
                        <span class="news-thumb">{if $featured.cover}<img class="news-thumb-img" src="{$featured.cover}" alt="">{else}<i class="bi bi-megaphone"></i>{/if}</span>
                        <div class="news-feature-body">
                            <div class="news-meta">
                                <span class="news-date num-tabular"><i class="bi bi-calendar3 me-1"></i>{$featured.date_display}</span>
                                <span class="news-readtime"><i class="bi bi-clock me-1"></i>{$featured.read_time} {lang key='website/news/min-read'}</span>
                            </div>
                            <h2 class="news-feature-title">{$featured.title}</h2>
                            {if $featured.excerpt}<p class="news-feature-excerpt">{$featured.excerpt}</p>{/if}
                            <span class="link-arrow fs-7">{lang key='website/news/read-more'}<i class="bi bi-arrow-right"></i></span>
                        </div>
                    </a>
                </div>
                {/if}

                <h2 class="news-section-title" data-role="news-heading">{lang key='website/news/latest-title'}</h2>
                <div class="news-list{if !$items} d-none{/if}" data-news-list
                     data-news-heading-all="{lang key='website/news/latest-title'}"
                     data-news-heading-search="{lang key='website/news/search-results'}"
                     data-news-noun="{lang key='website/news/noun'}"
                     data-news-noun-plural="{lang key='website/news/noun-plural'}"
                     data-news-count="{lang key='website/news/count-template'}"
                     data-news-count-empty="{lang key='website/news/count-empty'}"
                     data-news-page-size="{$page_size}">
                    {foreach $items as $item}
                    <a class="news-item" href="{$item.link}"{if $item@index == 0} data-pinned{/if}>
                        <span class="news-thumb">{if $item.cover}<img class="news-thumb-img" src="{$item.cover}" alt="">{else}<i class="bi bi-megaphone"></i>{/if}</span>
                        <div class="news-item-main">
                            <div class="news-meta">
                                <span class="news-date num-tabular"><i class="bi bi-calendar3 me-1"></i>{$item.date_display}</span>
                                <span class="news-readtime"><i class="bi bi-clock me-1"></i>{$item.read_time} {lang key='website/news/min-read'}</span>
                            </div>
                            <h3 class="news-item-title">{$item.title}</h3>
                            {if $item.excerpt}<p class="news-item-excerpt">{$item.excerpt}</p>{/if}
                        </div>
                        <span class="news-item-arrow" aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
                    </a>
                    {/foreach}
                </div>

                <div class="news-empty basic-empty-state{if $items} d-none{/if}" data-role="news-empty">
                    <i class="bi bi-megaphone" aria-hidden="true"></i>
                    <p class="fw-semibold mb-1">{lang key='website/news/empty-title'}</p>
                    <p class="fs-7 mb-0">{lang key='website/news/empty-text'}</p>
                </div>

                <div class="list-foot" data-role="news-foot">
                    <p class="list-count num-tabular" data-role="news-count" aria-live="polite"></p>
                    <nav class="list-pagination" aria-label="{lang key='website/news/pagination-label'}" data-role="news-pagination">
                        <ul class="pagination pagination-sm m-0"></ul>
                    </nav>
                </div>

                {hook name='ui:client.news_list.feed.after'}

            </div>

            <aside class="col-12 col-lg-4">
                <div class="news-sidebar">
                    {if $popular}
                    <h2 class="news-sidebar-title">{lang key='website/news/popular-title'}</h2>
                    <div class="news-recent">
                        {foreach $popular as $p}
                        <a class="news-recent-item" href="{$p.link}">
                            <span class="news-recent-title">{$p.title}</span>
                            <span class="news-recent-date num-tabular"><i class="bi bi-calendar3 me-1"></i>{$p.date_display}</span>
                        </a>
                        {/foreach}
                    </div>
                    {/if}

                    {include file='components/news-newsletter.tpl' idsuffix='list' subscribe_url=$subscribe_url}

                </div>
            </aside>

        </div>
    </section>

{/block}
