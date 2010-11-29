# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 01-welcome.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Welkom bij CentOS =MAJOR_RELEASE=!/
s/=TEXT1=//
s/=TEXT2=/CentOS is een enterprise Linux-distributie die gebaseerd is op de broncode die vrij beschikbaar is gesteld aan het publiek door een bekende Noord-Amerikaanse Enterprise Linux-leverancier (ook "upstream" genoemd)./
s/=TEXT3=/CentOS conformeert volledig met het distributiebeleid van deze leverancier, en heeft tot doel honderd procent compatibel te zijn. (CentOS verandert hoofdzakelijk dingen om merknamen en logo's van de leverancier te verwijderen.)/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!nl!g
