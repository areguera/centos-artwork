# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 02-donate.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS 기부/
s/=TEXT1=/CentOS를 만드는 단체의 이름은 The CentOS Project 입니다. 우리는 다른 어떤 단체와도 관련이 없습니다./
s/=TEXT2=/CentOS를 배포하기 위한 하드웨어와 자금은 오로지 여러분들의 기부에 의해서 마련됩니다./
s/=TEXT3=/만약 귀하께서 CentOS가 유용하다고 생각되신다면 CentOS 프로젝트에 기부하는 것을 고려해 주시면 감사하겠습니다./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g
