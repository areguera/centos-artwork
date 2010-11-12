# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 01-welcome.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/সাগতম  CentOS =MAJOR_RELEASE= !/
s/=TEXT1=/ িববেচনার জন ধনবাদ CentOS =MAJOR_RELEASE= ./
s/=TEXT2=/CentOS  একটি   enterprise লিনাকস অপারেটিং সিসটেম যেটি   একটি  নামী উওর অামেরিকার Enterprise লিনাকস vendor কাছ থেকে জনগণের কাছে বিনামূলে বিতরিত কোড থেকে তৈরী./
s/=TEXT3=/CentOS upstream vendor-এর পুনরায় বিতরণ নীতি পুরো মানন করে এবং  100% binary সমতুল । CentOS পধানত  পাকেজের থেকে upstream vendor চিএকলা পরিবরতন করে./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://www.centos.org/!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!bn_IN!g
