# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 01-welcome.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Bun venit la CentOS =MAJOR_RELEASE= !/
s/=TEXT1=//
s/=TEXT2=/CentOS este o distributie de linux de tip Enterprise obtinuta din sursele puse gratuit la dispozitie catre public de catre un Proeminent Vinzator Nord American de linux./
s/=TEXT3=/CentOS se conformeaza integral cu politica de redistribuire a furnizorului original si vizeaza o compatibilitate binara de 100%. (In general CentOS modifica pachetele pentru a elimina elementele de grafica si marca protejate.)/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!;

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!ro!g
