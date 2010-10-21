# ------------------------------------------------------------
# $Id: RELEASE-NOTES-ro.html.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!CentOS =RELEASE= Release Notes!

# Welcome message.
s!=P1=!Proiectul Centos va ureaza bun venit la CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!Versiunea completa pt versiunea =RELEASE= a informatiilor de lansare\
poate fi gasita online la adresa\
=LINK_P2=.!

# Frequently asked questions (FAQ)
s!=P3=!O lista cu intrebari si raspunsuri frecvente pentru CentOS =MAJOR_RELEASE=\
poate fi gasita la =LINK_P3=.!

# Getting Help
s!=P4=!Daca sinteti in cautare de ajutor pt CentOS, va recomandam sa\
incepeti de lai =LINK_P4= pentru informatii\
asupra diferitelor moduri prin care puteti cere ajutor.!

# CentOS HomePage
s!=P5=!Pentru mai multe informatii asupra Proiectului Centos in\
general, va rugam sa vizitati pagina noastra de intrare,\
=LINK_P5=.!

# Contribute
s!=P6=!Daca doriti sa contribuiti la Proiectul Centos, va rugam sa\
cititi la =LINK_P6= despre modurile in\
care puteti fi de ajutor.!

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
s!=LOCALE=!ro!g

# XHTML document language direction (ltr|rtl)
s!=LANG_DIR=!ltr!g

