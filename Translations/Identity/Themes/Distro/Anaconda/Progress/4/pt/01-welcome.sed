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
s/=TEXT2=/CentOS é uma distribuição Linux de classe empresarial, derivada de código-fonte oferecido ao público por uma destacada empresa norte-americana de Linux./
s/=TEXT3=/CentOS está em plena conformidade com a política de redistribuição do produto original e tem como objectivo 100% de compatibilidade binária com o mesmo. Basicamente, CentOS modifica os pacotes no sentido de remover marcas e elementos gráficos comerciais./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!pt!g
