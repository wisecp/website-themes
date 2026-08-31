<section class="newsletter-band chrome-dark py-5" data-reveal>
    <div class="container">
        <div class="newsletter-panel">
            <div>
                <span class="newsletter-kicker"><i class="bi bi-envelope-paper"></i>{lang key='band_newsletter_kicker'}</span>
                <h2 class="h3 mb-2">{lang key='band_newsletter_title'}</h2>
                <p class="newsletter-sub fs-7 mb-0">{lang key='band_newsletter_sub'}</p>
            </div>
            <div data-newsletter>
                <form class="newsletter-form" data-role="newsletter-form" action="{link route='news'}" method="post" novalidate>
                    <div class="wui-collapse wui-show" data-role="newsletter-step-email">
                        <div class="wui-collapse-inner">
                            <div class="newsletter-controls">
                                <label for="band-nl-email" class="visually-hidden">{lang key='website/news/newsletter-email-label'}</label>
                                <input type="email" class="form-control" id="band-nl-email" placeholder="{lang key='website/news/newsletter-email-placeholder'}" required autocomplete="email" data-role="newsletter-email">
                                <button class="btn btn-secondary px-4" type="submit">{lang key='website/news/newsletter-subscribe'}</button>
                            </div>
                            <div class="form-check mt-3">
                                <input class="form-check-input" type="checkbox" id="band-nl-consent" required data-role="newsletter-consent">
                                <label class="form-check-label fs-8" for="band-nl-consent">{lang key='website/news/newsletter-consent-pre'} <a{if $privacy_contract_link} href="{$privacy_contract_link}" target="_blank" rel="noopener"{/if}>{lang key='website/news/newsletter-privacy'}</a>{lang key='website/news/newsletter-consent-post'}</label>
                            </div>
                        </div>
                    </div>
                    <div class="wui-collapse" data-role="newsletter-step-captcha">
                        <div class="wui-collapse-inner">
                            {captcha area='newsletter'}
                            <button class="btn btn-secondary w-100 mt-3" type="submit"><i class="bi bi-shield-check me-1"></i>{lang key='website/news/newsletter-verify-subscribe'}</button>
                        </div>
                    </div>
                    {csrf form='newsletter'}
                </form>
                <div class="wui-collapse" data-role="newsletter-ok">
                    <div class="wui-collapse-inner">
                        <p class="fs-7 text-success pt-3 mb-0 text-center fw-semibold"><i class="bi bi-check-circle-fill me-1"></i>{lang key='website/news/newsletter-success'}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
