<?php
/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */


Hook::add("filter:template.variables", 1, function ($template, $data) {
    $tpl = str_replace('\\', '/', (string) $template);
    if (str_ends_with($tpl, '/domain.php') || str_ends_with($tpl, '/account/sms.php') || str_ends_with($tpl, '/account/domain-detail.php') || str_ends_with($tpl, '/content/blog-detail.php'))
        $data["plural_js"] = Utility::asset('templates/admin/js/plural.js');

    return $data;
});
