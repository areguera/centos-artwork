# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 01-welcome.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS =MAJOR_RELEASE= 에 오신것을 환영합니다!/
s/=TEXT1=/CentOS =MAJOR_RELEASE= 를 설치해 주셔서 감사합니다./
s/=TEXT2=/CentOS는 유명한 북미 엔터프라이즈 리눅스 업체가 자유롭게 이용할 수 있도록 대중에게 제공한 소스로 부터 유래된 엔터프라이즈 클래스 리눅스 배포판입니다./
s/=TEXT3=/CentOS는 업스트림 제공자의 재 배포 정책을 전적으로 따르며 100%의 바이너리 호환성을 추구합니다. CentOS는 주로 기존 패키지에서 업스트림 제공자의 상표나 이미지 등의 변경작업을 합니다./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!kr!g
