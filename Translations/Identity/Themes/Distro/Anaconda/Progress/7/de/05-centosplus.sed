# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 05-centosplus.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Plus-Repository/
s/=TEXT1=/Dieses Repository enthält Pakete welche Komponenten aus der Distribution ersetzen. Dadurch wird CentOS so verändert, dass es nicht mehr 100% kompatibel zur Distribution des Upstream-Distributors ist./
s!=TEXT2=!Das CentOS-Development-Team hat jedes Paket in diesem Repository auf Funktionalität unter CentOS =MAJOR_RELEASE= getestet. Diese Pakete wurden nicht vom Upstream-Distributor getestet und sind auch nicht in dessen Produkten enthalten.!
s!=TEXT3=!Bitte beachten Sie, dass Sie damit die vollständige Kompatibilität zum Produkt des Upstream-Distributors verlieren.!
s!=TEXT4=!!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!de!g
