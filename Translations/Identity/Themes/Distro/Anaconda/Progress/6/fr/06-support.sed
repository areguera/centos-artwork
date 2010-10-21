# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 06-support.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Obtenir de l'aide pour CentOS/
s/=TEXT1=/Vous disposez de nombreuses manières pour obtenir de l'aide à propos de CentOS :/
s!=TEXT2=!<flowSpan style="font-weight:bold">Internet Relay Chat (IRC)</flowSpan> - #centos, #centos-social et #centos-devel sur irc.freenode.net!
s!=TEXT3=!<flowSpan style="font-weight:bold">Mailing Lists</flowSpan> - CentOS, CentOS-Devel, CentOS-Announce ainsi qu'une liste dédiée en français : CentOS-FR. Voir http://lists.centos.org!
s!=TEXT4=!<flowSpan style="font-weight:bold">Forums</flowSpan> - Disponibles ici : http://www.centos.org/forums/!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!fr!g
