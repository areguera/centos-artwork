<?php
/***
 * Convert Xoops + CBB (newbb) to phpBB
 * 
 * --
 * Alain Reguera Delgado <alain.reguera@gmail.com>
 ***/


class NEWBB_TO_PHPBB
{

   /***
    * Class Construct
    * ----------------------------------------------------
    */
    function __construct()
    {
        // Initialize session
        session_start();

        // Check action: usedefaults
        if ( isset( $_GET['action'] ) && $_GET['action'] == 'restore' )
        {
            // Unset session values
            session_unset();
        
            // Reload page 
            header('Location: index.php');
        }
    }

   /***
    * Verify Configuration
    *
    * This verification is needed to be sure new information entered
    * is valid.
    */
    function config_verification( $next_step )
    {
        global $db;
        global $ldap;
        global $html;

        $htmlblock = array();
        $error = 0;

        // Verify LDAP bind
        if ( $ldap->do_bind() )
        {
            array_push($htmlblock, $html->format_message('LDAP Configuration is correct', 'green'));
        }
        else
        {
            array_push( $htmlblock, $html->format_message('LDAP Configuration is incorrect', 'orange'));
            $error++;
        }

        // Verify Database
        if ( $db->connect() === true )
        {
            array_push( $htmlblock, $html->format_message('Common DB Configuration is correct', 'green'));

            // Verify XOOPS database and table
            if ( $db->check_existance('xoops') === true )
            {
                array_push( $htmlblock, $html->format_message('Xoops configuration is correct', 'green'));
            }
            else
            {
                array_push( $htmlblock, $html->format_message('Xoops configuration is incorrect', 'orange'));
                $error++;
            }
    
            // Verify PHPBB database and table
            if ( $db->check_existance('phpbb') === true )
            {
                array_push( $htmlblock, $html->format_message('phpBB configuration is correct', 'green'));
            }
            else
            {
                array_push( $htmlblock, $html->format_message('phpBB configuration is incorrect', 'orange'));
                $error++;
            }
        }
        else
        {
            array_push( $htmlblock, $html->format_message('Common DB Configuration is incorrect', 'orange'));
            $error++;
        }

        // Add action button
        if ( $error == 0 )
        {
            $next_step++;
            array_push( $htmlblock,
                             '<p class="action right">
                              <input type="hidden" name="step" value="'.$next_step.'" />
                              <input type="submit" name="Next" value="Next" />
                              </p>');
        }
        else
        {
            array_push($htmlblock, '<p class="action left"><img src="img/previous.png" alt="Previous" /><a href="index.php">Check your configuration</a></p>');
        }

        return $html->format_htmlblock($htmlblock);
    }

   /***
    * Groups
    *
    * All users in xoops.users will be inserted into phpBB.users
    * using the REGISTERED group (group_id = 2). Forums administrators should
    * be redifined after migration.
    */

   /*** 
    * Users 
    * 
    * Basic fields are copied from xoops.users to phpBB.users.
    *
    * Password field should be redifined by the user in order to get logged in
    * after the migration.
    *
    * If LDAP authentication is used the directory structure should be design
    * to receive uid and userPassword attributes. In this case the migration
    * should be focused from xoops.users to LDAP directory not phpBB.users.
    *
    * The LDAP registration process is (as my understanding): 1. Add an entry
    * for the user in the LDAP directory.  2. Add an entry for the user in the
    * DB (this is automatically done by phpBB). This is needed to relate user
    * against user specific information like topics, posts, etc.
    *
    * As we are using LDAP server for users. This function use php's ldap
    * extension to add users into LDAP directory. If the user do no exist in
    * the Database but in LDAP server, phpBB will automatically insert a
    * record for that user in the phpBB.user table. It is needed to relate
    * user identity to posts, topics, etc .
    *
    * User passwords need to be reseted and a notification could be send to each
    * user telling the new password set. This is requiered because the
    * password codification used in newbb, phpbb and LDAP is different.
    *
    * The structure of LDAP user entries was built with rfc2377 in mind.
    */
    function copy_Users()
    {
        global $ldap;
        global $db;

        $htmlblock = array('<h2>Users</h2>','<ul>');

        // Remove phpBB.users. Number 52 seems to be the greatest user_id
        // value when no user has been created.

        array_push($htmlblock,'<li>Cleanning up ... </li>');

        $sql = sprintf('DELETE FROM %s.%susers WHERE user_id > 52;', 
                               $db->db_phpbb_db, 
                               $db->db_phpbb_tbl );
        $db->query( $sql );

    	// Add users into LDAP directory

        array_push($htmlblock,'<li>Copying ... </li>');

    	$sql = sprintf("SELECT uname, 
                               name, 
                               email, 
                               pass
                               FROM %s.%susers WHERE uid > 1", 
                               $db->db_xoops_db, 
                               $db->db_xoops_tbl );

        $result = $db->query( $sql );

		$counter = 0;

		while ( $entry = mysql_fetch_array( $result ) )
		{
            // Add xoops.users into LDAP directory
            if ( $ldap->add_User( $entry ) === true )
            {
                $counter++;
            }
        }
        
        array_push($htmlblock,'<li>'. $counter .' user(s) copied successfully.</li>','</ul>');

        return $htmlblock;
    }

   /***
    * Categories 
    * 
    * Not copied. In phpBB there is no category.
    */

   /***
    * Copy Forum
    */
    function copy_Forums()
    {
        global $db;

        $htmlblock = array('<h2>Forums</h2>', '<ul>');

        // Clean up Forums

        array_push( $htmlblock, '<li>Cleanning up ... </li>' );

        $sql = sprintf("TRUNCATE %s.%sforums;", 
                            $db->db_phpbb_db, 
                            $db->db_phpbb_tbl );

        $db->query( $sql );

        // Copy Forums

        array_push($htmlblock,'<li>Copying ... </li>');

        $sql = sprintf("INSERT INTO %s.%sforums (forum_name,
                                                 forum_desc,
                                                 forum_topics,
                                                 forum_topics_real,
                                                 forum_type,
                                                 forum_posts) SELECT forum_name,
                                                                     forum_desc,
                                                                     forum_topics,
                                                                     forum_topics,
                                                                     (SELECT 1 AS forum_type),
                                                                     forum_posts FROM %s.%sbb_forums;",
                            $db->db_phpbb_db, $db->db_phpbb_tbl, 
                            $db->db_xoops_db, $db->db_xoops_tbl);

        $db->query( $sql );

        // Get forums recently added and update their order, ownership, and type. 

        $sql = sprintf('SELECT forum_id, left_id, right_id FROM %s.%sforums;', 
                                    $db->db_phpbb_db, 
                                    $db->db_phpbb_tbl );

        $result = $db->query( $sql );

        // Sanitize forum's order one by one

        $left_id    = 1;
        $right_id   = 2;
        $counter    = 0;

        while ( $row = mysql_fetch_array( $result ) )
        {
            $sql = sprintf("UPDATE %s.%sforums SET left_id = %d, right_id = %d WHERE forum_id = %d;", 
                                $db->db_phpbb_db, 
                                $db->db_phpbb_tbl, 
                                $left_id, 
                                $right_id, 
                                $row['forum_id']);

            $db->query( $sql );

            $left_id  = $left_id + 2;
            $right_id = $left_id + 1;

            // Counter

            $counter++;
        }

        // Get amount of forums copied.
        array_push( $htmlblock, '<li>' . $counter . ' forum(s) copied successfully.</li>', '</ul>'); 

        return $htmlblock;
    }

   /*** 
    * Topics
    * 
    * When doing Topic copying the user used will be administrator. This means
    * that all topics and posts after migration will be own by the
    * administrator user. 
    */
    function copy_Topics()
    {
        global $db;

        $htmlblock = array('<h2>Topics</h2>','<ul>');

        // Claen up topics

        array_push( $htmlblock, '<li>Cleanning up ... </li>' );

        $sql = sprintf("TRUNCATE %s.%stopics;",
                        $db->db_phpbb_db, 
                        $db->db_phpbb_tbl );

        $db->query( $sql );

        // Copy topics

        array_push( $htmlblock, '<li>Copying ... </li>' );

        $sql = sprintf("INSERT INTO %s.%stopics (forum_id, 
                                                 topic_title, 
                                                 topic_time, 
                                                 topic_last_post_time,
                                                 topic_views, 
                                                 topic_last_poster_id,
                                                 topic_poster,
                                                 topic_replies,
                                                 topic_replies_real) SELECT forum_id, 
                                                          topic_title, 
                                                          topic_time, 
                                                          topic_time, 
                                                          topic_views, 
                                                          (SELECT 2 AS last_poster_id),
                                                          (SELECT 2 AS last_poster_id),
                                                          topic_replies, 
                                                          topic_replies 
                                                          FROM %s.%sbb_topics",
                                $db->db_phpbb_db, $db->db_phpbb_tbl, 
                                $db->db_xoops_db, $db->db_xoops_tbl );

        $db->query( $sql );

        array_push( $htmlblock, '<li>' . mysql_affected_rows() . ' topic(s) copied successfully.</li>', '</ul>' ); 

        return $htmlblock;
    }

   /***
    * Posts
    */
    function copy_Posts()
    {
        global $db;

        $htmlblock = array('<h2>Posts</h2>','<ul>');
        
        // Clean Up posts

        array_push($htmlblock,'<li>Cleanning up ... </li>');

        $sql = sprintf("TRUNCATE %s.%sposts;", $db->db_phpbb_db, $db->db_phpbb_tbl);

        $db->query( $sql );

        // Copy Posts
        
        array_push( $htmlblock, '<li>Copying ... </li>');

        $sql = sprintf("INSERT INTO %s.%sposts (topic_id,
                                                forum_id,
                                                poster_id,
                                                post_time,
                                                post_subject,
                                                post_text) SELECT t1.topic_id,
                                                                  t1.forum_id,
                                                                  (SELECT 2 AS poster_id),
                                                                  t1.post_time,
                                                                  t1.subject,
                                                                  t2.post_text
                                                                  FROM %s.%sbb_posts t1 
                                                                  LEFT JOIN %s.%sbb_posts_text t2 
                                                                  ON t2.post_id = t1.post_id;",
                                            $db->db_phpbb_db, $db->db_phpbb_tbl,
                                            $db->db_xoops_db, $db->db_xoops_tbl,
                                            $db->db_xoops_db, $db->db_xoops_tbl);

        $db->query( $sql );

        array_push( $htmlblock, '<li>' . mysql_affected_rows() .' posts(s) copied successfully.</li>', '</ul>'); 

        return $htmlblock;
    }

   /***
    * Generate random password
    */
    function get_randomPass()
    {
        // Add lower case letters
        $seed = array('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 
                      'i', 'j', 'k', 'i', 'l', 'm', 'n', 'o', 
                      'p', 'q', 'r', 's', 't', 'u', 'v', 'x', 
                      'y', 'z');

        // Add upper case letters
        foreach ( $seed as $value )
        {
            array_push( $seed, strtoupper($value) );
        }

        // Add numbers
        array_push( $seed, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' );

        // Use some symbols chars
        array_push( $seed, '!', '@', '#', '$', '%', '=', '/','+' );

        // Build password based on seed
        $userPassword   = '';
        $passwordLength = 20;
        for ($i = 0; $i < $passwordLength; $i++)
        {
            $userPassword = $userPassword . $seed[array_rand($seed)];
        }

        return $userPassword;
    }

   /***
    * Class Destruct
    * ----------------------------------------------------
    */

    function __destruct()
    {
    }
}

$newbb_to_phpbb = new NEWBB_TO_PHPBB;
?>
