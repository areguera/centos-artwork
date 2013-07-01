<?php
/***
 * Content Template
 *
 */

//-----------/* Show error if called directly */

    if ( basename( $_SERVER['PHP_SELF'] ) <> 'index.php')
    {
        echo '<h3>Sorry, this page can\'t be served directly. ';
        echo 'Try <a href="index.php">this instead</a>.</h3>';
        exit;
    }

//-----------/* Sanitize URL variables */

    foreach ( $_GET as $key => $value )
    {
        if ( sanitize_url_var($key) )
        {
            $url[$key] = $value;
        }
    }

//----------/* Page Selector */

    if ( isset( $url['page'] ) ) 
    {
        switch ( $url['page'] )
        {
            case 'entries':
                /* Build relation between "Entries" sublinks and its pages */
                if ( isset($url['action'] ) ) 
                {
                    switch ( $url['action'] ) 
                    {
                        case "add":
                            $page = 'p_entries_add.php';
                            break;
    
                        case "update":
                            $page = 'p_entries_update.php';
                            break;
                    }
                }
                else
                {
                    $page = 'p_entries.php';
                }
                break;
        
                case 'pages':
                    // Just if user has admin rights.
                    if ( is_user('administrator') )
                    {
                        /* Build relation between "Pages" sublinks and its pages */
                        if ( isset($url['action'] ) ) 
                        {
                            switch ( $url['action'] ) 
                            {
                                case 'add':
                                    $page = 'p_pages_add.php';
                                        break;
                                    
                                case 'update':
                                    $page = 'p_pages_update.php';
                                    break;
                            }
                        }
                        else
                        {
                            $page = 'p_pages.php';
                        }
                    }
                    break;
        
                case 'categories':
                    // Just if user has admin rights.
                    if ( is_user('administrator') )
                    {
                        /* Build relation between "Categories" sublinks and its pages */
                        if ( isset($url['action'] ) ) 
                        {
                            switch ( $url['action'] )
                            {
                                case 'add':
                                    $page = 'p_categories_add.php';
                                    break;
                                case 'update':
                                    $page = 'p_categories_update.php';
                                    break;
                                case 'tree':
                                    $page = 'p_categories_tree.php';
                                    break;
                            }
                        }
                        else
                        {
                           $page = 'p_categories.php'; 
                        }
                    }
                    break;

                case 'comments':
                    // Just if user has admin rights.
                    if ( is_user('administrator') )
                    {
                        /* Build relation between "Links" sublinks and its pages */
                        if ( isset($url['action'] ) ) 
                        {
                            switch ( $url['action'] )
                            {
                                case 'add':
                                    $page = 'p_comments_add.php';
                                    break;
                                case 'update':
                                    $page = 'p_comments_update.php';
                                    break;
                            }
                        }
                        else
                        {
                            $page = 'p_comments.php'; 
                        }
                    }
                    break;
                
                case 'links':
                    // Just if user has admin rights.
                    if ( is_user('administrator') )
                    {
                        /* Build relation between "Links" sublinks and its pages */
                        if ( isset($url['action'] ) ) 
                        {
                            switch ( $url['action'] )
                            {
                                case 'add':
                                    $page = 'p_links_add.php';
                                    break;
                            }
                        }
                        else
                        {
                            $page = 'p_links.php'; 
                        }
                    }
                    break;
        
                case 'users':
                    // Just if user has admin rights.
                    if ( is_user('administrator') )
                    {
                        /* Build relation between "Links" sublinks and its pages */
                        if ( isset($url['action'] ) ) 
                        {
                            switch ( $url['action'] )
                            {
                                case 'add':
                                    $page = 'p_users_add.php';
                                    break;
                            }
                        }
                        else
                        {
                            $page = 'p_users.php';
                        }
                    }
                    break;
    
                default:
                    $page = 'p_index.php';
                    break;
            }
        }
        else
        {
            $page = 'p_index.php'; 
        }

//--------/* Verify file before include it

    if ( file_exists( ABSPATH . 'admin/' . $page ) )
    {
        include (ABSPATH . 'admin/' . $page );
    }
?>
