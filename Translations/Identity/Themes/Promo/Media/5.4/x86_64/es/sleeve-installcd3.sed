# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: sleeve-installcd3.sed 4893 2010-03-13 17:06:33Z al $
# ------------------------------------------------------------


s!=TEXT=!CD instalador 3/6!
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
s!=ARCH=!x86_64!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!4!g
s!=MAJOR_RELEASE=!5!g
