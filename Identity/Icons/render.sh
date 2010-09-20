#!/bin/bash
#
# Icons rendering script
#
# Copyright (C) 2009 The CentOS Project 
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
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
# USA
#
#--------------------------------------
# Category: rendering
#--------------------------------------



# Define export id used on templates.
# Not export id used. Take the whole work area.

# Define directory holding templates. It is preferable to point the
# local working directory holding templates in order to let people
# rendering their templates changes locally before commit them up to
# the central repository.
SVG=tpl

# Save images locally. Generally on the working directory, there where
# you can use svn commands.
IMG=img

# Define icon width. Height is calculated automatically.
WIDTHS="16 20 22 24 32 36 40 48 64 96 128 148 164 196 200"

if [ "$1" ];then
   WIDTHS="$1"
fi

# Define category filter
if [ "$2" ]; then
   CATEGORIES=`ls $SVG | egrep "$2"`
else
   CATEGORIES=`ls $SVG`
fi

for CATEGORY in $CATEGORIES; do

   for WIDTH in $WIDTHS; do

      # Check output image directory existence
      if [ ! -d $IMG/$WIDTH/$CATEGORY ];then
         mkdir -p $IMG/$WIDTH/$CATEGORY
      fi

      # Define template filter
      if [ "$3" ]; then
         TEMPLATES=`ls $SVG/$CATEGORY | egrep $3`
      else
         TEMPLATES=`ls $SVG/$CATEGORY`
      fi

      for FILE in $TEMPLATES; do

         # Define template file
         TEMPLATE=$SVG/$CATEGORY/$FILE

         # Define image file
         IMAGE=$IMG/$WIDTH/$CATEGORY/`echo $FILE | sed -e "s!\.tpl!.png!"`

         # Image rendering 
         inkscape $TEMPLATE --export-width=$WIDTH --export-png=$IMAGE
      done
   done
done
