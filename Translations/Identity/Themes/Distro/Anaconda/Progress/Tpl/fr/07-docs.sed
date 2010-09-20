# ------------------------------------------------------------
# $Id: 07-docs.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Documentation pour CentOS/
s/=TEXT1=/La documentation CentOS (en anglais):/
s/=TEXT2=/• Deployment Guide/
s/=TEXT3=/• Installation Guide/
s/=TEXT4=/• Virtualization Guide/
s/=TEXT5=/• Cluster Suite Overview/
s/=TEXT6=/• Cluster Suite Overview/
s/=TEXT7=/• Cluster Logical Volume Manager/
s/=TEXT8=/• Global File System/
s/=TEXT9=/• Global Network Block Device/
s/=TEXT10=/• Notes accompagnant tous les logiciels/
s/=TEXT11=/• Managing Software with yum/
s/=TEXT12=/• Using YumEx/
s/=TEXT13=/• Virtual Server Administration/
s/=TEXT14=//
s/=TEXT15=//
s/=TEXT16=//
s/=TEXT17=//
s/=TEXT18=//
s/=TEXT19=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!
