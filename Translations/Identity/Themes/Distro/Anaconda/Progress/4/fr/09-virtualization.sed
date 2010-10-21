# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 09-virtualization.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/La Virtualisation sur CentOS =MAJOR_RELEASE=/
s!=TEXT1=!CentOS =MAJOR_RELEASE= supporte la Virtualisation via Xen pour les architectures i386 et x86_64 , que ce soit en mode 'fully virtualized' ou/et 'para virtualized'!
s/=TEXT2=/Pour comprendre le fonctionnement de la Virtualisation sous CentOS =MAJOR_RELEASE=, vous pouvez consulter le 'Virtualization Guide' ainsi que le 'Virtual Server Administration Guide' (en anglais)./
s/=TEXT3=//
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!fr!g
