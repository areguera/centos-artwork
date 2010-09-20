#!/bin/bash
#
# Copy Browser Defaul Page files into their location.

TARGET=/usr/share/doc/HTML

#
# Copy information
#
printf 'Updating Browser Default Page ... '
/bin/cp -r img/ $TARGET
/bin/cp index.html $TARGET
/bin/cp style.css $TARGET
printf "done.\n"

#
# Update file permissions.
#
printf 'Updating file permissions ... '
chmod -R 755 $TARGET
chown -R root.root $TARGET
printf "done.\n"

#
# Update SELinux context
#
/usr/sbin/selinuxenabled
if [ "$?" == "0" ];then
    printf 'Updating SELinux context ... '
    /sbin/restorecon -R $TARGET
    /usr/bin/chcon -R system_u:object_r:usr_t $TARGET
    printf "done.\n"
fi
