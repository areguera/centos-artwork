# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 06-support.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS-Hilfe/
s/=TEXT1=/Hilfe für das Arbeiten mit CentOS ist auf verschiedenen Wegen erhältlich:/
s!=TEXT2=!<flowSpan style="font-weight:bold">Internet Relay Chat (IRC)</flowSpan> - #centos, #centos-social und #centos-devel auf irc.freenode.net!
s!=TEXT3=!<flowSpan style="font-weight:bold">Mailinglisten</flowSpan> - CentOS, CentOS-Devel, CentOS-Announce und nicht-englischsprachige Listen via http://lists.centos.org/!
s!=TEXT4=!<flowSpan style="font-weight:bold">Webforen</flowSpan> - http://www.centos.org/forums/!
s!=TEXT4=!!
s!=TEXT5=!!
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!de!g
