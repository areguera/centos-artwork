# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 03-yum.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Gérer les applications avec Yum/
s!=TEXT1=!Pour installer ou mettre à jour CentOS, il est recommandé d'utiliser l'outil <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellow Dog Updater, Modified).!
s/=TEXT2=/Consultez aussi la documentation (en anglais) : 'Managing Software with Yum' en suivant le lien ci-dessous./
s!=TEXT3=!<flowSpan style="font-weight:bold">YumEx</flowSpan>, une interface graphique pour Yum, est également disponible dans le dépôt CentOS Extras.!
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!7!g

# Locale information.
s!=LOCALE=!fr!g
