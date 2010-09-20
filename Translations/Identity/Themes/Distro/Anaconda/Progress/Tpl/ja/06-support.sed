# ------------------------------------------------------------
# $Id: 06-support.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS ヘルプ/
s/=TEXT1=/CentOSに関するヘルプは様々な方法で得られます。例えば、 /
s/=TEXT2=/チャット(IRC) - irc.freenode.net の #centos, #centos-social および #centos-devel/
s!=TEXT3=! メーリングリスト - CentOS, CentOS-Devel, CentOS-Announceがhttp://lists.centos.org にあります。!
s!=TEXT4=! フォーラム - http://www.centos.org/modules/newbb/ にあります。!
s!=TEXT5=!wiki: http://wiki.centos.org/ にあります。!
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/GettingHelp!
