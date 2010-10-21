# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 04-repos.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Software repositories/
s!=TEXT1=!CentOS kent deze repositories voor de installatie van software:!
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (aka <flowSpan style="font-weight:bold">[os]</flowSpan>) - De RPMS die op de CentOS ISO's staan.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - Updates voor de [base] repository.!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - Extra onderdelen voor CentOS (vervangt geen pakketten uit [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Extra onderdelen voor CentOS (vervangt pakketten uit [base]).!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!nl!g
