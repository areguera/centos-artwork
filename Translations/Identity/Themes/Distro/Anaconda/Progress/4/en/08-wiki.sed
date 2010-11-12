# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Wiki/
s/=TEXT1=/The CentOS wiki is available with Frequently Asked Questions, HowTos, Tips and Tricks on a number of CentOS related topics including software installation, upgrades, repository configuration and much more./
s/=TEXT2=/The wiki also contains information on CentOS Events in your area and CentOS media sightings./
s/=TEXT3=/In conjuntion with the CentOS-Docs mailing list, contributors can obtain permission to post articles, tips and HowTos on the CentOS Wiki. So contribute today!/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!en!g
