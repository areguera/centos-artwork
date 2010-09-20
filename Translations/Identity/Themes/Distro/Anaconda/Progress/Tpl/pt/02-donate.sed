# ------------------------------------------------------------
# $Id: 02-donate.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Doações ao CentOS/
s/=TEXT1=/A organização que produz o CentOS é conhecida como "The CentOS Project". Não somos filiados em qualquer outra organização./
s/=TEXT2=/As doações são a nossa única fonte de equipamento e financiamento./
s/=TEXT3=/Se achar útil o CentOS, por favor considere uma doação ao Projecto CentOS./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate!
