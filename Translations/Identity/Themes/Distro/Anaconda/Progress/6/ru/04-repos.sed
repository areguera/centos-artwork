# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 04-repos.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/Репозитории CentOS/
s!=TEXT1=!Пользователям CentOS доступны следующие репозитории, из которых может быть установлено программное обеспечение:!
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (или <flowSpan style="font-weight:bold">[os]</flowSpan>) - Пакеты, входящие в состав дистрибутива.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - Обновления к репозиторию [base].!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - Дополнительные пакеты к репозиторию [base] (не могут заменять пакеты из [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Дополнительные пакеты к репозиторию [base] (могут заменять пакеты из [base]).!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
