# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Wiki do CentOS/
s/=TEXT1=/O Wiki do CentOS está disponível com Perguntas Freqüentes (FAQ) , HowTos, dicas e macetes em um grande número de tópicos relacionados ao CentOS, incluindo instalação de software, atualizações, configuração de repositórios e muito mais./
s/=TEXT2=/O Wiki também contém informações sobre os Eventos do CentOS em sua região e aparições do CentOS na mídia./
s/=TEXT3=/Em conjunto com a lista de emails CentOS-Docs, os contribuidores podem obter permissão para postar artigos, dicas e HowTos no Wiki do CentOS. Então contribua hoje mesmo!/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!pt_BR!g
