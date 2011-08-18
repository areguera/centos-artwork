<?php
/***
 * Useradd page.
 *
 * This page sumarize the actions needed to add users into LDAP
 * directory server's database.
 *
 * --
 * 2009 (c) Alain Reguera Delgado <al@ciget.cienfuegos.cu>
 * Released under GPL lisence (http://www.fsf.org/licensing/licenses/gpl.txt)
 */

//------------/* Show error if this page is called directly.

    if ( basename($_SERVER['PHP_SELF']) <> 'index.php')
    {
        echo '<h3>Sorry, this page can\'t be served directly. ';
        echo 'Try <a href="index.php?p=users&a=add">this instead</a>.</h3>';
        exit;
    }

//------------/* Initialize entry values.

    $fields = array('uid', 'userpassword', 'cn', 'employeetype', 'preferredlanguage', 'displayname');
    $entry  = $ldap->init_useradd_values( $fields );

//------------/* Do Action if POST 

    if ( isset( $_POST['useradd'] ) )
    {
        $message = $ldap->do_action( $entry, 'add' );
    }

//------------/* Display useradd action results

    if ( isset($message) )
    {
        echo $message; 
    }

//------------/* Display useradd title

    echo '<h1>' . ucfirst(translate('add')) . ' ' . translate('user') . '</h1>';

//------------/* Display useradd form

    echo show_useradd_form( $entry ); 

?>
