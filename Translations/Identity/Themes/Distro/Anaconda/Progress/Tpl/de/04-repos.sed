# ------------------------------------------------------------
# $Id: 04-repos.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Software-Repositories/
s/=TEXT1=/Software für CentOS ist in den folgenden Repositories verfügbar:/
s!=TEXT2=!1. <flowSpan style="font-weight:bold">[base]</flowSpan> (bzw. <flowSpan style="font-weight:bold">[os]</flowSpan>) - Die RPMs der eigentlichen Distribution.!
s!=TEXT3=!2. <flowSpan style="font-weight:bold">[updates]</flowSpan> - Updates für die Software im [base]-Repository.!
s!=TEXT4=!3. <flowSpan style="font-weight:bold">[extras]</flowSpan> - Zusätzliche Software für CentOS, ersetzt keine Pakete aus [base].!
s!=TEXT5=!4. <flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Zusätzliche Software für CentOS, ersetzt Software aus [base].!
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories!
