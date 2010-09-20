# ------------------------------------------------------------
# $Id: 08-wiki.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Wiki/
s/=TEXT1=/CentOS Wiki tem disponível FAQs (perguntas frequentes), HowTos (guias passo-a-passo), Dicas e Truques, sobre diversos tópicos do CentOS tais como instalação de software, actualizações, configuração de repositórios e muito mais./
s/=TEXT2=/O wiki contém também informação sobre eventos CentOS na sua região e sobre a cobertura mediática do CentOS./
s/=TEXT3=/Em conjunção com a "mailing list" CentOS-Docs, os contribuintes podem obter permissão para colocar artigos, dicas e HowTos em CentOS Wiki. Contribua também!/
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/!
