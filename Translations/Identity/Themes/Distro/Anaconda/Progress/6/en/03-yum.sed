# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 03-yum.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Managing Software with Yum/
s!=TEXT1=!The recommended way to install or upgrade CentOS is to use <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellow Dog Updater, Modified)!
s!=TEXT2=!See the guide entitled: "Managing Software with Yum" at the documentation link below.!
s!=TEXT3=!<flowSpan style="font-weight:bold">YumEx</flowSpan>, a graphical front end for Yum, is also available from the CentOS Extras repository.!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!en!g
