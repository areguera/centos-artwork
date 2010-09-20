# ------------------------------------------------------------
# $Id: 04-repos.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Repositories/
s!=TEXT1=!The following repositories exist in CentOS to install software from:!
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (aka <flowSpan style="font-weight:bold">[os]</flowSpan>) - The RPMS released on a CentOS ISO.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - Updates to the [base] repository.!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - Items by CentOS that are not upstream (does not upgrade [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Items by CentOS that are not upstream (does upgrade [base])!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories!
