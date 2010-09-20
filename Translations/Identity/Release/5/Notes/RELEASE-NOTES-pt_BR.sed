# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: RELEASE-NOTES-pt_BR.sed 20 2010-09-11 08:50:50Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!CentOS =RELEASE= Release Notes!

# Welcome message.
s!=P1=!O projeto CentOS lhe dá as boas vindas ao CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!As notas completas de lançamento do CentOS =RELEASE= podem ser\
encontradas online em\
=P2_URL=!

# Frequently asked questions (FAQ)
s!=P3=!Uma lista das perguntas mais frequentes (FAQ) e suas respostas\
sobre o CentOS =MAJOR_RELEASE= pode ser encontrada aqui :\
=P3_URL=.!

# Getting Help
s!=P4=!Se você necessita de ajuda com o CentOS, recomendamos iniciar\
=P4_URL= para guiá-lo por diferentes\
maneiras para você obter ajuda.!

# CentOS HomePage
s!=P5=!Para maiores informações gerais sobre O Projeto CentOS, por\
favor visite nossa homepage em =P5_URL=.!

# Contribute
s!=P6=!Se você deseja contribuir para o Projeto CentOS, veja em\
=P6_URL= as maneiras como você poderia\
ajudar.!

# Url definition
s!=P2_URL=!http://wiki.centos.org/=LANG_CODE=/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/=LANG_CODE=/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/=LANG_CODE=/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/=LANG_CODE=/Contribute!g

# Language Code (ISO639)
s!=LANG_CODE=!pt_BR!g


# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g
