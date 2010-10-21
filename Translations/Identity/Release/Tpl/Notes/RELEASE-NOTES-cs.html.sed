# ------------------------------------------------------------
# $Id: RELEASE-NOTES-cs.html.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------

# HTML header
s!=TITLE=!CentOS =RELEASE= Poznámky k vydání!

# Welcome message.
s!=P1=!CentOS projekt uvádí CentOS =RELEASE=.!

# Explain that release notes are now managed online.
s!=P2=!Poznámky k vydání jsou zveřejněny na adrese =LINK_P2=. !

# Frequently asked questions (FAQ)
s!=P3=!Seznam často kladených otázek k CentOS =MAJOR_RELEASE= a\
příslušné odpovědi naleznete na =LINK_P3=.!

# Getting Help
s!=P4=!Pokud hledáte nápovědu či pomoc týkající se CentOS,\
doporučujeme adresu =LINK_P4=.!

# Home page
s!=P5=!Zde jsou vyjmenovány jednotlivé zdroje, které mohou být\
vhodné. Informace o "CentOS projektu" naleznete na =LINK_P5=.!

# Contribute
s!=P6=!Na adrese =LINK_P6= naleznete informace, jak se můžete zapojit\
do vývoje a činnosti v rámci CentOS projektu.!

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
s!=LOCALE=!cs!g

# XHTML document language direction (ltr|rtl)
s!=LANG_DIR=!ltr!g

