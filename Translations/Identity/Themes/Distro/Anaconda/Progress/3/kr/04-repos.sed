# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 04-repos.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS 저장소/
s!=TEXT1=!소프트웨어 설치를 위해서 CentOS에서는 다음의 저장소들이 마련되어 있습니다.!
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (<flowSpan style="font-weight:bold">[os]</flowSpan>라고도 칭함) - CentOS ISO상에서 배포된 RPM들.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - [base] 저장소의 업데이트들.!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - 업스트림에 없는 CentOS 아이템들 ([base]를 업그레이드 하지않음).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - 업스트림에 없는 CentOS 아이템들 ([base]를 업그레이드 함).!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!kr!g
