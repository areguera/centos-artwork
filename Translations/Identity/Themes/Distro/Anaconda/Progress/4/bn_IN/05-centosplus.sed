# Warning: Do not modify this file directly. This file is created
# automatically using 'centos-art' command line interface.  Any change
# you do in this file will be lost the next time you update
# translation files using 'centos-art' command line interface. If you
# want to improve the content of this translation file, improve its
# template file instead and run the 'centos-art' command line
# interface later to propagate your changes.
# ------------------------------------------------------------
# $Id: 05-centosplus.sed 304 2010-10-21 18:18:03Z al $
# ------------------------------------------------------------


s/=TITLE=/CentOS Plus Repository/
s/=TEXT1=/এই repository থেকে পাকেজ পাবেন যেগুলো কতগুলো base CentOS পাকেজ upgrade করে । এই repo CentOS পরিবরতন করে এবং upstream ভেনডরের সাথে একরকম থাকে না ./
s/=TEXT2=/CentOS development team এই repo পতিটি পাকেজ পরিকখা করেছে, এবং তারা যথাযথ কাজ করে CentOS =MAJOR_RELEASE=. কিনতু এগুলো upstream ভেনডর দারা পরিকখিত নয় , এবং upstream ভেনডরের কাছ থেকে পাওয়া যাবে না./
s/=TEXT3=/অাপনাকে বুঝতে হবে এগুলো বাবহার করলে CentOS upstream ভেনডরের সংগে100% binary সমতুলল থাকবে না./
s/=TEXT4=//
s/=TEXT5=//
s/=TEXT6=//
s!=URL=!http://wiki.centos.org/=LOCALE=/AdditionalResources/Repositories/CentOSPlus!

# Release number information.
s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
s!=MINOR_RELEASE=!0!g
s!=MAJOR_RELEASE=!4!g

# Locale information.
s!=LOCALE=!bn_IN!g
