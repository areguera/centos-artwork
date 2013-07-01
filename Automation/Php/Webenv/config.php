<?php
/***
 * CentOS-News configuration files.
 * 
 */

    /* HTTP */
    define('BASEURL',           'http://localhost/~al/cnus/trunk/');

    /* HTML */
    define('HTML_TITLE',        'CentOS Español');

    /* LANGUAGE */
    define('LANGUAGE',          'es');
    
    /* LDAP */
    define('LDAP_HOST',         'localhost');
    define('LDAP_PORT',         '389');
    define('LDAP_DN',           'ou=people,dc=example,dc=com');
    define('LDAP_ROOTDN',       'cn=manager,dc=example,dc=com');
    define('LDAP_ROOTPW',       'ldap.Example28.InLife');
    define('LDAP_PASSHASH',     '{MD5}'); // Ex. {MD5}, {SHA}
    define('LDAP_FILTER_ATT',   'preferredlanguage');
    define('LDAP_FILTER_TYPE',  '=');
    define('LDAP_FILTER_VALUE', LANGUAGE);

    /* DATABASE

    In order to this configuration to take effect, you need to commit the
    following steps:

      1. Get into PostgreSQL as superuser and create a database to store the
         tables used by this application.

      2. Build database from predifined SQL commands.

      3. Create the user you'll use to connect to PostgreSQL. 
         (Ex. createuser -P -d cnus )

      4. Add, to the created user, access to authenticate in the PostgreSQL
         host base authentication file (var/lib/pgsql/pg_hba.conf). 

         For example:

         # TYPE  DATABASE    USER        CIDR-ADDRESS          METHOD
         local   cnus        cnus                              md5

      5. Reload PostgreSQL service (Ex. service postgresql reload)

    */
    define('DB_USERNAME',       'cnus');        // Username
    define('DB_PASSWORD',       'www.Cnus');    // Password
    define('DB_DBNAME',         'cnus');        // Database name
    

//--- stop editing here!

define('ABSPATH', dirname(__FILE__) . '/');
?>
