# ------------------------------------------------------------
# $Id: 05-centosplus.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Plus zdroj/;
s!=TEXT1=!V tomto zdroji jsou distribuovány RPM balíčky, které mohou nahradit základní balíčky systému. Při jejich použití nebude již CentOS totožný s nadřazeným produktem.!;
s!=TEXT2=!Veškeré balíčky z tohoto zdroje byly řádně otestovány CentOS teamem tak, aby byla zaručena jejich kompilace a běh pod CentOS 5. Balíčky však nebyly testovány u nadřazeného vydavatele, jakož nejsou součástí produktů nadřazeného vydavatele.!;
s!=TEXT3=!Uvědomte si, že použití těchto balíčků naruší 100% binární kompatibilitu s nadřazeným produktem.!;
s!=TEXT4=!!;
s/=TEXT5=//;
s/=TEXT6=//;
s!=URL=!http://wiki.centos.org/AdditionalResources/Respositories/CentOSPlus!;
