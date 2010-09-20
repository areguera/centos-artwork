# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 02-donate.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/Поддержка проекта CentOS/
s/=TEXT1=/Организация, производящая CentOS, называется "CentOS Project". Мы не являемся дочерней компанией какой-либо другой организации./
s/=TEXT2=/Финансирование затрат на приобретение аппаратного обеспечения и распространение CentOS производится за счет пожертвований./
s/=TEXT3=/Пожалуйста, поддержите проект, если CentOS полезен Вам./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
