# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: eula.en.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------

s!=TITLE=!CentOS =RELEASE= EULA!

s!=P1=!CentOS =RELEASE= comes with no guarantees or warranties\
of any sorts, either written or implied.!

s!=P2=!The Distribution is released as GPL. Individual packages in\
the distribution come with their own licences.!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
