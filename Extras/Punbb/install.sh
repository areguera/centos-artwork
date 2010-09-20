#!/bin/bash
# Install Punbb TreeFlower files.

PUNBB_PATH=/var/www/html/punbb

EXPORTDIR=tmp_punbb

SVNREPODIR=https://projects.centos.org/svn/artwork/trunk/Extras/Punbb

if [ "$@" ]; then

	for i in "$@";do
	case $i in
	   --subversion | -s	)
		svn export $SVNREPODIR $EXPORTDIR --force --quiet
		/bin/cp -r $EXPORTDIR/style/* $PUNBB_PATH/style/;
		/bin/cp -r $EXPORTDIR/img/* $PUNBB_PATH/img/;
		/bin/cp $EXPORTDIR/*.php $PUNBB_PATH/;
		/bin/rm -r $EXPORTDIR;;
	esac
	done
else

	/bin/cp -r style/* $PUNBB_PATH/style/;
	/bin/cp -r img/* $PUNBB_PATH/img/;
	/bin/cp *.php $PUNBB_PATH/;
fi 
