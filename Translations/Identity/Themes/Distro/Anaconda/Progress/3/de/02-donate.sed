# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 02-donate.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/Spenden für CentOS/
s/=TEXT1=/Der Urheber von CentOS ist "The CentOS Project". Wir sind eigenständig und keiner anderen Organisation angegliedert oder zugehörig./
s/=TEXT2=/Unsere einzige Quelle für Hardware oder finanzielle Aufwendungen bei der Verbreitung von CentOS sind Spenden./
s/=TEXT3=/Sollte CentOS für Sie von Nutzen sein, denken Sie bitte über eine Spende für das CentOS-Projekt nach./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
