# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: label-installcd3.sed 4893 2010-03-13 17:06:33Z al $
# ------------------------------------------------------------


s!=TEXT=!CD instalador 3/6!
s!=ARCH=!para arquitecturas =ARCH=!
s!=URL=!http://www.centos.org/!
s!=ARCH=!x86_64!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!9!g
s!=MAJOR_RELEASE=!4!g
