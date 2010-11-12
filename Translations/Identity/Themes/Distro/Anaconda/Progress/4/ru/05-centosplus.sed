# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 05-centosplus.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Репозиторий CentOS Plus/
s/=TEXT1=/Данный репозиторий предназначен для пакетов, которые обновляют те, что входят в состав базового репозитория. Он вносит в CentOS изменения, которые отсутствуют в исходном дистрибутиве./
s/=TEXT2=/Данные пакеты не тестируются поставщиком исходного дистрибутива и не доступны в его продуктах./
s/=TEXT3=/Вы должны понимать, что использование данного репозитория нарушает 100% совместимость на уровне двоичного кода с исходным дистрибутивом./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!ru!g
