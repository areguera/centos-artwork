# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
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

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!es!g
