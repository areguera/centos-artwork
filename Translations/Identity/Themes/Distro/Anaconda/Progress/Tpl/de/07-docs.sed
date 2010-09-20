# ------------------------------------------------------------
# $Id: 07-docs.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS-Dokumentation/
s/=TEXT1=/Folgende Dokumentation ist für CentOS erhältlich:/
s!=TEXT2=!• Deployment Guide.!
s!=TEXT3=!• Installation Guide.!
s!=TEXT4=!• Virtualization Guide.!
s!=TEXT5=!• Cluster Administration.!
s/=TEXT6=/• Cluster Logical Volume Manager./
s/=TEXT7=/• Global Network Block Device./
s/=TEXT8=/• Virtual Server Administration./
s/=TEXT9=/• Managing Software with Yum./
s/=TEXT10=/• Using YumEx und Release-Notes für die Software/
s/=TEXT11=/• Global File System./
s!=TEXT12=!• Cluster Suite Overview.!
s/=TEXT13=/• /
s/=TEXT14=//
s/=TEXT15=//
s/=TEXT16=//
s/=TEXT17=//
s/=TEXT18=//
s/=TEXT19=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!
