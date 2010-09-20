# ------------------------------------------------------------
# $Id: 06-support.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Ajutor pentru CentOS/
s/=TEXT1=/Ajutorul pentru CentOS poate fi obtinut prin mai multe metode, intre care:/
s!=TEXT2=!<flowSpan style="font-weight:bold">Internet Relay Chat (IRC)</flowSpan> - #centos, #centos-social si  #centos-devel pe irc.freenode.net.!
s!=TEXT3=!<flowSpan style="font-weight:bold">Listele de mail</flowSpan> - CentOS, CentOS-Devel, CentOS-Announces si listele in alte limbi decit engleza disponibile la http://lists.centos.org/. !
s!=TEXT4=!<flowSpan style="font-weight:bold">Forumurile</flowSpan> - disponibile la http://www.centos.org/forums/.!
s!=TEXT5=!<flowSpan style="font-weight:bold">Wiki</flowSpan> - disponibil la  http://wiki.centos.org/.!
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/GettingHelp!
