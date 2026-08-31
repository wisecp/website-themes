{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/software.css'}">
<link rel="stylesheet" href="{asset path='css/index.css'}">
{/block}

{block name=scripts}<script src="{asset path='js/index.js'}" defer></script>{/block}

{block name=body_class}{if $slides}chrome-overlay{/if}{/block}

{block name=content}

    {if $slides}
    <section class="hero-slider chrome-dark carousel slide" id="heroSlider" data-wstyle-autoplay="7000" data-wstyle-pause="off" aria-label="{lang key='home_hero_aria'}">
        <div class="carousel-inner">
            {foreach $slides as $slide}
            <div class="carousel-item{if $slide@first} active{/if}">
                <div class="hero-slide{if !$slide.video_url && !$slide.image_url} hero-slide-{cycle values='a,b,c'}{/if}">
                    {if $slide.video_url}
                    <video class="hero-media" autoplay muted loop playsinline preload="none"{if $slide.image_url} poster="{$slide.image_url}"{/if} aria-hidden="true">
                        <source src="{$slide.video_url}" type="video/mp4">
                    </video>
                    {elseif $slide.image_url}
                    <img class="hero-media" src="{$slide.image_url}" alt="">
                    {/if}
                    <span class="hero-scrim" aria-hidden="true"></span>
                    <div class="container">
                        <div class="hero-copy">
                            {if $slide@first}<h1 class="hero-title mb-3">{$slide.title}</h1>{else}<h2 class="hero-title mb-3">{$slide.title}</h2>{/if}
                            {if $slide.description}<p class="hero-lead mb-4">{$slide.description}</p>{/if}
                            {if $slide.link}
                            <div>
                                <a class="btn btn-soft rounded-pill px-4" href="{$slide.link}">{if $slide.button}{$slide.button}{else}{lang key='home_hero_cta'}{/if}</a>
                            </div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
            {/foreach}
        </div>
        <div class="hero-bottom">
            <div class="container">
                <div class="hero-nav">
                    <button class="btn btn-soft hero-nav-btn" type="button" data-bs-target="#heroSlider" data-bs-slide="prev" aria-label="{lang key='home_hero_prev'}"><i class="bi bi-chevron-left"></i></button>
                    <button class="btn btn-soft hero-nav-btn" type="button" data-bs-target="#heroSlider" data-bs-slide="next" aria-label="{lang key='home_hero_next'}"><i class="bi bi-chevron-right"></i></button>
                </div>
            </div>
        </div>
        {if $visibility_domain}<a class="hero-scroll d-inline-flex" href="#find-domain" aria-label="{lang key='home_hero_scroll'}"><i class="bi bi-chevron-down"></i></a>{/if}
    </section>
    {/if}

    {hook name='ui:client.home.hero.after'}

    {foreach $home_blocks as $block}
    {include file="components/home/`$block.view`.tpl"}
    {/foreach}

    {hook name='ui:client.home.sections.end'}

{/block}
