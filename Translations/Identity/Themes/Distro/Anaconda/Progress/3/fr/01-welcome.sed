# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 01-welcome.sed 4959 2010-03-18 02:27:24Z al $
# ------------------------------------------------------------


s/=TITLE=/Bienvenue dans CentOS =MAJOR_RELEASE= !/
s/=TEXT1=/Merci d'installer CentOS =MAJOR_RELEASE=./
s/=TEXT2=/CentOS est une distribution Linux de type 'entreprise' qui est construite à partir des sources disponibles gratuitement et mises à disposition au public par une importante société d'Amérique du Nord spécialisée dans la vente de produits Linux./
s/=TEXT3=/CentOS est parfaitement conforme aux normes édictées en amont par cette société et l'un de nos objectifs est d'être compatible à 100% au niveau des programmes binaires./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
