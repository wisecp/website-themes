{hook name='ui:client.cta_band.before'}
<section class="container pb-5">
    <div class="cta-band">
        <h2 class="cta-title mb-2">{lang key=$cta_title_key}</h2>
        <p class="mb-4 opacity-75">{lang key=$cta_text_key}</p>
        <div class="d-flex flex-wrap justify-content-center gap-2">
            {if !($cta_gate|default:true) || $registration_enabled}<a class="btn btn-light rounded-pill px-4" href="{link route='sign-up'}">{lang key=$cta_primary_key}</a>{/if}
            <a class="btn btn-outline-light rounded-pill px-4" href="{link route='contact'}">{lang key=$cta_secondary_key}</a>
        </div>
    </div>
</section>
