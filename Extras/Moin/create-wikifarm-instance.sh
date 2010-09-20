#!/bin/bash
# moinmoin-postinstall.sh
# MoinMoin 1.5 wikifarm instance installation script.
#
# The CentOS Artwork SIG.
# http://wiki.centos.org/ArtWork



# ---------------------------------------------------------
# Begin Configuration Section

# First Wiki Site Name. This is the name shown in the browser 
# title bar.
WIKISITENAME="mywiki"

# Your Domain Name (without the trailing slash).
MYDOMAIN="localdomain"

# Name of the Wiki Front Page.
WIKIFRONTPAGE="FrontPage"

# Directory name where the wiki instance will be copied.
WIKILOCATION=/var/www/

# Instance Name.
WIKIINSTANCE="wikifarm"

# Alias name used to access wiki static files. This value
# should be different from $WIKIALIAS above.
WIKIURLPREFIX="staticfiles"

# Wiki Super User. Add your WikiUserName here.
WIKISUPERUSER="YourName"

# Do you want to restrict the edit actions ?  (yes|no).
# 
# a) If `yes' only the wiki superuser, and those listed into
# EditGroup and AdminGroup pages will be able to edit pages
# on your wiki. After this script is run, we suggest to:
#
#    1. Register the superuser. For example:
#	Login > UserPreferences > Create Profile
#    2. Create a EditGroup page.
#    3. Add registered user names into EditGroup page.
#
#       At this point those users listed in EditGroup will
#       be able to edit pages on your wiki. If you need to
#       grant admin rights to other people then create the
#       AdminGroup page and add register users names into
#       it. After that they will have admin rights.
#
#       More info about acl can be found at
#       http://localhost/wiki/HelpOnAccessControlLists once
#       you have installed the wiki.
# 
# b) If `no' all users will be able to edit your wiki. Even
# if they haven't a user register on it.
WIKIRESTRICTEDIT="no"

# Mail
WIKIMAILSMARTHOST=""
WIKIMAILFROM=""
WIKIMAILLOGIN=""

# Language.
WIKILANGUAGE="en"

# Basic installation Prefix.
PREFIX=/usr

# Share directory name.
SHARE=$PREFIX/share/moin/

# User & Group used by your web server.
USER=apache
GROUP=$USER

# End of Configuration section
# ---------------------------------------------------------


# Copy files
#
# Here we create directories and copy files into the
# instance.
#
cd $WIKILOCATION
mkdir -p ${WIKIINSTANCE}/cgi-bin/
mkdir -p ${WIKIINSTANCE}/${WIKISITENAME}.${MYDOMAIN}/
cp -r ${SHARE}data/* ${WIKIINSTANCE}/${WIKISITENAME}.${MYDOMAIN}/
cp -r ${SHARE}data ${WIKIINSTANCE}/
cp -r ${SHARE}htdocs $WIKIINSTANCE
cp -r ${SHARE}underlay $WIKIINSTANCE
cp ${SHARE}server/moin.cgi ${WIKIINSTANCE}/cgi-bin/


# Fix PATH in moin.cgi file
#
sed -i -e "
        s/\/path\/to\/wikiconfig/\/var\/www\/${WIKIINSTANCE}\/cgi-bin/
        s/\/path\/to\/farmconfig/\/var\/www\/${WIKIINSTANCE}\/cgi-bin\/farmconfig/
        " ${WIKILOCATION}${WIKIINSTANCE}/cgi-bin/moin.cgi


# Apache Configuration
#
# Here we create the apache configuration file. By default
# the wiki will be accessed through the `wiki' apache alias.
# Virtual domains are also included but commented by
# default.
cat <<APACHECONF > /etc/httpd/conf.d/${WIKIINSTANCE}.conf
# Apache web server configuration for MoinMoin wiki.
#
# Created by moinmoin-postinstall-wikifarm.sh.

<VirtualHost *:80>
   ServerName ${WIKISITENAME}.${MYDOMAIN}/
   ServerAdmin webmaster@${MYDOMAIN}
   ErrorLog logs/wiki-${WIKISITENAME}.error_log
   CustomLog logs/wiki-${WIKISITENAME}.access_log common   
   Alias /${WIKIURLPREFIX} "${WIKILOCATION}${WIKIINSTANCE}/htdocs/"
   Alias /favicon.ico "${WIKILOCATION}${WIKIINSTANCE}/favicon.ico"
   ScriptAlias / "${WIKILOCATION}${WIKIINSTANCE}/cgi-bin/moin.cgi/"
</VirtualHost>
APACHECONF

# MoinMoin Configuration - farmconfig.py
#
# Here is a copy and paste from original farmconfig.py file
# in the moin-1.5.7-1.el5.rf package. Some additions were
# included in the secutiry section to make it configurablen
# between 1) an everyone editable wiki 2) a just Superuser,
# EditGroup, and AdminGroup editable wiki.
cat <<WIKICONFIG > ${WIKIINSTANCE}/cgi-bin/farmconfig.py 
# -*- coding: iso-8859-1 -*-
# IMPORTANT! This encoding (charset) setting MUST be correct! If you live in a
# western country and you don't know that you use utf-8, you probably want to
# use iso-8859-1 (or some other iso charset). If you use utf-8 (a Unicode
# encoding) you MUST use: coding: utf-8
# That setting must match the encoding your editor uses when you modify the
# settings below. If it does not, special non-ASCII chars will be wrong.

"""
    MoinMoin - Configuration for a wiki farm

    If you run a single wiki only, you can keep the "wikis" list "as is"
    (it has a single rule mapping all requests to mywiki.py).

    Note that there are more config options than you'll find in
    the version of this file that is installed by default; see
    the module MoinMoin.multiconfig for a full list of names and their
    default values.

    Also, the URL http://moinmoin.wikiwikiweb.de/HelpOnConfiguration has
    a list of config options.
"""


# Wikis in your farm --------------------------------------------------

# If you run multiple wikis, you need this list of pairs (wikiname, url
# regular expression). moin processes that list and tries to match the
# regular expression against the URL of this request - until it matches.
# Then it loads the <wikiname>.py config for handling that request.

# Important:
#  * the left part is the wikiname enclosed in double quotes
#  * the left part must be a valid python module name, so better use only
#    lower letters "a-z" and "_". Do not use blanks or "-" there!!!
#  * the right part is the url re, use r"..." for it
#  * the right part does NOT include "http://" nor "https://" at the beginning
#  * in the right part ".*" means "everything". Just "*" does not work like
#    for filenames on the shell / commandline, you must use ".*" as it is a RE.
#  * in the right part, "^" means "beginning" and "$" means "end"

wikis = [
    # Standalone server needs the port e.g. localhost:8000
    # Twisted server can now use the port, too.
    
    # wikiname,     url regular expression (no protocol)
    # ---------------------------------------------------------------
    #("mywiki",  r".*"),   # this is ok for a single wiki

    # for multiple wikis, do something like this:
    #("moinmoin",    r"^moinmoin.wikiwikiweb.de/.*$"),
    #("moinmaster",  r"^moinmaster.wikiwikiweb.de/.*$"),

    ("${WIKISITENAME}",		r"^${WIKISITENAME}.${MYDOMAIN}/.*$"),
]


# Common configuration for all wikis ----------------------------------

# Everything that should be configured the same way should go here,
# anything else that should be different should go to the single wiki's
# config.
# In that single wiki's config, we will use the class FarmConfig we define
# below as the base config settings and only override what's different.
#
# In exactly the same way, we first include MoinMoin's Config Defaults here -
# this is to get everything to sane defaults, so we need to change only what
# we like to have different:

from MoinMoin.multiconfig import DefaultConfig

# Now we subclass this DefaultConfig. This means that we inherit every setting
# from the DefaultConfig, except those we explicitely define different.

class FarmConfig(DefaultConfig):

    # Critical setup  ---------------------------------------------------

    # Misconfiguration here will render your wiki unusable. Check that
    # all directories are accessible by the web server or moin server.

    # If you encounter problems, try to set data_dir and data_underlay_dir
    # to absolute paths.

    # Where your mutable wiki pages are. You want to make regular
    # backups of this directory.
    #data_dir = '${WIKILOCATION}${WIKIINSTANCE}/data/'

    # Where read-only system and help page are. You might want to share
    # this directory between several wikis. When you update MoinMoin,
    # you can safely replace the underlay directory with a new one. This
    # directory is part of MoinMoin distribution, you don't have to
    # backup it.
    data_underlay_dir = '${WIKILOCATION}${WIKIINSTANCE}/underlay/'

    # Location of your STATIC files (css/png/js/...) - you must NOT use the
    # same for invoking moin.cgi (or, in general, the moin code).
    # url_prefix must be '/wiki' for Twisted and standalone servers.
    # For CGI, it should match your Apache Alias setting.
    url_prefix = '/${WIKIURLPREFIX}'


    # Security ----------------------------------------------------------

    # This is checked by some rather critical and potentially harmful actions,
    # like despam or PackageInstaller action:
    #superuser = [u"${WIKISUPERUSER}", ]

    # IMPORTANT: grant yourself admin rights! replace YourName with
    # your user name. See HelpOnAccessControlLists for more help.
    # All acl_rights_xxx options must use unicode [Unicode]
    #acl_rights_default = u"All:read"
    #acl_rights_before  = u"${WIKISUPERUSER}:read,write,delete,revert,admin" \\
    #			 u"AdminGroup:read,write,delete,revert,admin" \\
    #			 u"EditGroup:read,write,delete,revert"

    # Link spam protection for public wikis (uncomment to enable).
    # Needs a reliable internet connection.
    #from MoinMoin.util.antispam import SecurityPolicy


    # Mail --------------------------------------------------------------

    # Configure to enable subscribing to pages (disabled by default)
    # or sending forgotten passwords.

    # SMTP server, e.g. "mail.provider.com" (None to disable mail)
    #mail_smarthost = "${WIKIMAILSMARTHOST}"

    # The return address, e.g u"Jürgen Wiki <noreply@mywiki.org>" [Unicode]
    #mail_from = u"${WIKIMAILFROM}"

    # "user pwd" if you need to use SMTP AUTH
    #mail_login = "${WIKIMAILLOGIN}"


    # User interface ----------------------------------------------------

    # Add your wikis important pages at the end. It is not recommended to
    # remove the default links.  Leave room for user links - don't use
    # more than 6 short items.
    # You MUST use Unicode strings here, but you need not use localized
    # page names for system and help pages, those will be used automatically
    # according to the user selected language. [Unicode]
    navi_bar = [
        # If you want to show your page_front_page here:
        #u'%(page_front_page)s',
        u'RecentChanges',
        u'FindPage',
        u'HelpContents',
    ]


    # You must use Unicode strings here [Unicode]
    page_category_regex = u'^Category[A-Z]'
    page_dict_regex = u'[a-z]Dict$'
    page_group_regex = u'[a-z]Group$'
    page_template_regex = u'[a-z]Template$'

    # Content options ---------------------------------------------------

    # Show users hostnames in RecentChanges
    show_hosts = 1

    # Show the interwiki name (and link it to page_front_page) in the Theme,
    # nice for farm setups or when your logo does not show the wiki's name.
    show_interwiki = 1
    #logo_string = u''

    # Enable graphical charts, requires gdchart.
    #chart_options = {'width': 600, 'height': 300}
WIKICONFIG

# Copy First Wiki Configuration file.
#
cat <<WIKICONFIG > ${WIKIINSTANCE}/cgi-bin/${WIKISITENAME}.py
# -*- coding: iso-8859-1 -*-
# IMPORTANT! This encoding (charset) setting MUST be correct! If you live in a
# western country and you don't know that you use utf-8, you probably want to
# use iso-8859-1 (or some other iso charset). If you use utf-8 (a Unicode
# encoding) you MUST use: coding: utf-8
# That setting must match the encoding your editor uses when you modify the
# settings below. If it does not, special non-ASCII chars will be wrong.

"""
This is a sample config for a wiki that is part of a wiki farm and uses
farmconfig for common stuff. Here we define what has to be different from
the farm's common settings.
"""

# we import the FarmConfig class for common defaults of our wikis:
from farmconfig import FarmConfig

# now we subclass that config (inherit from it) and change what's different:
class Config(FarmConfig):

    # basic options (you normally need to change these)
    sitename = u'${WIKISITENAME}' # [Unicode]
    interwikiname = '${WIKISITENAME}'

    # name of entry page / front page [Unicode], choose one of those:

    # a) if most wiki content is in a single language
    #page_front_page = u"MyStartingPage"

    # b) if wiki content is maintained in many languages
    page_front_page = u"${WIKIFRONTPAGE}"

    logo_string = u'<img src="/${WIKIURLPREFIX}/common/moinmoin.png" alt="MoinMoin Logo">'

    # The default theme anonymous or new users get
    theme_default = 'modern'

    # Language options --------------------------------------------------
    
    # See http://moinmoin.wikiwikiweb.de/ConfigMarket for configuration in 
    # YOUR language that other people contributed.
    
    # The main wiki language, set the direction of the wiki pages
    language_default = '${WIKILANGUAGE}'

    data_dir = '${WIKILOCATION}${WIKIINSTANCE}/${WIKISITENAME}.${MYDOMAIN}/'
WIKICONFIG

# Uncomment some options in the farmconfig.py file if ...
if [ "$WIKISUPERUSER" != "" ]; then

	sed -i -e '
		/#superuser/s/#//
		s/YourName/'$WIKISUPERUSER'/' ${WIKIINSTANCE}/cgi-bin/farmconfig.py

fi

if [ "$WIKIRESTRICTEDIT" = "yes" ]; then

	sed -i -r -e '
		/#acl_rights_before/s/#//
		/#acl_rights_default/s/#//
		/#[\t ]*u"EditGroup/s/#//
		/#[\t ]*u"AdminGroup/s/#//' ${WIKIINSTANCE}/cgi-bin/farmconfig.py

fi

if [ "$WIKIMAILSMARTHOST" != "" ]; then

	sed -i -e '
		/#mail_smarthost/s/#//' ${WIKIINSTANCE}/cgi-bin/farmconfig.py

fi

if [ "$WIKIMAILFROM" != "" ];then

	sed -i -e '
		/#mail_from/s/#//' ${WIKIINSTANCE}/cgi-bin/farmconfig.py

fi

if [ "$WIKIMAILLOGIN" != "" ];then
 
	sed -i -e '
		/#mail_login/s/#//' ${WIKIINSTANCE}/cgi-bin/farmconfig.py

fi

# File Permissions
#
# Here we set the file permissons to the created and copied
# files.
#
chown -R $USER.$GROUP $WIKIINSTANCE
chmod -R ug=rwx $WIKIINSTANCE
chmod -R o-rwx $WIKIINSTANCE
cd $WIKIINSTANCE
chown -R $USER.$GOUP cgi-bin 
chmod -R ug=rx cgi-bin
chmod -R o-rwx cgi-bin


# Last Message
#
less <<LASTMESSAGE

------------------------------------------------------------
	     *** WIKIFARM INSTANCE CREATED *** 
------------------------------------------------------------

   To finish the installation do the following:

	1. Restart the Web Server (service httpd restart)

	2. Open your browser and try the address:
	http://${WIKISITENAME}.${MYDOMAIN}/"

------------------------------------------------------------
	      *** HOWTO CREATE NEW WIKIS  *** 
------------------------------------------------------------

  To create new wikis into the farm check the following
  steps:

  	1. Update your farmconfig.py file adding the new
	wiki definition. Ex.

	("mywiki2",    r"^mywiki2.${MYDOMAIN}/.*$"),

	2. Create a directory to store your new wiki data.
	Ex.
	
	mkdir ${WIKILOCATION}${WIKIINSTANCE}/mywiki2.${MYDOMAIN}/

	3. Copy the content of data directory into the
	recently created directory. Ex.: 

	cp -rv ${WIKILOCATION}${WIKIINSTANCE}/data/* \\
	${WIKILOCATION}${WIKIINSTANCE}/mywiki2.${MYDOMAIN}/

	4. Create a copy of your cgi-bin/mywiki.py into
	cgi-bin/mywiki2.py. Then modify mywiki2 with the new
	and specific configuration, related to the second
	wiki. Ex.:

	sitename = u'mywiki2' # [Unicode]
	interwikiname = 'mywiki2'
	data_dir = '/var/www/wikifarm/mywiki2.${MYDOMAIN}/'
		

------------------------------------------------------------
		   *** GET TROUBLES ? ***
------------------------------------------------------------

   If you get some error when try to reach your wiki through
   the web browser, check the following:

	1. Add in your DNS or HOSTS file a record to your
	wiki address. For example, if your domain is
	${MYDOMAIN} and your wiki is in a host with the ip
	192.168.0.1, and you want a wiki address like
	http://${WIKISITENAME}.${MYDOMAIN}/ it is possible
	that you should add a related CNAME record into your
	DNS to your new wiki address, something like the
	following:

   	${WIKISITENAME}.${MYDOMAIN}.	IN CNAME	${MYDOMAINl}.

	Remeber to do a 'service named restart' after
	changes.

	2. Check Virtual Domain configuration in your Apache
	server. It is possible that it is disabled so enable
	it by uncomenting a line like the following:

	NameVirtualHost *:80

	3. It is possible that you want something in
	http://${MYDOMAIN}/ other than the error that
	sometimes appears there after you get your wiki
	working into virtual domains. So you should create a
	virtual domain for that address too and change the
	DocumentoRoot param to wherever you want to load at
	that moment.

	If you are still in troubles, you can write to:
	<alain.reguera@gmail.com>. 
	
	Other way ...
	
   Enjoy your installed wikifarm :).

LASTMESSAGE
