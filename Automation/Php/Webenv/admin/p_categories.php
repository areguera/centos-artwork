<?php
//--------------------/* Show error if called directly */

    if ( basename($_SERVER['PHP_SELF']) <> 'index.php')
    {
        echo '<h3>Sorry, this page can\'t be served directly. ';
        echo 'Try <a href="index.php?p=categories&a=cat">this instead</a>.</h3>';
        exit;
    }

//----- Admin categories

    $message = admin_categories();

//----- Get Row

    $sql_string = "SELECT id, name, parent, description FROM categories ORDER BY name;";
    $rows = $db->query( $sql_string );

//----- Show action results

    if ( isset( $message ) )
    {
        echo $message; 
    }
?>



<h1><?php echo ucfirst(translate(strtolower('admin')))?> <?php echo translate(strtolower('categories'))?></h1>

<hr />
<?php echo get_categories_admin_form( $rows ) ?>
<hr />
