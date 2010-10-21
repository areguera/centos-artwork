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


s/=TITLE=/Ajuda com o CentOS/
s!=TEXT1=!Você pode obter ajuda com o CentOS de várias formas, incluindo:!
s!=TEXT2=!<flowSpan style="font-weight:bold">Internet Relay Chat (IRC)</flowSpan> - #centos, #centos-social e #centos-devel em irc.freenode.net.!
s!=TEXT3=!<flowSpan style="font-weight:bold">Listas de email</flowSpan> - CentOS, CentOS-Devel, CentOS-Announce e listas locais em diversos idiomas que podem ser encontradas em http://lists.centos.org/.!
s!=TEXT4=!<flowSpan style="font-weight:bold">Fórum</flowSpan> - Disponível em http://www.centos.org/forums/.!
s!=TEXT5=!<flowSpan style="font-weight:bold">Wiki</flowSpan> - Disponível em http://wiki.centos.org/=LOCALE=/.!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!pt_BR!g
