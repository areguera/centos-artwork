# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 01-welcome.sed 4959 2010-03-18 02:27:24Z al $
# ------------------------------------------------------------


s/=TITLE=/ようこそCentOS =MAJOR_RELEASE=へ!/
s/=TEXT1=/CentOS =MAJOR_RELEASE=をインストールしていただきありがとうございます。/
s/=TEXT2=/CentOSは、世界的に有名な北アメリカの企業向けLinuxベンダーが誰もが使える形で公開するソースを基に作られています。/
s/=TEXT3=/CentOSは上位ベンダーの再配布ポリシーを全面的に遵守し、100% のバイナリ互換性を目標としています。 (CentOSは主に上位ベンダーの商標とアートワークを除去するようパッケージに変更を加えています）。/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g
