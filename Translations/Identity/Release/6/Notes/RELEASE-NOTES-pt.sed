# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: RELEASE-NOTES-pt.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!CentOS =RELEASE= Release Notes!

# Welcome message.
s!=P1=!!

# Explain that release notes are now managed online.
s!=P2=!!

# Frequently asked questions (FAQ)
s!=P3=!!

# Getting Help
s!=P4=!!

# CentOS HomePage
s!=P5=!!

# Contribute
s!=P6=!!

# Url definition
s!=P2_URL=!http://wiki.centos.org/=LOCALE=/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/=LOCALE=/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/=LOCALE=/Contribute!g

# Language Code (ISO639)
s!=LOCALE=!pt!g


# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
