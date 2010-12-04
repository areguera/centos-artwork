# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 05-centosplus.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Plus 저장소/
s/=TEXT1=/이 저장소는 기본 CentOS 컴포넌트를 업그레이드 하기 위한 아이템들의 저장소 입니다. 이 저장소는 CentOS를 업스트림 제공자의 컨텐츠와 동일하지 않게 바꿉니다./
s/=TEXT2=/본 저장소의 모든 아이템들은 CentOS 개발팀에 의해 테스트되었으며, CentOS =MAJOR_RELEASE= 상에서 빌드되고 작업되었습니다. 업스트림 제공자에 의해 테스트 되지 않았으며, 업스트림 제품에서는 이용 가능하지 않습니다./
s/=TEXT3=/이들 컴포넌트를 이용할 경우 업스트림 제품에 대한 100% 바이너리 호환성이 저해 됨을 유념하셔야 합니다./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!7!g

# Locale information.
s!=LOCALE=!kr!g
