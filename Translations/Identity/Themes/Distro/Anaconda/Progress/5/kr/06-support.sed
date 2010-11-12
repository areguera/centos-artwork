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


s/=TITLE=/CentOS에대한 도움 얻기/
s!=TEXT1=!CentOS에대한 도움을 얻는 몇가지 방법이 있습니다.:!
s!=TEXT2=!<flowSpan style="font-weight:bold">인터넷 릴레이 챗 (IRC)</flowSpan> - irc.freenode.net의 #centos, #centos-social 그리고 #centos-devel.!
s!=TEXT3=!<flowSpan style="font-weight:bold">메일링 리스트</flowSpan> - CentOS, CentOS-Devel, CentOS-Annouces 그리고 http://lists.centos.org/상의 비영어권 언어 리스트.!
s!=TEXT4=!<flowSpan style="font-weight:bold">포럼</flowSpan> - http://www.centos.org/forums/에서 가능.!
s!=TEXT5=!<flowSpan style="font-weight:bold">위키</flowSpan> - http://wiki.centos.org/=LOCALE=/에서 가능.!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!kr!g
