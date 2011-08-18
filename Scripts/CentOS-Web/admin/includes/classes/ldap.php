<?php
/**
 * LDAP Access
 *
 * @category   Logic
 * @package    CentOS-News
 * @author     Alain Reguera Delgado <alain.reguera@gmail.com>
 * @copyright  2009 - CentOS Artwork SIG.
 * @license    GPL
 */

class LDAP
{

    var $ldapconn;
    var $ldapbind;

    // LDAP Filter Attributes
    var $filter_attrb                     = array();
    var $filter_type                      = array();
    var $filter_clean                     = array();

//-----------/* Class initializations

    function __construct()
    {
        // Open connection against ldap server
        $this->ldapconn = ldap_connect(LDAP_HOST,LDAP_PORT) or die("Could not connect to " . LDAP_HOST . ".");

        // Set protocol version to use
        ldap_set_option($this->ldapconn, LDAP_OPT_PROTOCOL_VERSION, 3) or die("Could not connect to server through LDAPv3.");

        // Bind
        $this->ldapbind = ldap_bind( $this->ldapconn, LDAP_ROOTDN, LDAP_ROOTPW ); 
        
        // Initialize ldap filter attributes
        $this->filter_attrb['cn']                   = 'cn';
        $this->filter_attrb['uid']                  = 'uid';
        $this->filter_attrb['employeetype']         = ucfirst(translate('employeetype'));
        $this->filter_attrb['preferredlanguage']    = ucfirst(translate('language'));

        // Initialize ldap filter Types
        $this->filter_type['=']                     = '=';
        $this->filter_type['~=']                    = '~=';

        // Initialize ldap filter default
        $this->filter_clean['attrb']                = 'preferredlanguage';
        $this->filter_clean['type']                 = '=';
        $this->filter_clean['value']                = LANGUAGE;
    }

//----------- Get entries from ldap server

    function get_entries( $filter )
    {
        // Return entries just if filter valid
        $search = ldap_search($this->ldapconn,LDAP_DN,$filter);
        $entries = ldap_get_entries($this->ldapconn,$search);
        return $entries;
    }

//----------// Validate filter value input
            // Sanitize filter pattern - Attributes

    function is_valid( $name , $value )
    {
        switch ( $name )
        {
            case 'uid': 
                $pattern = '/^([a-z0-9_]|\-|\.)+@(([a-z0-9_]|\-)+\.)+([a-z]{2,6})?$/';
                break;

            case 'preferredlanguage': 
                $pattern = '/^[a-zA-Z]{2}$/';
                break;

            case 'filtertype': 
                $pattern = '/^(=|~=)$/';
                break;

            case 'employeetype':
                $pattern = '/^(writer|administrator)$/';
            break;

            default: 
                $pattern = '/^[a-zA-Z0-9_áéíóñúàçèé ]+$/';
                break;
        }

        if ( isset( $pattern ) && preg_match( $pattern , $value ))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

//---------- Check filter attributes */

    function sanitize_filter_attribute()
    {
        $dirty = array();
        $clean = array();

        // Initialize dirty attribute
        $dirty['attrb'] = $this->filter_clean['attrb'];

        // Initialize clean attribute
        $clean['attrb'] = $this->filter_clean['attrb'];

        // Recover dirty attribute values from filter form
        if ( isset( $_POST['attribute'] ) )
        {
            $dirty['attrb'] = $_POST['attribute'];
        }

        // Check dirty attribute
        if ( array_key_exists( $dirty['attrb'], $this->filter_attrb ) )
        {
            // Attribute is not dirty any more. It passed validation.
            $clean['attrb'] = $dirty['attrb'];
        }

        return $clean['attrb'];
    }

//---------- Check filter types

    function sanitize_filter_type()
    {
        $dirty = array();
        $clean = array();

        $dirty['type'] = $this->filter_clean['type'];
        $clear['type'] = $this->filter_clean['type'];

        // Recover dirty type values from filter form
        if ( isset( $_POST['type'] ) )
        {
            $dirty['type'] = $_POST['type'];
        }
        else
        {
            $dirty['type'] = $this->filter_clean['type'];
        }

        // Check dirty types
        if ( array_key_exists( $dirty['type'], $this->filter_type ) )
        {
            // Type is not dirty any more. It passed validation.
            $clean['type'] = $dirty['type'];
        }

        return $clean['type'];
    }

//---------- Sanitize filter value

    function sanitize_filter_value()
    {
        $dirty = array();
        $clean = array();

        $dirty['value'] = $this->filter_clean['value'];
        $clean['value'] = $this->filter_clean['value'];

        // Recover dirty value from filter form
        if ( isset( $_POST['value'] ) )
        {
            $dirty['value'] = $_POST['value'];
        }

        // Sanitize dirty value, based on supplied attribe
        $name  = $this->sanitize_filter_attribute();
        $value = $dirty['value'];

        if ( $this->is_valid( $name, $value ) )
        {
            // Value is not dirty any more. It passed validation.
            $clean['value'] = $value;
        }

        return $clean['value'];
    }

//---------- Build ldap form filter

    function show_filter()
    {
        $clean = array();

        $clean['attrb'] = $this->sanitize_filter_attribute();
        $clean['type']  = $this->sanitize_filter_type();
        $clean['value']  = $this->sanitize_filter_value();

        // Start html form
        $html = '<div class="filter">';
        $html .= '<form name="filter" method="post" action="">';

        // Build html form fileds. Start with some text
        $html .= ucfirst(translate('filtering by')) . ': ';

        // Build attributes' select form field
        $html .= get_user_attrSelector();

        // Build types' select form field
        $html .= '<select name="type">';
        foreach ($this->filter_type as $key => $value)
        {
            if ($clean['type'] == $key )
            {
                $html .= '<option selected value="'.$key.'">' . $value . '</option>';
            }
            else
            {
                $html .= '<option value="'.$key.'">' . $value . '</option>';
            }
        }
        $html .= '</select>';

        // Build value's text form field
        $html .= '<input type="text" name="value" value="'.$clean['value'].'">';

        // Build submit form button
        $html .= '<input type="submit" name="submit_filter" value="'.ucfirst(translate('filter')).'">';

        // End html form
        $html .= '</form>';
        $html .= '</div>';
        
        return $html;
    }

//---------- Build ldap filter string

    function build_filter_string()
    {
        $clean['attrb'] = $this->sanitize_filter_attribute();
        $clean['type']  = $this->sanitize_filter_type();
        $clean['value']  = $this->sanitize_filter_value();

        return $clean['attrb'] . $clean['type'] . $clean['value'];

    }

//----------- Check uniqueness of uid attribute */

    function is_uid_present( $uid )
    {
        // Verify that uid entry's value be unique
        $filter     = 'uid=' . $uid;
        $entry      = $this->get_entries($filter);

        if ( $uid != '' && $entry['count'] == 1 )
        {
            return true;
        }
        else
        {
            return false;
        }
    }

//---------- Prepare userPassword

    function prepare_userpassword( $userpassword )
    {
        $dirty['userpassword'] = $userpassword;

        switch ( LDAP_PASSHASH )
        {
            case '{MD5}':
            $clean['userpassword'] = LDAP_PASSHASH . base64_encode( pack( 'H*', md5( $dirty['userpassword'] ) ) );
            break;
    
            case '{SHA}':
            $clean['userpassword'] = LDAP_PASSHASH . base64_encode( pack( 'H*', sha1( $dirty['userpassword'] ) ) );
            break;
        }

        return $clean['userpassword'];
    }

//-----------/* Verify modifiable attributes
             /* Description : Generally used to redifine entry's input keys and values,
             /*               based on is_valid() */
             /*      $entry : is an array with entry's keys and values. */

    function sanitize_entry( $entry )
    {
        // Define attributes that can be modified
        $fields = array('uid', 'cn','userpassword','displayname','preferredlanguage','employeetype');

        // Verify and validate entry's attributes
        foreach ( $fields as $key )
        {
            if ( isset( $entry[$key] ) && $this->is_valid( $key, $entry[$key] ) ) 
            {
                // Values that reach this point may be concider "clean".
                $clean['entry'][$key] = $entry[$key];
            }
        }

        // Return clean entry array or false
        if ( isset( $clean['entry'] ) && is_array( $clean['entry'] ) )
        {
            return $clean['entry'];
        }
        else
        {
            return false;
        }
    }

//----------/* Initialize useradd values.
            /* Description: Used in the useradd form page to initiate form values.
            /* $attribute : is an array with the related attributes to check. */

   function init_useradd_values( $attributes )
   {
        foreach ( $attributes as $key )
        {   
            if ( ! isset( $_POST[$key] ) )
            {
                $entry[$key] = ''; 
            }
            else
            {
                if ( isset( $_POST[$key] ) && $this->is_valid($key, $_POST[$key]) )
                {
                    $entry[$key] = $_POST[$key];
                }
                else
                {
                    $entry[$key] = '';
                }   
            }   
        }   
        return $entry;
   }

//----------/* Initialize useradmin values and do action if submited 
            /* values are different from the actual one.
            /* Description: used in the p_users.php to initiate form values.
            /*        $id : is the name of the form identification.
            /* $attribute : is an array with the related attributes to check. */

   function init_useradmin_values( $entry, $attributes, $action )
   {

        // First loop to match b in x[b]
        for ($i = 0; $i < $entry['count']; $i++)
        {
            if ( isset( $_POST['uid'][$i] ))
            {
                // Define entry id
                $entry_new['uid'] = $entry[$i]['uid'][0];

                // Initialize entry cn
                // Needed to update sn in the background.
                $entry_new['cn'] = $entry[$i]['cn'][0];

                // Second loop to match x in x[b]
                foreach ( $attributes as $key )
                {
                    // Reset entry value based on input 
                    if ( isset( $_POST[$key][$i] ) )
                    {
                        // Check it is a valid value
                        if ( $this->is_valid( $key, $_POST[$key][$i] ) )
                        {
                            // ... and that it is different from the actual one
                            if ( $_POST[$key][$i] != $entry[$i][$key][0] )
                            {
                
                                $entry_new[$key] = $_POST[$key][$i];

                                // Prepare userPassword.
                                // SECURITY: this attribute value should never
                                // be verified with the previous one. If
                                // verification is done you are providing a
                                // way to "guess" the user password by trying
                                // passwords until someone reject to update.
                                // Not to critic but if you guess it at the
                                // first try ;). Keep it unverifiable please.
                                if ( $key == 'userpassword' )
                                {
                                    $newpasswd = $this->prepare_userpassword($_POST[$key][$i]);
                                    $entry_new[$key] = $newpasswd;
                                }
                            }
                        }
                    }
                }
            }

            // Do action if pressent
            if ( isset( $entry_new ) )
            {
                $message = $this->do_action( $entry_new, $action );
            }
            else
            {
                $message = show_message(ucfirst(translate('nothing to do')), 'orange');
            }
        }

        return $message;
   }

//-----------/*  Do actions (udpate|delete|add) 
             /*       $entry : is an array with the entry's key and value information.
             /*      $action : is an string telling what to do with the $entry.
             /*  Description : Actions are applied to just one entry at the same time. */
             /*                The returned value is a message telling what happend with 
                               the action requested.*/

    function do_action( $entry, $action )
    {
        // Define Entry's DN
        if ( isset( $entry['uid'] ) && $this->is_valid( 'uid', $entry['uid'] ) )
        {
            $dn = 'uid=' . $entry['uid'] . ',' . LDAP_DN;
        }
        else
        {
            $message = show_message(ucfirst(translate('a valid uid is required')),'orange');
            return $message;
        }
                
        // Define possible actions
        $possible_actions = '/^(add|update|delete)$/';
        if ( ! preg_match( $possible_actions, $action ) )
        {
            // There is nothing to do here so exit to finish action intention.
            $message = show_message(ucfirst(translate('invalid action')), 'red');
            return $message;
        }

        // Define what to do in each action's case 
        switch ( $action )
        {
            case 'update':

                // If there are valid values then do the update action.
                if ( is_array( $entry ) )
                {
                    // Update sn attribute
                    $entry['sn'] = preg_replace('/^([a-zA-Z0-9_]+ ?)/','', $entry['cn']);
                    if ( $entry['sn'] == '' )
                    {
                        $message = show_message(ucfirst(translate('invalid cn')), 'orange');
                        return $message;
                    }

                    if (ldap_modify($this->ldapconn, $dn, $entry))
                    {
                        $message = show_message(ucfirst(translate('data was updated successfully')), 'green');
                    }
                    else
                    {
                        $message = show_message(ucfirst(translate('data was not updated')), 'orange');
                    }
                }
            break;

            // Delete Entry
            case 'delete':

                // Delete Entry
                if ( is_array( $entry ) )
                {
                    if ( ldap_delete( $this->ldapconn, $dn ) )
                    {
                        $message = show_message(ucfirst(translate('data was deleted successfully')), 'green');
                    }
                    else
                    {
                        $message = show_message(ucfirst(translate('data was not deleted')), 'orange');
                    }
                }
            break;

            // Add Entry
            case 'add':

                // Verify uid presence
                if ( $this->is_uid_present( $entry['uid'] ) )
                {
                    // Abort this action commitment.
                    $message = show_message(ucfirst(translate('user identifier already exists')), 'orange');
                    return $message;
                }
                
                // Define and validate required attributes
                $require_attrs = array('uid', 'userpassword', 'cn', 'displayname', 'preferredlanguage', 'employeetype');
                foreach ( $require_attrs as $key )
                {
                    if ( !isset($entry[$key]) || ! $this->is_valid($key, $entry[$key]))
                    {
                        $message = show_message(ucfirst(translate('the field')) .' '. translate($key) .' ' . translate('requires a valid value') , 'orange');
                        return $message;
                    }
                }

                // Prepare userPassword and other attributes.
                $entry['userpassword'] = $this->prepare_userpassword($entry['userpassword']);
                $entry['objectclass']  = 'inetOrgPerson';
                $entry['sn']           = preg_replace('/^([a-zA-Z0-9_]+ ?)/','', $entry['cn']);
                if ( $entry['sn'] == '' )
                {
                    $message = show_message(ucfirst(translate('invalid cn')), 'orange');
                    return $message;
                }
                $entry['mail']         = $entry['uid'];

                // If there are valid values then do the add action.
                if ( ldap_add( $this->ldapconn, $dn, $entry ) )
                {
                    $message = show_message(ucfirst(translate('user added successfully')), 'green');
                }
                else
                {
                    $message = show_message(ucfirst(translate('user was not added')), 'orange');
                }
            break;
        }

        return $message;
    }

//-------------------/*  Rename entry dn */

    function rename_dn( $olddn, $newdn, $newparent, $deleteoldrdn )
    {
        ldap_rename($this->ldapconn, $olddn, $newdn, $newparent, $deleteoldrdn ); 

        return true;
    }

//-----------/* Display useradmin information
             /* Description : Used in p_users.php
             /*    $entries : is an array with the entries' keys and values. */

    function show_useradmin_info( $entries )
    {
        $html = '<ul>';
        $html .= '<li>LDAP Host: ' . LDAP_HOST . '</li>';
        $html .= '<li>Domain Component (dc): ' . LDAP_DN . '</li>';
        $html .= '<li>' . $this->show_filter() .'</li>';
        $html .= '<li>' . ucfirst(translate('results')) . ': '. $entries['count']; '</li>';
        $html .= '</ul>';

        return $html;
    }

//-------------------/*  Close connection */

    function __destruct()
    {
        if ( isset( $this->ldapconn ) ) 
        {
            ldap_unbind( $this->ldapconn );
        }
    }

}

$ldap = new LDAP;
?>
