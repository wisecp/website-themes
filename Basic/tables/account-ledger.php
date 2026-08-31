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

        $type   = ($r["type"] ?? 'up') === 'down' ? 'down' : 'up';
        $ts     = (int) ($r["ts"] ?? 0);
        $date   = htmlspecialchars((string) ($r["date"] ?? ''));
        $desc   = htmlspecialchars((string) ($r["desc"] ?? ''));
        $amount = (string) ($r["amount_fmt"] ?? '');

        $badge = $type === 'up'
            ? '<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-plus-circle me-1"></i>' . \Language::gc("website/balance/badge-up") . '</span>'
            : '<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-receipt me-1"></i>' . \Language::gc("website/balance/badge-down") . '</span>';
        $amtClass = $type === 'up' ? 'bal-amt-pos' : 'bal-amt-neg';

        $row["html"] = <<<HTML
<tr data-filter-type="{$type}">
    <td class="num-tabular" data-value="{$ts}">{$date}</td>
    <td>{$desc}</td>
    <td>{$badge}</td>
    <td class="text-end num-tabular {$amtClass}">{$amount}</td>
</tr>
HTML;

        return $row;
    });
