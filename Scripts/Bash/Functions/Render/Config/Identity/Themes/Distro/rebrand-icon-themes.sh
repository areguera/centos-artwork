#!/bin/bash
#
# Rebrand CentOS Icons in your local system using images from your
# working copy of the CentOS Artwork Repository. Run this script (as
# root) if you want to see how CentOS Icons, inside CentOS Artwork
# Repository, look in your system.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
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
# $Id$
# ----------------------------------------------------------------------

# Check user id.
if [ $UID -ne 0 ];then
   cli_printMessage "`gettext "You need to run this script as root user."`"
   exit
fi

SRC_LOGOS=~/artwork/trunk/Identity/Brands
WORKPLACE=$(pwd)
TRG='/usr/share/icons'

# Define file names which should contain the CentOS Brand, in this
# specific case the CentOS Symbol. Take care with the order in which
# you put files! Put more specific files first.
FILES='redhat-icon-panel-menu
       redhat-starthere 
       gnome-starthere 
       start-here
       kmenu'

for FILE in $FILES;do

   # Hold FILE's location.
   LOCATIONS=$(find $TRG/{Bluecurve,crystalsvg}/* \
      -regextype posix-egrep \
      -regex ".*/$FILE\.png")

   # Process each FILE location.
   for LOCATION in $LOCATIONS;do

      # Define FILE width.
      WIDTH=$(echo $LOCATION | cut -d/ -f6 | cut -dx -f1)

      # Define the appropriate source image.
      ICON=$SRC_LOGOS/Img/centos/symbol/5c-a/violet/$WIDTH.png

      # If ICON doesn't exist go to Logos section, render it, come
      # back here and continue.
      if [ ! -f $ICON ];then
         cd $SRC_LOGOS
         ./render.sh centos/symbol/5c-a/violet/$WIDTH
         cd $WORKPLACE
      fi

      # Rebrand LOCATION with the appropriate source image.
      if [ -f $LOCATION ] || [ -h $LOCATION ];then
         /bin/cp --remove-destination \
            --verbose \
            -Z system_u:object_r:usr_t \
            $ICON $LOCATION
     fi
   done
done

# SVG Files.
cp -v $SRC_LOGOS/Tpl/centos/symbols/kmenu.svgz \
   /usr/share/icons/crystalsvg/scalable/apps/kmenu.svgz

