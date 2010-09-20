# ------------------------------------------------------------
# $Id: 09-virtualization.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Virtualizace na CentOS =MAJOR_RELEASE=/;
s/=TEXT1=/Na CentOS =MAJOR_RELEASE= i386 a x86_64 je možné provozovat virtualizaci pomocí software Xen, a to jak plnou virtualizaci, tak paravirtualizaci./;
s/=TEXT2=/The Virtualization Guide a Virtual Server Administration Guide naleznete na níže uvedeném odkazu./;
s/=TEXT3=//;
s/=TEXT4=//;
s/=TEXT5=//;
s/=TEXT6=//;
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!;
