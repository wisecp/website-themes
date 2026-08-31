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

    $opts             = $table->getOptions();
    $showInvoicesLink = (bool) ($opts["show_invoices_link"] ?? false);
    $invoicesLink     = (string) ($opts["invoices_link"] ?? '');
    $orderServiceLink = (string) ($opts["order_service_link"] ?? '');
    $accountAutopay   = (bool) ($opts["account_autopay"] ?? false);
    $homeLink         = \LinkGenerator::client("home");
    $ucid             = (int) \Money::getUCID();
    $today            = strtotime(date("Y-m-d"));


    $statusBadge = fn (string $s): string => match ($s) {
        'waiting', 'inprocess'   => 'pending',
        'suspended'              => 'suspended',
        'expired'                => 'expired',
        'cancelled', 'completed' => 'cancelled',
        default                  => 'active',
    };

    $typeMeta = fn (string $t): array => match ($t) {
        'hosting'  => ['bi bi-hdd-stack',   'hosting'],
        'server'   => ['bi bi-cpu',         'server'],
        'ssl'      => ['bi bi-shield-lock', 'ssl'],
        'software' => ['bi bi-box-seam',    'software'],
        default    => ['bi bi-box-seam',    $t !== '' ? $t : 'other'],
    };

    $typeLabel = function (string $g): string {
        $label = \Language::gc("website/services/type-" . $g);
        return (is_string($label) && $label !== '') ? $label : (string) \Language::gc("website/services/type-other");
    };

    $validTs = fn (string $dt): int => (($ts = (int) strtotime($dt)) > strtotime("2000-01-01")) ? $ts : 0;

    $isLifetime = function (array $r): bool {
        if (($r["period"] ?? '') === "none") return true;
        $ts = strtotime((string) ($r["duedate"] ?? ''));
        return !$ts || (int) date("Y", $ts) < 1900;
    };

    $fmtDate = fn (int $ts): string => $ts
        ? \DateManager::format(\Config::get("options/date-format") ?: "M d, Y", date("Y-m-d H:i:s", $ts))
        : '';

    $dueBlock = function (string $badge, bool $lifetime, int $dueTs, int $today) use ($fmtDate): array {
        $base = ['kind' => 'none', 'date' => '', 'text' => '', 'class' => '', 'icon' => '', 'meter' => false, 'flag' => 'none', 'overdue' => false];

        if ($badge === "pending")
            return array_merge($base, ['kind' => 'pending', 'text' => \Language::gc("website/services/awaiting"), 'icon' => "bi bi-hourglass-split", 'flag' => 'attention']);

        if ($lifetime)
            return array_merge($base, ['kind' => 'lifetime', 'text' => \Language::gc("website/services/lifetime"), 'icon' => "bi bi-infinity"]);

        if ($badge === "cancelled")
            return array_merge($base, ['kind' => 'none', 'text' => \Language::gc("website/services/no-renewal")]);

        if (!$dueTs)
            return array_merge($base, ['kind' => 'none', 'text' => \Language::gc("website/services/no-renewal"), 'flag' => in_array($badge, ["suspended", "expired"], true) ? 'attention' : 'none']);

        $dated = ['kind' => 'date', 'date' => $fmtDate($dueTs), 'meter' => true];

        if ($badge === "expired")
            return array_merge($base, $dated, ['text' => \Language::gc("website/services/expired"), 'class' => "is-critical", 'icon' => "bi bi-calendar-x", 'flag' => 'attention']);

        if ($badge === "suspended")
            return array_merge($base, $dated, ['text' => \Language::gc("website/services/overdue"), 'class' => "is-critical", 'icon' => "bi bi-exclamation-circle", 'flag' => 'attention']);

        $days = (int) ceil(($dueTs - $today) / 86400);
        if ($days <= 0)
            return array_merge($base, $dated, ['text' => \Language::gc("website/services/overdue"), 'class' => "is-critical", 'icon' => "bi bi-exclamation-circle", 'flag' => 'due', 'overdue' => true]);

        $text = $days === 1
            ? \Language::gc("website/services/days-left-one")
            : \Language::gc("website/services/days-left", ['{days}' => $days]);
        $soon = $days <= 7;

        return array_merge($base, $dated, ['text' => $text, 'class' => $soon ? "is-soon" : '', 'icon' => "bi bi-clock", 'flag' => $soon ? 'due' : 'none']);
    };

    $productGroups = \Products::groups();

    $table->setRowRender(function ($row) use (
        $statusBadge, $typeMeta, $typeLabel, $validTs, $isLifetime, $dueBlock, $productGroups,
        $ucid, $today, $showInvoicesLink, $invoicesLink, $orderServiceLink, $homeLink, $accountAutopay
    ) {
        $r = $row["model"];

        $id       = (int) $r["id"];
        $badge    = $statusBadge((string) $r["status"]);
        $rType    = (string) $r["type"];
        $icon     = $typeMeta($rType)[0];
        $tid   = (int) ($r["type_id"] ?? 0);
        $group = ($rType === "special" && $tid > 0) ? "special-" . $tid : $rType;
        $lifetime = $isLifetime($r);

        $jopts = \Utility::jdecode($r["options"] ?? '', true) ?: [];
        $ident = trim((string) ($jopts["domain"] ?? ($jopts["hostname"] ?? '')));
        $blocked = !empty($jopts["block_access"]);

        $cid    = (int) $r["amount_cid"];
        $amount = (float) $r["amount"];
        $inUcid = $cid === $ucid ? $amount : (float) \Money::exChange($amount, $cid, $ucid);

        $dueTs   = $lifetime ? 0 : $validTs((string) $r["duedate"]);
        $startTs = $validTs((string) $r["cdate"]);

        $due  = $dueBlock($badge, $lifetime, $dueTs, $today);
        $flag = $due["flag"];

        $ck        = \Products::cycle((int) $r["period_time"], (string) $r["period"]);
        $cycleName = $lifetime ? \Language::g("date/cycles/onetime") : ($ck ? \Language::g("date/cycles/" . $ck) : '');
        $cycleName = is_string($cycleName) ? $cycleName : '';

        $name      = (string) $r["name"];
        $nameEsc   = htmlspecialchars($name);
        $label     = $productGroups[$group] ?? ($productGroups[$rType] ?? $typeLabel($rType));
        $link      = \LinkGenerator::client("service-detail", [$id]);
        $amountFmt = \Money::formatter_symbol($amount, $cid);
        $showRenew = !$blocked && !$lifetime && in_array($badge, ["active", "suspended", "expired"], true);
        $autorenew = (int) ($r["auto_pay"] ?? 0) === 1;

        $dName   = htmlspecialchars(\Utility::strtolower($name));
        $dSearch = htmlspecialchars(\Utility::strtolower(trim($ident . ' ' . $label . ' #' . $id)));
        $dPrice  = sprintf('%.2f', $inUcid);
        $dDue    = $dueTs ? (string) $dueTs : '0';
        $dOverdue = !empty($due["overdue"]) ? '1' : '0';
        $dStart  = (string) $startTs;

        $itemClass = 'list-item' . (in_array($badge, ['suspended', 'expired'], true) ? ' is-danger' : '');

        $badgeHtml = match ($badge) {
            'active'    => '<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>' . \Language::gc("website/services/st-active") . '</span>',
            'pending'   => '<span class="badge bg-info-subtle text-info-emphasis"><i class="bi bi-gear-fill wcp-status-spin me-1"></i>' . \Language::gc("website/services/st-pending") . '</span>',
            'suspended' => '<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-pause-circle me-1"></i>' . \Language::gc("website/services/st-suspended") . '</span>',
            'expired'   => '<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-calendar-x me-1"></i>' . \Language::gc("website/services/st-expired") . '</span>',
            default     => '<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-x-circle me-1"></i>' . \Language::gc("website/services/st-cancelled") . '</span>',
        };

        $metaHtml = '';
        if ($ident !== '') $metaHtml .= '<span class="list-ident">' . htmlspecialchars($ident) . '</span>';
        $metaHtml .= '<span class="list-chip"><i class="' . $icon . '"></i>' . htmlspecialchars($label) . '</span>';
        if ($showRenew) {
            if ($accountAutopay) {
                $metaHtml .= '<span class="d-inline-block" tabindex="0" data-bs-toggle="tooltip" title="' . htmlspecialchars(\Language::gc("website/account/autorenew-locked-account")) . '">'
                    . '<button type="button" class="list-chip list-chip-btn is-on" disabled aria-pressed="true"><i class="bi bi-arrow-repeat"></i><span class="list-chip-text">' . htmlspecialchars(\Language::gc("website/services/autorenew-on")) . '</span></button></span>';
            } else {
                $renewLabel = $autorenew ? \Language::gc("website/services/autorenew-on") : \Language::gc("website/services/autorenew-off");
                $metaHtml .= '<button type="button" class="list-chip list-chip-btn' . ($autorenew ? ' is-on' : '') . '" data-action="service-autorenew" data-bs-toggle="tooltip" title="' . htmlspecialchars(\Language::gc("website/services/autorenew-tip")) . '" data-id="' . $id . '" data-name="' . $nameEsc . '" aria-pressed="' . ($autorenew ? 'true' : 'false') . '"><i class="bi bi-arrow-repeat"></i><span class="list-chip-text">' . htmlspecialchars($renewLabel) . '</span></button>';
            }
        }
        $metaHtml .= '<span class="list-orderid num-tabular">#' . $id . '</span>';

        $remIcon = $due["icon"];
        $dueHtml = '';
        if ($due["kind"] === 'pending')
            $dueHtml = '<span class="list-due-pending"><i class="' . $remIcon . ' me-1"></i>' . $due["text"] . '</span>';
        elseif ($due["kind"] === 'lifetime')
            $dueHtml = '<span class="list-due-date list-due-lifetime"><i class="' . $remIcon . ' me-1"></i>' . $due["text"] . '</span>';
        elseif ($due["kind"] === 'none')
            $dueHtml = '<span class="list-due-date list-due-none">' . $due["text"] . '</span>';
        else {
            $dueHtml = '<span class="list-due-date num-tabular">' . $due["date"] . '</span>';
            if ($due["text"] !== '')
                $dueHtml .= '<span class="list-due-rem' . ($due["class"] ? ' ' . $due["class"] : '') . '"><i class="' . $remIcon . ' me-1"></i>' . $due["text"] . '</span>';
            if ($due["meter"])
                $dueHtml .= '<span class="list-meter" data-role="meter" aria-hidden="true"><span></span></span>';
        }

        $cycleHtml = $cycleName !== '' ? '<span class="list-cycle">' . htmlspecialchars($cycleName) . '</span>' : '';

        if ($blocked)
            $actionsHtml = '';
        elseif ($badge === 'cancelled')
            $actionsHtml = '<a class="btn btn-soft btn-sm list-manage" href="' . ($orderServiceLink ?: $homeLink) . '"><i class="bi bi-bag-plus me-1"></i>' . \Language::gc("website/services/re-order") . '</a>';
        elseif ($badge === 'pending')
            $actionsHtml = '<a class="btn btn-soft btn-sm list-manage disabled" href="' . $link . '" aria-disabled="true" tabindex="-1"><i class="bi bi-gear me-1"></i>' . \Language::gc("website/services/manage") . '</a>';
        else
            $actionsHtml = '<a class="btn btn-soft btn-sm list-manage" href="' . $link . '"><i class="bi bi-gear me-1"></i>' . \Language::gc("website/services/manage") . '</a>';

        if ($showInvoicesLink)
            $actionsHtml .= '<div class="dropdown"><button class="btn btn-soft btn-sm list-more" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="' . htmlspecialchars(\Language::gc("website/services/more-actions")) . '"><i class="bi bi-three-dots"></i></button><ul class="dropdown-menu dropdown-menu-end"><li><a class="dropdown-item" href="' . $invoicesLink . '"><i class="bi bi-receipt"></i>' . \Language::gc("website/services/view-invoices") . '</a></li></ul></div>';

        $iconData = is_array($r["icon"] ?? null) ? $r["icon"] : [];
        $icoHtml  = ($iconData["kind"] ?? '') === 'logo'
            ? '<span class="list-ico has-logo"><img src="' . htmlspecialchars((string) ($iconData["src"] ?? '')) . '" alt=""></span>'
            : '<span class="list-ico"><i class="' . htmlspecialchars((string) ($iconData["class"] ?? $icon)) . '"></i></span>';

        $nameHtml = $blocked
            ? '<span class="list-name">' . $nameEsc . '</span>'
            : '<a class="list-name" href="' . $link . '">' . $nameEsc . '</a>';

        $row["html"] = <<<HTML
<article class="{$itemClass}" data-status="{$badge}" data-group="{$group}" data-flag="{$flag}" data-name="{$dName}" data-search="{$dSearch}" data-price="{$dPrice}" data-due="{$dDue}" data-overdue="{$dOverdue}" data-start="{$dStart}">
    {$icoHtml}
    <div class="list-main">
        <div class="list-head">
            {$nameHtml}
            {$badgeHtml}
        </div>
        <div class="list-meta">{$metaHtml}</div>
    </div>
    <div class="list-side">
        <div class="list-due">{$dueHtml}</div>
        <div class="list-price">
            <span class="list-amount num-tabular">{$amountFmt}</span>
            {$cycleHtml}
        </div>
        <div class="list-actions">{$actionsHtml}</div>
    </div>
</article>
HTML;

        return $row;
    });
