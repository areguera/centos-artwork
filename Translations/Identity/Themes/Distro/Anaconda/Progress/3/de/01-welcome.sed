# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 01-welcome.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Willkommen bei CentOS =MAJOR_RELEASE=!/
s/=TEXT1=/Danke, dass Sie CentOS =MAJOR_RELEASE= installieren./
s/=TEXT2=/CentOS ist eine Enterprise-Linux-Distribution, die aus den veröffentlichten Sourcen eines bekannten nordamerikanischen Linux-Distributors neu zusammengestellt wird./
s/=TEXT3=/CentOS hält sich komplett an die Richtlinien zur Weiterverteilung, die dieser Distributor erlassen hat und versucht zu dessen Produkt 100% binärkompatibel zu sein. (Zum größten Teil werden von CentOS Markenzeichen und Illustrationen bzw. Bilder ausgetauscht)./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!de!g
