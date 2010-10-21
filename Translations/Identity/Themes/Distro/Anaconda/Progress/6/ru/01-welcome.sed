# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 01-welcome.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Добро пожаловать в CentOS =MAJOR_RELEASE=!/
s/=TEXT1=/Благодарим Вас за выбор CentOS =MAJOR_RELEASE=./
s/=TEXT2=/CentOS - это дистрибутив Linux промышленного уровня, полученный из свободно распространяемых известным северо-американским поставщиком Linux исходных текстов./
s/=TEXT3=/CentOS полностью соответствует политике распространения исходного дистрибутива и стремится быть на 100% совместимым с ним на уровне двоичного кода. CentOS преимущественно изменяет пакеты для удаления из них торговых марок и графических изображений поставщика исходного дистрибутива./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!ru!g
