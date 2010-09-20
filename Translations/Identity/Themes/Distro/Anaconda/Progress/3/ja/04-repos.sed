# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 04-repos.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS ソフトウェアのリポジトリ/
s/=TEXT1=/以下のリポジトリがCentOS ソフトウェアのインストールにご利用になれます。/
s/=TEXT2=/[base] ([os]と同じ) - CentOSのISOイメージに収録されたRPMS/
s/=TEXT3=/[updates] - [base]リポジトリの更新パッケージ/
s/=TEXT4=/[extras] - 上位ベンダーにはない、CentOSによるもの ([base]をアップグレードしない)/
s/=TEXT5=/[centosplus] - 上位ベンダーにはない、CentOSによるもの ([base]をアップグレードする)/
s/=TEXT6=/[testing] - テスト版、ベータ版のパッケージ/
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
