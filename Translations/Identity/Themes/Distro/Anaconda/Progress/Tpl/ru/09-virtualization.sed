# ------------------------------------------------------------
# $Id: 09-virtualization.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Виртуализация в CentOS =MAJOR_RELEASE=/
s/=TEXT1=/CentOS =MAJOR_RELEASE= имеет поддержку полной виртуализации и паравиртуализации Xen для архитектур i386 и x86_64./
s/=TEXT2=/Более детальная информация по использованию виртуализации в CentOS =MAJOR_RELEASE= доступна в руководстах "Virtualization Guide" и "Virtual Server Administration Guide", ссылка на которые приведена ниже./
s/=TEXT3=//
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!
