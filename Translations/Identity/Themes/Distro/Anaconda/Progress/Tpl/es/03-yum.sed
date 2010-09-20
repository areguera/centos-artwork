# ------------------------------------------------------------
# $Id: 03-yum.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/Gestión de paquetes con Yum/
s!=TEXT1=!La forma recomendada para instalar o actualizar CentOS es usar <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellow Dog Updater, Modified).!
s/=TEXT2=/Vea la guía titulada: "Managing Software with Yum" en el enlace a la documentación siguiente./
s!=TEXT3=!<flowSpan style="font-weight:bold">YumEx</flowSpan>, una interfase gráfica para Yum, también está disponible en el repositorio CentOS Extras.!
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!
