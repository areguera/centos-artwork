# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: RELEASE-NOTES-fr.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!Notes spécifiques à CentOS =RELEASE=!

# Welcome message.
s!=P1=!Le projet CentOS vous souhaite la bienvenue dans CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!La version complète des notes spécifiques à CentOS =RELEASE= peut\
être consultée en ligne à l'adresse suivante : =P2_URL=.!

# Frequently asked questions (FAQ)
s!=P3=!Une liste de questions fréquemment posées (FAQ) sur CentOS =MAJOR_RELEASE=\
ainsi que leurs réponses peut être consultée ici : =P3_URL=.!

# Getting Help
s!=P4=!Si vous avez besoin d'aide concernant CentOS, nous vous\
recommandons de commencer par consulter la liste des sources d'aide\
disponibles sur =P4_URL=.!

# CentOS HomePage
s!=P5=!Pour plus d'informations sur le projet CentOS en général,\
veuillez vous rendre sur notre page d'accueil =P5_URL=.!

# Contribute
s!=P6=!Si vous souhaitez contribuer au projet CentOS, consultez la\
page =P6_URL= afin de connaitre les\
différentes manières de le faire.!

# Url definition
s!=P2_URL=!http://wiki.centos.org/=LOCALE=/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/=LOCALE=/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/=LOCALE=/Contribute!g

# Language Code (ISO639)
s!=LOCALE=!fr!g


# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
