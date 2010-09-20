# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: eula.es.sed 20 2010-09-11 08:50:50Z al $
# ------------------------------------------------------------

s!=TITLE=!CentOS =RELEASE= EULA!

s!=P1=!CentOS =RELEASE= viene sin garantías o respaldos escritos o\
implícitos de ningún tipo.!

s!=P2=!La distribución es liberada bajo los términos de la licencia\
GPL. Los paquetes individuales dentro de la distribución vienen con\
sus propias licencias.!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g
