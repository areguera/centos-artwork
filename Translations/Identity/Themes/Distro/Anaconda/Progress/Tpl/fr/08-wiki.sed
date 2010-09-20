# ------------------------------------------------------------
# $Id: 08-wiki.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Le Wiki CentOS/
s/=TEXT1=/Il existe un projet de wiki collaboratif pour CentOS. On peut y trouver les Questions Fréquemment Posées, des HowTos, des Astuces et des Articles sur une série de sujets liés à CentOS, en ce compris l'installation de logiciel, les mises-à-jour, la configuration des dépôts et bien plus. /
s/=TEXT2=/Ce wiki répertorie également les événements liés à CentOS dans votre région ainsi que les apparitions de CentOS dans les médias./
s/=TEXT3=/Il suffit de demander la permission sur la liste de diffusion CentOS-Docs afin de pouvoir publier des articles, des astuces et des HowTos sur le wiki CentOS ... participez donc dès aujourd'hui !/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/!
