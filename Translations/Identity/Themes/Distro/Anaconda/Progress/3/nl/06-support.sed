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


s/=TITLE=/Hulp voor CentOS/
s!=TEXT1=!U kunt op verschillende manieren hulp krijgen voor CentOS, zoals:!
s!=TEXT2=!<flowSpan style="font-weight:bold">Internet Relay Chat (IRC)</flowSpan> - #centos en #centos-devel op irc.freenode.net!
s!=TEXT3=!<flowSpan style="font-weight:bold">Mailing lijsten</flowSpan> - centos, centos-devel, centos-announce en mailing lijsten in andere talen via http://lists.centos.org!
s!=TEXT4=!<flowSpan style="font-weight:bold">Forums</flowSpan> - beschikbaar op http://www.centos.org/modules/newbb/!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!nl!g
