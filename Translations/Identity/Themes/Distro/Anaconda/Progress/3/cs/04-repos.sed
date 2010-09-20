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


s/=TITLE=/CentOS software/;
s/=TEXT1=/Software pro CentOS můžete instalovat z následujících zdrojů:/;
s!=TEXT2=!1. <flowSpan style="font-weight:bold">[base]</flowSpan> (jakož <flowSpan style="font-weight:bold">[os]</flowSpan>) - RPM balíčky vydané v rámci CentOS ISO.!;
s!=TEXT3=!2. <flowSpan style="font-weight:bold">[updates]</flowSpan> - Opravy [base] sekce.!;
s!=TEXT4=!3. <flowSpan style="font-weight:bold">[extras]</flowSpan> - Balíčky nedodávané nadřazeným vydavatelem (neupravuje [base]).!;
s!=TEXT5=!4. <flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Balíčky nedodávané nadřazeným vydavatelem (upravuje [base]).!;
s!=TEXT6=!5. <flowSpan style="font-weight:bold">[testing]</flowSpan> - Testovací či beta verze balíčků!;
s!=URL=!http://wiki.centos.org/AddicionalResources/Repositories!;

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g
