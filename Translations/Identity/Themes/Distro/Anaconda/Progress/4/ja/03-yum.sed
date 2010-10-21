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


s/=TITLE=/Yumによるソフトウェアの管理/
s/=TEXT1=/インストールやアップグレードではyum (Yellow Dog Updater, Modified)を使うことをお勧めします。/
s/=TEXT2=/詳しくは下記のリンクで記されるドキュメントの"Managing Software with Yum"という章を参照してください。/
s/=TEXT3=/YumのGUIフロントエンドであるyumexもCentOS Extrasのリポジトリから入手できます。/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!ja!g
