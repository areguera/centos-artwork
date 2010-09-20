# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 08-wiki.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Wiki/
s/=TEXT1=/CentOS Wiki tem disponível FAQs (perguntas frequentes), HowTos (guias passo-a-passo), Dicas e Truques, sobre diversos tópicos do CentOS tais como instalação de software, actualizações, configuração de repositórios e muito mais./
s/=TEXT2=/O wiki contém também informação sobre eventos CentOS na sua região e sobre a cobertura mediática do CentOS./
s/=TEXT3=/Em conjunção com a "mailing list" CentOS-Docs, os contribuintes podem obter permissão para colocar artigos, dicas e HowTos em CentOS Wiki. Contribua também!/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
