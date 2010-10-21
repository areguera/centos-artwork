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


s/=TITLE=/Repository-urile Centos/
s/=TEXT1=/Pe durata instalarii exista urmatoarele repository-uri ce se pot folosi ca surse de programe:/
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (alias <flowSpan style="font-weight:bold">[os]</flowSpan> - Pachetele incluse in imaginea ISO.)!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - Actualizari ale pachetelor din [base].!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - Pachete furnizate de CentOS, neincluse in distributia originala (nu afecteaza pachetele din [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> -  Pachete furnizate de CentOS, neincluse in distributia originala (actualizeaza pachete din [base]).!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!ro!g
