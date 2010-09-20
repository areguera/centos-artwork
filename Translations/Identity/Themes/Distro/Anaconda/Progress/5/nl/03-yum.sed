# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 03-yum.sed 4959 2010-03-18 02:27:24Z al $
# ------------------------------------------------------------


s/=TITLE=/Softwarebeheer met Yum/
s!=TEXT1=!Het gebruik van <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellowdog Updater, Modified) wordt aangeraden voor de installatie of het updaten van software in CentOS.!
s/=TEXT2=/Raadpleeg de gids getiteld "Managing Software with Yum" via de snelkoppeling hieronder./
s!=TEXT3=!Er is ook een grafische tool voor Yum beschikbaar genaamd <flowSpan style="font-weight:bold">YumEx</flowSpan>. U kunt dit programma vinden in de CentOS Extras repository.!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g
