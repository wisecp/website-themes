{extends file='layouts/default.tpl'}

{block name=body_class}chrome-overlay{/block}

{block name=head}
<link rel="stylesheet" href="{asset path='css/contact.css'}">
<script src="{asset path='js/contact.js'}" defer></script>
{/block}

{block name=bands}
{include file='partials/band-newsletter.tpl'}
{/block}

{block name=content}

    {include file='partials/page-hero.tpl'
        title="{lang key='website/contact/hero-title'}"
        lead="{lang key='website/contact/hero-lead'}"
        crumbs=[['title' => "{lang key='website/contact/hero-title'}"]]}

    <section class="container py-4 py-lg-5">
        <div class="row g-4 g-lg-5">

            <div class="col-12 col-lg-7">
                {if $contact_form_enabled}
                <div data-contact-step="form">
                    <form action="{link route='contact'}" method="post" novalidate data-contact-form data-msg-invalid="{lang key='website/contact/error-invalid'}">
                        <div class="card">
                            <div class="card-body p-4 p-lg-5">
                                <h2 class="h5 mb-1">{lang key='website/contact/form-title'}</h2>
                                <p class="fs-7 text-body-secondary mb-4">{lang key='website/contact/form-subtitle'}</p>
                                {hook name='ui:client.contact.form.top'}
                                <div class="row g-3">
                                    <div class="col-sm-6">
                                        <label for="ct-name" class="form-label">{lang key='website/contact/name-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                                        <input type="text" class="form-control" id="ct-name" name="name" autocomplete="name" placeholder="{lang key='website/contact/name-placeholder'}" required>
                                        <div class="invalid-feedback">{lang key='website/contact/name-invalid'}</div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label for="ct-email" class="form-label">{lang key='website/contact/email-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                                        <input type="email" class="form-control" id="ct-email" name="email" autocomplete="email" placeholder="{lang key='website/contact/email-placeholder'}" required>
                                        <div class="invalid-feedback">{lang key='website/contact/email-invalid'}</div>
                                    </div>
                                    <div class="col-12">
                                        <label for="ct-message" class="form-label">{lang key='website/contact/message-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                                        <textarea class="form-control" id="ct-message" name="message" rows="6" placeholder="{lang key='website/contact/message-placeholder'}" required></textarea>
                                        <div class="invalid-feedback">{lang key='website/contact/message-invalid'}</div>
                                    </div>
                                </div>
                                {csrf form='contact-form'}
                                <div class="wui-collapse" data-role="ct-alert">
                                    <div class="wui-collapse-inner">
                                        <div class="pt-3">
                                            <div class="auth-alert auth-alert-danger" role="alert" aria-live="assertive">
                                                <i class="bi bi-exclamation-triangle-fill"></i>
                                                <span></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {hook name='ui:client.contact.form.bottom'}
                                <div class="d-flex flex-wrap align-items-center gap-3 border-top pt-3 mt-4">
                                    {captcha area='contact-form'}
                                    <button class="btn btn-primary ms-sm-auto" type="submit" data-busy-text="{lang key='website/contact/sending'}"><i class="bi bi-send me-1"></i>{lang key='website/contact/send-button'}</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="d-none h-100" data-contact-step="done">
                    <div class="card h-100">
                        <div class="card-body contact-done p-4 p-lg-5 text-center">
                            <span class="contact-done-icon"><i class="bi bi-check-circle"></i></span>
                            <h2 class="h4 mt-4 mb-3">{lang key='website/contact/done-title'}</h2>
                            <p class="text-body-secondary mb-4">{lang key='website/contact/done-body-1'} <strong data-role="contact-email">{lang key='website/contact/email-placeholder'}</strong>{lang key='website/contact/done-body-2'}</p>
                            <div class="d-flex flex-wrap justify-content-center gap-2">
                                <a class="btn btn-primary" href="{link route='home'}"><i class="bi bi-house me-1"></i>{lang key='website/contact/back-home'}</a>
                                <button type="button" class="btn btn-soft" data-action="contact-reset"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/contact/send-another'}</button>
                            </div>
                        </div>
                    </div>
                </div>
                {/if}
            </div>

            <div class="col-12 col-lg-5">
                <div class="card h-100">
                    <div class="card-body p-4 p-lg-5">
                        <h2 class="h5 mb-4">{lang key='website/contact/other-title'}</h2>
                        <ul class="contact-method-list list-unstyled mb-0">
                            {if $contact_emails}
                            <li class="contact-method">
                                <span class="icon-disc"><i class="bi bi-cart-check"></i></span>
                                <div class="contact-method-body">
                                    <span class="contact-method-label">{lang key='website/contact/sales-label'}</span>
                                    <a class="contact-method-value" href="mailto:{$contact_emails[0]}">{$contact_emails[0]}</a>
                                    <span class="contact-method-sub">{lang key='website/contact/sales-sub'}</span>
                                </div>
                            </li>
                            {/if}
                            <li class="contact-method">
                                <span class="icon-disc"><i class="bi bi-life-preserver"></i></span>
                                <div class="contact-method-body">
                                    <span class="contact-method-label">{lang key='website/contact/support-label'}</span>
                                    <span class="contact-method-sub">{lang key='website/contact/support-sub'}</span>
                                    <span class="d-flex flex-wrap gap-2 mt-2">
                                        {if $support_enabled}<a class="btn btn-soft btn-sm" href="{link route='ticket-create'}"><i class="bi bi-life-preserver me-1"></i>{lang key='website/contact/open-ticket'}</a>{/if}
                                        <a class="btn btn-soft btn-sm" href="{link route='kbase'}"><i class="bi bi-journal-text me-1"></i>{lang key='website/contact/knowledge-base'}</a>
                                    </span>
                                </div>
                            </li>
                            {if $contact_phones}
                            <li class="contact-method">
                                <span class="icon-disc"><i class="bi bi-telephone"></i></span>
                                <div class="contact-method-body">
                                    <span class="contact-method-label">{lang key='website/contact/phone-label'}</span>
                                    <a class="contact-method-value num-tabular" href="tel:{$contact_phones[0]|replace:' ':''}">{$contact_phones[0]}</a>
                                    <span class="contact-method-sub">{lang key='website/contact/phone-sub'}</span>
                                </div>
                            </li>
                            {/if}
                            {if $support_hours.summary}
                            <li class="contact-method">
                                <span class="icon-disc"><i class="bi bi-clock"></i></span>
                                <div class="contact-method-body">
                                    <span class="contact-method-label">{lang key='website/contact/support-hours-label'}</span>
                                    <span class="contact-method-value">{$support_hours.summary}</span>
                                    {if $support_hours.description}<span class="contact-method-sub">{$support_hours.description}</span>{/if}
                                </div>
                            </li>
                            {/if}
                        </ul>
                        {hook name='ui:client.contact.aside.bottom'}
                    </div>
                </div>
            </div>
        </div>
    </section>

    {if $offices || $has_map}
    <section class="container pb-5">
        {if $offices}
        <div class="text-center mb-4 mb-lg-5">
            <h2 class="h3 mb-2">{lang key='website/contact/offices-title'}</h2>
            <p class="text-body-secondary mb-0">{lang key='website/contact/offices-sub'}</p>
        </div>
        <div class="row g-4 align-items-stretch">
            <div class="{if $has_map}col-12 col-lg-5{else}col-12{/if}">
                <ul class="{if $has_map}contact-office-list{else}contact-office-grid{/if} list-unstyled mb-0">
                    {foreach $offices as $office}
                    <li class="contact-office">
                        <div class="contact-office-head">
                            <h3 class="contact-office-city">{$office.city}</h3>
                            {if $office.head_office}<span class="badge bg-primary-subtle text-primary-emphasis"><i class="bi bi-buildings me-1"></i>{lang key='website/contact/head-office'}</span>{/if}
                        </div>
                        {if $office.address}<address class="contact-office-addr">{$office.address|escape|nl2br nofilter}</address>{/if}
                        <ul class="contact-office-meta list-unstyled mb-0">
                            {if $office.phone}<li><i class="bi bi-telephone" aria-hidden="true"></i><a class="num-tabular" href="tel:{$office.phone|replace:' ':''}">{$office.phone}</a></li>{/if}
                            {if $office.hours}<li><i class="bi bi-clock" aria-hidden="true"></i>{$office.hours}</li>{/if}
                        </ul>
                    </li>
                    {/foreach}
                </ul>
            </div>

            {if $has_map}
            <div class="col-12 col-lg-7">
                <figure class="contact-map h-100 mb-0">
                    <div class="contact-map-frame" data-map-embed>
                        {$map_embed nofilter}
                        {assign var=head_city value=''}
                        {foreach $offices as $o}{if $o.head_office && $head_city == ''}{assign var=head_city value=$o.city}{/if}{/foreach}
                        {if $head_city}<span class="contact-map-chip"><i class="bi bi-geo-alt-fill me-1"></i>{lang key='website/contact/head-office'}, {$head_city}</span>{/if}
                    </div>
                </figure>
            </div>
            {/if}
        </div>
        {else}
        <figure class="contact-map mb-0">
            <div class="contact-map-frame" data-map-embed>{$map_embed nofilter}</div>
        </figure>
        {/if}
    </section>
    {/if}

{/block}
