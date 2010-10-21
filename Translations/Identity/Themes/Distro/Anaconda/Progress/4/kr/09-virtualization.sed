# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 09-virtualization.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/가상화와 CentOS =MAJOR_RELEASE=/
s/=TEXT1=/CentOS =MAJOR_RELEASE=에서는 fully virtualized 모드와 para virtualized 모드의 Xen for the i386 과 x86_64 아키텍쳐를 통한 가상화를 제공합니다./
s/=TEXT2=/CentOS =MAJOR_RELEASE= 가상화 가이드와 가상화 서버 관리 가이드를 아래의 링크에서 확인 하실 수 있습니다./
s/=TEXT3=//
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!kr!g
