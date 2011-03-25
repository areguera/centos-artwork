#!/bin/bash
#  Theme Name : GreenBugs
#   Theme URI : 
# Description : GreenBugs is a patch based on TreeFlower
#               theme used to retheme the Mantis default application.
#
#		To install this patch you need to install the
#		TreeFlower theme first. Then use this script to update
#		the css and header files.
#
#		The main changes in this patch are the colors (from
#		blue to green) and the artistic motive used (from
#		flowers to bugs.)
#
#      Author : The CentOS Artwork SIG.
#     Licence : This CSS design is released under GPL (
#               http://www.opensource.org/licenses/gpl-license.php)
 

EXPORTDIR=tmp_mantis

if [ "$@" ]; then

	for i in "$@";do
	case $i in
	   --subversion | -s	)
		svn export http://localhost/svn/artwork/branches/MantisThemeDesign/GreenBugs/ $EXPORTDIR --force --quiet
		/bin/cp $EXPORTDIR/css/* /usr/share/mantis/css/
		/bin/cp -r $EXPORTDIR/images/* /usr/share/mantis/images/
		/bin/cp $EXPORTDIR/*.html /usr/share/mantis/
		/bin/rm -r $EXPORTDIR;;
	esac
	done
else

	/bin/cp css/* /usr/share/mantis/css/
	/bin/cp -r images/* /usr/share/mantis/images/
	/bin/cp *.html /usr/share/mantis/core/
fi 

# Final output
echo '--------------'
echo " $0: The Mantis theme was install successfully!" 
echo '--------------'
