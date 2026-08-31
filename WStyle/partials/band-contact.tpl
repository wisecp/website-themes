{if $contact_phone || $contact_email}
<section class="py-5 border-top" data-reveal>
    <div class="container">
        <div class="section-head">
            <span class="eyebrow">{lang key='band_contact_eyebrow'}</span>
            <h2 class="tracking-tight">{lang key='band_contact_title'}</h2>
            <p class="section-lead">{lang key='band_contact_lead'}</p>
        </div>
        <div class="row g-4 justify-content-center">
            {if $contact_phone}
            <div class="col-md-6 col-xl-5">
                <a class="contact-card hover-lift" href="tel:{$contact_phone|regex_replace:'/[^+0-9]/':''}">
                    <span class="contact-ico"><i class="bi bi-telephone"></i></span>
                    <span class="contact-body">
                        <span class="contact-label">{lang key='band_contact_call'}</span>
                        <span class="contact-value num-tabular">{$contact_phone}</span>
                        <span class="contact-sub">{lang key='band_contact_call_sub'}</span>
                    </span>
                    <i class="bi bi-arrow-right contact-arrow" aria-hidden="true"></i>
                </a>
            </div>
            {/if}
            {if $contact_email}
            <div class="col-md-6 col-xl-5">
                <a class="contact-card hover-lift" href="mailto:{$contact_email}">
                    <span class="contact-ico"><i class="bi bi-envelope"></i></span>
                    <span class="contact-body">
                        <span class="contact-label">{lang key='band_contact_email'}</span>
                        <span class="contact-value">{$contact_email}</span>
                        <span class="contact-sub">{lang key='band_contact_email_sub'}</span>
                    </span>
                    <i class="bi bi-arrow-right contact-arrow" aria-hidden="true"></i>
                </a>
            </div>
            {/if}
        </div>
    </div>
</section>
{/if}
