# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: RELEASE-NOTES-de.sed 20 2010-09-11 08:50:50Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!CentOS =RELEASE= Release Notes!

# Welcome message.
s!=P1=!Das CentOS Projekt heißt Sie willkommen bei CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!Die vollständigen Release Notes für CentOS =RELEASE= finden Sie\
Online unter =P2_URL=.!

# Frequently asked questions (FAQ)
s!=P3=!Eine Liste der am häufigsten gestellten Fragen (FAQs) zu\
CentOS =MAJOR_RELEASE= ist hier verfügbar: =P3_URL=.!

# Getting Help
s!=P4=!Wenn Sie Hilfe für CentOS benötigen, dann finden Sie unter\
=P4_URL= eine Übersicht der verschiedenen\
Hilfequellen, die für CentOS existieren.!

# CentOS HomePage
s!=P5=!Um weitere allgemeine Informationen über das CentOS Projekt zu\
erhalten, besuchen Sie bitte die Homepage auf =P5_URL=.!

# Contribute
s!=P6=!Wenn Sie sich am CentOS Projekt beteiligen wollen, schlagen Sie\
bitte =P6_URL= nach. Dort sind Aufgaben\
gelistet bei denen Sie das CentOS Projekt unterstützen können.!

# Url definition
s!=P2_URL=!http://wiki.centos.org/=LANG_CODE=/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/=LANG_CODE=/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/=LANG_CODE=/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/=LANG_CODE=/Contribute!g

# Language Code (ISO639)
s!=LANG_CODE=!de!g


# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
