# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 02-donate.sed 13 2010-09-10 09:55:59Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS তহবিল/
s/=TEXT1=/যে  সংসথা CentOS তৈরী করে তার নাম "The CentOS Project" । অামরা কোন সংসথার সংগে যুকত নই ./
s/=TEXT2=/ অামাদের  hardware বা অরথের একমাএ উৎস  হল অনুদান  CentOS বিতরণ করার জনন./
s/=TEXT3=/যদি  CentOS অাপনার উপকারে লাগে তাহলে CentOS Project-এর তহবিলে দান করুন./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/donate!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!5!g

# Locale information.
s!=LOCALE=!bn_IN!g
