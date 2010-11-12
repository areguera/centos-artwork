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


s/=TITLE=/CentOS Wiki (ウィキ)/
s/=TEXT1=/CentOS wiki からは、ソフトウェアのインストール、アップグレード、リポジトリの設定などに関するFAQ, HowTo, ヒントならびに多くのCentOS関連のトピックスなどが得られます。/
s/=TEXT2=/wikiにはまた、あなたの地域でのCentOSに関係する催しや、メディアに取り上げられたCentOS関連の話題などもあります。/
s/=TEXT3=/CentOS-Docsメーリングリストに関連して、寄与した方はCentOS wikiに文書、ヒント、HowToを投稿する許可がもらえます。さっそく寄与しましょう。/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!ja!g
