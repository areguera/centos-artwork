<?php
/***
 * Mail
 */

class MAIL
{

    public $notification; 
    public $notification_subject;
    public $notification_message;

   /***
    * Class constructor
    */

    function __construct()
    {
        // Initialize variables with default values
        $this->notification = 'NO';
        $this->notification_subject         = '[CentOS Forum] User account notification.';
        $this->notification_message         = "Dear =USER_FIRST_NAME=,

The CentOS Forums (http://centos.org/forums/) were migrated from
Xoops+CBB(newbb) to phpBB3 and the user accounts were moved to an LDAP
server. As consequence your user account is now on that LDAP server.

In order to make this happen, it was needed to reset your account
password. Your password(userPassword) is here with the rest of your
user account information.

The following LDAP entry has the information of your user account:

               dn: =DN=
              uid: =UID1=
              uid: =UID2=
     userPassword: =PASS=
             mail: =MAIL=
               cn: =CN=
               sn: =SN=
     employeeType: =TYPE=
preferredLanguage: =LANG=
      displayName: =DISPLAYNAME=

With this migration we are preparing the ground to unify all CentOS
user accounts into a common place. If you need to authenticate
somewhere under centos.org domain use any of your uids and the
password provided above.

Best Regards,
--
The CentOS Team";

        // Reinitialize variables with form values
        $config = array('notification', 'notification_subject', 'notification_message');
        foreach ( $config as $param )
        {
            if ( ! isset($_SESSION[$param]))
            {
                $_SESSION[$param] = $this->$param;
            }   

            $_SESSION[$param] = isset($_POST[$param])?$_POST[$param]:$_SESSION[$param];

            $this->$param = $_SESSION[$param];
        }
    }
    
   /***
    * Send
    * -------
    * $info is an array with the following indexes:
    *  - mailto
    *  - name
    *  - dn
    *  - newpass
    */

    function send( $info )
    {
        // Do replacements in message template
        $this->notification_message = preg_replace('/=MAIL=/',  $info['mailto'],$this->notification_message);
        $this->notification_message = preg_replace('/=DN=/',    $info['dn'],$this->notification_message);
        $this->notification_message = preg_replace('/=UID1=/',  $info['uid1'],$this->notification_message);
        $this->notification_message = preg_replace('/=UID2=/',  $info['uid2'],$this->notification_message);
        $this->notification_message = preg_replace('/=PASS=/',  $info['userpassword'],$this->notification_message);
        $this->notification_message = preg_replace('/=CN=/',    $info['cn'],$this->notification_message);
        $this->notification_message = preg_replace('/=SN=/',    $info['sn'],$this->notification_message);
        $this->notification_message = preg_replace('/=TYPE=/',  $info['employeetype'],$this->notification_message);
        $this->notification_message = preg_replace('/=LANG=/',  $info['preferredlanguage'],$this->notification_message);
        $this->notification_message = preg_replace('/=DISPLAYNAME=/',$info['displayname'],$this->notification_message);
        $this->notification_message = preg_replace('/=USER_FIRST_NAME=/', preg_replace('/ .+$/','',$info['cn']), $this->notification_message);

        $to              = $info['mailto'];
        $subject         = $this->notification_subject;
        $message         = $this->notification_message;
        $headers         = 'From: webmaster';
        $extra_params    = '-fwebmaster';
        if ( $this->notification == 'YES' )
        {
            return mail( $to, $subject, $message, $headers, $extra_params );
        }
    }

   /***
    * Send notification ?
    * Show form selector
    */

    function get_configForm( $disabled = '' )
    {
        $htmlblock = array('<h2>Mail Notification:</h2>','<dl>');

        // Mail template
        array_push($htmlblock, 

        '<dt>Subject:</dt>',
        '<dd><input name="notification_subject" size="70" '.$disabled.' value="'.$this->notification_subject.'" /></dd>',
                               
       '<dt>Message:</dt>',
       '<dd><textarea name="notification_message" cols="70" rows="15" '.$disabled.'>'.$this->notification_message.'</textarea></dd>',

        '<dt>Send notifications ?:</dt>',
        '<dd><select name="notification" '.$disabled.'>');

        if ( $this->notification == 'YES' )
        {
            array_push($htmlblock,
                '<option value="NO">NO</option>',
                '<option value="YES" selected="selected">YES</option>');
        }
        else
        {
            array_push ( $htmlblock, 
                '<option value="NO" selected="selected">NO</option>',
                '<option value="YES">YES</option>');
        }

        array_push($htmlblock, '</select><span class="description"><strong>Use it with care!</strong></span></dd>');

        array_push($htmlblock, '</dl>');

        return $htmlblock;
    }

   /***
    * Class destructor
    */

    function __destruct()
    {
    
    }
}

$mail = new MAIL;
?>
