# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 06-support.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/Ajuda com o CentOS/
s!=TEXT1=!Pode obter ajuda com o CentOS de diversos modos, tais como:!
s!=TEXT2=!<flowSpan style="font-weight:bold">Internet Relay Chat (IRC)</flowSpan> - #centos, #centos-social and #centos-devel em irc.freenode.net.!
s!=TEXT3=!<flowSpan style="font-weight:bold">Mailing Lists</flowSpan> - CentOS, CentOS-Devel, CentOS-Annouces e listas localizadas, em línguas para além do Inglês, a partir de http://lists.centos.org/.!
s!=TEXT4=!<flowSpan style="font-weight:bold">Forums</flowSpan> - Disponível em http://www.centos.org/forums/.!
s!=TEXT5=!<flowSpan style="font-weight:bold">Wiki</flowSpan> - Disponível em http://wiki.centos.org/.!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g
