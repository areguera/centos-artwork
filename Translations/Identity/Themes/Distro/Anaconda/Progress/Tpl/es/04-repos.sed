# ------------------------------------------------------------
# $Id: 04-repos.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Repositorios de software/
s!=TEXT1=!Los siguientes repositorios existen en CentOS desde los cuales se pueden instalar aplicaciones:!
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (alias <flowSpan style="font-weight:bold">[os]</flowSpan>) - RPMS presentes en los ficheros ISO de CentOS.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - Actualizaciones al repositorio [base].!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - Paquetes que no están presentes en el proveedor (no mejoran paquetes de [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Paquetes que no están presentes en el proveedor (mejoran paquetes de [base]).!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories!
