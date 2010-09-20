# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 09-virtualization.sed 4959 2010-03-18 02:27:24Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS 5 における仮想化/
s/=TEXT1=/CentOS 5は、i386とx86_64のアーキテクチャ上で、完全仮想化（full virtualization）と準仮想化（para-virtualization）の双方に対応したXenによる仮想化を提供しています。/
s/=TEXT2=/Virtualization Guide と Virtual Server Administration Guide が、CentOS 5における仮想化の情報源としてご利用いただけます。/
s/=TEXT3=//
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g
