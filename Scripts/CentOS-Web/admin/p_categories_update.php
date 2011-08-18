<?php
//--------------------/* Show error if called directly */

    if ( basename($_SERVER['PHP_SELF']) <> 'index.php')
    {
        echo '<h3>Sorry, this page can\'t be served directly. ';
        echo 'Try <a href="index.php?p=categories">this instead</a>.</h3>';
        exit;
    }

//---- Do action and grab results

    if (isset($_POST['action']))
    {
        $message = admin_categories();
        if (isset($message))
        {
            echo $message;
        }
    }

?>

<h1><?php echo ucfirst(translate(strtolower('update')))?> <?php echo translate(strtolower('category'))?></h1>

<?php echo get_categories_update_form(); ?>
