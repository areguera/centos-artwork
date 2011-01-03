#!/bin/bash
#
# Rebrand CentOS Logos in your local system using images from your
# working copy of the CentOS Artwork Repository. Run this script (as
# root) if you want to see how CentOS Icons, inside CentOS Artwork
# Repository, look in your system.
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
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
# Scripts > Identity > Themes > Distro
# ----------------------------------------------------------------------

# Check user id.
if [ $UID -ne 0 ];then
   cli_printMessage "`gettext "You need to run this script as root user."`"
   exit
fi

SRC_LOGOS=~/artwork/trunk/Identity/Brands
WORKPLACE=$(pwd)
TRG=/usr/share/pixmaps/redhat

# Actually, images related to CentOS Logos are contained in files that
# begin its filename with the word `redhat'. We use that pattern here
# to rebrand the images with the appropriate CentOS information.
for FILE in $TRG/redhat*;do

   # If FILE is a symbolic link continue.
   if [ -h $FILE ];then
      continue;
   fi

   # Get image properties. There are images that doesn't have the
   # width on the filename so we used the identify utility to get
   # it and other image properties.
   PROP=`identify $FILE`

   # Define image name.
   NAME=`basename $FILE`

   # Define image width.
   WIDTH=`echo $PROP | cut -d' ' -f3 | cut -dx -f1`

   # Check if image specifies emboss in its name. If so, consider it
   # as an emboss effect applied to the image an use the appropriate
   # emboss source for it.
   echo $NAME | grep emboss >> /dev/null
   if [ $? -eq 0 ];then
      EFFECT='-emboss'
   else
      EFFECT=
   fi

   # Define image format. We use only three characters in the image
   # extension.
   FORMAT=`echo $PROP \
         | cut -d' ' -f2 \
         | tr '[:upper:]' '[:lower:]' \
         | sed -r 's!^([a-z]{3}).*!\1!'`

   # Define the appropriate source image. This is the source image we
   # use to rebrand.
   LOGO=$SRC_LOGOS/Img/centos/horizontal/5c-a/violet/${WIDTH}${EFFECT}.${FORMAT}

   # If LOGO doesn't exist go to Logos section, render it, come
   # back here and continue.
   if [ ! -f $LOGO ];then
      cd $SRC_LOGOS
      ./render.sh centos/horizontal/5c-a/violet/$WIDTH
      cd $WORKPLACE
   fi

   # Rebrand FILE with the appropriate CentOS Logo image.
   if [ -f $LOCATION ] || [ -h $LOCATION ];then
      /bin/cp --remove-destination \
         --verbose \
         -Z system_u:object_r:usr_t \
         $LOGO $FILE
   fi
done

# Copy gnome-startup.png image. This image have no source inside Logos
# section. The original verison was copied from the distribution and
# rebranded using GIMP. After that I put it on inside Logos/Img/ to be
# used as source image on rebranding.
cp $SRC_LOGOS/Img/gnome-startup.png $TRG/
