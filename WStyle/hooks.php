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
    $data["support_enabled"] = (int) (Config::get("options/ticket-system") ?? 0) === 1;

    if (!empty($data["is_logged_in"]) && !empty($data["show_client_subnav"])) {
        $last_login = User::getLastLogin((int) ($data["client_id"] ?? 0));
        $ll_ip      = (string) ($last_login["ip"] ?? '');
        $ll_date    = (string) ($last_login["date"] ?? '');
        if ($ll_ip !== '' && $ll_ip !== '0.0.0.0' && DateManager::isValid($ll_date))
            $data["last_login"] = [
                'date' => DateManager::format(((string) (Config::get("options/date-format") ?: 'd/m/Y')) . ' H:i', $ll_date),
                'ip'   => $ll_ip,
            ];
    }

    return $data;
});

