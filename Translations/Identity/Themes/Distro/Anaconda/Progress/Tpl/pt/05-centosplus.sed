# ------------------------------------------------------------
# $Id: 05-centosplus.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Repositório CentOS Plus/
s/=TEXT1=/Este repositório contém melhoramentos para alguns componentes de base do CentOS. Modificado por este repositório, o CentOS deixará de ser idêntico à distribuição da empresa original./
s/=TEXT2=/A equipa de desenvolvimento do CentOS testou cada um dos componentes deste repositório. São compilados e funcionam sobre CentOS =MAJOR_RELEASE=. Não foram testados pelo fornecedor original e não estão disponíveis entre os seus produtos./
s/=TEXT3=/Deverá estar ciente de que o uso destes componentes remove a compatibilidade binária a 100% com os produtos do fornecedor original./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories/CentOSPlus!
