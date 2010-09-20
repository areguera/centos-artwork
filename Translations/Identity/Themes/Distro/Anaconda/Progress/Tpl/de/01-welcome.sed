# ------------------------------------------------------------
# $Id: 01-welcome.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Willkommen bei CentOS =MAJOR_RELEASE=!/
s/=TEXT1=/Danke, dass Sie CentOS =MAJOR_RELEASE= installieren./
s/=TEXT2=/CentOS ist eine Enterprise-Linux-Distribution, die aus den veröffentlichten Sourcen eines bekannten nordamerikanischen Linux-Distributors neu zusammengestellt wird./
s/=TEXT3=/CentOS hält sich komplett an die Richtlinien zur Weiterverteilung, die dieser Distributor erlassen hat und versucht zu dessen Produkt 100% binärkompatibel zu sein. (Zum größten Teil werden von CentOS Markenzeichen und Illustrationen bzw. Bilder ausgetauscht)./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!
