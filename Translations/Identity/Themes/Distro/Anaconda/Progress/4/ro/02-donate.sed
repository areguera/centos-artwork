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


s/=TITLE=/Donatii catre Centos/
s/=TEXT1=/Organizatia care produce CentOS se numeste "The CentOS Project". Nu sintem afiliati nici unei alte organizatii./
s/=TEXT2=/Unica noastra sursa de hardware si de finantare a distribuirii sint donatiile./
s/=TEXT3=/Daca proiectul Centos vi se pare util, va rugam sa luati in considerare o donatie catre proiect./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!ro!g
