# ------------------------------------------------------------
# $Id: RELEASE-NOTES-ru.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!!

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
s!=P2_URL=!http://wiki.centos.org/=LANG_CODE=/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/=LANG_CODE=/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/=LANG_CODE=/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/=LANG_CODE=/Contribute!g

# Language Code (ISO639)
s!=LANG_CODE=!ru!g

