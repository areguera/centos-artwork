# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 05-centosplus.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Plus Repository/
s/=TEXT1=/This repository is for items that actually upgrade certain base CentOS components. This repo will change CentOS to not be exactly like the upstream providers content./
s/=TEXT2=/The CentOS development team has tested every item in this repo, and they build and work under CentOS =MAJOR_RELEASE=. They have not been tested by the upstream provider, and are not available in the upstream products./
s/=TEXT3=/You should understand that use of the components removes the 100% binary compatibility with the upstream products./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!en!g
