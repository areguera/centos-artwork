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


s/=TITLE=/Получение помощи по CentOS/
s!=TEXT1=!Вы можете получить помощь по использованию CentOS на следующих ресурсах:!
s!=TEXT2=!<flowSpan style="font-weight:bold">Ретранслируемый интернет-чат (IRC)</flowSpan> - #centos, #centos-social и #centos-devel на irc.freenode.net.!
s!=TEXT3=!<flowSpan style="font-weight:bold">Списки рассылки</flowSpan> - CentOS, CentOS-Devel, CentOS-Annouces и другие на http://lists.centos.org/.!
s!=TEXT4=!<flowSpan style="font-weight:bold">Форумы</flowSpan> - http://www.centos.org/forums/.!
s!=TEXT5=!<flowSpan style="font-weight:bold">Вики</flowSpan> - http://wiki.centos.org/=LOCALE=/.!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!ru!g
