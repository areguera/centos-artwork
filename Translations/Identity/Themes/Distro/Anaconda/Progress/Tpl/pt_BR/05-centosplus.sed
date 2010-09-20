# ------------------------------------------------------------
# $Id: 05-centosplus.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Repositório CentOS Plus/
s/=TEXT1=/Este repositório é para itens que atualizam certos componentes do repositório base. Este repositório fará com que o CentOS não seja exatamente como o fornecido pelo fornecedor original./
s/=TEXT2=/O time de desenvolvimento do CentOS testou todos os itens neste repositório, e eles compilam e funcionam sob o CentOS =MAJOR_RELEASE=. Eles não foram testados pelo fornecedor original, e não estão disponíveis nos produtos do fornecedor original./
s/=TEXT3=/Você deve estar ciente de que o uso destes componentes remove o 100% de compatibilidade binária com os produtos do fornecedor original./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories/CentOSPlus!
