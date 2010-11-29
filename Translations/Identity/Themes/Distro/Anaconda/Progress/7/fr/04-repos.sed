# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 04-repos.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Dépôts CentOS/
s/=TEXT1=/Les dépôts suivants sont disponibles pour installer des logiciels dans CentOS:/
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (aka <flowSpan style="font-weight:bold">[os]</flowSpan>) - RPMS disponibles sur l'image ISO CentOS.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - Mises-à-jour du dépôt [base].!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - Composants additionels non disponible en amont (ne mets pas à jour [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Composants additionels non disponible en amont (mets à jour [base]).!
s!=TEXT6=!!
s!=URL=!http://mirror.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!fr!g
