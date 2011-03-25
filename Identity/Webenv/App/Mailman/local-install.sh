#!/bin/bash
# Install Mailman customization using a local copy of installation
# source once it has been exported from svn repository.

DOINSTALL=N
SVNDIR=http://centos.org/svn/artwork/trunk/Extras/Mailman/
EXPORTDIR=Exported_files

echo 'Looking for available customizations ...'
select MM_VALIDVERSION in `find . -maxdepth 1 -type d \
			   | grep -v '^\.$' \
			   | grep -v 'install\.sh' \
			   | grep -v 'svn' \
			   | sed 's!\./!!; s!/$!!'`; do
	break;
done

# Check mailman package from available repository
function check_mailman_yuminstall {
	# This customization was built for
	# mailman-2.1.9-4.el5 and only tested on it. It may not work in other
	# version. If other version is found show a warning message about this
	# issue and let the user decide what to do.
	MM_VERSION=`yum info mailman | egrep '^Version: ' | cut -f2 -d' '`
	MM_RELEASE=`yum info mailman | egrep '^Release: ' | cut -f2 -d' '`
	MM_REPOSIT=`yum info mailman | egrep '^Repo   : ' | sed	-r 's/^Repo   : //'`
	MM_VERSREL="$MM_VERSION-$MM_RELEASE"
	if [ $MM_VERSREL == $MM_VALIDVERSION ];then
		return 0
	else
		echo "   Package found : mailman-$MM_VERSREL"
		echo "   Repository    : $MM_REPOSIT"
  		echo "   ****************************************************"
		echo "   WARNING!: You are trying to apply"
		echo "             mailman-$MM_VALIDVERSION customization to"
		echo "             mailman-$MM_VERSREL and that may not work!"
  		echo "   ****************************************************"
		printf "   Do you want to apply it anyway ? [y/N]: "
		read DOINSTALL

		if [ "$DOINSTALL" == 'y' ];then
			return 0
		else
			exit 1;
		fi
	fi
}

# Apply customization
function install_mailman_customization {
	echo 'Applying customization ...'
	/bin/cp -r $MM_VALIDVERSION/Mailman/* /usr/lib/mailman/Mailman/
	/bin/cp -r $MM_VALIDVERSION/messages/* /usr/lib/mailman/messages/
	/bin/cp -r $MM_VALIDVERSION/templates/* /usr/lib/mailman/templates/
	/bin/cp $MM_VALIDVERSION/mailman.conf /etc/httpd/conf.d/
}

# Verify mailman local installation 
function check_mailman_localinstall {
	echo "Looking for local installation ..."
	# Is mailman already installed ?
	rpm -q mailman-$MM_VALIDVERSION > /dev/null

	if [ $? == 0 ]; then
		# Package is already installed ... jump to customization
		install_mailman_customization
		# and exit;
		exit 0;
	else
		echo   "   mailman-$MM_VALIDVERSION is not installed."
		printf '   Do you want to install it now ? [y/N]: '
		read DOINSTALL
	
		if [ "$DOINSTALL" == 'y' ];then
			return 0
		else
			exit 1
		fi
	fi
}


# Install mailman package from available repository
function install_mailman {
	check_mailman_yuminstall
	yum -y install mailman
	install_mailman_customization
}

check_mailman_localinstall
install_mailman


# After this you need to configure your mailman:
# (Take a look to: /usr/share/doc/mailman-2.1.9/INSTALL.REDHAT)
#
# 1. Create your site password:
#
#	/usr/lib/mailman/bin/mmsitepass
#
# 2. Define the first mailing list. 
#
#	/usr/lib/mailman/bin/newsite mailman@domain.tld
#
# 3. Restart the Apache web server
#
#	/sbin/service httpd restart
#
# 4. Start mailman daemon
#
# 	/sbin/service mailman start
#
#
# ... and thats all folks! :)
