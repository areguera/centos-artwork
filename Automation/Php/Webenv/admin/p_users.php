<?php 
/***
 * Useradmin page.
 *
 * This page sumarize the actions needed to administer users into LDAP
 * directory server's database.
 *
 * --
 * 2009 (c) Alain Reguera Delgado <al@ciget.cienfuegos.cu>
 * Released under GPL lisence (http://www.fsf.org/licensing/licenses/gpl.txt)
 */


//-------------/* Show error if this page is called directly.

    if ( basename($_SERVER['PHP_SELF']) <> 'index.php')
    {
        echo '<h3>Sorry, this page can\'t be served directly. ';
        echo 'Try <a href="index.php?p=users">this instead</a>.</h3>';
        exit;
    }

//------------|* Define filter.

    $filter = $ldap->build_filter_string(); 

/*------------|* Initialize entry values. */

    $entries = $ldap->get_entries( $filter );

/*------------|* Do Action if POST 
               *
               * Description : Actions take place entry by entry. Just one
               * entry at the same time. Actually two actions are supported
               * (update,delete). */

    if ( isset( $_POST['useradmin'] ) )
    {
        // Define useradmin attributes.
        $fields = array('cn', 'userpassword', 'displayname', 'preferredlanguage', 'employeetype');

        // Recover action to do.
        $action = $_POST['action'];

        // Reinitialize entries values based on input and do action if present
        $message = $ldap->init_useradmin_values( $entries, $fields, $action );


        // Reload entry value to reflect changes immediately
        $entries = $ldap->get_entries( $filter );
    }

//------------/* Display useradmin action results

    if ( isset( $message ) )
    {
        echo $message;
    }

//------------/* Display useradmin title 

    echo '<h1>' . ucfirst(translate(strtolower('admin'))) . ' ' . translate(strtolower('users')) . '</h1>';

//------------/* Display useradmin form

?>

<form name="ldapusers" action="" method="post">

    <p><?php echo $ldap->show_useradmin_info( $entries ) ?></p>

    <hr/>

    <div class="action alignr">

        <?php echo show_action_field(); ?>

        <input type="submit" name="useradmin" value="<?php echo ucfirst(translate('accept'))?>" />

    </div>

    <table class="ldapusers">

    <tr>

        <th> </th>

        <th><?php echo ucfirst(translate('uid'))?></th>

        <th><?php echo ucfirst(translate('userpassword'))?></th>

        <th><?php echo ucfirst(translate('cn'))?></th>

        <th><?php echo ucfirst(translate('displayname'))?></th>

        <th><?php echo ucfirst(translate('preferredlanguage'))?></th>

        <th><?php echo ucfirst(translate('employeetype'))?></th>


    </tr>

<?php for ($i=0; $i<$entries['count']; $i++) { ?>
    <tr>
        <td align="center"><input type="checkbox" name="uid[<?php echo $i ?>]" value="<?php echo $entries[$i]['uid'][0]; ?>" /></td>
        <td align="center"><?php echo $entries[$i]['uid'][0]; ?></td>


        <td align="center"><input type="password" name="userpassword[<?php echo $i ?>]" value="<?php echo $entries[$i]['userpassword'][0]; ?>" size="20" /></td>

        <td align="center"><input type="text" name="cn[<?php echo $i ?>]" value="<?php echo $entries[$i]['cn'][0]; ?>" size="20" /></td>

        <td align="center"><input type="text" name="displayname[<?php echo $i ?>]" value="<?php echo $entries[$i]['displayname'][0]; ?>" size="10" /></td>

        <td align="center" style="padding: 0.5em;">
        <?php echo get_user_langSelector($i,$entries[$i]['preferredlanguage'][0])?>
        </td>

        <td align="center" style="padding: 0.5em;">
        <?php echo get_user_roleSelector($i,$entries[$i]['employeetype'][0])?>
        </td>

    </tr>
    <?php } ?>

    </table>

    <div class="action alignr">

        <input type="submit" name="useradmin" value="<?php echo ucfirst(translate('accept'))?>" />

    </div>
    
</form>
