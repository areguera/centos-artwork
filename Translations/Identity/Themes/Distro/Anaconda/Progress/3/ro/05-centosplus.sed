# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 05-centosplus.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Repository-ul CentOS Plus/
s/=TEXT1=/Acest repository include programe care inlocuiesc anumite elemente de baza din Centos. Acest repository va schimba CentOS astfel incit nu va mai avea exact acelasi continut cu ceea ce pune la dispozitie furnizorul original./
s/=TEXT2=/Echipa de dezvoltatori a Centos a testat fiecare componenta din acest repository, iar ele sint compilate si functioneaza in CentOS versiunea =MAJOR_RELEASE=.Ele nu au fost testate de catre furnizorul original si nu sint disponibile in produsele acestuia./
s/=TEXT3=/Utilizarea acestor componente elimina compatibilitatea binara de 100% cu produsele furnizorului original./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!ro!g
