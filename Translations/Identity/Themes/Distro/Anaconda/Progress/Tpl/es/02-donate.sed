# ------------------------------------------------------------
# $Id: 02-donate.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Donaciones para CentOS/
s/=TEXT1=/La organización que produce CentOS se llama The CentOS Project. The CentOS Project no está afiliada con ninguna otra organización./
s/=TEXT2=/La donación es nuestra única fuente de hardware y financiamento para distribuir CentOS./
s/=TEXT3=/Si usted encuentra a CentOS de utilidad, por favor considere realizar una donación al proyecto./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate/!
