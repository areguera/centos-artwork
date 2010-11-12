# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 09-virtualization.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Virtualisierung unter CentOS =MAJOR_RELEASE=/
s/=TEXT1=/CentOS =MAJOR_RELEASE= enthält Xen für i386 und x86_64, um sowohl vollständige Virtualisierung als auch Paravirtualisierung von Rechnern zu ermöglichen./
s!=TEXT2=!Der "Virtualization Guide" und der "Virtual Server Administration Guide" werden für weiterführende Informationen bereitgestellt.!
s!=TEXT3=!!
s!=TEXT4=!!
s!=TEXT4=!!
s!=TEXT5=!!
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!de!g
