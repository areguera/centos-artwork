<?php
/**
 * User related functions
 *
 */


//---------------------/* Define user's roles */

 function get_user_roles()
 {
    // First array value ("writer" in this case) define the default value.
    $employeetype = array('writer', 'administrator');

    return $employeetype;
 }

//---------------------/* Define user's attributes */

 function get_user_attributes()
 {
    $attributes = array('dn', 'objectclass', 'uid', 'employeetype', 
                        'sn', 'preferredlanguage', 'userpassword', 
                        'displayname', 'mail', 'cn');

    return $attributes;
 }

//---------------------/* Define user's languages */

 function get_user_languages()
 {
    $languages = array('en' => 'English', 
                       'es' => 'Español',
                       'fr' => 'Français');

    return $languages;
 }

//---------------------/* Determine user's role */

 function is_user( $role )
 {
    if ( $_SESSION['employeetype'] == $role )
    {
        return true;
    }
    else
    {
        return false;
    }
 }

//---------------------/* User Role-Selector */

function get_user_roleSelector( $id = '', $entry_value = '' )
{
    $employeetypes = get_user_roles();

    if ( ! is_int($id) )
    {
        $html = '<select name="employeetype">';
    }
    else
    {
        $html = '<select name="employeetype['. $id . ']">';
    }

    foreach ($employeetypes as $value )
    {
        if ( $entry_value <> '' && $value == $entry_value )
        {
            $html .= '<option selected value="'.$value.'">'.ucfirst(translate($value)).'</option>';
        }
        else
        {
            $html .= '<option value="'.$value.'">'.ucfirst(translate($value)).'</option>';
        }
    }

    $html .= '</select>';

    return $html;
}

//---------------------/* User Attribute-Selector */

function get_user_attrSelector( $attr = '/(uid|cn|preferredlanguage|employeetype)/' )
{
    global $ldap;

    $clean['attrb'] = $ldap->sanitize_filter_attribute();

    $attributes = get_user_attributes();

    $html = '<select name="attribute">';

    foreach ( $attributes as $value )
    {
        if ( preg_match ( $attr, $value ) )
        {
            if ( $clean['attrb'] == $value )
            {
                $html .= '<option selected value="'.$value.'">' . ucfirst(translate($value)) . '</option>';
            }
            else
            {
                $html .= '<option value="'.$value.'">' . ucfirst(translate($value)) . '</option>';
            }
        }

    }

    $html .= '</select>';

    return $html;
}

//---------------------/* User Language-Selector */

function get_user_langSelector( $id = '', $entry_value = '' )
{
    $languages = get_user_languages();

    if ( isset($id) && is_int($id) )
    {
        $html = '<select name="preferredlanguage['. $id . ']">';
    }
    else
    {
        $html = '<select name="preferredlanguage">';
    }

    foreach ($languages as $key => $value )
    {
        if ( ( $entry_value <> '' && $key == $entry_value ) || ( $id == '' && $entry_value == '' && $key == LANGUAGE ) )
        {
            $html .= '<option selected value="'.$key.'">'.ucfirst(translate($value)).'</option>';
        }
        else
        {
            $html .= '<option value="'.$key.'">'.ucfirst(translate($value)).'</option>';
        }
    }

    $html .= '</select>';

    return $html;
}

//-------/* Build useradd's form */

function show_useradd_form( $entry )
{
   $html = '<div class="formfields">';
   $html .= '<form name="useradd" action="" method="post">';

   $html .= '<ul>';
   $html .= '<li class="description">' . ucfirst(translate('uid')) .':</li>';
   $html .= '<li class="value"><input type="text" name="uid" value="' . $entry['uid'] . '" size="30" /> ' . ucfirst(translate('ex')) . '. john@example.com</li>';
   $html .= '<li class="description">' . ucfirst(translate('password')) . ':</li>';
   $html .= '<li class="value"><input type="password" name="userpassword" value="" size="30" /></li>';
   $html .= '<li class="description">'. ucfirst(translate('cn')) . ':</li>';
   $html .= '<li class="value"><input type="text" name="cn" value="' . $entry['cn'] . '" size="30" /></li>';
   $html .= '<li class="description">'. ucfirst(translate('displayname')) . ':</li>';
   $html .= '<li class="value"><input type="text" name="displayname" value="' . $entry['displayname'] . '" size="30" /></li>';
   $html .= '<li class="description">'. ucfirst(translate('preferredlanguage')) . ':</li>';
   $html .= '<li class="value">' . get_user_langSelector() . '</li>';
   $html .= '<li class="description">' . ucfirst(translate('employeetype')) . ':</li>';
   $html .= '<li class="value">'. get_user_roleSelector() . '</li>';
   $html .= '<li class="submit"><input type="submit" name="useradd" value="' . ucfirst(translate('add')) . '" /></li>';
   $html .= '</ul>';

   $html .= '</form>';
   $html .= '</div>';

   return $html;
}

//-------/* Show useradmin form

    function show_useradmin_form()
    {
   
        

    }

?>
