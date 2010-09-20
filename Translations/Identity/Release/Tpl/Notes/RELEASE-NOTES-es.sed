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
s!=P2_URL=!http://wiki.centos.org/=LANG_CODE=/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/=LANG_CODE=/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/=LANG_CODE=/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/=LANG_CODE=/Contribute!g

# Language Code (ISO639)
s!=LANG_CODE=!es!g

