# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 06-support.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Ottenere aiuto con CentOS/
s/=TEXT1=/Ci sono diversi modi per ottenere aiuto con CentOS:/
s!=TEXT2=!<flowSpan style="font-weight:bold">Internet Relay Chat (IRC)</flowSpan> - #centos e #centos-devel su irc.freenode.net!
s!=TEXT3=!<flowSpan style="font-weight:bold">Mailing lists</flowSpan>- Le liste CentOS, CentOS-Devel e CentOS-Announce oltre a liste di discussione non anglofone su http://lists.centos.org!
s!=TEXT4=!<flowSpan style="font-weight:bold">I Forum</flowSpan> -  Disponibili all'indirizzo http://www.centos.org/modules/newbb!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!it!g
