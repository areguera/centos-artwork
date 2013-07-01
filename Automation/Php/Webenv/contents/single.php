<div id="content">

<?php
/***
 * Content Template
 */


// Initialize variables
if ( isset($_GET['p']) ) {

    $id = $_GET['p'];
    $file = "pages/p_$id.php";

    // Check file 
    if (file_exists($file)) 
    {
        if (is_readable($file)) 
        {
            include($file);
        } 
        else {
            echo "<p>The page $id isn't readable!</p>";
        }

    } 
    else {
        echo "<p>The page $id doesn't exist!</p>";
    }

} 
else {

    $id = 0;
    include("pages/p_index.php");

}

// Validate id value

?>

</div>
