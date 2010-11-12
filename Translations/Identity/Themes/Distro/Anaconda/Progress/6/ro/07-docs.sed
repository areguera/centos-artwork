# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 07-docs.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Documentatie pentru CentOS/
s/=TEXT1=/Pentru CentOS sint disponibile urmatoarele seturi de documente:/
s/=TEXT2=/• Ghid de implementare./
s/=TEXT3=/• Ghid pentru virtualizare./
s/=TEXT4=/• Clustere - Prezentare generala./
s/=TEXT5=/• Administrarea clusterelor./
s/=TEXT6=/• Logical Volume Manager pt clustere./
s/=TEXT7=/• Administrarea programelor cu Yum./
s/=TEXT8=/• Administrarea serverelor virtuale./
s/=TEXT9=/• Global Network Block Device./
s/=TEXT10=/• Note de lansare pentru toate programele./
s/=TEXT11=/• Ghid de instalare./
s/=TEXT12=/• Utilizarea YumEx./
s/=TEXT13=/• Global File System./
s/=TEXT14=//
s/=TEXT15=//
s/=TEXT16=//
s/=TEXT17=//
s/=TEXT18=//
s/=TEXT19=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!ro!g
