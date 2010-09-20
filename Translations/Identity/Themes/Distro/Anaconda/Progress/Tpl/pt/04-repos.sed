# ------------------------------------------------------------
# $Id: 04-repos.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Repositórios CentOS/
s!=TEXT1=!O CentOS dispõe dos seguintes repositórios para a instalação de software:!
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (aka <flowSpan style="font-weight:bold">[os]</flowSpan>) - RPMs contidos num ISO CentOS.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - Actualizações ao repositório [base].!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - Items do CentOS que não provêm do produtor original (não actualiza [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Items do CentOS que não provêm do produtor original (actualiza [base])!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories!
