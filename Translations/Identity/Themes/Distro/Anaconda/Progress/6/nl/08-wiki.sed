# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Wiki/
s!=TEXT1=!Op de CentOS Wiki kunt u antwoorden op veelgestelde vragen, gidsen, tips en artikels vinden over CentOS en gerelateerde onderwerpen, zoals software-installatie, upgrades, en de configuratie van repositories. Daarnaast kunt u er veel informatie vinden over CentOS evenementen in uw regio, CentOS in de media, etc.!
s!=TEXT2=!Met de CentOS Wiki kunt u ook uw CentOS kennis delen met anderen. Kijk gelijk even.!
s!=TEXT3=!!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!nl!g
