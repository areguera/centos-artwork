#!/bin/bash
#
# groupByFormats.sh -- This function provides post-rendering action
# used to group images by format.  This function create a directory
# for for the image format and move the image file inside it.  For
# example: if the current file is a png file, it is moved inside a png
# directory; if the current file is a jpg file, it is stored inside a
# jpg directory, and so on.
#
# For this function to work correctly, you need to specify which formats you
# want to group. This is done in the post-rendering ACTIONS array inside the
# appropriate render.conf.sh script. 
#
# For example, the following two lines will create a jpg, ppm, xpm, and tif
# file for each png file and will group them all by its format, inside
# directories named as the file format they contain inside (i.e. png, jpg,
# ppm, xpm, tif). 
#     
#     ACTIONS[0]="renderFormats: jpg, ppm, xpm, tif"
#     ACTIONS[1]="groupByFormat: png, jpg, ppm, xpm, tif"
#
# groupByFormat function is generally used with renderFormats function. Both
# definitions should match the type of formats you want to have rendered and
# grouped. You don't need to specify the png format in renderFormats'
# definition, but in groupByFormats's definition it should be specified.
# Otherwise png files will not be grouped inside a png directory.
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
# $Id: render_doIdentityImageGroupBy.sh 56 2010-09-17 11:07:26Z al $
# ----------------------------------------------------------------------

function groupByFormat {

   # Get absolute path of PNG image file.
   local FILE="$1"

   # Get image formats.
   local FORMATS=$(echo "$2" | cut -d: -f2-)

   # Sanitize image formats.
   FORMATS=$(echo "${FORMATS}" \
      | sed -r 's!^ *!!g' \
      | sed -r 's!( |:|,|;) *! !g' \
      | sed -r 's! *$!!g')

   # Check image formats.
   if [ "$FORMATS" != "" ];then

      # Loop through image formats and do group by format.
      for FORMAT in $FORMATS;do

         # Redifine file path to add format directory
         local SOURCE=${FILE}.${FORMAT}
         local TARGET=$(dirname $FILE)/${FORMAT}

         # Check target directory existence.
         if [ ! -d $TARGET ];then
            mkdir $TARGET
         fi

         # Redifine file path to add file and its format.
         TARGET=${TARGET}/$(basename $FILE).${FORMAT}

         # Move file into its format location.
         echo "Moved to: $TARGET"
         mv ${SOURCE} ${TARGET}

      done

   fi

}
