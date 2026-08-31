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

        $kind  = (string) ($r["kind"] ?? 'action');
        $tone  = (string) ($r["tone"] ?? 'primary');
        $icon  = (string) ($r["icon"] ?? 'bi-pencil');
        $title = htmlspecialchars((string) ($r["title"] ?? ''));
        $ts    = (int) ($r["ts"] ?? 0);
        $date  = htmlspecialchars((string) ($r["date"] ?? ''));

        $chipsHtml = '';
        foreach ((array) ($r["chips"] ?? []) as $chip) {
            $ci  = htmlspecialchars((string) ($chip["icon"] ?? ''));
            $ct  = htmlspecialchars((string) ($chip["text"] ?? ''));
            $tab = !empty($chip["tabular"]) ? ' num-tabular' : '';
            $chipsHtml .= '<span class="list-chip' . $tab . '"><i class="bi ' . $ci . '"></i>' . $ct . '</span>';
        }
        if ($chipsHtml !== '') $chipsHtml = '<span class="as-activity-meta">' . $chipsHtml . '</span>';

        $row["html"] = <<<HTML
<tr data-filter-type="{$kind}">
    <td>
        <div class="d-flex align-items-center gap-2">
            <span class="as-activity-ico as-activity-ico-{$tone}"><i class="bi {$icon}"></i></span>
            <span class="as-activity-text">{$title}</span>
        </div>
    </td>
    <td>{$chipsHtml}</td>
    <td class="text-end as-activity-time num-tabular" data-value="{$ts}">{$date}</td>
</tr>
HTML;

        return $row;
    });
