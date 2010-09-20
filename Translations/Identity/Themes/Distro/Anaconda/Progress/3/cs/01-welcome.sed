# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 01-welcome.sed 4959 2010-03-18 02:27:24Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS vás vítá!/
s/=TEXT1=/Děkujeme, že si instalujete CentOS =MAJOR_RELEASE=./
s/=TEXT2=/Centos je Enterprise Linux distribuce, postavená na volně dostupných zdrojových kódech významného severoamerického vydavatele Enterprise Linux distribuce./
s/=TEXT3=/CentOS má shodnou politiku distribuce jako nadřazený vydavatel a je 100% binárně kompatibilní. Změny balíčků ze strany CentOS povětšinou zahrnují pouze změnu výtvarné části či ochranné známky nadřazeného vydavatele./
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
