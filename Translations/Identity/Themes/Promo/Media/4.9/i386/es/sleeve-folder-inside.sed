# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: sleeve-folder-inside.sed 4893 2010-03-13 17:06:33Z al $
# ------------------------------------------------------------


s!=LEFTCD_TEXT=!DVD instalador!

s!=LEFTCD_MSG=!Use este DVD si desea instalar CentOS en su\
computadora. Para instalar CentOS, ponga el DVD en la unidad de DVD,\
reinicie la computadora y siga las direcciones en la pantalla.!

s!=RIGHTCD_TEXT=!CD vivo!

s!=RIGHTCD_MSG=!Este CD contiene un sistema CentOS que puede utilizar\
de forma segura sin alterar los ficheros en su computadora. Para\
probar CentOS, ponga el CD en la unidad de CD y reinicie su\
computadora.!

s!=ARCH=!para arquitecturas =ARCH=!

s!=MESSAGE1_HEAD=!¿Qué es CentOS?!

s!=MESSAGE1_P1=!CentOS es una distribución de Linux Empresarial\
basada en los paquetes fuentes libremente disponibles de Red Hat\
Enterprise Linux. Cada versión de CentOS es manteninda durante 7 años\
(por medio de actualizaciones de seguridad).!

s!=MESSAGE1_P2=!Una versión nueva de CentOS es liberada cada 2 años y\
cada versión de CentOS es actualizada regularmente (cada 6 meses)\
para mantener hardware nuevo.!

s!=MESSAGE1_P3=!Esto resulta un entorno seguro, de baja mantención,\
confiable, predecible y reproducible.!

s!=URL=!http://www.centos.org/!
s!=ARCH=!i386!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!9!g
s!=MAJOR_RELEASE=!4!g
