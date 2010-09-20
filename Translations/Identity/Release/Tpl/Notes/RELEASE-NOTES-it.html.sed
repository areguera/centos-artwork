# ------------------------------------------------------------
# $Id: RELEASE-NOTES-it.html.sed 13 2010-09-10 09:55:59Z al $
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
s!=LANG_CODE=!it!g

# XHTML document language direction (ltr|rtl)
s!=LANG_DIR=!ltr!g

