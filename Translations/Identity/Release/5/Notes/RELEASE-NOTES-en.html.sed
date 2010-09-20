# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: RELEASE-NOTES-en.html.sed 20 2010-09-11 08:50:50Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!CentOS =RELEASE= Release Notes!

# Welcome message.
s!=P1=!The CentOS project welcomes you to CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!The complete release notes for CentOS =RELEASE= can be\
found online at: =LINK_P2=.!

# Frequently asked questions (FAQ)
s!=P3=!A list of frequently asked questions and answers about\
CentOS =MAJOR_RELEASE= can be found here: =LINK_P3=.!

# Getting Help
s!=P4=!If you are looking for help with CentOS, we recommend you\
start at =LINK_P4= for pointers to the different sources where\
you can get help.!

# CentOS HomePage
s!=P5=!For more information about The CentOS Project in general\
please visit our homepage at: =LINK_P5=.!

# Contribute
s!=P6=!If you would like to contribute to the CentOS Project, \
see =LINK_P6= for areas where you could help.!

# Link definition
s!=LINK_P2=!<a href="=P2_URL=">=P2_URL=</a>!
s!=LINK_P3=!<a href="=P3_URL=">=P3_URL=</a>!
s!=LINK_P4=!<a href="=P4_URL=">=P4_URL=</a>!
s!=LINK_P5=!<a href="=P5_URL=">=P5_URL=</a>!
s!=LINK_P6=!<a href="=P6_URL=">=P6_URL=</a>!

# Url definition
s!=P2_URL=!http://wiki.centos.org/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/Contribute!g

# XHTML document language code (ISO639)
s!=LANG_CODE=!en!g

# XHTML document language direction (ltr|rtl)
s!=LANG_DIR=!ltr!g


# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g
