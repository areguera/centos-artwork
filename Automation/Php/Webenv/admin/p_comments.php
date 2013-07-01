<?php
//--------------------/* Show error if called directly */

    if ( basename($_SERVER['PHP_SELF']) <> 'index.php')
    {
        echo '<h3>Sorry, this page can\'t be served directly. ';
        echo 'Try <a href="index.php?page=comments">this instead</a>.</h3>';
        exit;
    }

//----- Admin categories


//----- Get Row


//----- Show action results

    if ( isset( $message ) )
    {
        echo $message; 
    }
?>



<h1><?php echo ucfirst(translate(strtolower('admin')))?> <?php echo translate(strtolower('comments'))?></h1>

<hr />
<hr />
