# ------------------------------------------------------------
# $Id: RELEASE-NOTES-cs.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------

# HTML header
s!=TITLE=!CentOS =RELEASE= Poznámky k vydání!

# Welcome message.
s!=P1=!CentOS projekt uvádí CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!Poznámky k vydání jsou zveřejněny na adrese \
=P2_URL=. !

# Frequently asked questions (FAQ)
s!=P3=!Seznam často kladených otázek k CentOS =MAJOR_RELEASE= a\
příslušné odpovědi naleznete na =P3_URL=.!

# Getting Help
s!=P4=!Pokud hledáte nápovědu či pomoc týkající se CentOS,\
doporučujeme adresu =P4_URL=.!

# Home page
s!=P5=!Zde jsou vyjmenovány jednotlivé zdroje, které mohou být\
vhodné. Informace o "CentOS projektu" naleznete na =P5_URL=.!

# Contribute
s!=P6=!Na adrese =P6_URL= naleznete informace, jak se můžete zapojit\
do vývoje a činnosti v rámci CentOS projektu.!

# Url definition
s!=P2_URL=!http://wiki.centos.org/=LOCALE=/Manuals/ReleaseNotes/CentOS=RELEASE=!g
s!=P3_URL=!http://wiki.centos.org/=LOCALE=/FAQ/CentOS=MAJOR_RELEASE=!g
s!=P4_URL=!http://wiki.centos.org/=LOCALE=/GettingHelp!g
s!=P5_URL=!http://www.centos.org/!g
s!=P6_URL=!http://wiki.centos.org/=LOCALE=/Contribute!g

# Language Code (ISO639)
s!=LOCALE=!cs!g

