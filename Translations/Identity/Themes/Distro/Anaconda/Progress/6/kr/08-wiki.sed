# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS 위키 /
s/=TEXT1=/CentOS 위키에는 자주하는 질문, 하우투 문서는 물론 소프트웨어 설치, 업그레이드, 저장소 설정등의 CentOS와 관련된 수많은 팁과 트릭 들이 있습니다./
s/=TEXT2=/또한 지역내의 CentOS 이벤트 정보와 CentOS 미디어 관련정보를 포함하고 있습니다./
s/=TEXT3=/메일링 리스트에 참여하시면 기사 및 팁과 하우투 문서를 직접 CentOS 위키에 등록하실 수도 있습니다. 오늘 CentOS-Docs 메일링 리스트에 참여하세요!/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!kr!g
