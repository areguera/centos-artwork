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


s/=TITLE=/CentOS Plus repository/
s!=TEXT1=!Deze repository wordt gebruikt voor dingen die basiscomponenten uit CentOS vervangen. Het gebruik van deze repository verandert CentOS zo dat het niet meer identiek zal zijn aan de distributie van de upstream-leverancier. !
s!=TEXT2=!Het CentOS ontwikkelingsteam heeft elk onderdeel van deze repository getest. Deze programma's kunnen worden gebruikt met CentOS =MAJOR_RELEASE=. Ze zijn niet getest door de upstream-leverancier, en zijn niet beschikbaar in upstream producten.!
s!=TEXT3=!Houdt er rekening mee dat u door de installatie van software uit deze repository compatibiliteit met upstream producten opoffert.!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!nl!g
