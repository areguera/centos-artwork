# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 02-donate.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Doações ao CentOS/
s/=TEXT1=/A organização que produz o CentOS é chamada de Projeto CentOS. Nós não somos afiliados a nenhuma outra organização./
s/=TEXT2=/Nossa única fonte de hardware ou financiamento para distribuir o CentOS é por meio de doações./
s/=TEXT3=/Por favor faça uma doação ao Projeto CentOS se você considera o CentOS útil./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!7!g

# Locale information.
s!=LOCALE=!pt_BR!g
