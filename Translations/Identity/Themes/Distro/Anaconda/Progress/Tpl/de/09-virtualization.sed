# ------------------------------------------------------------
# $Id: 09-virtualization.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Virtualisierung unter CentOS =MAJOR_RELEASE=/
s/=TEXT1=/CentOS =MAJOR_RELEASE= enthält Xen für i386 und x86_64, um sowohl vollständige Virtualisierung als auch Paravirtualisierung von Rechnern zu ermöglichen./
s!=TEXT2=!Der "Virtualization Guide" und der "Virtual Server Administration Guide" werden für weiterführende Informationen bereitgestellt.!
s!=TEXT3=!!
s!=TEXT4=!!
s!=TEXT4=!!
s!=TEXT5=!!
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!
