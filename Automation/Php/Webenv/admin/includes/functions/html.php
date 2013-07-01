<?php
/***
 * Function collection for html admin needs
 *
 * ...
 */

//-----------/* Show admonition
             /* Description: Useful to show actions results */
             /* $message : is an string with the message itself */
             /* $severity : may be green, orange, red, violet or blue */

    function show_message( $message , $severity = 'blue' )
    {
   
        $html = '<div class="message lm ' . $severity . '">';
        $html .= $message;
        $html .= '</div>';

        return $html;
    }

//-------/* Show action selector form field

    function show_action_field( $action = 'default' )
    {
        $html = ucfirst(translate('action')) . ': <select name="action">';
        switch ( $action )
        {
            case 'update':
                $html .= '<option value="update">' . ucfirst(translate('update')) . '</option>';
            break;

            case 'delete':
                $html .= '<option value="delete">' . ucfirst(translate('delete')) . '</option>';
            break;

            default:
                $html .= '<option value="update">' . ucfirst(translate('update')) . '</option>';
                $html .= '<option value="delete">' . ucfirst(translate('delete')) . '</option>';
        }
        $html .= '</select>';

        return $html;

    }
?>
