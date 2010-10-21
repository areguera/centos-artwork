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


s/=TITLE=/CentOS ヘルプ/
s/=TEXT1=/CentOSに関するヘルプは様々な方法で得られます。例えば、 /
s/=TEXT2=/チャット(IRC) - irc.freenode.net の #centos, #centos-social および #centos-devel/
s!=TEXT3=! メーリングリスト - CentOS, CentOS-Devel, CentOS-Announceがhttp://lists.centos.org にあります。!
s!=TEXT4=! フォーラム - http://www.centos.org/modules/newbb/ にあります。!
s!=TEXT5=!wiki: http://wiki.centos.org/=LOCALE=/ にあります。!
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!ja!g
