# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Wiki/
s!=TEXT1=!Pe site-ul wiki al CentOS sint oferite numeroase informatii, precum raspunsuri la intrebari frecvente, HowTo-uri, "Tips and Tricks" referitoare la diverse subiecte legate de CentOS precum instalarea / actualizarea de programe, configurarea surselor de pachete si multe altele.!
s/=TEXT2=/Tot aici sint anuntate informatiile referitoare la evenimentele legate de CentOS din zona Dvs si prezentari in mediile de informare in masa./
s/=TEXT3=/Prin intermediul listei de mail CentOS-Docs, puteti obtine si Dvs permisiunea de a publica pe wiki-ul CentOS. Contribuiti chiar azi!/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!ro!g
