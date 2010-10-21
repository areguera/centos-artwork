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


s!=TITLE=!Podpora a pomoc CentOS!;
s!=TEXT1=!Je několik způsobů, jak se dobrat podpory k CentOS:!;
s!=TEXT2=!<flowSpan style="font-weight:bold">Internet Relay Chat (IRC)</flowSpan> - #centos, #centos-social a #centos-devel na irc.freenode.net!;
s!=TEXT3=!<flowSpan style="font-weight:bold">Konference</flowSpan> - CentOS, CentOS-Devel, CentOS-Announce a několik neanglických, včetně české konference, viz http://lists.centos.org/!;
s!=TEXT4=!<flowSpan style="font-weight:bold">Forums</flowSpan> - Viz http://www.centos.org/forums/.!;
s!=TEXT5=!<flowSpan style="font-weight:bold">Wiki</flowSpan>: Viz http://wiki.centos.org/=LOCALE=/!;
s!=TEXT6=!!;
s!=URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!;

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!cs!g
