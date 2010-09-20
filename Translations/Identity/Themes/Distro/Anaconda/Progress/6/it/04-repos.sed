# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 04-repos.sed 4861 2010-03-13 00:52:25Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Repositories/
s/=TEXT1=/Con CentOS puoi usare i seguenti repository per installare nuove componenti:/
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (alias [os]) - I pacchetti RPMS rilasciati nella distribuzione.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - Aggiornamenti (update) al repository [base].!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - pacchetti prodotti da CentOS che non provengono dal distributore primario (non aggiornano (upgrade) [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - pacchetti prodotti da CentOS che non provengono dal distributore primario (aggiornano (upgrade) [base]).!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!6!g
