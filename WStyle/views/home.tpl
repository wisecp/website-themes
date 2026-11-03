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

{block name=body_end}
{if $testimonials.send_opinion|default:false}
<div class="modal fade" id="feedbackModal" tabindex="-1" aria-labelledby="feedbackModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="{link route='home'}" method="post" novalidate data-feedback-form data-msg-invalid="{lang key='website/index/customer-feedback/error-invalid' attr=1}">
                <div class="modal-header">
                    <span class="modal-icon"><i class="bi bi-chat-quote"></i></span>
                    <div class="modal-titles">
                        <h2 class="modal-title h5" id="feedbackModalTitle">{lang key='website/index/customer-feedback/modal-title'}</h2>
                        <p class="modal-subtitle">{lang key='website/index/customer-feedback/modal-subtitle'}</p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/index/customer-feedback/close' attr=1}"></button>
                </div>
                <div class="modal-body" data-feedback-step="form">
                    <div class="row g-3">
                        <div class="col-sm-6">
                            <label for="fb-name" class="form-label">{lang key='website/index/customer-feedback/name-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                            <input type="text" class="form-control" id="fb-name" name="full_name" autocomplete="name" maxlength="100" required>
                            <div class="invalid-feedback">{lang key='website/index/customer-feedback/error-name'}</div>
                        </div>
                        <div class="col-sm-6">
                            <label for="fb-company" class="form-label">{lang key='website/index/customer-feedback/company-label'}</label>
                            <input type="text" class="form-control" id="fb-company" name="company_name" autocomplete="organization" maxlength="100">
                        </div>
                        <div class="col-12">
                            <label for="fb-email" class="form-label">{lang key='website/index/customer-feedback/email-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                            <input type="email" class="form-control" id="fb-email" name="email" autocomplete="email" maxlength="200" required>
                            <div class="form-text">{lang key='website/index/customer-feedback/email-help'}</div>
                            <div class="invalid-feedback">{lang key='website/index/customer-feedback/error-email'}</div>
                        </div>
                        <div class="col-12">
                            <label for="fb-message" class="form-label">{lang key='website/index/customer-feedback/message-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                            <textarea class="form-control" id="fb-message" name="message" rows="5" minlength="10" maxlength="500" placeholder="{lang key='website/index/customer-feedback/message-placeholder' attr=1}" required></textarea>
                            <div class="invalid-feedback">{lang key='website/index/customer-feedback/error-message'}</div>
                        </div>
                    </div>
                    {csrf form='customer-feedback'}
                    <div class="mt-3">{captcha area='customer-feedback'}</div>
                    <div class="wui-collapse" data-role="fb-alert">
                        <div class="wui-collapse-inner">
                            <div class="pt-3">
                                <div class="alert alert-danger d-flex align-items-center mb-0" role="alert" aria-live="assertive">
                                    <i class="bi bi-exclamation-circle me-2 flex-shrink-0" aria-hidden="true"></i>
                                    <div class="text-break"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-body d-none" data-feedback-step="done">
                    <div class="alert alert-success d-flex align-items-center mb-0" role="status">
                        <i class="bi bi-check-circle me-2 flex-shrink-0" aria-hidden="true"></i>
                        <div class="text-break" data-role="fb-done-text">{lang key='website/index/customer-feedback/done-body'}</div>
                    </div>
                </div>
                <div class="modal-footer" data-feedback-step="form">
                    <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/index/customer-feedback/cancel'}</button>
                    <button type="submit" class="btn btn-primary" data-busy-text="{lang key='website/index/customer-feedback/sending' attr=1}"><i class="bi bi-send me-1"></i>{lang key='website/index/customer-feedback/submit'}</button>
                </div>
            </form>
        </div>
    </div>
</div>
{/if}
{/block}
