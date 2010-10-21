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


s/=TITLE=/Bem-vindo ao CentOS =MAJOR_RELEASE= !/
s/=TEXT1=/Obrigado por instalar o CentOS =MAJOR_RELEASE=./
s/=TEXT2=/O CentOS é uma Distribuição Linux de nível corporativo derivada de fontes gratuitamente distribuídas ao público por um Fornecedor Original norte-americano./
s/=TEXT3=/O CentOS é completamente compatível com a política de redistribuição de seu Fornecedor Original e pretende ter 100% de compatiblidade binária. O CentOS basicamente altera os pacotes para remover as marcas e artes-finais do seu fornecedor original./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!pt_BR!g
