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


s/=TITLE=/Donations au projet CentOS/
s/=TEXT1=/L'organisation qui produit CentOS est nommée 'Le Projet CentOS'. Nous ne sommes affiliés avec aucune autre organisation./
s/=TEXT2=/Les donations constituent notre seule source de revenus pour l'achat de matériel et le support de la distribution de CentOS./
s/=TEXT3=/Envisagez la possibilité de faire une donation si vous trouvez le projet CentOS utile./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
