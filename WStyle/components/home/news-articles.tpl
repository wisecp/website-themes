{if $news_posts || $blog_posts}
<section class="py-5 border-top" data-reveal>
    <div class="container">
        <div class="row g-4 g-lg-5">
            {if $news_posts}
            <div class="col-lg">
                <div class="d-flex flex-wrap align-items-end justify-content-between gap-2 mb-3">
                    <div class="section-head section-head-start">
                        <span class="eyebrow">{lang key='home_news_eyebrow'}</span>
                        <h2 class="h4 tracking-tight mb-0">{lang key='home_news_title'}</h2>
                    </div>
                    <a class="link-arrow fs-7" href="{link route='news'}">{lang key='home_view_all'}<i class="bi bi-arrow-right"></i></a>
                </div>
                <div class="post-feed">
                    {foreach $news_posts as $post}
                    <a class="post-row" href="{$post.link}">
                        {if $post.cover}<img src="{$post.cover}" alt="">{/if}
                        <span>
                            <span class="post-date num-tabular d-block">{$post.date}</span>
                            <span class="post-title d-block">{$post.title}</span>
                            {if $post.summary}<span class="fs-8 text-body-secondary d-block mt-1">{$post.summary}</span>{/if}
                        </span>
                    </a>
                    {/foreach}
                </div>
            </div>
            {/if}
            {if $blog_posts}
            <div class="col-lg">
                <div class="d-flex flex-wrap align-items-end justify-content-between gap-2 mb-3">
                    <div class="section-head section-head-start">
                        <span class="eyebrow">{lang key='home_blog_eyebrow'}</span>
                        <h2 class="h4 tracking-tight mb-0">{lang key='home_blog_title'}</h2>
                    </div>
                    <a class="link-arrow fs-7" href="{link route='articles'}">{lang key='home_view_all'}<i class="bi bi-arrow-right"></i></a>
                </div>
                <div class="post-feed">
                    {foreach $blog_posts as $post}
                    <a class="post-row" href="{$post.link}">
                        {if $post.cover}<img src="{$post.cover}" alt="">{/if}
                        <span>
                            <span class="post-date num-tabular d-block">{$post.date}</span>
                            <span class="post-title d-block">{$post.title}</span>
                            {if $post.summary}<span class="fs-8 text-body-secondary d-block mt-1">{$post.summary}</span>{/if}
                        </span>
                    </a>
                    {/foreach}
                </div>
            </div>
            {/if}
        </div>
    </div>
</section>
{/if}
