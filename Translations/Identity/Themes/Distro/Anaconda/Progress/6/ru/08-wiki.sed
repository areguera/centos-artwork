# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/Вики CentOS/
s/=TEXT1=/Вики CentOS включает в себя список наиболее часто задаваемых вопросов, различные руководства, описывающие установку, обновление программного обеспечения, настройку, использование репозиториев и многое другое./
s/=TEXT2=/Вики также содержит информацию о событиях CentOS./
s/=TEXT3=/Пользователи CentOS могут получить доступ на редактирование и добавление различных статей в Вики. Внеси свой вклад в развитие CentOS сегодня!/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
