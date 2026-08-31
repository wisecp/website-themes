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

        $badge  = (string) ($r["badge"] ?? 'unpaid');
        $number = (string) ($r["number"] ?? '');
        $numEsc = htmlspecialchars($number);
        $link   = (string) ($r["link"] ?? '');
        $pay    = !empty($r["pay"]);

        $itemClass = 'list-item' . ($badge === 'overdue' ? ' is-danger' : '');

        $dName   = htmlspecialchars((string) ($r["d_name"] ?? ''));
        $dSearch = htmlspecialchars((string) ($r["d_search"] ?? ''));
        $dPrice  = (string) ($r["d_price"] ?? '0');
        $dDue    = (string) ($r["d_due"] ?? '0');
        $dStart  = (string) ($r["d_start"] ?? '0');

        $badgeHtml = match ($badge) {
            'paid'      => '<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>' . \Language::gc("website/invoices/st-paid") . '</span>',
            'overdue'   => '<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-exclamation-circle me-1"></i>' . \Language::gc("website/invoices/st-overdue") . '</span>',
            'refunded'  => '<span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-arrow-counterclockwise me-1"></i>' . \Language::gc("website/invoices/st-refunded") . '</span>',
            'cancelled' => '<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-x-circle me-1"></i>' . \Language::gc("website/invoices/st-cancelled") . '</span>',
            'waiting'   => '<span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-clock me-1"></i>' . \Language::gc("website/invoices/st-waiting") . '</span>',
            default     => '<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>' . \Language::gc("website/invoices/st-unpaid") . '</span>',
        };

        $dueClass = !empty($r["due_none"]) ? 'list-due-date list-due-none' : 'list-due-date num-tabular';
        $dueHtml  = '<span class="' . $dueClass . '">' . (string) ($r["due_line"] ?? '') . '</span>';
        $remText  = (string) ($r["rem_text"] ?? '');
        if ($remText !== '')
            $dueHtml .= '<span class="list-due-rem' . (($r["rem_class"] ?? '') ? ' ' . $r["rem_class"] : '') . '"><i class="' . (string) ($r["rem_icon"] ?? '') . ' me-1"></i>' . $remText . '</span>';

        $amountFmt = (string) ($r["amount"] ?? '');
        $issued    = (string) ($r["issued"] ?? '');

        if ($pay)
            $actionsHtml = '<a class="btn btn-soft btn-sm list-manage" href="' . $link . '"><i class="bi bi-credit-card me-1"></i>' . \Language::gc("website/invoices/pay-now") . '</a>';
        else
            $actionsHtml = '<a class="btn btn-soft btn-sm list-manage" href="' . $link . '"><i class="bi bi-eye me-1"></i>' . \Language::gc("website/invoices/view") . '</a>';

        if ($pay)
            $menu = '<li><a class="dropdown-item" href="' . $link . '"><i class="bi bi-eye"></i>' . \Language::gc("website/invoices/view-invoice") . '</a></li>'
                  . '<li><a class="dropdown-item" href="' . $link . '"><i class="bi bi-download"></i>' . \Language::gc("website/invoices/download-pdf") . '</a></li>';
        else {
            $menu = '<li><a class="dropdown-item" href="' . $link . '"><i class="bi bi-download"></i>' . \Language::gc("website/invoices/download-pdf") . '</a></li>';
            if ($badge === 'paid')
                $menu .= '<li><a class="dropdown-item" href="' . $link . '"><i class="bi bi-receipt-cutoff"></i>' . \Language::gc("website/invoices/download-receipt") . '</a></li>';
            elseif ($badge === 'refunded')
                $menu .= '<li><a class="dropdown-item" href="' . $link . '"><i class="bi bi-receipt-cutoff"></i>' . \Language::gc("website/invoices/download-credit-note") . '</a></li>';
        }

        $actionsHtml .= '<div class="dropdown"><button class="btn btn-soft btn-sm list-more" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="' . htmlspecialchars(\Language::gc("website/invoices/more-actions")) . '"><i class="bi bi-three-dots"></i></button><ul class="dropdown-menu dropdown-menu-end">' . $menu . '</ul></div>';

        $row["html"] = <<<HTML
<article class="{$itemClass}" data-status="{$badge}" data-flag="none" data-name="{$dName}" data-search="{$dSearch}" data-price="{$dPrice}" data-due="{$dDue}" data-start="{$dStart}">
    <span class="list-ico"><i class="bi bi-receipt"></i></span>
    <div class="list-main">
        <div class="list-head">
            <a class="list-name" href="{$link}">{$numEsc}</a>
            {$badgeHtml}
        </div>
    </div>
    <div class="list-side">
        <div class="list-due">{$dueHtml}</div>
        <div class="list-price">
            <span class="list-amount num-tabular">{$amountFmt}</span>
            <span class="list-cycle">{$issued}</span>
        </div>
        <div class="list-actions">{$actionsHtml}</div>
    </div>
</article>
HTML;

        return $row;
    });
