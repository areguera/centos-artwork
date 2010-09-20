# ------------------------------------------------------------
# $Id: RELEASE-NOTES-pt_BR.html.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!CentOS =RELEASE= Release Notes!

# Welcome message.
s!=P1=!O projeto CentOS lhe dá as boas vindas ao CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!As notas completas de lançamento do CentOS =RELEASE= podem ser\
encontradas online em\
=LINK_P2=!

# Frequently asked questions (FAQ)
s!=P3=!Uma lista das perguntas mais frequentes (FAQ) e suas respostas\
sobre o CentOS =MAJOR_RELEASE= pode ser encontrada aqui :\
=LINK_P3=.!

# Getting Help
s!=P4=!Se você necessita de ajuda com o CentOS, recomendamos iniciar\
=LINK_P4= para guiá-lo por diferentes\
maneiras para você obter ajuda.!

# CentOS HomePage
s!=P5=!Para maiores informações gerais sobre O Projeto CentOS, por\
favor visite nossa homepage em =LINK_P5=.!

# Contribute
s!=P6=!Se você deseja contribuir para o Projeto CentOS, veja em\
=LINK_P6= as maneiras como você poderia\
ajudar.!

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
s!=LANG_CODE=!pt_BR!g

# XHTML document language direction (ltr|rtl)
s!=LANG_DIR=!ltr!g

