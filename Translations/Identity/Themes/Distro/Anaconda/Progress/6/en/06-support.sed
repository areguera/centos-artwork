# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 06-support.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Help with CentOS/
s!=TEXT1=!You can get help with CentOS in several ways, including:!
s!=TEXT2=!<flowSpan style="font-weight:bold">Internet Relay Chat (IRC)</flowSpan> - #centos, #centos-social and #centos-devel on irc.freenode.net.!
s!=TEXT3=!<flowSpan style="font-weight:bold">Mailing Lists</flowSpan> - CentOS, CentOS-Devel, CentOS-Annouces and non-English localized language lists from http://lists.centos.org/.!
s!=TEXT4=!<flowSpan style="font-weight:bold">Forums</flowSpan> - Available at http://www.centos.org/forums/.!
s!=TEXT5=!<flowSpan style="font-weight:bold">Wiki</flowSpan> - Available at http://wiki.centos.org/.!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!en!g
