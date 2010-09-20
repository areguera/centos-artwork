# ------------------------------------------------------------
# $Id: RELEASE-NOTES-ro.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------

# Header content
s!=TITLE=!CentOS =RELEASE= Release Notes!

# Welcome message.
s!=P1=!Proiectul Centos va ureaza bun venit la CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!Versiunea completa pt versiunea =RELEASE= a informatiilor de\
lansare poate fi gasita online la adresa =P2_URL=.!

# Frequently asked questions (FAQ)
s!=P3=!O lista cu intrebari si raspunsuri frecvente pentru CentOS\
=MAJOR_RELEASE= poate fi gasita la =P3_URL=.!

# Getting Help
s!=P4=!Daca sinteti in cautare de ajutor pt CentOS, va recomandam sa\
incepeti de lai =P4_URL= pentru informatii asupra diferitelor moduri\
prin care puteti cere ajutor.!

# CentOS HomePage
s!=P5=!Pentru mai multe informatii asupra Proiectului Centos in\
general, va rugam sa vizitati pagina noastra de intrare, =P5_URL=.!

# Contribute
s!=P6=!Daca doriti sa contribuiti la Proiectul Centos, va rugam sa\
cititi la =P6_URL= despre modurile in care puteti fi de ajutor.!

# Url definition
s!=P2_URL=!http://wiki.centos.org/=LANG_CODE=/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/=LANG_CODE=/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/=LANG_CODE=/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/=LANG_CODE=/Contribute!g

# Language Code (ISO639)
s!=LANG_CODE=!ro!g

