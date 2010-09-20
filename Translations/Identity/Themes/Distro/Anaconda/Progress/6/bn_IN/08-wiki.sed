# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Wiki/
s/=TEXT1=/CentOS wiki থেকে অাপনি পাবেন কতগুলি পশেনর উওর, HowTos, Tips এবং Tricks যেগুলো কভার করে software installation, upgrades, repository configuration এবং অারও অনেক কিছু./
s/=TEXT2=/এই  wiki থেকে অাপনার এলাকাতে CentOS Events এবং CentOS media খবর পাবেন./
s/=TEXT3=/CentOS-Docs mailing list থেকে  অংশগহণকারীরা অনুমতি পেতে পারেন নিবনধ, tips এবং HowTos CentOS Wiki লেখার জনন । সুতরাং অাজ থেকেই অংশগহণ করতে শুরু করুন!/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
