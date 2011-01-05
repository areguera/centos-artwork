#!/bin/bash
#
# Rebrand CentOS Symbol in your local system using images from your
# working copy of the CentOS Artwork Repository. Run this script (as
# root) if you want to see how CentOS Symbols inside CentOS Artwork
# Repository look in your system.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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

SRC_SYMBOLS=~/artwork/trunk/Identity/Brands
WORKPLACE=$(pwd)
TRG=/usr/share/pixmaps/redhat

# Actually, images related to CentOS Symbol are contained in files
# that begin its filename with the words `shadowman', and `rpm'. We
# use that pattern here to rebrand the images with the appropriate
# CentOS information.
for FILE in $TRG/{shadowman,rpm}*;do

   # If FILE is a symbolic link continue.
   if [ -h $FILE ];then
      continue;
   fi

   # Get image properties. There are images that doesn't have the
   # width on the filename so we use the identify utility to get it
   # and other image properties.
   PROP=`identify $FILE`

   # Define image name.
   NAME=`basename $FILE`

   # Define image width.
   WIDTH=`echo $PROP | cut -d' ' -f3 | cut -dx -f1`

   # Define image format. We are using only three characters in the
   # image extension.
   FORMAT=`echo $PROP \
         | cut -d' ' -f2 \
         | tr '[:upper:]' '[:lower:]' \
         | sed -r 's!^([a-z]{3}).*!\1!'`

   # Define the appropriate source image. This is the source image we
   # use to rebrand.
   SYMBOL=$SRC_SYMBOLS/Img/centos/symbol/5c-a/violet/${WIDTH}.${FORMAT}

   # If SYMBOL doesn't exist go to Logos section, render it, come
   # back here and continue.
   if [ ! -f $SYMBOL ];then
      cd $SRC_SYMBOLS
      ./render.sh centos/symbols/5c-a/violet/$WIDTH
      cd $WORKPLACE
   fi

   # Rebrand FILE with CentOS Symbol
   if [ -f $LOCATION ] || [ -h $LOCATION ]; then
      /bin/cp --remove-destination \
         --verbose \
         -Z system_u:object_r:usr_t \
         $SYMBOL  $FILE
   fi
done
