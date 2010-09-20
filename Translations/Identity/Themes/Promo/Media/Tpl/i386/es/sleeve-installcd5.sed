# ------------------------------------------------------------
# $Id: sleeve-installcd5.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s!=TEXT=!CD instalador 5/6!
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
