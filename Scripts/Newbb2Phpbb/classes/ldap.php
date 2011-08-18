<?php
/***
 * LDAP Access
 *
 * --
 * Alain Reguera Delgado <alain.reguera@gmail.com>
 ***/

class LDAP
{
    public $this_conn;
    public $this_host;
    public $this_port;
    public $this_rootdn;
    public $this_rootpw;
    public $this_authschema;
    public $this_basedn;

   /*** 
    * Class initialization
    */
    function __construct()
    {
        // Initialize configuration values
        $this->ldap_host       = 'localhost';
        $this->ldap_port       = '389';
        $this->ldap_rootdn     = 'cn=manager,dc=example,dc=com';
        $this->ldap_rootpw     = '';
        $this->ldap_authschema = '{MD5}';
        $this->ldap_basedn     = 'ou=people,dc=example,dc=com'; 

        // Reinitialize configuration values
        $config = array('ldap_host',   'ldap_port',      'ldap_rootdn', 
                        'ldap_rootpw', 'ldap_authschema','ldap_basedn');

        foreach ( $config as $param )
        {
            if ( ! isset($_SESSION[$param] ) )
            {
                $_SESSION[$param] = $this->$param;
            }   

            $_SESSION[$param] = isset($_POST[$param])?$_POST[$param]:$_SESSION[$param];

            $this->$param = $_SESSION[$param];
        }

        // Open connection against ldap server
        if ( $this->ldap_host && $this->ldap_port )
        {
            $this->ldap_conn = ldap_connect( $this->ldap_host, $this->ldap_port );
        }

        // Set protocol version to use LDAPv3 
        ldap_set_option( $this->ldap_conn, LDAP_OPT_PROTOCOL_VERSION, 3);
    }

   /***
    * LDAP configuration
    */
    function get_configForm( $disabled = "" )
    {
        $htmlblock = array();

        array_push( $htmlblock, 

        '<h2>LDAP configuration:</h2>', '<dl>',
        
        '<dt>Host:</dt>',
        '<dd><input type="text" name="ldap_host" value="'. $this->ldap_host . '" ' . $disabled . ' /></dd>',
        
        '<dt>Port:</dt>',
        '<dd><input type="text" name="ldap_port" value="' . $this->ldap_port.'" ' . $disabled . ' /></dd>',
        
        '<dt>Bind DN:</dt>',
        '<dd><input type="text" name="ldap_rootdn" value="'. $this->ldap_rootdn .'" size="50" ' . $disabled . ' /></dd>',
        
        '<dt>Base DN: </dt>',
        '<dd><input type="text" name="ldap_basedn" value="' . $this->ldap_basedn . '" size="50" ' . $disabled . ' /></dd>',
        
        '<dt>Bind Password: </dt>',
        '<dd><input type="password" name="ldap_rootpw" value="' . $this->ldap_rootpw.'" ' . $disabled . ' /></dd>',
        
        
        '<dt>Schema: </dt>',
        '<dd>',
        '<select name="ldap_authschema" ' . $disabled . '>',
        '<option value="{MD5}">{MD5}</option>',
        '<option value="{SHA}">{SHA}</option>',
        '</select>',
        '</dd>',
        
        '</dl>');

        return $htmlblock;
    }


   /***
    * Verify configuration
    */
    function verify_configuration()
    {
    
    }

   /***
    * Bind to LDAP server
    */
    function do_bind()
    {
        return ldap_bind( $this->ldap_conn, $this->ldap_rootdn, $this->ldap_rootpw );
    }

   /*** 
    * Verify LDAP uid's value uniqness
    */
    function is_uid_present( $uid )
    {
        $filter     = 'uid=' . $uid;
        $result     = ldap_search( $this->ldap_conn, $this->ldap_basedn, $filter);
        $entry      = ldap_get_entries( $this->ldap_conn, $result);

        if ( $uid != '' && $entry['count'] == 1 )
        {
            return true;
        }
        else
        {
            return false;
        }
    }

   /*** 
    * Prepare LDAP userPassword attribute
    */
    function prepare_userpassword( $userpassword )
    {
        $dirty['userpassword'] = $userpassword;
        $clean['userpassword'] = '';

        switch ( $this->ldap_authschema )
        {
            case '{MD5}':
            $clean['userpassword'] = '{MD5}' . base64_encode( pack( 'H*', md5( $dirty['userpassword'] ) ) );
            break;
    
            case '{SHA}':
            $clean['userpassword'] = '{SHA}' . base64_encode( pack( 'H*', sha1( $dirty['userpassword'] ) ) );
            break;
        }

        return $clean['userpassword'];
    }


   /*** 
    * Add User
    */
    function add_User( $entry )
    {
        $this_entry = array();

        // Define user DN
        $dn = 'uid=' . $entry['email'] . ',' . $this->ldap_basedn;
                
        // Remove user if exists
        if ( $this->is_uid_present( $entry['uname'] ) === true )
        {
            $this->delete_User( $entry );
        }

        // Prepare userPassword and other attributes for insertion in LDAP directory.
        $this_entry['objectclass']  = 'inetOrgPerson';
        $this_entry['cn']           = $entry['name'];
        $this_entry['mail']         = $entry['email'];
        $this_entry['userpassword'] = $this->prepare_userpassword($entry['pass']);
        $this_entry['sn']           = preg_replace('/^([a-zA-Z0-9_]+ ?)/','', $this_entry['cn']);
        $this_entry['uid'][0]       = $this_entry['mail'];
        $this_entry['uid'][1]       = $entry['uname'];
        $this_entry['displayname']  = $entry['uname'];
        $this_entry['employeetype'] = 'writer';
        $this_entry['preferredlanguage'] = 'en';

        if ( $this->do_bind() && ldap_add( $this->ldap_conn, $dn, $this_entry ))
        {
            return true; 
        } 
        else
        {
            return false;
        }
    }

   /*** 
    * Delete User 
    */
    function delete_User( $entry )
    {
        // Define user DN
        $dn = 'uid=' . $entry['email'] . ',' . $this->ldap_basedn;

        if ( $this->do_bind() && ldap_delete( $this->ldap_conn, $dn ) ) 
        {
            return true;
        }
        else
        {
            return false;
        }
    }

   /*** 
    * Update LDAP userPassword only.
    */
    function update_userPassword( $dn, $userPassword )
    {
        $entry = array('userpassword' => $userPassword ); 

        if ( $this->do_bind() && ldap_modify( $this->ldap_conn, $dn, $entry) ) 
        {
            return true; 
        }
        else
        {
            return false; 
        }
    }

   /*** 
    * Get LDAP user list 
    * ----------------------------------------------------
    * 1. Show a form with a list of all users inserted from xoops.users table.
    * 2.  Generate random passwords for each user and codify them into
    * userPassword format. 
    * 3. Real passwords are not displayed.
    */
    function get_userList()
    {
        global $newbb_to_phpbb;
        global $mail;

        // Get users from LDAP server
        $filter = 'objectclass=inetorgperson';
        $result = ldap_search( $this->ldap_conn, $this->ldap_basedn, $filter);
        $users = ldap_get_entries( $this->ldap_conn, $result );
        
        $htmlblock = array('<p>'.$users['count'].' password(s) reset under: <code>'.$this->ldap_basedn.'</code></p>',
                           '<table border="1">',
                           '<tr>',
                           '<th>DN</th>',
                           '<th>CN</th>',
                           '<th>NewPass</th>',
                           '<th>userPassword</th>',
                           '<th>Password Updated</th>',
                           '<th>Email Notification</th>',
                           '</tr>');

        for ($i = 0; $i < $users['count']; $i++)
        {
            // Reset userPassword value in a random manner
            $newPassword = $newbb_to_phpbb->get_randomPass();
            $userPassword = $this->prepare_userpassword($newPassword);

            array_push($htmlblock, '<tr>',
                                   '<td>' . $users[$i]['dn'] . '</td>',
                                   '<td>' . $users[$i]['cn'][0] . '</td>',
                                   '<td>' . $newPassword . '</td>',
                                   '<td>' . $userPassword . '</td>');

            // Update LDAP userPassword field
            if ( $this->update_userPassword( $users[$i]['dn'], $userPassword ) === true )
            {
                array_push($htmlblock,'<td class="center">YES</td>');
            }
            else
            {
                array_push($htmlblock,'<td class="center">NO</td>');
            }
            
            // Send email notification
            $info = array('mailto'              => $users[$i]['mail'][0],
                          'cn'                  => $users[$i]['cn'][0],
                          'dn'                  => $users[$i]['dn'],
                          'uid1'                => $users[$i]['uid'][0],
                          'uid2'                => $users[$i]['uid'][1],
                          'sn'                  => $users[$i]['sn'][0],
                          'employeetype'        => $users[$i]['employeetype'][0],
                          'preferredlanguage'   => $users[$i]['preferredlanguage'][0],
                          'displayname'         => $users[$i]['displayname'][0],
                          'userpassword'        => $newPassword);
            if ( $mail->send( $info ) === true )
            {
                array_push($htmlblock,'<td class="center">SENT</td>');
            }
            else
            {
                array_push($htmlblock,'<td class="center">NOT SENT</td>');
            }
            array_push($htmlblock,'</tr>');
        }
         
        array_push($htmlblock,'</table>');

        return $htmlblock;
    }

   /*** 
    * Class destruct
    */
    function __destruct()
    {
        if ( isset( $this->ldap_conn ) ) 
        {
            ldap_unbind( $this->ldap_conn );
        }
    }
}

$ldap = new LDAP;
?>
