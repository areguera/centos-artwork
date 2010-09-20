# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 09-virtualization.sed 4959 2010-03-18 02:27:24Z al $
# ------------------------------------------------------------


s/=TITLE=/Virtualizace na CentOS =MAJOR_RELEASE=/;
s/=TEXT1=/Na CentOS =MAJOR_RELEASE= i386 a x86_64 je možné provozovat virtualizaci pomocí software Xen, a to jak plnou virtualizaci, tak paravirtualizaci./;
s/=TEXT2=/The Virtualization Guide a Virtual Server Administration Guide naleznete na níže uvedeném odkazu./;
s/=TEXT3=//;
s/=TEXT4=//;
s/=TEXT5=//;
s/=TEXT6=//;
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!;

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g
