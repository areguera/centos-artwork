<?php
//--------------------/* Show error if called directly */

    if ( basename($_SERVER['PHP_SELF']) <> 'index.php')
    {
        echo '<h3>Sorry, this page can\'t be served directly. ';
        echo 'Try <a href="index.php">this instead</a>.</h3>';
        exit;
    }
?>
<h1>
    <?php echo ucfirst(translate(strtolower('hello')))?> 
    <?php echo preg_replace('/ .*$/','',$_SESSION['cn'])?>
</h1>

<p><strong>Database Status:</strong> <?php echo $db->check_connection();?></p>
<p><?php echo ucfirst(translate(strtolower('admin_info_1')))?></p>
