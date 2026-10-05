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

    $opts           = $table->getOptions();
    $canManage      = (bool) ($opts["can_manage"] ?? false);
    $accountAutopay = (bool) ($opts["account_autopay"] ?? false);

    $table->setRowRender(function ($row) use ($canManage, $accountAutopay) {
        $r = $row["model"];

        $id        = (int) ($r["id"] ?? 0);
        $name      = (string) ($r["name"] ?? '');
        $nameEsc   = htmlspecialchars($name);
        $badge     = (string) ($r["badge"] ?? 'active');
        $flag      = (string) ($r["flag"] ?? 'none');
        $tld       = (string) ($r["tld"] ?? '');
        $logo      = (string) ($r["logo"] ?? '');

        $itemClass = 'list-item' . (in_array($badge, ['expired', 'suspended'], true) ? ' is-danger' : '');

        $dName   = htmlspecialchars((string) ($r["d_name"] ?? ''));
        $dSearch = htmlspecialchars((string) ($r["d_search"] ?? ''));
        $dPrice  = (string) ($r["d_price"] ?? '0');
        $dDue    = (string) ($r["d_due"] ?? '0');
        $dStart  = (string) ($r["d_start"] ?? '0');
        $tldAttr = htmlspecialchars($tld);

        $badgeHtml = match ($badge) {
            'active'    => '<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>' . \Language::gc("website/domains/st-active") . '</span>',
            'expiring'  => '<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-exclamation-triangle me-1"></i>' . \Language::gc("website/domains/st-expiring") . '</span>',
            'expired'   => '<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-calendar-x me-1"></i>' . \Language::gc("website/domains/st-expired") . '</span>',
            'suspended' => '<span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-pause-circle me-1"></i>' . \Language::gc("website/domains/st-suspended") . '</span>',
            'cancelled' => '<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-x-circle me-1"></i>' . \Language::gc("website/domains/st-cancelled") . '</span>',
            default     => '',
        };

        $metaHtml = '<span class="list-ident">' . $r["registered"] . '</span>';

        if (!empty($r["show_lock"])) {
            $locked   = !empty($r["locked"]);
            $lockIcon = $locked ? "bi-lock-fill" : "bi-unlock";
            $lockText = $locked ? \Language::gc("website/domains/locked") : \Language::gc("website/domains/unlocked");
            if ($canManage)
                $metaHtml .= '<button type="button" class="list-chip list-chip-btn' . ($locked ? ' is-on' : '') . '" data-action="domain-lock" data-bs-toggle="tooltip" title="' . htmlspecialchars(\Language::gc("website/domains/lock-tip")) . '" data-id="' . $id . '" data-domain="' . $nameEsc . '" aria-pressed="' . ($locked ? 'true' : 'false') . '"><i class="bi ' . $lockIcon . '"></i><span class="list-chip-text">' . $lockText . '</span></button>';
            else
                $metaHtml .= '<span class="list-chip"><i class="bi ' . $lockIcon . '"></i>' . $lockText . '</span>';
        }

        if (!empty($r["show_renew"])) {
            $auto     = !empty($r["autorenew"]);
            $autoText = $auto ? \Language::gc("website/domains/autorenew-on") : \Language::gc("website/domains/autorenew-off");
            if ($accountAutopay)
                $metaHtml .= '<span class="d-inline-block" tabindex="0" data-bs-toggle="tooltip" title="' . htmlspecialchars(\Language::gc("website/account/autorenew-locked-account")) . '">'
                    . '<button type="button" class="list-chip list-chip-btn is-on" disabled aria-pressed="true"><i class="bi bi-arrow-repeat"></i><span class="list-chip-text">' . \Language::gc("website/domains/autorenew-on") . '</span></button></span>';
            elseif ($canManage)
                $metaHtml .= '<button type="button" class="list-chip list-chip-btn' . ($auto ? ' is-on' : '') . '" data-action="domain-autorenew" data-bs-toggle="tooltip" title="' . htmlspecialchars(\Language::gc("website/domains/autorenew-tip")) . '" data-id="' . $id . '" data-domain="' . $nameEsc . '" aria-pressed="' . ($auto ? 'true' : 'false') . '"><i class="bi bi-arrow-repeat"></i><span class="list-chip-text">' . $autoText . '</span></button>';
            else
                $metaHtml .= '<span class="list-chip"><i class="bi bi-arrow-repeat"></i>' . $autoText . '</span>';
        }

        $dueKind = (string) ($r["due_kind"] ?? 'none');
        $remIcon = (string) ($r["rem_icon"] ?? '');
        $remText = (string) ($r["rem_text"] ?? '');
        if ($dueKind === 'pending')
            $dueHtml = '<span class="list-due-pending"><i class="' . $remIcon . ' me-1"></i>' . $remText . '</span>';
        elseif ($dueKind === 'refused') {
            $reason  = (string) ($r["transfer_reason"] ?? '');
            $tipAttr = $reason !== '' ? ' data-bs-toggle="tooltip" title="' . htmlspecialchars($reason) . '"' : '';
            $dueHtml = '<span class="badge bg-danger-subtle text-danger-emphasis"' . $tipAttr . ' data-role="transfer-refused"><i class="' . $remIcon . ' me-1"></i>' . $remText . '</span>';
        }
        elseif ($dueKind === 'none')
            $dueHtml = '<span class="list-due-date list-due-none">' . $remText . '</span>';
        else {
            $dueHtml = '<span class="list-due-date num-tabular">' . (string) ($r["due_date"] ?? '') . '</span>';
            if ($remText !== '')
                $dueHtml .= '<span class="list-due-rem' . (($r["rem_class"] ?? '') ? ' ' . $r["rem_class"] : '') . '"><i class="' . $remIcon . ' me-1"></i>' . $remText . '</span>';
            if (!empty($r["meter"]))
                $dueHtml .= '<span class="list-meter" data-role="meter" aria-hidden="true"><span></span></span>';
        }

        $cycleHtml = ($r["cycle"] ?? '') !== '' ? '<span class="list-cycle">' . htmlspecialchars((string) $r["cycle"]) . '</span>' : '';
        $amountFmt = (string) ($r["amount"] ?? '');

        $needsVerify = !empty($r["needs_verify"]);
        $verifyState = (string) ($r["verify_state"] ?? '');

        $blocked = !empty($r["blocked"]);
        if ($blocked) {
            $actionsHtml = '';
        } elseif ($canManage && $needsVerify) {
            $vLead = match ($verifyState) {
                'rejected' => '<i class="bi bi-arrow-clockwise me-1"></i>' . \Language::gc("website/domains/verify-cta-rejected"),
                'review'   => '<i class="bi bi-eye me-1"></i>' . \Language::gc("website/domains/verify-cta-review"),
                default    => '<i class="bi bi-clipboard-check me-1"></i>' . \Language::gc("website/domains/verify-cta"),
            };
            $actionsHtml = '<button type="button" class="btn btn-primary btn-sm list-manage" data-bs-toggle="modal" data-bs-target="#domainVerifyModal" data-id="' . $id . '" data-domain="' . $nameEsc . '" data-verify-state="' . htmlspecialchars($verifyState) . '">' . $vLead . '</button>';
        } else {
            $actionsHtml = '<a class="btn btn-soft btn-sm list-manage" href="' . (string) ($r["manage_link"] ?? '') . '"><i class="bi ' . (string) ($r["manage_icon"] ?? 'bi-gear') . ' me-1"></i>' . (string) ($r["manage_label"] ?? '') . '</a>';
        }

        $canNs    = !empty($r["can_ns"]);
        $canEpp   = !empty($r["can_epp"]);
        $canWhois = !empty($r["can_whois"]);
        $isTrans  = !empty($r["is_transfer"]);

        if (!$blocked && $canManage && ($canNs || $canEpp || $canWhois || $isTrans || $needsVerify)) {
            $items = '';
            if ($isTrans)
                $items .= '<li><button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#transferStatusModal" data-id="' . $id . '" data-domain="' . $nameEsc . '"' . ($dueKind === 'refused' ? ' data-refused="1"' : '') . '><i class="bi bi-key"></i>' . \Language::gc("website/domains/transfer-action") . '</button></li>';
            if ($needsVerify)
                $items .= '<li><button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#domainVerifyModal" data-id="' . $id . '" data-domain="' . $nameEsc . '" data-verify-state="' . htmlspecialchars($verifyState) . '"><i class="bi bi-clipboard-check"></i>' . \Language::gc("website/domains/verify-action") . '</button></li>';
            if ($canNs)
                $items .= '<li><button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#domainNsModal" data-id="' . $id . '" data-domain="' . $nameEsc . '" data-ns1="' . htmlspecialchars((string) ($r["ns1"] ?? '')) . '" data-ns2="' . htmlspecialchars((string) ($r["ns2"] ?? '')) . '" data-ns3="' . htmlspecialchars((string) ($r["ns3"] ?? '')) . '" data-ns4="' . htmlspecialchars((string) ($r["ns4"] ?? '')) . '" data-default-ns="' . htmlspecialchars((string) ($r["default_ns"] ?? '')) . '"><i class="bi bi-hdd-network"></i>' . \Language::gc("website/domains/ns-action") . '</button></li>';
            if ($canWhois)
                $items .= '<li><button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#domainWhoisModal" data-id="' . $id . '" data-domain="' . $nameEsc . '" data-profile="' . (int) ($r["whois_profile_id"] ?? 0) . '" data-privacy="' . (!empty($r["whois_privacy"]) ? '1' : '0') . '" data-can-privacy="' . (!empty($r["can_privacy"]) ? '1' : '0') . '"><i class="bi bi-person-vcard"></i>' . \Language::gc("website/domains/whois-action") . '</button></li>';
            if ($canEpp)
                $items .= '<li><button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#eppCodeModal" data-id="' . $id . '" data-domain="' . $nameEsc . '"><i class="bi bi-key"></i>' . \Language::gc("website/domains/epp-action") . '</button></li>';

            $actionsHtml .= '<div class="dropdown"><button class="btn btn-soft btn-sm list-more" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="' . htmlspecialchars(\Language::gc("website/domains/more-actions")) . '"><i class="bi bi-three-dots"></i></button><ul class="dropdown-menu dropdown-menu-end">' . $items . '</ul></div>';
        }

        $icoHtml = $logo !== ''
            ? '<span class="list-ico has-logo"><img src="' . htmlspecialchars($logo) . '" alt=""></span>'
            : '<span class="list-ico"><i class="bi bi-globe2"></i></span>';

        $nameHtml = $blocked
            ? '<span class="list-name">' . $nameEsc . '</span>'
            : '<a class="list-name" href="' . (string) ($r["manage_link"] ?? '') . '">' . $nameEsc . '</a>';

        $row["html"] = <<<HTML
<article class="{$itemClass}" data-status="{$badge}" data-group="{$tldAttr}" data-flag="{$flag}" data-name="{$dName}" data-search="{$dSearch}" data-price="{$dPrice}" data-due="{$dDue}" data-start="{$dStart}">
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
