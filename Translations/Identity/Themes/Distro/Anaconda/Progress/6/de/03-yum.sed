# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 03-yum.sed 4959 2010-03-18 02:27:24Z al $
# ------------------------------------------------------------


s/=TITLE=/Softwaremanagement mit Yum/
s!=TEXT1=!Der empfohlene Weg für die Installation oder das Update von CentOS-Paketen ist die Benutzung von <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellow Dog Updater, Modified).!
s/=TEXT2=/Dokumentation zu Yum mit dem Titel "Managing Software with Yum" ist unter dem unten stehenden URL erhältlich./
s!=TEXT3=!<flowSpan style="font-weight:bold">YumEx</flowSpan> - eine grafische Oberfläche für Yum - ist über das CentOS Extras-Repository erhältlich.!
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
