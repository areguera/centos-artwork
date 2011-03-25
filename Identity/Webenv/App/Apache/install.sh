#!/bin/bash
#
# Install web server customization.

echo 'What customization do you want to apply?:'
select VERSION in `find . -maxdepth 1 -type d \
	| egrep -v '^.$' | egrep -v 'svn' \
	| sed 's/\.\///'`;do
	SVN=http://centos.org/svn/artwork/trunk/Extras/Apache/$VERSION
	break
done

INSTANCE=tmp
FILE=apache.conf	 # Apache's Customization file
CONFD=/etc/httpd/conf.d	 # Apache's Configuration directory
DROOT=/var/www/html/	 # Apache's Document Root
DERROR=/var/www/error	 # Apache's Error directory
DICONS=/var/www/icons	 # Apache's Icons directory

echo 'Creating local copy ...'
svn export $SVN $INSTANCE --force --quiet

# Copy files
echo "Applying Errors Customization ... "
cp -r $INSTANCE/error/*   $DERROR;

echo  "Applying Indexing Customization ... "
cp -r $INSTANCE/indexing/* $DROOT/;

echo "Applying Icons Customization ... "
cp -r $INSTANCE/icons/* $DICONS/;

echo "Applying Apache Customization ... "
cp $INSTANCE/$FILE $CONFD/;

# Permissions
echo 'Applying permissions ...'
chown -R apache:apache $DROOT
chown -R apache:apache $DERROR
chown -R apache:apache $DICONS
chmod -R 750 $DROOT
chmod -R 750 $DERROR
chmod -R 750 $DICONS
if [ selinuxenabled ];then
chcon -R system_u:object_r:httpd_sys_content_t $DROOT
chcon -R system_u:object_r:httpd_sys_content_t $DERROR
chcon -R system_u:object_r:httpd_sys_content_t $DICONS
chcon -R system_u:object_r:httpd_config_t $CONFD
fi

# Remove temporal files
rm -r $INSTANCE

# Reloading configuration
/sbin/service httpd reload
