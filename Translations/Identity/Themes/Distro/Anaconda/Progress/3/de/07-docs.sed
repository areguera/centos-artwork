# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 07-docs.sed 4959 2010-03-18 02:27:24Z al $
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

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
