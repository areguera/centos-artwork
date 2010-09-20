# ------------------------------------------------------------
# $Id: 02-donate.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Donations/
s/=TEXT1=/The organization that produces CentOS is named The CentOS Project. We are not affiliated with any other organization./
s/=TEXT2=/Our only source of hardware or funding to distribute CentOS is by donations./
s/=TEXT3=/Please consider donating to the CentOS Project if you find CentOS useful./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate!
