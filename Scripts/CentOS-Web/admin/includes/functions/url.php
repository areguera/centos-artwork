<?php
/***
 * URL's functions
 *
 */


//-----------/* Sanitize URL variables */
    
    function sanitize_url_var( $name )
    {
        if ( ! preg_match( '/^(page|action|id)$/', $name ) )
        {
            return false;
        }

        switch ( $name )
        {
            case 'page': 
                if ( isset($_GET[$name]) && preg_match( '/^(users|pages|categories|comments|entries|links)$/', $_GET[$name] ) )
                {
                    return true;
                }
                else
                {
                    return false;
                }
            break;

            case 'action':
                if ( isset( $_GET[$name] ) && preg_match( '/^(update|add|tree|logout)$/', $_GET[$name] ) )
                {
                    return true;
                }
                else
                {
                    return false;
                }
            break;

            case 'id':
                if ( isset( $_GET[$name] ) && preg_match( '/^[0-9]+$/', $_GET[$name] ) )
                {
                    return true;
                }
                else
                {
                    return false;
                }
            break;
        }
    }
?>
