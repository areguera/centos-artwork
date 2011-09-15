<?php
/***
 * p_convert.php:
 *
 */

    $next_step = isset($_POST['step'])?$_POST['step']:0;
    array_push($htmlblock,'<form action="" method="post">');
    // Configuration
    if ( $next_step == 0 )
    {
        $next_step++;
        array_push($htmlblock,'<h1>Configuration</h1>', '<hr />');
        $htmlblock = array_merge($htmlblock,$ldap->get_configForm());
        $htmlblock = array_merge($htmlblock,$db->get_configForm());
        $htmlblock = array_merge($htmlblock,$mail->get_configForm());

        array_push($htmlblock, '<p class="action right">',
                               '<span class="floatl"><img src="img/reload.png" alt="Reload" /><a href="?action=restore">Reload default configuration</a></span>
                               <input type="hidden" name="step" value="'.$next_step.'" />',
                               '<span><input type="submit" name="Next" value="Verify Configuration" /></span>',
                               '</p>');
    }
    
    // Verification
    else if ( $next_step == 1 )
    {
        array_push($htmlblock,'<h1>Verification</h1>', 
                              '<hr />', 
                              $newbb_to_phpbb->config_verification( $next_step ));
    }

    // Migration
    else if ( $next_step == 2 )
    {
        array_push($htmlblock,'<h1>Migration</h1>', '<hr />');
        $htmlblock = array_merge($htmlblock, $newbb_to_phpbb->copy_Forums(),
                                             $newbb_to_phpbb->copy_Users(),
                                             $newbb_to_phpbb->copy_Topics(),
                                             $newbb_to_phpbb->copy_Posts());
        $next_step++;
        array_push($htmlblock,'<p class="action right">
                              <input type="hidden" name="step" value="'.$next_step.'" />
                              <input type="submit" name="Next" value="Next" />
                              </p>');
    }

    // Reset Passwords
    else if ( $next_step == 3 )
    {   
        $next_step++;
        array_push($htmlblock,'<h1>Reset Passwords</h1>', '<hr />');
        $htmlblock = array_merge($htmlblock, $ldap->get_userList());
        array_push($htmlblock,'<p class="action right"><strong>That\'s all!</strong> <img src="img/smile.png" alt="smile" /></p>');
    }

    array_push($htmlblock,'</form>');
   
?>
