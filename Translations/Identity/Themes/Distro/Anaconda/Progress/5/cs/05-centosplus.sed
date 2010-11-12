# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 05-centosplus.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Plus zdroj/;
s!=TEXT1=!V tomto zdroji jsou distribuovány RPM balíčky, které mohou nahradit základní balíčky systému. Při jejich použití nebude již CentOS totožný s nadřazeným produktem.!;
s!=TEXT2=!Veškeré balíčky z tohoto zdroje byly řádně otestovány CentOS teamem tak, aby byla zaručena jejich kompilace a běh pod CentOS 5. Balíčky však nebyly testovány u nadřazeného vydavatele, jakož nejsou součástí produktů nadřazeného vydavatele.!;
s!=TEXT3=!Uvědomte si, že použití těchto balíčků naruší 100% binární kompatibilitu s nadřazeným produktem.!;
s!=TEXT4=!!;
s/=TEXT5=//;
s/=TEXT6=//;
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Respositories/CentOSPlus!;

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!cs!g
