# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Wiki/
s/=TEXT1=/Im CentOS-Wiki sind FAQs, Howtos bzw. Tipps und Tricks für Szenarien unter CentOS, Artikel zu Softwareinstallation und der Konfiguration von Fremdrepositories für CentOS und weitere Texte vorhanden, ebenso Informationen über Veranstaltungen bei denen CentOS präsentiert wird./
s!=TEXT2=!In Zusammenarbeit mit der CentOS-Docs Mailingliste erhalten Interessenten die Möglichkeit, eigene Tipps und Tricks oder Howtos für die Community beizusteuern.!
s!=TEXT3=!!
s!=TEXT4=!!
s!=TEXT4=!!
s!=TEXT5=!!
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g
