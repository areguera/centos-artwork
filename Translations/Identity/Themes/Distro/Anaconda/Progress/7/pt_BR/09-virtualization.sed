# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 09-virtualization.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Virtualização no CentOS =MAJOR_RELEASE=/
s/=TEXT1=/O CentOS =MAJOR_RELEASE= fornece virtualização através do Xen para as arquiteturas i386 e x86_64, tanto no modo totalmente virtualizado quanto no paravirtualizado./
s/=TEXT2=/O Guia de Virtualização (Virtualization Guide) e o Administração de Servidores Virtuais (Virtual Server Administration) são fornecidos no link abaixo para ajudar com a virtualização no CentOS =MAJOR_RELEASE=./
s/=TEXT3=//
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!pt_BR!g
