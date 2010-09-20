# ------------------------------------------------------------
# $Id: 08-wiki.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Wiki/
s/=TEXT1=/Im CentOS-Wiki sind FAQs, Howtos bzw. Tipps und Tricks für Szenarien unter CentOS, Artikel zu Softwareinstallation und der Konfiguration von Fremdrepositories für CentOS und weitere Texte vorhanden, ebenso Informationen über Veranstaltungen bei denen CentOS präsentiert wird./
s!=TEXT2=!In Zusammenarbeit mit der CentOS-Docs Mailingliste erhalten Interessenten die Möglichkeit, eigene Tipps und Tricks oder Howtos für die Community beizusteuern.!
s!=TEXT3=!!
s!=TEXT4=!!
s!=TEXT4=!!
s!=TEXT5=!!
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/!
