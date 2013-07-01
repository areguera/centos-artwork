<?php
/***
 * Mainlinks used in administratoristration interface
 *
 * @param show_mainlink();
 * @param control link visibility/availability.
 */

 function show_mainlinks()
 {

 //--------------------/* Initialize Link Array */
 
    $link = array();

    // User should have writer access to see the following links.
    if ( is_user('writer') || is_user('administrator')  )
    {
        $link['entries']                = ucfirst(translate('entries'));
    }

    // User should have administrator rights to see the following links.
    if ( is_user('administrator') )
    {
        $link['pages']                  = ucfirst(translate('pages'));
        $link['categories']             = ucfirst(translate('categories'));
        $link['comments']             = ucfirst(translate('comments'));
        $link['links']                  = ucfirst(translate('links'));
        $link['users']                  = ucfirst(translate('users'));
    }

 //-----------/* Sanitize URL variables */

    if ( sanitize_url_var('page') )
    {
        $url['page'] = $_GET['page'];
    }

 //--------------------/* Build html links */

    $html = '<ul class="mainlinks">';

    if ( isset($url['page'] ) )
    {
        $html .= '<li><a href="index.php">'. strtoupper(translate('home')) . '</a></li>';
    } 
    else 
    {
        $html .= '<li class="current"><a href="index.php">'. strtoupper(translate('home')) . '</a></li>';
    }

    foreach ($link as $key => $value) 
    {
        if ( isset($url['page']) && $url['page'] == $key) 
        {
            $value = translate(strtolower($key));
            $html .= '<li class="current"><a href="?page='.$key.'">' . strtoupper($value). '</a></li>';
        } 
        else
        {
            $value = translate(strtolower($key));
            $html .= '<li><a href="?page='.$key.'">' . strtoupper($value). '</a></li>';
        }
    }

    $html .= '</ul>';

    return $html;
 }

/***
 * Sublinks used in the administratoristration interface
 *
 * @param show_sublink();
 * @param control link visibility/availability.
 */

function show_sublinks()
{

//-----------/* Initialize Link Array */
 
    $link = array();

    $link['entries']                = ucfirst(translate('entries'));
    $link['pages']                  = ucfirst(translate('pages'));
    $link['categories']             = ucfirst(translate('categories'));
    $link['links']                  = ucfirst(translate('links'));
    $link['users']                  = ucfirst(translate('users'));

//-----------/* Sanitize URL variables */

    if ( sanitize_url_var('page') )
    {
        $url['page'] = $_GET['page'];
    }

//-----------/* Build html links */

    $html = '<div class="sublinks">';
    $html .= '<ul>';

if ( isset( $url['page'] ) )
{
    switch ($url['page']) 
    {

        case 'entries':
            if ( is_user('writer') == 'true' || is_user('administrator') == 'true' )
            {
                $html .= '<li><a href="?page=entries">' . ucfirst(translate(strtolower('admin'))) . ' ' . translate(strtolower('entries')) . '</a></li>';
                $html .= '<li><a href="?page=entries&action=add">' . ucfirst(translate(strtolower('add'))) . ' ' . translate(strtolower('entry')) . '</a></li>';
            }
            break;

        case 'pages':
            if ( is_user('administrator') == 'true' )
            {
                $html .= '<li><a href="?page=pages">' . ucfirst(translate(strtolower('admin'))) . ' ' . translate(strtolower('pages')) . '</a></li>';
                $html .= '<li><a href="?page=pages&action=add">' . ucfirst(translate(strtolower('add'))) . ' ' . translate(strtolower('page')) . '</a></li>';
            }
            break;

        case 'categories':
            if ( is_user('administrator') == 'true' )
            {
                $html .= '<li><a href="?page=categories">' . ucfirst(translate(strtolower('admin'))) . ' ' . translate(strtolower('categories')) . '</a></li>';
                $html .= '<li><a href="?page=categories&action=add">' . ucfirst(translate(strtolower('add'))) . ' ' . translate(strtolower('category')) . '</a></li>';
                $html .= '<li><a href="?page=categories&action=tree">' . ucfirst(translate(strtolower('category tree'))) . '</a></li>';
            }
            break;

        case 'comments':
            if ( is_user('administrator') == 'true' )
            {
                $html .= '<li><a href="?page=comments">' . ucfirst(translate(strtolower('admin'))) . ' ' . translate(strtolower('comments')) . '</a></li>';
                $html .= '<li><a href="?page=comments&action=add">' . ucfirst(translate(strtolower('add'))) . ' ' . translate(strtolower('comment')) . '</a></li>';
            }
            break;

        case 'links':
            if ( is_user('administrator') == 'true' )
            {
                $html .= '<li><a href="?page=links">' . ucfirst(translate(strtolower('admin'))) . ' ' . translate(strtolower('links')) . '</a></li>';
                $html .= '<li><a href="?page=links&action=add">' . ucfirst(translate(strtolower('add'))) . ' ' . translate(strtolower('link')) . '</a></li>';
            }
            break;

        case 'users':
            if ( is_user('administrator') == 'true' )
            {
                $html .= '<li><a href="?page=users">' . ucfirst(translate(strtolower('admin'))) . ' ' . translate(strtolower('users')) . '</a></li>';
                $html .= '<li><a href="?page=users&action=add">' . ucfirst(translate(strtolower('add'))) . ' ' . translate(strtolower('user')) . '</a></li>';
            }
            break;
    
        }
    }

    $html .= '</ul>';
    $html .= '</div>';

    return $html;
 }
?>
