# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 07-docs.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Documentatie/
s!=TEXT1=!De volgende documentatie is beschikbaar voor CentOS:!
s!=TEXT2=!• Deployment Guide.!
s!=TEXT3=!• Installation Guide.!
s!=TEXT4=!• Virtualization Guide.!
s!=TEXT5=!• Cluster Suite Overview.!
s!=TEXT6=!• Cluster Administration.!
s!=TEXT7=!• Cluster Logical Volume Manager.!
s!=TEXT8=!• Global File System.!
s!=TEXT9=!• Global Network Block Device.!
s!=TEXT10=!• Release notes voor alle software!
s!=TEXT11=!• Managing Software with yum.!
s!=TEXT12=!• Using YumEx!
s!=TEXT13=!• Virtual Server Administration.!
s!=TEXT14=!!
s!=TEXT15=!!
s!=TEXT16=!!
s!=TEXT17=!!
s!=TEXT18=!!
s!=TEXT19=!!
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!nl!g
