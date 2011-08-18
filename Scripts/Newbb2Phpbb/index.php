<?php
    require_once('classes/newbb_to_phpbb.php');
    require_once('classes/ldap.php');
    require_once('classes/db_mysql.php');
    require_once('classes/html.php');
    require_once('classes/mail.php');

    require_once('contents/header.php');
    require_once('contents/content.php');
    require_once('contents/footer.php');

    echo $html->format_htmlblock( $htmlblock );
?>
