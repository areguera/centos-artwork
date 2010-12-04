# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 04-repos.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Repositórios CentOS/
s!=TEXT1=!O CentOS dispõe dos seguintes repositórios para a instalação de software:!
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (aka <flowSpan style="font-weight:bold">[os]</flowSpan>) - RPMs contidos num ISO CentOS.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - Actualizações ao repositório [base].!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - Items do CentOS que não provêm do produtor original (não actualiza [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Items do CentOS que não provêm do produtor original (actualiza [base])!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!7!g

# Locale information.
s!=LOCALE=!pt!g
