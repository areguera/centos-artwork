# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: RELEASE-NOTES-en.sed 20 2010-09-11 08:50:50Z al $
# ------------------------------------------------------------

# Header content.
s!=TITLE=!CentOS =RELEASE= Release Notes!

# Welcome message.
s!=P1=!The CentOS project welcomes you to CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!The complete release notes for CentOS =RELEASE= can be found\
online at: =P2_URL=.!

# Frequently asked questions (FAQ)
s!=P3=!A list of frequently asked questions and answers about CentOS\
=MAJOR_RELEASE= can be found here: =P3_URL=.!

# Getting Help
s!=P4=!If you are looking for help with CentOS, we recommend you\
start at =P4_URL= for pointers to the different sources where you can\
get help.!

# Home page
s!=P5=!For more information about The CentOS Project in general\
please visit our homepage at: =P5_URL=.!

# Contribute
s!=P6=!If you would like to contribute to the CentOS Project, see\
=P6_URL= for areas where you could help.!

# Url definitions
s!=P2_URL=!http://wiki.centos.org/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/Contribute!g


# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
