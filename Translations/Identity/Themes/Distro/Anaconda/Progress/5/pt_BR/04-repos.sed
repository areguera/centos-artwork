# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 04-repos.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Repositórios do CentOS/
s!=TEXT1=!O CentOS possui os seguintes repos para a instalação de software:!
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (também chamado de <flowSpan style="font-weight:bold">[os]</flowSpan>) – São os RPMS liberados em um ISO de instalação do CentOS.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> – Atualizações do repositório [base].!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> – Itens fornecidos pelo CentOS que não são do fornecedor original (não atualiza o [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> – Itens fornecidos pelo CentOS que não são do fornecedor original (atualiza o [base]).!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!pt_BR!g
