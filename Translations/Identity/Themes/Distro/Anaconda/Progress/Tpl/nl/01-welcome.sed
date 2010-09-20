# ------------------------------------------------------------
# $Id: 01-welcome.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Welkom bij CentOS =MAJOR_RELEASE=!/
s/=TEXT1=//
s/=TEXT2=/CentOS is een enterprise Linux-distributie die gebaseerd is op de broncode die vrij beschikbaar is gesteld aan het publiek door een bekende Noord-Amerikaanse Enterprise Linux-leverancier (ook "upstream" genoemd)./
s/=TEXT3=/CentOS conformeert volledig met het distributiebeleid van deze leverancier, en heeft tot doel honderd procent compatibel te zijn. (CentOS verandert hoofdzakelijk dingen om merknamen en logo's van de leverancier te verwijderen.)/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!
