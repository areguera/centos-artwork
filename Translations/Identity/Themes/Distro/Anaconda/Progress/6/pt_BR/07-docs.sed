# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 07-docs.sed 4959 2010-03-18 02:27:24Z al $
# ------------------------------------------------------------


s/=TITLE=/Documentações do CentOS/
s!=TEXT1=!As seguintes documentações estão disponíveis para o CentOS:!
s!=TEXT2=!• Guia de Implementação.!
s!=TEXT3=!• Guia de Instalação.!
s!=TEXT4=!• Guia de Virtualização.!
s!=TEXT5=!• Visão Geral do Cluster Suite.!
s!=TEXT6=!• Administração de Cluster.!
s!=TEXT7=!• Cluster Logical Volume Manager.!
s!=TEXT8=!• Global Network Block Device.!
s!=TEXT9=!• Administração de Servidores Virtuais.!
s!=TEXT10=!• Notas de lançamento para todos os softwares.!
s!=TEXT11=!• Gerenciando Software com yum.!
s!=TEXT12=!• Utilizando YumEx.!
s!=TEXT13=!• Global File System.!
s!=TEXT14=!!
s!=TEXT15=!!
s!=TEXT16=!!
s!=TEXT17=!!
s!=TEXT18=!!
s!=TEXT19=!!
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
