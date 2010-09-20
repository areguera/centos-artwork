# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 05-centosplus.sed 4959 2010-03-18 02:27:24Z al $
# ------------------------------------------------------------


s/=TITLE=/Repositório CentOS Plus/
s/=TEXT1=/Este repositório contém melhoramentos para alguns componentes de base do CentOS. Modificado por este repositório, o CentOS deixará de ser idêntico à distribuição da empresa original./
s/=TEXT2=/A equipa de desenvolvimento do CentOS testou cada um dos componentes deste repositório. São compilados e funcionam sobre CentOS =MAJOR_RELEASE=. Não foram testados pelo fornecedor original e não estão disponíveis entre os seus produtos./
s/=TEXT3=/Deverá estar ciente de que o uso destes componentes remove a compatibilidade binária a 100% com os produtos do fornecedor original./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g
