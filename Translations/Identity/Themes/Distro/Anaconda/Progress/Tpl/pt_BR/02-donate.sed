# ------------------------------------------------------------
# $Id: 02-donate.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Doações ao CentOS/
s/=TEXT1=/A organização que produz o CentOS é chamada de Projeto CentOS. Nós não somos afiliados a nenhuma outra organização./
s/=TEXT2=/Nossa única fonte de hardware ou financiamento para distribuir o CentOS é por meio de doações./
s/=TEXT3=/Por favor faça uma doação ao Projeto CentOS se você considera o CentOS útil./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate/!
