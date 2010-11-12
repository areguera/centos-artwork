# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 02-donate.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOSへの寄付/
s/=TEXT1=/CentOSを提供している組織は、The CentOS Project (CentOS プロジェクト)と名付けられています。私たちはどの他の組織とも関連しておりません。/
s/=TEXT2=/CentOSの配布のためのハードウェアおよび資金は寄付によって賄われています。/
s/=TEXT3=/あなたにとってCentOSが有用でしたら、ぜひ寄付をお願いいたします。/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!ja!g
