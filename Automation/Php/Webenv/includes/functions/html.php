<?php

/*
 * HTML Functions
 *
 */

// Display header template
function get_html_header()
{
    require_once(ABSPATH . 'contents/header.php');
}
// Display content template
function get_html_content()
{
    require_once(ABSPATH . 'contents/content.php');
}
// Display sidebar template
function get_html_sidebar()
{
    require_once(ABSPATH . 'contents/sidebar.php');
}
// Display footer template
function get_html_footer()
{
    require_once(ABSPATH . 'contents/footer.php');
}

// Display Mainlinks (to Pages)
function get_html_mainlinks()
{

    $mainlinks = array ();
    $mainlinks[1] = 'donaciones';
    $mainlinks[2] = 'documentacion';
    $mainlinks[3] = 'wiki';
    $mainlinks[4] = 'foros';

    $html = '<ul class="mainlinks">' . "\n";

    if (!isset($_GET['p']))
    { 

        $html .= '<li class="current"><a href="index.php">' .  strtoupper(translate('home')) . '</a></li>' . "\n";

    } 
    else 
    {
        $html .= '<li><a href="index.php">' . strtoupper(translate('home')) . '</a></li>' . "\n";
    }

    foreach ($mainlinks as $key => $value) 
    {
        if (isset($_GET['p']) && $_GET['p'] == $key) 
        {
            $html .= '<li class="current"><a href="?p='.$key.'">' . strtoupper($value). "</a></li>" . "\n";
        } 
        else 
        {
            $html .= '<li><a href="?p='.$key.'">' . strtoupper($value). "</a></li>" . "\n";
        }
    }

$html .= '</ul>' . "\n";
return $html;

}

 // Display promotions
function get_html_promo()
{
    $promotion = array();
    $promotion['CentOS-5 Releases'] = 'Information about CentOS-5 releases will be displayed here. <a href="">Read more ...</a>';
    $promotion['CentOS-4 Releases'] = 'Information about CentOS-5 releases will be displayed here. <a href="">Read more ...</a>';
    $promotion['CentOS-3 Releases'] = 'Information about CentOS-5 releases will be displayed here. <a href="">Read more ...</a>';
    $promotion['CentOS-2 Releases'] = 'Information about CentOS-5 releases will be displayed here. <a href="">Read more ...</a>';

    $counter = 0;
    $last_promotion = count($promotion) -1;

    echo '<div class="pageline"></div>' . "\n";

    foreach ( $promotion as $key => $value )
    {

    // Set first promoblock
    switch ($counter) 
    {
        case 0:
        $html = '<div class="promoblock first">';
            break;
    
        case $last_promotion:
        $html .= '<div class="promoblock last">';
        break;
    
        default:
        $html .= '<div class="promoblock">';
    } 

    $html .= '<h3>' . $key . '</h3>' . "\n";
    $html .= '<p>' . $value . '</p>' . "\n";
    $html .= '</div>';

    $counter++;
    }

return $html; 

}

function get_html_searchform()
{
    $html = '<div class="searchform">';
    $html .= '<form action="" method="post">';
    $html .= '<input id="searchinput" type="text" name="search" value="" onfocus="searchChange(this)" onblur="searchBlur(this)">';
    $html .= '<input type="submit" value="'.ucfirst(translate('find')).'">';
    $html .= '</form>';
    $html .= '</div>';

    return $html;
}

// Build 404 page not found error
function get_html_err($err_id = '404', $err_msg = 'Page not found', $err_descrip = '')
{
    $html = '<h1>' . $err_id . ': ' . ucfirst($err_msg) . '</h1>' . "\n";
    $html .= '<p>' . $err_descrip. '</p>';
    return $html;
}

?>
