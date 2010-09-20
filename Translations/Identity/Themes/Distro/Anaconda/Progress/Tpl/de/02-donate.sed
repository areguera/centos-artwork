# ------------------------------------------------------------
# $Id: 02-donate.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Spenden für CentOS/
s/=TEXT1=/Der Urheber von CentOS ist "The CentOS Project". Wir sind eigenständig und keiner anderen Organisation angegliedert oder zugehörig./
s/=TEXT2=/Unsere einzige Quelle für Hardware oder finanzielle Aufwendungen bei der Verbreitung von CentOS sind Spenden./
s/=TEXT3=/Sollte CentOS für Sie von Nutzen sein, denken Sie bitte über eine Spende für das CentOS-Projekt nach./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate/!
