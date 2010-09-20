# ------------------------------------------------------------
# $Id: 03-yum.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Správa balíčků pomocí Yum/
s!=TEXT1=!Doporučený způsob instalace či upgradu je pomocí programu <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellow Dog Updater, Modified).!
s!=TEXT2=!Viz: "Managing Software with Yum" na odkaze uvedeném níže.!
s!=TEXT3=!K dispozici je rovněž <flowSpan style="font-weight:bold">YumEx</flowSpan>, což je grafické rozhraní pro Yum. Naleznete jej v sekci CentOS Extras.!
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!
