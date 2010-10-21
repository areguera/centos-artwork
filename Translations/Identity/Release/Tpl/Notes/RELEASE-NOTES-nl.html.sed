# ------------------------------------------------------------
# $Id: RELEASE-NOTES-nl.html.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!CentOS =RELEASE= Release Notes!

# Welcome message.
s!=P1=!Het CentOS project verwelkomt je bij CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!De volledige aantekeningen voor CentOS =RELEASE= kunt u online\
vinden op =LINK_P2=.!

# Frequently asked questions (FAQ)
s!=P3=!Een lijst van veel gestelde vragen en antwoorden kunt u hier\
vinden =LINK_P3=.!

# Getting Help
s!=P4=!Als u op zoek bent naar hulp voor CentOS, raden we u aan\
=LINK_P4= te lezen voor verwijzingen naar\
verschillende informatiebronnen die u verder kunnen helpen.!

# CentOS HomePage
s!=P5=!Voor meer algemene informatie over het CentOS project kunt u\
onze website bezoeken op =LINK_P5=.!

# Contribute
s!=P6=!Als u graag wilt meehelpen aan het CentOS project, zie\
=LINK_P6= voor manieren waarop u dit\
kunt doen.!

# Link definition
s!=LINK_P2=!<a href="=P2_URL=">=P2_URL=</a>!
s!=LINK_P3=!<a href="=P3_URL=">=P3_URL=</a>!
s!=LINK_P4=!<a href="=P4_URL=">=P4_URL=</a>!
s!=LINK_P5=!<a href="=P5_URL=">=P5_URL=</a>!
s!=LINK_P6=!<a href="=P6_URL=">=P6_URL=</a>!

# Url definition
s!=P2_URL=!http://wiki.centos.org/=LOCALE=/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/=LOCALE=/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/=LOCALE=/Contribute!g

# XHTML document language code (ISO639)
s!=LOCALE=!nl!g

# XHTML document language direction (ltr|rtl)
s!=LANG_DIR=!ltr!g

