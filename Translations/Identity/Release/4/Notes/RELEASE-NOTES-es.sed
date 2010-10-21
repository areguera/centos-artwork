# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: RELEASE-NOTES-es.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!Notas de la publicación de CentOS =RELEASE=!

# Welcome message.
s!=P1=!El proyecto CentOS le da la bienvenida a CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!Las notas completas para esta versión puede encontrarse en: \
=P2_URL=.!

# Frequently asked questions (FAQ)
s!=P3=!Una lista de las preguntas y respuestas más frecuentes acerca\
de CentOS =MAJOR_RELEASE= puede encontrarse en: =P3_URL=.!

# Getting Help
s!=P4=!Si usted está buscando ayuda con CentOS nosotros le\
recomendamos empezar visitando la página =P4_URL=, allí encontrará\
indicaciones sobre dónde y cómo obtener ayuda.!

# CentOS HomePage
s!=P5=!Para mayor información acerca de El Proyecto CentOS en general\
le recomendamos visitar nuestra página web =P5_URL=. !

# Contribute
s!=P6=!Si usted desea contribuir al Proyecto CentOS, busque en\
=P6_URL= tópicos o áreas donde usted\
puede ayudar.!

# Url definition
s!=P2_URL=!http://wiki.centos.org/=LOCALE=/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/=LOCALE=/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/=LOCALE=/Contribute!g

# Language Code (ISO639)
s!=LOCALE=!es!g


# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g
