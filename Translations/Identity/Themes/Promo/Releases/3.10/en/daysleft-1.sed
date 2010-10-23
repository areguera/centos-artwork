# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: daysleft-1.sed 308 2010-10-21 18:57:44Z al $
# ------------------------------------------------------------


s/=MESSAGE1=/1 day left/

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!10!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!en!g
