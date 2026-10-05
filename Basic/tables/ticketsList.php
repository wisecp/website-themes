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

        $status  = (string) ($r["status"] ?? 'open');
        $subject = htmlspecialchars((string) ($r["subject"] ?? ''));
        $ref     = htmlspecialchars((string) ($r["ref"] ?? ''));
        $link    = (string) ($r["link"] ?? '');
        $deptIco = htmlspecialchars((string) ($r["dept_icon"] ?? 'bi bi-tag'));
        $avatar  = htmlspecialchars((string) ($r["avatar"] ?? ''));
        $inits   = htmlspecialchars((string) ($r["initials"] ?? ''));
        $dept    = (string) ($r["dept"] ?? '');

        $dGroup  = (int) ($r["dept_id"] ?? 0);
        $dName   = htmlspecialchars((string) ($r["d_name"] ?? ''));
        $dSearch = htmlspecialchars((string) ($r["d_search"] ?? ''));
        $dPrice  = (string) ($r["d_price"] ?? '0');
        $dStart  = (string) ($r["d_start"] ?? '0');

        $badgeHtml = match ($status) {
            'answered'   => '<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-chat-left-text me-1"></i>' . \Language::gc("website/tickets/st-answered") . '</span>',
            'awaiting'   => '<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>' . \Language::gc("website/tickets/st-awaiting") . '</span>',
            'inprogress' => '<span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-gear-fill wcp-status-spin me-1"></i>' . \Language::gc("website/tickets/st-inprogress") . '</span>',
            'closed'     => '<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-lock me-1"></i>' . \Language::gc("website/tickets/st-closed") . '</span>',
            default      => '<span class="badge bg-primary-subtle text-primary-emphasis"><i class="bi bi-envelope-open me-1"></i>' . \Language::gc("website/tickets/st-open") . '</span>',
        };

        $metaHtml = '<span class="list-ident">#' . $ref . '</span>';
        if ($dept !== '')
            $metaHtml .= '<span class="list-chip"><i class="' . $deptIco . '"></i>' . htmlspecialchars($dept) . '</span>';
        $metaHtml .= match ((string) ($r["priority"] ?? 'low')) {
            'urgent' => '<span class="list-chip"><i class="bi bi-exclamation-triangle"></i>' . \Language::gc("website/tickets/pr-urgent") . '</span>',
            'high'   => '<span class="list-chip"><i class="bi bi-arrow-up"></i>' . \Language::gc("website/tickets/pr-high") . '</span>',
            'medium' => '<span class="list-chip"><i class="bi bi-dash-lg"></i>' . \Language::gc("website/tickets/pr-medium") . '</span>',
            default  => '<span class="list-chip"><i class="bi bi-arrow-down"></i>' . \Language::gc("website/tickets/pr-low") . '</span>',
        };

        $lastStaff = !empty($r["last_staff"]);
        $lastBy    = $lastStaff ? \Language::gc("website/tickets/by-support") : \Language::gc("website/tickets/by-you");
        $dueHtml   = '<span class="list-due-date num-tabular">' . (string) ($r["date"] ?? '') . '</span>'
                   . '<span class="list-due-rem"><i class="bi bi-clock me-1"></i>' . (string) ($r["time_ago"] ?? '') . ' &middot; ' . $lastBy . '</span>';

        $staffRibbon = $lastStaff ? '<span class="list-ico-staff" aria-hidden="true"><i class="bi bi-headset"></i></span>' : '';

        if ($avatar !== '')
            $icoInner = '<img src="' . $avatar . '" alt="">';
        elseif ($inits !== '')
            $icoInner = '<span class="list-ico-ini">' . $inits . '</span>';
        else
            $icoInner = '<i class="' . $deptIco . '"></i>';
        $icoClass = 'list-ico' . ($lastStaff && $avatar !== '' ? ' is-plain' : '');

        $id     = (int) ($r["id"] ?? 0);
        $rating = (int) ($r["rating"] ?? 0);
        if ($status === 'closed')
            $menu = '<li><a class="dropdown-item" href="' . $link . '"><i class="bi bi-arrow-clockwise"></i>' . \Language::gc("website/tickets/reopen") . '</a></li>';
        else
            $menu = '<li><button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#closeTicketModal" data-ticket="#' . $ref . '" data-ticket-id="' . $id . '" data-ticket-rating="' . $rating . '"><i class="bi bi-lock"></i>' . \Language::gc("website/tickets/close") . '</button></li>';

        $actionsHtml = '<a class="btn btn-soft btn-sm list-manage" href="' . $link . '"><i class="bi bi-eye me-1"></i>' . \Language::gc("website/tickets/view") . '</a>'
                     . '<div class="dropdown"><button class="btn btn-soft btn-sm list-more" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="' . htmlspecialchars(\Language::gc("website/tickets/more-actions")) . '"><i class="bi bi-three-dots"></i></button><ul class="dropdown-menu dropdown-menu-end">' . $menu . '</ul></div>';

        $row["html"] = <<<HTML
<article class="list-item" data-status="{$status}" data-group="{$dGroup}" data-flag="none" data-name="{$dName}" data-search="{$dSearch}" data-price="{$dPrice}" data-due="0" data-start="{$dStart}">
    <span class="{$icoClass}">{$icoInner}{$staffRibbon}</span>
    <div class="list-main">
        <div class="list-head">
            <a class="list-name" href="{$link}"><bdi>{$subject}</bdi></a>
            {$badgeHtml}
        </div>
        <div class="list-meta">{$metaHtml}</div>
    </div>
    <div class="list-side">
        <div class="list-due">{$dueHtml}</div>
        <div class="list-actions">{$actionsHtml}</div>
    </div>
</article>
HTML;

        return $row;
    });
