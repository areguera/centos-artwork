# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 09-virtualization.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Virtualisatie met CentOS =MAJOR_RELEASE=/
s!=TEXT1=!CentOS =MAJOR_RELEASE= levert virtualisatie met behulp van Xen voor de i386 en x86_64 architecturen, zowel volledig gevirtualiseerd als para-gevirtualiseerd.!
s!=TEXT2=!De "Virtualization Guide" en de "Virtual Server Administration Guide" zijn beschikbaar via onderstaande link.!
s!=TEXT3=!!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!nl!g
