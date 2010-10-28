#!/bin/bash
#
# Use this script to update svg metadata information massively, based
# on one Tpl file. To use this script you need to be located inside
# the artwork component you want to update. For example if you want to
# update the svg metadata information used by CentOS Brands files, you
# type: 
#
#  cd ~/artwork/trunk/Identity/Brands
#
#  first, and later
#
#  ~/artwork/trunk/Scripts/Bash/Styles/replaceInFiles.sh '.*\.svg$'
#
# At this point you select the translation file you want to apply to
# all files matching the regular expression you defined as first
# argument ('.*\.svg$') in the above command. The svg metadata
# translation file used for CentOS Brands' svg file is:
# svg-metadata-centos.sed. Pick that and press return to go on. After
# that, if you are using subversion, use the following command to see
# changes:
#
#  svn diff | less
#
# Note that inside trunk/Scripts/Bash/Styles/Tpl directory you can find
# standard translation files that you can apply to files. In order to
# have the appropriate result, it is important that you know what
# translation file you apply to which file. As convenction each
# translation file inside the above location have a comment on the
# first lines describing which kind of files they apply to.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id: replaceInFiles.sh 12 2010-09-10 09:55:08Z al $
# ----------------------------------------------------------------------

REGEX=$1
TRANSLATIONS=~/artwork/trunk/Scripts/Bash/Styles/Tpl

# Define translation file.
echo "`gettext "Select the translation you want to apply:"`"
select TRANSLATION in $(ls $TRANSLATIONS);do
   TRANSLATION=$TRANSLATIONS/$TRANSLATION
   break
done

# Check regular expression.
if [ $REGEX == '' ];then
   echo "`gettext "You need to provide a regular expression as first argument."`"
   exit
fi

# Check translation file.
if [ ! -f $TRANSLATION ];then
   echo "`gettext "You need to provide a valid translation file."`"
   exit
fi

# Define keywords using repo path as base.
PATH_KEYWORDS=$(pwd | cut -d/ -f6- | tr '/' '\n')

# Redifine keywords using SVG standard format.
SVG_KEYWORDS=$(\
   for KEY in $PATH_KEYWORDS;do
      echo "            <rdf:li>$KEY</rdf:li>\\"
   done)

for FILE in $(find . -regextype posix-egrep -regex $REGEX);do
   echo "Updating: $FILE"
   sed -i -r -f $TRANSLATION $FILE
   sed -i -r -e /=KEYWORDS=/c\\"$SVG_KEYWORDS" $FILE
done \
   | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
