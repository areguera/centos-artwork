# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 02-donate.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Donaties/
s/=TEXT1=/Het CentOS Project is de organisatie die CentOS produceert. Wij zijn geheel onafhankelijk en hebben geen banden met andere organisaties./
s/=TEXT2=/Donaties zijn onze enige bron van inkomsten voor het maken en distribueren van CentOS./
s/=TEXT3=/Overweeg alstublieft een donatie aan het CentOS Project als u dit product bruikbaar vindt./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!nl!g
