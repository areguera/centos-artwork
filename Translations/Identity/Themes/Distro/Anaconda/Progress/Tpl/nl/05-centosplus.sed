# ------------------------------------------------------------
# $Id: 05-centosplus.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Plus repository/
s!=TEXT1=!Deze repository wordt gebruikt voor dingen die basiscomponenten uit CentOS vervangen. Het gebruik van deze repository verandert CentOS zo dat het niet meer identiek zal zijn aan de distributie van de upstream-leverancier. !
s!=TEXT2=!Het CentOS ontwikkelingsteam heeft elk onderdeel van deze repository getest. Deze programma's kunnen worden gebruikt met CentOS =MAJOR_RELEASE=. Ze zijn niet getest door de upstream-leverancier, en zijn niet beschikbaar in upstream producten.!
s!=TEXT3=!Houdt er rekening mee dat u door de installatie van software uit deze repository compatibiliteit met upstream producten opoffert.!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories/CentOSPlus!
