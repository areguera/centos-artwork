<?php
/**
 * Authentication and authorization
 *
 * @category   Logic
 * @package    CentOS-News
 * @author     Alain Reguera Delgado <alain.reguera@gmail.com>
 * @copyright  2009 - CentOS Artwork SIG.
 * @license    GPL
 */

//--------------Authentication stuff--------------

    session_start();

//--------------/* Verify Admin access rights  */

    function check_adminaccess()
    {
        /* Verify session */
        if (!isset($_SESSION['employeetype']))
        {
            header('Location: '. BASEURL .'admin/login.php');
        }
    }

    /* Check User Access */
    function check_useraccess()
    {
        $timeout = 60 * 30; // In seconds, i.e. 30 minutes.
        $fingerprint = md5($_SERVER['REMOTE_ADDR'].$_SERVER['HTTP_USER_AGENT']);
        $redirect_to = BASEURL . 'admin/login.php?loggedout=true';

        /* Destroy session if ... */
        if (isset($_SESSION['last_active']) && $_SESSION['last_active'] < (time()-$timeout)
           || (isset($_SESSION['fingerprint']) && $_SESSION['fingerprint']!=$fingerprint)
           || isset($_GET['action']) && $_GET['action'] == 'logout') 
        {

            setcookie(session_name(), '', time()-3600, '/');
            session_destroy();
            header("Location: $redirect_to");
        }

        /* Regenerate session */
        session_regenerate_id(); 

        /* Increase session lifetime */
        $_SESSION['last_active'] = time();

        /* Rebuild session fingerprint */
        $_SESSION['fingerprint'] = $fingerprint;

    }

    /* Verify username and password */
    function login()
    {
        require_once(ABSPATH . 'admin/includes/classes/ldap.php');
        $ldap = new LDAP;

        /* Inicialize variables */
        $login = array();
        $login['username'] = '';
        $login['password'] = '';

        /* Validate username input */ 
        if (isset($_POST['username']))
        {
            $mail_pattern = '/^([a-z0-9+_]|\-|\.)+@(([a-z0-9_]|\-)+\.)+[a-z]{2,6}$/';
            if (preg_match( $mail_pattern,$_POST['username']))
            {
                $login['username'] = $_POST['username'];
            }
        }

        /* Validate password input */
        if (isset($_POST['password']))
        {
            $login['password'] = $ldap->prepare_userpassword($_POST['password']);
        }
 
        /* Query LDAP directory looking for username AND password */
        $search = $ldap->get_entries('(&(uid=' . $login['username']  . ')(&(userpassword=' . $login['password'] . ')))');

        /* Build user's session if match */
        if ($search['count'] == 1)
        {
            /* Set session information */
            $_SESSION['uid']            = $search[0]['uid'][0];
            $_SESSION['cn']             = $search[0]['cn'][0];
            $_SESSION['employeetype']   = $search[0]['employeetype'][0];

            /* Set session lasttime access */
            $_SESSION['last_active'] = time();

            /* Set session fingerprint */
            $fingerprint = md5($_SERVER['REMOTE_ADDR'].$_SERVER['HTTP_USER_AGENT']);
            $_SESSION['fingerprint'] = $fingerprint;

            /* Redirect to frontpage */
            header("Location: " . BASEURL);

            return 0;
        }
        else if ($search['count'] > 1)
        {
            // Login Failed: There are duplicates in the ldap directory database
            return 002;
        }
        else
        {
            // Login Failed: There is no coincidece in the search
            return '001';
        }
    }

    // User links
    function get_auth_userlinks()
    {

        $html = '<ul>' . "\n";

        if (isset($_SESSION['cn'])) 
        {
            $html .= '<li><strong>' . $_SESSION['cn'] . '</strong> (<a href="?action=logout">' . ucfirst(translate("logout")) . '</a>)</li>' . "\n";
            $html .= '<li><a href="admin/index.php">' .  ucfirst(translate("admin")) . '</a></li>' . "\n";
        }
        else
        {
            $html .= '<li><a href="admin/login.php">' . ucfirst(translate("login")) . '</a></li>' . "\n";
        }

        $html .= '</ul>' . "\n";

        return $html;

    }

?>
