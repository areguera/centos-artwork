<div id="content">

    <?php echo get_html_sidebar(); ?>

	<div class="columnl">

    <hr />

<?php
/***
 * Content Template
 */

// Get page content
// NOTE: For testing purposes I'll use an array. This should 
//       be replaced by database entries.
$page = array();

$page[1] = '<h1>Donaciones</h1><p>Esta es la pagina de las donaciones</p>';
$page[2] = '<h1>Documentacion</h1><p>Esta es la pagina de la documentacion.</p>';
$page[3] = '<h1>Wiki</h1><p>Esta es la pagina de la wiki.</p>';
$page[4] = '<h1>Foros</h1>Esta es la pagina de los foros.</p>';

// Initialize variables
if ( isset($_GET['p']) ) {

    // If $_GET['p'] is set the content shown is the pages one.
    $id = htmlspecialchars($_GET['p']);

    echo $page[$id];
}
else
{
    // If $_GET['p'] is not set the content shown is the entries's loop.
    echo get_html_err();
}

// Validate id value

?>

</div>
</div>
