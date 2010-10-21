# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 05-centosplus.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Plus リポジトリ/
s/=TEXT1=/このリポジトリには、CentOSのbaseコンポーネントのいくつかを実際にアップグレードするもの (パッケージ) があります。このリポジトリを使うと、CentOSは上位ベンダーと全く同じではなくなります。/
s/=TEXT2=/CentOS開発チームはこのレポジトリ内のすべてのものをテストしており、これらはCentOS上で構築し作動します。これらは上位ベンダーによってはテストされていませんし、上位の製品には含まれていません。/
s/=TEXT3=/これらのコンポーネントを使用すると上位の製品との100%のバイナリ互換性がなくなることをご了承ください。/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!ja!g
