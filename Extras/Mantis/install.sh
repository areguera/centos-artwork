#!/bin/bash
#
#

EXPORTDIR=tmp_mantis

echo 'Select the customization:'
select VERSION in `find . -maxdepth 1 -type d \
		   | egrep -v '^\.$' \
		   | egrep -v 'svn' \
		   | sed 's/\.\///'`;do
	break;
done

SVNREPODIR=http://centos.org/svn/artwork/trunk/Extras/Mantis/$VERSION

echo 'Creating local copy ...'
svn export $SVNREPODIR $EXPORTDIR --force --quiet
echo 'Copying css directory ...'
/bin/cp $EXPORTDIR/css/* 	/usr/share/mantis/css/
echo 'Copying images directory ...'
/bin/cp -r $EXPORTDIR/images/* 	/usr/share/mantis/images/
echo 'Copying core directory ...'
/bin/cp $EXPORTDIR/core/* 	/usr/share/mantis/core/
echo 'Copying lang directory ...'
/bin/cp $EXPORTDIR/lang/* 	/usr/share/mantis/lang/
echo 'Copying html files ...'
/bin/cp $EXPORTDIR/*.html 	/usr/share/mantis/
echo 'Copying php files ...'
/bin/cp $EXPORTDIR/*.php 	/usr/share/mantis/
/bin/rm -r $EXPORTDIR
