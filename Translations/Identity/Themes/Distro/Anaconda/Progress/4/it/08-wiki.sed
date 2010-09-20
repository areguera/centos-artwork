# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/Wiki di CentOS/
s/=TEXT1=/La wiki di CentOS contiene le domande più frequenti (FAQ), HowTo, suggerimenti ed articoli su argomenti correlati a CentOS come installazione software, aggiornamenti, configurazione dei repository e molto altro. Potrete trovare inoltre informazioni su eventi CentOS, presenze sui media etc./
s/=TEXT2=/La wiki è inoltre una risorsa per poter contribuire a CentOS. Vieni a dare un'occhiata oggi stesso./
s/=TEXT3=//
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g
