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


s/=TITLE=/কেমন করে সাহায পাবেন CentOS/
s!=TEXT1=!অাপনি বিভিনন ভাবে  CentOS থেকে সাহায পেতে পারেন,যেগুলো হল:!
s!=TEXT2=!<flowSpan style="font-weight:bold">Internet Relay Chat (IRC)</flowSpan> - #centos, #centos-social এবং #centos-devel পাবেন এই চানেলে irc.freenode.net.!
s!=TEXT3=!<flowSpan style="font-weight:bold">Mailing Lists</flowSpan> - CentOS, CentOS-Devel, CentOS-Annouces এবং English ছাড়া অনন ভাষার তালিকা পাবেন এই সাইট থেকে http://lists.centos.org/.!
s!=TEXT4=!<flowSpan style="font-weight:bold">Forums</flowSpan> - এটি পাবেন এই সাইট থেকেhttp://www.centos.org/forums/.!
s!=TEXT5=!<flowSpan style="font-weight:bold">Wiki</flowSpan> -  এটি পাবেন এই সাইট থেকে http://wiki.centos.org/=LOCALE=/.!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!bn_IN!g
