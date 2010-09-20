# ------------------------------------------------------------
# $Id: 04-repos.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Репозитории CentOS/
s!=TEXT1=!Пользователям CentOS доступны следующие репозитории, из которых может быть установлено программное обеспечение:!
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (или <flowSpan style="font-weight:bold">[os]</flowSpan>) - Пакеты, входящие в состав дистрибутива.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - Обновления к репозиторию [base].!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - Дополнительные пакеты к репозиторию [base] (не могут заменять пакеты из [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Дополнительные пакеты к репозиторию [base] (могут заменять пакеты из [base]).!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories!
