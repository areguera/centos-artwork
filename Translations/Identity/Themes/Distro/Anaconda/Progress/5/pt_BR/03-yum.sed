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


s/=TITLE=/Gerenciando Software com o Yum/
s!=TEXT1=!A forma recomendada de instalar ou atualizar o CentOS é utilizando o <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellow Dog Updater, Modified).!
s/=TEXT2=/Leia o guia entitulado: "Managing Software with Yum" (Gerenciando Software com o Yum) no link de documentação abaixo./
s!=TEXT3=!O <flowSpan style="font-weight:bold">YumEx</flowSpan>, uma interface gráfica para o Yum, também está disponível no repositório Extras do CentOS.!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!pt_BR!g
