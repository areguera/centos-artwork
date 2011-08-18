<?php
/**
 * Language     : English
 * Language-code: en
 * Description  : English Translation
 *
 * Alain Reguera Delgado <al@ciget.cienfuegos.cu>
 */

 function translate($word)
 {

    $translation = array('' => '',
                         // Admonition translations
                         // LDAP translations
                         'uid' => 'User ID',
                         'cn' => 'Full Name',
                         'preferredlanguage' => 'Language',
                         'employeetype'=>'privileges',
                         'displayname'=>'nickname',
                         'userpassword'=>'password',
                         // Others
                         'go back' => 'go back',
                         'default_f' => 'default',
                         'default_m' => 'default',
                         'en' => 'English',
                         'credits_on_footer_1' => 'The CentOS Project - '.date('Y').' | "Linux" is a registered trademark of Linus Torvalds. All other trademarks are property of their respective owners.',
                         ''=>'');

    // if $word hasn't a translation here, return it.
    if ( array_key_exists($word, $translation))
    {
        $translation[$word] = $translation[$word];
        return $translation[$word];
    }
    else
    {
        return $word;
    }
 }

?>
