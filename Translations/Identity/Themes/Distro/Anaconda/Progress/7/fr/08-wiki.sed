# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Le Wiki CentOS/
s/=TEXT1=/Il existe un projet de wiki collaboratif pour CentOS. On peut y trouver les Questions Fréquemment Posées, des HowTos, des Astuces et des Articles sur une série de sujets liés à CentOS, en ce compris l'installation de logiciel, les mises-à-jour, la configuration des dépôts et bien plus. /
s/=TEXT2=/Ce wiki répertorie également les événements liés à CentOS dans votre région ainsi que les apparitions de CentOS dans les médias./
s/=TEXT3=/Il suffit de demander la permission sur la liste de diffusion CentOS-Docs afin de pouvoir publier des articles, des astuces et des HowTos sur le wiki CentOS ... participez donc dès aujourd'hui !/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!7!g

# Locale information.
s!=LOCALE=!fr!g
