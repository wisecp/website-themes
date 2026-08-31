<?php
/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
    if (!isset($table)) return;

    $table->setRowRender(function ($row) {
        $r = $row["model"];

        $id      = (int) ($r["id"] ?? 0);
        $type    = ($r["type"] ?? 'email') === 'sms' ? 'sms' : 'email';
        $subject = htmlspecialchars((string) ($r["subject"] ?? ''));
        $meta    = htmlspecialchars((string) ($r["meta"] ?? ''));
        $channel = htmlspecialchars((string) ($r["channel"] ?? ''));
        $ts      = (int) ($r["ts"] ?? 0);
        $date    = htmlspecialchars((string) ($r["date"] ?? ''));

        $ico  = $type === 'sms' ? 'bi-chat-dots' : 'bi-envelope';
        $tone = $type === 'sms' ? 'info' : 'primary';
        $badge = $type === 'sms'
            ? '<span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-chat-dots me-1"></i>' . $channel . '</span>'
            : '<span class="badge bg-primary-subtle text-primary-emphasis"><i class="bi bi-envelope me-1"></i>' . $channel . '</span>';

        $row["html"] = <<<HTML
<tr data-action="as-message-view" data-id="{$id}" data-type="{$type}" data-subject="{$subject}" data-meta="{$meta}">
    <td>
        <div class="d-flex align-items-center gap-2">
            <span class="as-activity-ico as-activity-ico-{$tone}"><i class="bi {$ico}"></i></span>
            <span class="as-activity-text">{$subject}</span>
        </div>
    </td>
    <td>{$badge}</td>
    <td class="text-end as-activity-time num-tabular" data-value="{$ts}">{$date}</td>
</tr>
HTML;

        return $row;
    });
