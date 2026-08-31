{if $testimonials.items|default:false}
<section class="py-5 border-top{if $testimonials.background.image || $testimonials.background.video} chrome-dark has-band-bg{else} bg-surface{/if}" data-reveal>
    {include file='components/band-bg.tpl' bg=$testimonials.background}
    <div class="container">
        <div class="row g-4 g-lg-5 align-items-lg-center">
            <div class="col-lg-4">
                <div class="section-head section-head-start">
                    <span class="eyebrow">{lang key='home_testimonials_eyebrow'}</span>
                    <h2 class="tracking-tight">{$testimonials.title}</h2>
                    {if $testimonials.description}<p class="section-lead">{$testimonials.description}</p>{/if}
                </div>
                {if $testimonials.review.enabled|default:false}
                <a class="quote-score d-flex align-items-center gap-3 mb-3" href="{$testimonials.review.url}" target="_blank" rel="noopener">
                    <span class="quote-score-num num-tabular">{$testimonials.review.score}</span>
                    <span>
                        <span class="quote-stars" data-score="{$testimonials.review.score}" role="img" aria-label="{lang key='home_quote_score_aria' score=$testimonials.review.score}">
                            <span class="quote-stars-base" aria-hidden="true"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i></span>
                            <span class="quote-stars-fill" aria-hidden="true"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i></span>
                        </span>
                        <span class="d-block fs-7 text-body-secondary">{if $testimonials.review.count}{lang key='home_quote_score_count' count=$testimonials.review.count}{else}{lang key='home_quote_score_note'}{/if}</span>
                    </span>
                </a>
                <a class="quote-platform d-inline-flex align-items-center gap-2 mb-4" href="{$testimonials.review.url}" target="_blank" rel="noopener">
                    <img src="{asset path=$testimonials.review.logo}" alt="{$testimonials.review.label}">
                    <span class="fs-7 text-body-secondary">{lang key='home_quote_platform' platform=$testimonials.review.label}</span>
                </a>
                <div>
                    <a class="btn btn-soft" href="{$testimonials.review.url}" target="_blank" rel="noopener"><i class="bi bi-chat-left-text me-1"></i>{lang key='home_quote_send'}</a>
                </div>
                {/if}
            </div>
            <div class="col-lg-8">
                <div class="quote-stage carousel carousel-fade slide" id="quoteSlider" data-wstyle-autoplay="8000" role="region" aria-roledescription="carousel" aria-label="{lang key='home_quote_aria'}">
                    <div class="carousel-inner">
                        {foreach $testimonials.items as $quote}
                        <div class="carousel-item{if $quote@first} active{/if}">
                            <figure class="quote-card">
                                <blockquote class="quote-text mb-0">{$quote.message}</blockquote>
                                <figcaption class="d-flex align-items-center gap-3">
                                    {if $quote.photo}<img class="quote-avatar" src="{$quote.photo}" alt="" loading="lazy">{else}<span class="quote-avatar" aria-hidden="true">{$quote.initials}</span>{/if}
                                    <span><span class="d-block fw-bold">{$quote.name}</span>{if $quote.company}<span class="d-block fs-7 text-body-secondary">{$quote.company}</span>{/if}</span>
                                </figcaption>
                            </figure>
                        </div>
                        {/foreach}
                    </div>
                    <div class="carousel-indicators quote-picker">
                        {foreach $testimonials.items as $quote}
                        <button type="button" data-bs-target="#quoteSlider" data-bs-slide-to="{$quote@index}"{if $quote@first} class="active" aria-current="true"{/if} aria-label="{lang key='home_quote_show'}: {$quote.name}">
                            {if $quote.photo}<img class="quote-chip-ava" src="{$quote.photo}" alt="" loading="lazy">{else}<span class="quote-chip-ava" aria-hidden="true">{$quote.initials}</span>{/if}
                            <span class="quote-chip-name">{$quote.name}</span>
                        </button>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
{/if}
