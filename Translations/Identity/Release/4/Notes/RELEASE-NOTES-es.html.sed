# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: RELEASE-NOTES-es.html.sed 20 2010-09-11 08:50:50Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!Notas de la publicación de CentOS =RELEASE=!

# Welcome message.
s!=P1=!El proyecto CentOS le da la bienvenida a CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!Las notas completas para esta versión puede encontrarse en: \
=LINK_P2=.!

# Frequently asked questions (FAQ)
s!=P3=!Una lista de las preguntas y respuestas más frecuentes acerca\
de CentOS =MAJOR_RELEASE= puede encontrarse en: =LINK_P3=.!

# Getting Help
s!=P4=!Si usted está buscando ayuda con CentOS nosotros le\
recomendamos empezar visitando la página =LINK_P4=, allí encontrará\
indicaciones sobre dónde y cómo obtener ayuda.!

# CentOS HomePage
s!=P5=!Para mayor información acerca de El Proyecto CentOS en general\
le recomendamos visitar nuestra página web =LINK_P5=. !

# Contribute
s!=P6=!Si usted desea contribuir al Proyecto CentOS, busque en\
=LINK_P6= tópicos o áreas donde usted\
puede ayudar.!

# Link definition
s!=LINK_P2=!<a href="=P2_URL=">=P2_URL=</a>!
s!=LINK_P3=!<a href="=P3_URL=">=P3_URL=</a>!
s!=LINK_P4=!<a href="=P4_URL=">=P4_URL=</a>!
s!=LINK_P5=!<a href="=P5_URL=">=P5_URL=</a>!
s!=LINK_P6=!<a href="=P6_URL=">=P6_URL=</a>!

# Url definition
s!=P2_URL=!http://wiki.centos.org/=LANG_CODE=/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/=LANG_CODE=/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/=LANG_CODE=/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/=LANG_CODE=/Contribute!g

# XHTML document language code (ISO639)
s!=LANG_CODE=!es!g

# XHTML document language direction (ltr|rtl)
s!=LANG_DIR=!ltr!g


# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g
