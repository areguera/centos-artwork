# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 02-donate.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/Dary pro CentOS/
s/=TEXT1=/The CentOS Projekt je organizace vydávající CentOS. Tato organizace není napojena na žádnou další organizaci./
s/=TEXT2=/Veškerý hardware, jakož i výdaje na distribuci a vývoj CentOS pocházejí z darů, které jsou jediným zdrojem našich příjmů./
s/=TEXT3=/Pokud je pro vás CentOS užitečný, prosím zvažte podporu CentOS vyjádřenou ve formě peněžních či nepeněžních darů./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
