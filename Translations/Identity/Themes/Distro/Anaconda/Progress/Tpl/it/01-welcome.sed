# ------------------------------------------------------------
# $Id: 01-welcome.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Benvenuto in CentOS =MAJOR_RELEASE=!/
s/=TEXT1=/Grazie per aver installato CentOS =MAJOR_RELEASE=./
s/=TEXT2=/CentOS è una distribuzione di classe enterprise del sistema operativo Linux derivata da sorgenti liberi rilasciati al pubblico dal preminente distributore enterprise Linux Nord Americano./
s/=TEXT3=/CentOS, è pienamente conforme con le regole di redistribuzione del distributore primario (upstream) e tende alla piena compatibilità binaria. (CentOS cambia i pacchetti originali principalmente per rimuovere marchi e art work del distributore primario.)/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!
