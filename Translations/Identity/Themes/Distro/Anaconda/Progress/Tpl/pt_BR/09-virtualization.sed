# ------------------------------------------------------------
# $Id: 09-virtualization.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Virtualização no CentOS =MAJOR_RELEASE=/
s/=TEXT1=/O CentOS =MAJOR_RELEASE= fornece virtualização através do Xen para as arquiteturas i386 e x86_64, tanto no modo totalmente virtualizado quanto no paravirtualizado./
s/=TEXT2=/O Guia de Virtualização (Virtualization Guide) e o Administração de Servidores Virtuais (Virtual Server Administration) são fornecidos no link abaixo para ajudar com a virtualização no CentOS =MAJOR_RELEASE=./
s/=TEXT3=//
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!
