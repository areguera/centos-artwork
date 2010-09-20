# ------------------------------------------------------------
# $Id: 01-welcome.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Welcome to CentOS =MAJOR_RELEASE= !/
s/=TEXT1=/Thank you for installing CentOS =MAJOR_RELEASE=./
s/=TEXT2=/CentOS is an enterprise-class Linux Distribution derived from sources freely provided to the public by a prominent North American Enterprise Linux vendor./
s/=TEXT3=/CentOS conforms fully with the upstream vendors redistribution policy and aims to be 100% binary compatible. CentOS mainly changes packages to remove upstream vendor branding and artwork./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!
