# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: label-installcd5.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s!=TEXT=!Install CD 5/6!
s!=ARCH=!for =ARCH= architectures!
s!=ARCH=!x86_64!
s!=LICENSE=!The CentOS distribution is released as GPL.!
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
