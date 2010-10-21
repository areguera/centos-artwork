# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Wiki de CentOS/
s/=TEXT1=/El wiki de CentOS está disponible con: Preguntas Más Frecuentes (FAQs, PMF), COMOs (HowTos), Tips y Artículos en varios asuntos relacionados con CentOS que incluyen instalación de aplicaciones, actualizaciones, configuración de repositorios y mucho más./
s/=TEXT2=/El wiki también contiene información de Eventos de CentOS en su localidad y CentOS en los medios./
s/=TEXT3=/En colaboración con las lista de correo CentOS-Docs, los contribuyentes pueden obtener permiso para publicar artículos, sugerencias y COMOs (HowTos) en el wiki de CentOS .... así que contribuye hoy mismo!!/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g

# Locale information.
s!=LOCALE=!es!g
