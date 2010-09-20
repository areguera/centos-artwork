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


s/=TITLE=/Fai una donazione a CentOS/
s/=TEXT1=/The CentOS Project è l'organizzazione che produce CentOS. Noi non siamo affiliati con nessuna altra organizzazione./
s/=TEXT2=/La nostra unica fonte di apparati hardware e di finanziamento per la distribuzione di CentOS sono le donazioni./
s/=TEXT3=/Se pensi che CentOS sia utile, considera di contribuire tramite una donazione al CentOS Project./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
