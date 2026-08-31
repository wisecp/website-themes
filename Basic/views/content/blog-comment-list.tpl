{foreach $items as $c}{include file='components/blog-comment-item.tpl' c=$c is_reply=$is_reply is_admin=$is_admin can_comment=$can_comment comment_owner_id=$comment_owner_id}{/foreach}
