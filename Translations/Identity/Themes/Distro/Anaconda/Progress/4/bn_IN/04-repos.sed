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
s!=TEXT1=!নিমনলিখিত repositories থেকে  software পাবেন  CentOS ইনসটল করার জনন:!
s!=TEXT2=!<flowSpan style="font-weight:bold">[base]</flowSpan> (অথবা <flowSpan style="font-weight:bold">[os]</flowSpan>) - এখান থেকে  RPMS পাবেন যেগুলো CentOS ISO.!
s!=TEXT3=!<flowSpan style="font-weight:bold">[updates]</flowSpan> - এখান থেকে  [base] repository update পাকেজ পাবেন.!
s!=TEXT4=!<flowSpan style="font-weight:bold">[extras]</flowSpan> - এখান থেকে  CentOS পাকেজ পাবেন যেগুলো upstream নয়( করে না upgrade [base]).!
s!=TEXT5=!<flowSpan style="font-weight:bold">[centosplus]</flowSpan> - এখান থেকে  CentOS পাকেজ পাবেন যেগুলো upstream নয় ( করে upgrade [base]).!
s!=TEXT6=!!
s!=URL=!http://wiki.centos.org/AdditionalResources/Repositories!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g
