#!/bin/bash
#  Theme Name : TreeFlower
#   Theme URI : http://wiki.centos.org/ArtWork/ThemeDesign/Trac/
# Description : This is the TreeFlower theme installation
# 		for the application we use to manage projects (Trac).
#      Author : The CentOS Artwork SIG.
#     Licence : This CSS design is released under GPL (
#               http://www.opensource.org/licenses/gpl-license.php)
# -----------------------------------------------------------------
#   $Revision: 2505 $
#     $Author: al $
#       $Date: 2008-12-25 03:00:40 -0500 (Thu, 25 Dec 2008) $
# -----------------------------------------------------------------

EXPORTDIR=theme-trac
SVNREPDIR=https://projects.centos.org/svn/artwork/trunk/Extras/Trac/

if [ "$@" ]; then

	for i in "$@";do
	case $i in
	   --subversion | -s	)
		svn export $SVNREPDIR   $EXPORTDIR --force --quiet
		/bin/cp -r $EXPORTDIR/htdocs/* /usr/share/trac/htdocs/
		/bin/cp -r $EXPORTDIR/templates/* /usr/share/trac/templates/
        /bin/cp ArtworkToc.py   /usr/share/trac/wiki-macros/
		/bin/rm -r $EXPORTDIR;;
	esac
	done
else

	/bin/cp -r htdocs/* /usr/share/trac/htdocs/
	/bin/cp -r templates/* /usr/share/trac/templates/
    /bin/cp ArtworkToc.py   /usr/share/trac/wiki-macros/
fi 

# Final output
echo '--------------'
echo " install.sh: The trac theme was install successfully!" 
echo '--------------'
