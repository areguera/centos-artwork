# ------------------------------------------------------------
# $Id: label-livecd.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s!=TEXT=!CD vivo!
s!=ARCH=!para arquitecturas =ARCH=!
s!=ARCH=!x86_64!

s!=COPYRIGHT=!Copyright © 2003-2010 The CentOS Project. Todos los derechos reservados.!g
s!=LICENSE=!La distribución CentOS es liberada como GPL.!
s!=URL=!http://www.centos.org/!
