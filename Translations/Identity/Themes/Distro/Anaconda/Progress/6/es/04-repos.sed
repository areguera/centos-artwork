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


s/=TITLE=/Repositorios de software/
s!=TEXT1=!Los siguientes repositorios existen en CentOS desde los cuales se pueden instalar aplicaciones:!
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (alias <flowSpan style="font-weight:bold">[os]</flowSpan>) - RPMS presentes en los ficheros ISO de CentOS.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - Actualizaciones al repositorio [base].!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - Paquetes que no están presentes en el proveedor (no mejoran paquetes de [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Paquetes que no están presentes en el proveedor (mejoran paquetes de [base]).!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
