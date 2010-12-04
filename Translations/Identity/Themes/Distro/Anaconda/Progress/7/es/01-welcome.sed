# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 01-welcome.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Bienvenidos a CentOS =MAJOR_RELEASE= !/
s/=TEXT1=/Gracias por instalar CentOS./
s/=TEXT2=/CentOS es una distribución Linux de clase empresarial derivado de fuentes libremente disponibles al público por un prominente vendedor Norteamericano de Linux Empresarial./
s/=TEXT3=/CentOS es compatible 100% con las políticas de distribución del proveedor y su objetivo es ser 100% compatible binario. CentOS realiza cambios en los paquetes para fundamentalmente eliminar las marcas y demás referencias comerciales del proveedor./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!7!g

# Locale information.
s!=LOCALE=!es!g
