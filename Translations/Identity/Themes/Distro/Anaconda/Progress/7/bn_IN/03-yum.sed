# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 03-yum.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/Yum দারা softwaremanagement/
s!=TEXT1=!CentOS ইনসটল বা Update করার জনন শেষঠ পথ হল <flowSpan style="font-weight:bold">Yum</flowSpan> (Yellow Dog Updater, Modified)!
s!=TEXT2=! এই গাইডটি দেখুন: "Managing Software with Yum" নিচের ডকুমেনটেশান লিংকের নিচে.!
s!=TEXT3=!<flowSpan style="font-weight:bold">YumEx</flowSpan>, একটি গাফিকাল ফরনট‌ -এনড Yum-এর জনন, যেটি  CentOS Extras repository থেকে পাওয়া যাবে.!
s!=TEXT4=!!
s!=TEXT5=!!
s!=TEXT6=!!
s!=URL=!http://www.centos.org/docs/=MAJOR_RELEASE=/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!3!g

# Locale information.
s!=LOCALE=!bn_IN!g
