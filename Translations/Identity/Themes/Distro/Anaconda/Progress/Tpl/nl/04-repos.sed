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
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories/!
