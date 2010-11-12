# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 03-yum.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Установка ПО при помощи Yum/
s!=TEXT1=!В CentOS рекомендуется управлять установкой, удалением, обновлением ПО при помощи <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellow Dog Updater).!
s!=TEXT2=!Более детальная информация доступна в руководстве "Managing Software with Yum", ссылка на которое приведена ниже.!
s!=TEXT3=!<flowSpan style="font-weight:bold">YumEx</flowSpan> - графический интерфейс для Yum. Он доступен в репозитории "CentOS Extras".!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!ru!g
