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


s/=TITLE=/Ajutor pentru CentOS/
s/=TEXT1=/Ajutorul pentru CentOS poate fi obtinut prin mai multe metode, intre care:/
s!=TEXT2=!<flowSpan style="font-weight:bold">Internet Relay Chat (IRC)</flowSpan> - #centos, #centos-social si  #centos-devel pe irc.freenode.net.!
s!=TEXT3=!<flowSpan style="font-weight:bold">Listele de mail</flowSpan> - CentOS, CentOS-Devel, CentOS-Announces si listele in alte limbi decit engleza disponibile la http://lists.centos.org/. !
s!=TEXT4=!<flowSpan style="font-weight:bold">Forumurile</flowSpan> - disponibile la http://www.centos.org/forums/.!
s!=TEXT5=!<flowSpan style="font-weight:bold">Wiki</flowSpan> - disponibil la  http://wiki.centos.org/=LOCALE=/.!
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!ro!g
