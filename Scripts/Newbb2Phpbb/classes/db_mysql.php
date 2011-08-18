<?php
/***
 * Database Access (MySQL)
 *
 * Provides default database access values, and functions used to
 * access data in both newbb and phpBB. 
 * 
 * --
 * Alain Reguera Delgado <alain.reguera@gmail.com>
 ***/

class DB_MYSQL
{
    public $db_conn;

    public $db_host;
    public $db_user;
    public $db_pass;
    public $db_xoops_db;
    public $db_xoops_tbl;
    public $db_phpbb_db;
    public $db_phpbb_tbl;

   /***
    * Class Construct
    ***/

    function __construct()
    {
        // Initialize configuration values
        $this->db_host      = 'localhost';
        $this->db_user      = 'root';
        $this->db_pass      = '';
        $this->db_xoops_db  = 'xoops';
        $this->db_xoops_tbl = 'xoops_';
        $this->db_phpbb_db  = 'phpBB';
        $this->db_phpbb_tbl = 'phpbb_';

        // Reinitialize configuration values
        $config = array('db_host', 'db_user', 'db_pass', 'db_xoops_db', 
                        'db_xoops_tbl', 'db_phpbb_db', 'db_phpbb_tbl');

        foreach ( $config as $param )
        {
            if ( ! isset( $_SESSION[$param] ) )
            {
                $_SESSION[$param] = $this->$param;
            }

            $_SESSION[$param] = isset($_POST[$param])?$_POST[$param]:$_SESSION[$param];

            $this->$param = $_SESSION[$param];
        }
    }

   /***
    * Connect
    */
    function connect()
    {
        // Connect to MySQL database
        $this->db_conn = mysql_connect( $this->db_host, 
                                        $this->db_user, 
                                        $this->db_pass );
        if ( $this->db_conn )
        {
            return true; 
        }
        else
        {
            return false;
        }
    }

   /***
    * DB Configuration
    */
    function get_configForm( $disabled = '' )
    {
        $htmlblock = array();

        array_push( $htmlblock, 
            // Common DB Configuration
            '<h2>Common DB configuration:</h2>',
            '<dl>',
            '<dt>Server: </dt>',
            '<dd><input type="text" name="db_host" value="'.$this->db_host.'" '.$disabled.' /></dd>',
            
            '<dt>Username:</dt>',
            '<dd><input type="text" name="db_user" value="'.$this->db_user.'" '.$disabled.' /></dd>',
            
            '<dt>Password:</dt>',
            '<dd><input type="password" name="db_pass" value="'.$this->db_pass.'" '.$disabled.' /></dd>',
            '</dl>',
            
            // Xoops Configuration
            '<h2>Xoops configuration:</h2>',
            '<dl>',
            '<dt>Xoops database name:</dt>',
            '<dd><input type="text" name="db_xoops_db" value="'.$this->db_xoops_db.'" '.$disabled.' /></dd>',
            
            '<dt>Xoops table prefix:</dt>',
            '<dd><input type="text" name="db_xoops_tbl" value="'.$this->db_xoops_tbl.'" '.$disabled.' /></dd>',
            
            '</dl>',
            
            // phpBB Configuration
            '<h2>phpBB configuration:</h2>',
            '<dl>',
            '<dt>Phpbb database name:</dt>',
            '<dd><input type="text" name="db_phpbb_db" value="'.$this->db_phpbb_db.'" '.$disabled.' /></dd>',
            
            '<dt>Phpbb table prefix:</dt>',
            '<dd><input type="text" name="db_phpbb_tbl" value="'.$this->db_phpbb_tbl.'" '.$disabled.' /></dd>',
            '</dl>');
            
        return $htmlblock;
    }

   /***
    * Query
    */
    function query( $sql )
    {
        $this->connect();
        $result = mysql_query( $sql, $this->db_conn );
        if ( $result )
        {
            return $result; 
        }
        else
        {
            return false;
        }
    }

   /***
    * Check existance
    */
    function check_existance( $name )
    {

        switch ( $name )
        {
            case 'phpbb':
                $check_dbname = $this->db_phpbb_db;
                $check_suffix = $this->db_phpbb_tbl;
                $check_tables = array('users', 'forums', 'topics', 'posts');
            break;

            case 'xoops':
                $check_dbname = $this->db_xoops_db;
                $check_suffix = $this->db_xoops_tbl;
                $check_tables = array('users', 'bb_forums', 'bb_topics', 'bb_posts', 'bb_posts_text');
            break;
        }

        $error = 0;
        $table_list = array();

        // Check database existance
        if ( ! mysql_select_db( $check_dbname ) )
        {
            $error++;
        }

        // Check tables existance
        else
        {
            $sql = 'SHOW TABLES FROM ' . $check_dbname . ';'; 
            $result = $this->query( $sql );
            while ( $row = mysql_fetch_row ($result) )
            {
                array_push($table_list, $row[0]);
            }

            foreach ($check_tables as $tablename)
            {
                $tablename = $check_suffix . $tablename; 
                if (in_array($tablename, $table_list) === false )
                {
                    $error++;
                }
            }
        }

        if ( $error == 0 )
        {
            return true;
        }
        else
        {
            return false;
        }
    }

   /***
    * Class Destruct
    ***/

    function disconnect()
    {
        mysql_close( $this->db_conn );
    }
}

$db = new DB_MYSQL;
?>
