<?php
//--------------------/* Show error if called directly */

    if ( basename($_SERVER['PHP_SELF']) <> 'index.php')
    {
        echo '<h3>Sorry, this page can\'t be served directly. ';
        echo 'Try <a href="index.php?p=pages&a=add">this instead</a>.</h3>';
        exit;
    }
?>
<h1><?php echo ucfirst(translate(strtolower('add')))?> <?php echo translate(strtolower('page'))?></h1>
