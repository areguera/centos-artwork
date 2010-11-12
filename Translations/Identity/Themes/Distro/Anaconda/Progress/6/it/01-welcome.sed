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


s/=TITLE=/Benvenuto in CentOS =MAJOR_RELEASE=!/
s/=TEXT1=/Grazie per aver installato CentOS =MAJOR_RELEASE=./
s/=TEXT2=/CentOS è una distribuzione di classe enterprise del sistema operativo Linux derivata da sorgenti liberi rilasciati al pubblico dal preminente distributore enterprise Linux Nord Americano./
s/=TEXT3=/CentOS, è pienamente conforme con le regole di redistribuzione del distributore primario (upstream) e tende alla piena compatibilità binaria. (CentOS cambia i pacchetti originali principalmente per rimuovere marchi e art work del distributore primario.)/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!it!g
