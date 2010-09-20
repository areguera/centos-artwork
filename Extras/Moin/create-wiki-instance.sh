#!/bin/bash
# moinmoin-postinstall.sh
# MoinMoin 1.5 instance installation script.
#
# The CentOS Artwork SIG.
# http://projects.centos.org/trac/artwork/



# ---------------------------------------------------------
# Begin Configuration Section

# Name of the Wiki Front Page.
WIKIFRONTPAGE="FrontPage"

# Directory name where the wiki instance will be copied.
WIKILOCATION=/var/www/

# Instance Name. This is the name used to create the directory under
# $WIKILOCATION and some others internal links.
printf "Instance Name [wiki]      : "
read WIKIINSTANCE
if [ ! $WIKIINSTANCE ];then
	WIKIINSTANCE='wiki'
fi

# Instance name should be uniq.
if [ -d ${WIKILOCATION}/$WIKIINSTANCE ];then
	echo "The instance '$WIKIINSTANCE' already exists."
	exit;
fi

# Site Name. This is the name shown in the browser title bar.
printf "Site Name [My Wiki]       : "
read WIKISITENAME
if [ ! $WIKINAME ];then
	WIKINAME='My Wiki'
fi

# Alias Name used to access the wiki. By default we access
# the wiki with the form: `http://localhost/wiki'. If you
# want to acces the wiki with other alias name then change
# this value and fill it with the name you want to access
# your wiki.
WIKIALIAS=$WIKIINSTANCE

# Alias name used to access wiki static files. This value
# should be different from $WIKIALIAS above.
WIKIURLPREFIX=${WIKIINSTANCE}_staticfiles

# Wiki Super User. Add your WikiUserName here.
printf "Site superuser [YourName] : "
read WIKISUPERUSER
if [ ! $WIKISUPERUSER ];then
	WIKISUPERUSER='YourName'
fi

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
echo "Creating instance ..."
cd $WIKILOCATION
mkdir $WIKIINSTANCE
cp -R ${SHARE}data $WIKIINSTANCE
cp -R ${SHARE}htdocs $WIKIINSTANCE
cp -R ${SHARE}underlay $WIKIINSTANCE
mkdir ${WIKIINSTANCE}/cgi-bin
cp ${SHARE}server/moin.cgi ${WIKIINSTANCE}/cgi-bin


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
# Created by create-wiki-instance.sh.
# `echo date`

#
# By Alias.
#
Alias /${WIKIURLPREFIX} "${WIKILOCATION}${WIKIINSTANCE}/htdocs/"
<Directory "${WIKILOCATION}${WIKIINSTANCE}/htdocs/">
   Order deny,allow
   Allow from all
</Directory>

ScriptAlias /${WIKIINSTANCE} "${WIKILOCATION}${WIKIINSTANCE}/cgi-bin/moin.cgi"
<Directory "${WIKILOCATION}${WIKIINSTANCE}/cgi-bin">
   Order deny,allow
   Allow from all
</Directory>


# By Virtual Domains.
#
#<VirtualHost *:80>
#   ServerName wiki.example.tld
#   ServerAdmin webmaster@example.tld
#   ErrorLog logs/wiki.example.tld-error_log
#   CustomLog logs/wiki.example.tld-access_log common   
#   Alias /${WIKIURLPREFIX} "${WIKILOCATION}${WIKIINSTANCE}/htdocs/"
#   Alias /favicon.ico "${WIKILOCATION}${WIKIINSTANCE}/favicon.ico"
#   ScriptAlias / "${WIKILOCATION}${WIKIINSTANCE}/cgi-bin/moin.cgi/"
#</VirtualHost>
APACHECONF


# MoinMoin Configuration - wikiconfig.py
#
# Here is a copy and paste from original wikiconfig.py file
# in the moin-1.5.7-1.el5.rf package. Some additions were
# included in the secutiry section to make it configurablen
# between 1) an everyone editable wiki 2) a just Superuser,
# EditGroup, and AdminGroup editable wiki.
cat <<WIKICONFIG > ${WIKIINSTANCE}/cgi-bin/wikiconfig.py 
# -*- coding: iso-8859-1 -*-
# IMPORTANT! This encoding (charset) setting MUST be correct! If you live in a
# western country and you don't know that you use utf-8, you probably want to
# use iso-8859-1 (or some other iso charset). If you use utf-8 (a Unicode
# encoding) you MUST use: coding: utf-8
# That setting must match the encoding your editor uses when you modify the
# settings below. If it does not, special non-ASCII chars will be wrong.

"""
    MoinMoin - Configuration for a single wiki

    If you run a single wiki only, you can omit the farmconfig.py config
    file and just use wikiconfig.py - it will be used for every request
    we get in that case.

    Note that there are more config options than you'll find in
    the version of this file that is installed by default; see
    the module MoinMoin.multiconfig for a full list of names and their
    default values.

    Also, the URL http://moinmoin.wikiwikiweb.de/HelpOnConfiguration has
    a list of config options.

    ** Please do not use this file for a wiki farm. Use the sample file 
    from the wikifarm directory instead! **
"""

from MoinMoin.multiconfig import DefaultConfig


class Config(DefaultConfig):

    # Wiki identity ----------------------------------------------------

    # Site name, used by default for wiki name-logo [Unicode]
    sitename = u'${WIKISITENAME}'

    # Wiki logo. You can use an image, text or both. [Unicode]
    # For no logo or text, use '' - the default is to show the sitename.
    # See also url_prefix setting below!
    logo_string = u'<img src="/${WIKIURLPREFIX}/common/moinmoin.png" alt="MoinMoin Logo">'

    # name of entry page / front page [Unicode], choose one of those:

    # a) if most wiki content is in a single language
    #page_front_page = u"MyStartingPage"

    # b) if wiki content is maintained in many languages
    page_front_page = u"${WIKIFRONTPAGE}"

    # The interwiki name used in interwiki links
    #interwikiname = 'UntitledWiki'
    # Show the interwiki name (and link it to page_front_page) in the Theme,
    # nice for farm setups or when your logo does not show the wiki's name.
    #show_interwiki = 1


    # Critical setup  ---------------------------------------------------

    # Misconfiguration here will render your wiki unusable. Check that
    # all directories are accessible by the web server or moin server.

    # If you encounter problems, try to set data_dir and data_underlay_dir
    # to absolute paths.

    # Where your mutable wiki pages are. You want to make regular
    # backups of this directory.
    data_dir = '${WIKILOCATION}${WIKIINSTANCE}/data/'

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

    # Link spam protection for public wikis (Uncomment to enable)
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
        u'SiteNavigation',
        u'HelpContents',
    ]

    # The default theme anonymous or new users get
    theme_default = 'modern'


    # Language options --------------------------------------------------

    # See http://moinmoin.wikiwikiweb.de/ConfigMarket for configuration in 
    # YOUR language that other people contributed.

    # The main wiki language, set the direction of the wiki pages
    language_default = '${WIKILANGUAGE}'

    # You must use Unicode strings here [Unicode]
    page_category_regex = u'^Category[A-Z]'
    page_dict_regex = u'[a-z]Dict$'
    page_form_regex = u'[a-z]Form$'
    page_group_regex = u'[a-z]Group$'
    page_template_regex = u'[a-z]Template$'

    # Content options ---------------------------------------------------

    # Show users hostnames in RecentChanges
    show_hosts = 1                  

    # Enable graphical charts, requires gdchart.
    #chart_options = {'width': 600, 'height': 300}
WIKICONFIG

#
# Uncomment some options in the wikiconfig.py file if ...
#

if [ "$WIKISUPERUSER" != "" ]; then

	sed -i -e '
		/#superuser/s/#//
		s/YourName/'$WIKISUPERUSER'/' ${WIKIINSTANCE}/cgi-bin/wikiconfig.py

fi

if [ "$WIKIRESTRICTEDIT" = "yes" ]; then

	sed -i -r -e '
		/#acl_rights_before/s/#//
		/#acl_rights_default/s/#//
		/#[\t ]*u"EditGroup/s/#//
		/#[\t ]*u"AdminGroup/s/#//' ${WIKIINSTANCE}/cgi-bin/wikiconfig.py

fi

if [ "$WIKIMAILSMARTHOST" != "" ]; then

	sed -i -e '
		/#mail_smarthost/s/#//' ${WIKIINSTANCE}/cgi-bin/wikiconfig.py

fi

if [ "$WIKIMAILFROM" != "" ];then

	sed -i -e '
		/#mail_from/s/#//' ${WIKIINSTANCE}/cgi-bin/wikiconfig.py

fi

if [ "$WIKIMAILLOGIN" != "" ];then
 
	sed -i -e '
		/#mail_login/s/#//' ${WIKIINSTANCE}/cgi-bin/wikiconfig.py

fi


# File Permissions
#
# Here we set the file permissons to the created and copied
# files.
#
echo 'Setting permissions ...'
chown -R $USER.$GROUP $WIKIINSTANCE
chmod -R 750 $WIKIINSTANCE


# Last Message
echo '---------------------------------------------'
echo ' *** The wiki instance had been created! *** '
echo '---------------------------------------------'
echo 'To finish the installation do the following:'
echo "  1. Restart the Web Server (service httpd restart)"
echo "  2. Open your browser and try the address: http://localhost/${WIKIALIAS}"
echo '  3. Enjoy your installed wiki :).'
echo ''
