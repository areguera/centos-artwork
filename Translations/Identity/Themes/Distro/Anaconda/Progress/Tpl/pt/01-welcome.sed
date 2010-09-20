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
