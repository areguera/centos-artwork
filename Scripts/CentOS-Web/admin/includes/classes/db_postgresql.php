<?php
/**
 * Database Access (PostgreSQL)
 *
 * @category   Database
 * @package    CentOS-News
 * @author     Alain Reguera Delgado <alain.reguera@gmail.com>
 * @copyright  2009 - CentOS Artwork SIG.
 * @license    GPL
 */

class DB_PostgreSQL
{

    var $dbconn;

//---- Initialize class

    function __construct()
    {
        $conn_string = 'user=' . DB_USERNAME . ' password=' . DB_PASSWORD . ' dbname=' . DB_DBNAME;
        $this->dbconn = pg_connect($conn_string) or die("Could not connect");
    }

//---- Am I connected ?

    function check_connection()
    {
        if (pg_connection_status($this->dbconn) === PGSQL_CONNECTION_OK )
        {
            return translate('connected'); 
        }
        else
        {
            return translate('disconnected');
        }

    }

//---- Query

    function query( $sql_string )
    {
        $result = pg_query( $this->dbconn, $sql_string ); 

        return $result;
    }

//---- Class Destructor 

    function __destruct()
    {

        if (pg_connection_status($this->dbconn))
        {
            pg_close($this->dbconn);
        }
        
    }

}

$db = new DB_PostgreSQL;
?>
