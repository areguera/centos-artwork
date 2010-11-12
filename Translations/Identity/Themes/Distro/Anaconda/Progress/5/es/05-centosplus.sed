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


s/=TITLE=/Repositorio CentOSPlus/
s/=TEXT1=/Este repositorio es para paquetes que actualizarán ciertos componentes del repositorio base. Este repo cambiará a CentOS de forma tal que ya no será exactamente como los contenidos del proveedor./
s/=TEXT2=/El equipo de desarrollo de CentOS ha probado cada paquete de este repositorio, y cada uno compila y trabaja bajo CentOS =MAJOR_RELEASE=. Estos mismos paquetes no han sido probados por el proveedor ni están disponibles entre sus productos./
s/=TEXT3=/El uso de estos paquetes elimina la compatibilidad binaria del 100% respecto a los paquetes del proveedor./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!es!g
