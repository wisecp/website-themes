<?php
/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
return [
    'name'        => 'Basic',
    'description' => 'O tema padrão do WISECP. Um tema responsivo baseado em Bootstrap 5, com modos claro e escuro e suporte a RTL. Feito para quem busca uma interface simples e organizada.',

    'grp_topbar'           => 'Barra de comunicados',
    'set_topbar_enabled'      => 'Mostrar barra de comunicados',
    'set_topbar_enabled_desc' => 'Exibe uma faixa estreita acima do cabeçalho para informações de contato, promoções ou avisos.',
    'set_topbar_text'         => 'Texto do comunicado',
    'set_topbar_text_desc'    => 'Exibido na faixa acima do cabeçalho. Tags HTML e Smarty são aceitas; scripts, formulários e manipuladores de eventos são removidos ao salvar.',

    'grp_appearance'      => 'Aparência',
    'set_primary_color'   => 'Cor primária',
    'set_secondary_color' => 'Cor secundária',
    'set_text_color'      => 'Cor do texto',

    'grp_checkout'              => 'Finalização da compra',
    'set_checkout_sidebar'      => 'Layout do resumo do pedido',
    'set_checkout_sidebar_desc' => 'Define onde o resumo do pedido aparece nas páginas de configuração, carrinho e finalização da compra.',
    'opt_checkout_rail'         => 'Painel lateral (fixo)',
    'opt_checkout_card'         => 'Cartão (coluna na página)',
    'opt_checkout_stack'        => 'Coluna única (com barra inferior)',

    'grp_dashboard'               => 'Painel do cliente',
    'set_dashboard_layout'        => 'Layout do painel',
    'set_dashboard_layout_desc'   => 'Define a organização do painel do cliente: o layout moderno com uma faixa de comandos em destaque ou o layout clássico com um painel da conta à esquerda.',
    'opt_dash_hero'               => 'Moderno (destaque)',
    'opt_dash_standard'           => 'Clássico (padrão)',

    'grp_popup'              => 'Janela pop-up',
    'set_popup_enabled'      => 'Mostrar janela pop-up',
    'set_popup_enabled_desc' => 'Exibe uma janela pop-up sobre o site após um intervalo, conforme a frequência escolhida.',
    'set_popup_content'      => 'Conteúdo do pop-up',
    'set_popup_content_desc' => 'Tags HTML e Smarty são aceitas; scripts, formulários e manipuladores de eventos são removidos ao salvar.',
    'set_popup_width'        => 'Largura (px)',
    'set_popup_height'       => 'Altura (px)',
    'set_popup_frequency'    => 'Frequência',
    'opt_popup_once'         => 'Uma vez por visitante',
    'opt_popup_daily'        => 'Uma vez por dia',
    'opt_popup_always'       => 'A cada carregamento da página',
    'set_popup_delay'        => 'Atraso (segundos)',
    'set_popup_delay_desc'   => 'O pop-up aparece após este número de segundos a partir do carregamento da página.',

    'cz_title'           => 'Prévia do tema',
    'cz_subtitle'        => 'Salvo no navegador; os arquivos do tema permanecem inalterados.',
    'cz_theme'           => 'Tema',
    'cz_soon'            => 'Em breve',
    'cz_layout'          => 'Layout',
    'cz_dashboard'       => 'Painel',
    'cz_hero'            => 'Destaque',
    'cz_standard'        => 'Padrão',
    'cz_checkout'        => 'Finalização da compra',
    'cz_rail'            => 'Painel lateral',
    'cz_card'            => 'Cartão',
    'cz_stack'           => 'Coluna única',
    'cz_appearance'      => 'Aparência',
    'cz_brand_logo'      => 'Logo da marca',
    'cz_logo_upload'     => 'Enviar seu logo',
    'cz_logo_hint'       => 'As cores predominantes da marca são aplicadas automaticamente.',
    'cz_logo_remove'     => 'Remover logo',
    'cz_colors'          => 'Cores',
    'cz_primary'         => 'Primária',
    'cz_secondary'       => 'Secundária',
    'cz_text'            => 'Texto',
    'cz_text_note'       => '(modo claro)',
    'cz_pick_primary'    => 'Escolher cor primária',
    'cz_pick_secondary'  => 'Escolher cor secundária',
    'cz_pick_text'       => 'Escolher cor do texto',
    'cz_typography'      => 'Tipografia',
    'cz_font_family'     => 'Família de fontes',
    'cz_reset'           => 'Restaurar padrões',
    'cz_close'           => 'Fechar painel',
    'cz_toast_extracted' => 'Cores da marca extraídas do seu logo.',
    'cz_toast_reset'     => 'Prévia do tema restaurada aos padrões.',
    'cz_nudge_dashboard' => 'Experimentar o outro painel',
    'cz_nudge_checkout'  => 'Experimentar outro layout de finalização da compra',
    'cz_nudge_explore'   => 'Explorar opções do tema',
];
