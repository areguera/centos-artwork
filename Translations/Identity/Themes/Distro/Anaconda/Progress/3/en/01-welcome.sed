# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 01-welcome.sed 4959 2010-03-18 02:27:24Z al $
# ------------------------------------------------------------


s/=TITLE=/Welcome to CentOS =MAJOR_RELEASE= !/
s/=TEXT1=/Thank you for installing CentOS =MAJOR_RELEASE=./
s/=TEXT2=/CentOS is an enterprise-class Linux Distribution derived from sources freely provided to the public by a prominent North American Enterprise Linux vendor./
s/=TEXT3=/CentOS conforms fully with the upstream vendors redistribution policy and aims to be 100% binary compatible. CentOS mainly changes packages to remove upstream vendor branding and artwork./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
