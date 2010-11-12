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


s/=TITLE=/CentOS Plus Repository/
s/=TEXT1=/Questo repository contiene pacchetti che aggiornano (upgrade) un certo numero di componenti del sistema operativo CentOS. Installando pacchetti da questo repository si modificherà la piena compatibilità di CentOS con la distribuzione primaria./
s/=TEXT2=/Il team di sviluppo di CentOS testa ogni pacchetto presente in questo repository e ne verifica il funzionamento. Questi pacchetti, che sono prodotti su CentOS =MAJOR_RELEASE=, non sono stati testati dal distributore primario e non sono disponibili nei suoi prodotti./
s/=TEXT3=/Installando componenti da questo repository, si perde la piena compatibilità binaria con la distribuzione upstream./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!it!g
