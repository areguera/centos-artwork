# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 09-virtualization.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Virtualization on CentOS =MAJOR_RELEASE=/
s/=TEXT1=/CentOS =MAJOR_RELEASE= থেকে অাপনি virtualization পাবেন ভায়া Xen i386 এবং x86_64 দুটো পলাটফরমের জনন   পুরো virtualized এবং অাংশিক virtualized মোড./
s/=TEXT2=/Virtualization Guide এবং Virtual Server Administration Guide অাপনি সাহায পাবেন CentOS =MAJOR_RELEASE= virtualization এর জনন নিমনলিখিত লিংকে./
s/=TEXT3=//
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!7!g

# Locale information.
s!=LOCALE=!bn_IN!g
