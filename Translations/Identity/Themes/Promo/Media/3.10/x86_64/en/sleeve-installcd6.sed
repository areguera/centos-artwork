# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: sleeve-installcd6.sed 4893 2010-03-13 17:06:33Z al $
# ------------------------------------------------------------


s!=TEXT=!Install CD 6/6!

s!=MESSAGE1_HEAD=!What is CentOS ?!

s!=MESSAGE1_P1=!CentOS is an Enterprise Linux distribution based on\
the freely available sources from Red Hat Enterprise Linux. Each\
CentOS version is supported for 7 years (by means of security\
updates).!

s!=MESSAGE1_P2=!A new CentOS version is released every 2 years and\
each CentOS version is regularly updated (every 6 months) to support\
newer hardware.!

s!=MESSAGE1_P3=!This results in a secure, low-maintenance, reliable,\
predictable and reproducible environment.!

s!=ARCH=!for =ARCH= architectures!
s!=URL=!http://www.centos.org/!

s!=ARCH=!x86_64!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!10!g
s!=MAJOR_RELEASE=!3!g
