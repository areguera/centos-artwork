# ------------------------------------------------------------
# $Id: 07-docs.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Documentatie pentru CentOS/
s/=TEXT1=/Pentru CentOS sint disponibile urmatoarele seturi de documente:/
s/=TEXT2=/• Ghid de implementare./
s/=TEXT3=/• Ghid pentru virtualizare./
s/=TEXT4=/• Clustere - Prezentare generala./
s/=TEXT5=/• Administrarea clusterelor./
s/=TEXT6=/• Logical Volume Manager pt clustere./
s/=TEXT7=/• Administrarea programelor cu Yum./
s/=TEXT8=/• Administrarea serverelor virtuale./
s/=TEXT9=/• Global Network Block Device./
s/=TEXT10=/• Note de lansare pentru toate programele./
s/=TEXT11=/• Ghid de instalare./
s/=TEXT12=/• Utilizarea YumEx./
s/=TEXT13=/• Global File System./
s/=TEXT14=//
s/=TEXT15=//
s/=TEXT16=//
s/=TEXT17=//
s/=TEXT18=//
s/=TEXT19=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!
