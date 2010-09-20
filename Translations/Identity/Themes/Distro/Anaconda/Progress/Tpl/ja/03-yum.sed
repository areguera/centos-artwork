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
