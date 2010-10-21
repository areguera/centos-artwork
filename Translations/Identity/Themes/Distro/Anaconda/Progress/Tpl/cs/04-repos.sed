# ------------------------------------------------------------
# $Id$
# ------------------------------------------------------------


s/=TITLE=/CentOS software/;
s/=TEXT1=/Software pro CentOS můžete instalovat z následujících zdrojů:/;
s!=TEXT2=!1. <flowSpan style="font-weight:bold">[base]</flowSpan> (jakož <flowSpan style="font-weight:bold">[os]</flowSpan>) - RPM balíčky vydané v rámci CentOS ISO.!;
s!=TEXT3=!2. <flowSpan style="font-weight:bold">[updates]</flowSpan> - Opravy [base] sekce.!;
s!=TEXT4=!3. <flowSpan style="font-weight:bold">[extras]</flowSpan> - Balíčky nedodávané nadřazeným vydavatelem (neupravuje [base]).!;
s!=TEXT5=!4. <flowSpan style="font-weight:bold">[centosplus]</flowSpan> - Balíčky nedodávané nadřazeným vydavatelem (upravuje [base]).!;
s!=TEXT6=!5. <flowSpan style="font-weight:bold">[testing]</flowSpan> - Testovací či beta verze balíčků!;
s!=URL=!http://wiki.centos.org/=LOCALE=/AddicionalResources/Repositories!;
