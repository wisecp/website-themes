<div class="news-subscribe" data-newsletter>
    <div class="news-subscribe-title"><i class="bi bi-envelope-paper"></i>{lang key='website/news/newsletter-title'}</div>
    <p class="news-subscribe-sub">{lang key='website/news/newsletter-sub'}</p>
    <form data-role="newsletter-form" action="{$subscribe_url}" method="post" novalidate>
        <div class="wui-collapse wui-show" data-role="newsletter-step-email">
            <div class="wui-collapse-inner">
                <label for="news-email-{$idsuffix}" class="visually-hidden">{lang key='website/news/newsletter-email-label'}</label>
                <input type="email" class="form-control form-control-sm" id="news-email-{$idsuffix}" placeholder="{lang key='website/news/newsletter-email-placeholder'}" autocomplete="email" required data-role="newsletter-email">
                <div class="form-check mt-2">
                    <input class="form-check-input" type="checkbox" id="news-consent-{$idsuffix}" required data-role="newsletter-consent">
                    <label class="form-check-label fs-8" for="news-consent-{$idsuffix}">{lang key='website/news/newsletter-consent-pre'} <a{if $privacy_contract_link} href="{$privacy_contract_link}" target="_blank" rel="noopener"{/if}>{lang key='website/news/newsletter-privacy'}</a>{lang key='website/news/newsletter-consent-post'}</label>
                </div>
                <button class="btn btn-primary btn-sm w-100 mt-3" type="submit"><i class="bi bi-envelope-check me-1"></i>{lang key='website/news/newsletter-subscribe'}</button>
            </div>
        </div>
        <div class="wui-collapse" data-role="newsletter-step-captcha">
            <div class="wui-collapse-inner">
                {captcha area='newsletter'}
                <button class="btn btn-primary btn-sm w-100 mt-3" type="submit"><i class="bi bi-shield-check me-1"></i>{lang key='website/news/newsletter-verify-subscribe'}</button>
            </div>
        </div>
        {csrf form='newsletter'}
    </form>
    <div class="wui-collapse" data-role="newsletter-ok">
        <div class="wui-collapse-inner">
            <p class="news-subscribe-ok mb-0"><i class="bi bi-check-circle-fill"></i><span>{lang key='website/news/newsletter-success'}</span></p>
        </div>
    </div>
</div>
