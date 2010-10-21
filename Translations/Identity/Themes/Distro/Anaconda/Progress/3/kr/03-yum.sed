# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 03-yum.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Yum을 이용한 소프트웨어 관리/
s!=TEXT1=!CentOS를 설치하시거나 업그레이드하실 때 <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellow Dog Updater 수정본)을 사용하실 것을 추천합니다.!
s!=TEXT2=!아래의 문서 링크에서 "Mannaging Software witn Yum"(Yum을 이용한 소프트웨어 관리)란 제목의 가이드를 보실 수 있습니다.!
s!=TEXT3=!<flowSpan style="font-weight:bold">YumEx</flowSpan>는 Yum의 그래피컬 프론트 엔드 이며 이 또한 CentOS Extras 저장소에서 이용 가능합니다.!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!kr!g
