# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 03-yum.sed 4959 2010-03-18 02:27:24Z al $
# ------------------------------------------------------------


s/=TITLE=/Gestão de Software com Yum/
s!=TEXT1=!O modo recomendado de instalar ou actualizar o CentOS é usar o <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellow Dog Updater, Modified)!
s!=TEXT2=!Ver o guia entitulado: "Managing Software with Yum" (Gestão de Software com Yum) no "link" de documentação abaixo.!
s!=TEXT3=!No repositório "Extras" do CentOS, está também disponível <flowSpan style="font-weight:bold">YumEx</flowSpan>, uma interface gráfica para o Yum.!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g
