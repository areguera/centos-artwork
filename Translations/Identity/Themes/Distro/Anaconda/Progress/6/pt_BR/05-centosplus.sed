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
s/=TEXT1=/Este repositório é para itens que atualizam certos componentes do repositório base. Este repositório fará com que o CentOS não seja exatamente como o fornecido pelo fornecedor original./
s/=TEXT2=/O time de desenvolvimento do CentOS testou todos os itens neste repositório, e eles compilam e funcionam sob o CentOS =MAJOR_RELEASE=. Eles não foram testados pelo fornecedor original, e não estão disponíveis nos produtos do fornecedor original./
s/=TEXT3=/Você deve estar ciente de que o uso destes componentes remove o 100% de compatibilidade binária com os produtos do fornecedor original./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
