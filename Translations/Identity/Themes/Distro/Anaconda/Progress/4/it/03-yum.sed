# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 03-yum.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Gestione dei pacchetti con Yum/
s!=TEXT1=!Il metodo consigliato per l'installazione o l'aggiornamento di CentOS è l'utilizzo di <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellow dog Updater, Modified).!
s/=TEXT2=/Fai riferimento alla guida: "Managing Software with Yum" all'indirizzo sottostante. /
s!=TEXT3=!!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!it!g
