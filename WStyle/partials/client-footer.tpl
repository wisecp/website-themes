<footer class="client-footer">
    <div class="container">
        <div class="client-footer-inner">
            {if !empty($last_login)}
            <a class="client-footer-meta num-tabular" href="{link route='info'}#activity"><i class="bi bi-clock-history"></i>{lang key='client_last_login' date=$last_login.date ip=$last_login.ip}</a>
            {/if}
            <span class="client-footer-copy ms-md-auto">© {$current_year} {$company_name} {lang key='website/index/footer-rights'}</span>
            {if $show_powered_by}
            <span class="client-footer-powered">{lang key='website/index/footer-powered-by'} <a href="https://www.wisecp.com">WISECP</a></span>
            {/if}
        </div>
    </div>
</footer>
