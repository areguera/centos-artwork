# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 05-centosplus.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/Le dépôt CentOS Plus/
s/=TEXT1=/Ce dépôt contient des composants qui mettent à jour la base de CentOS. Son utilisation modifiera donc potentiellement CentOS de manière significative. La distribution pourrait alors ne plus être exactement conforme à celle utilisée en amont comme référence./
s/=TEXT2=/L'équipe de développement CentOS a testé chaque composant de ce dépôt, et ces composants sont compilés et fonctionnent sur CentOS. Ils n'ont cependant pas été testés par le fournisseur en amont, et ne sont pas non plus disponibles dans les produits de la société en amont./
s/=TEXT3=//
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
