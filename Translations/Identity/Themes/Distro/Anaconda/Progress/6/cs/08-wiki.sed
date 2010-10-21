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


s/=TITLE=/CentOS Wiki/;
s/=TEXT1=/Na CentOS Wiki naleznete často kladené dotazy (FAQ), návody, tipy a články pokrývající široké spektrum témat, jako je instalace software, aktualizace OS, nastavení RPM zdrojů, a pod./;
s/=TEXT2=/Wiki obsahuje taktéž informace o událostech týkající se CentOS, které vás mohou zajímat a upoutávky na informace o CentOS v médiích./;
s/=TEXT3=/Přihlaste se do konference CentOS-Docs. Začnete tvořit tipy a články, dostanete práva na zápis do Wiki ... Neváhejte a začnete přispívat do Wiki ještě dnes!/;
s/=TEXT4=//;
s/=TEXT5=//;
s/=TEXT6=//;
s!=URL=!http://wiki.centos.org/=LOCALE=/!;

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!cs!g
