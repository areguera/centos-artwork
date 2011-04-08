#!/bin/bash
#
# brandAnaconda - Anaconda branding script.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function brandAnaconda {

   # Define file's source and target.
   local ARTDIR=~/artwork/trunk/Identity/Themes/$(cli_getPathComponent '--theme')/Distro/Anaconda
   local PIXMAP=/usr/share/anaconda/pixmaps
   local SOURCE=''
   local TARGET=''

   # Define list of files used as base to determine which files may
   # need to be updated.  Remove target from file path. Do not use
   # basename command. We may need the directory structure (if any)
   # under target, for further evaluation.
   local FILES=$(find ${PIXMAP}/ | sort | uniq | sed "s!${PIXMAP}/!!g")
   local FILE=''

   for FILE in $FILES;do

      # Define which file is release-specific, and specify the correct
      # path on source.
      case $FILE in
         anaconda_header.png )
         SOURCE=$ARTDIR/Header/Img/$MAJOR_RELEASE/$FILE 
         TARGET=$PIXMAP/$FILE
         ;;

         progress_first*.png | first*.png )
         SOURCE=$ARTDIR/Progress/Img/$MAJOR_RELEASE/$FILE
         TARGET=$PIXMAP/$FILE
         ;;

         rnotes | rnotes/?? | rnotes/??_?? )
         continue
         ;;

         rnotes/??-*.png )
         FILE=$(basename $FILE | sed -r 's!-centos[0-9]+!!')
         SOURCE=$ARTDIR/Progress/Img/$MAJOR_RELEASE/en/$FILE
         TARGET=$PIXMAP/rnotes/$FILE
         ;;

         rnotes/*/??-*.png )
         LANGUAGE=$(echo $FILE | sed -r 's!rnotes/(.+)/.*!\1!')
         FILE=$(basename $FILE | sed -r 's!-centos[0-9]+!!')
         SOURCE=$ARTDIR/Progress/Img/$MAJOR_RELEASE/$LANGUAGE/$FILE
         TARGET=$PIXMAP/rnotes/$LANGUAGE/$FILE
         ;;

         splash.png )
         SOURCE=$ARTDIR/Splash/Img/$MAJOR_RELEASE/$FILE
         TARGET=$PIXMAP/$FILE
         ;;

         syslinux-splash.png )
         TARGET=$PIXMAP/$FILE
         FILE=$(echo $FILE | sed -r 's!\.png$!-16c.png!')
         SOURCE=$ARTDIR/Prompt/Img/$MAJOR_RELEASE/$FILE
         ;;

         * )
         TARGET=$PIXMAP/$FILE
         SOURCE=$ARTDIR/$FILE
      esac

      # Check if file exists on source. If file doesn't exist on the
      # source it is not updated on target. Go to next file in the
      # loop and check again. Only file names on source that match
      # those in target are updated.
      cli_checkFiles "$SOURCE"
   
      # File exists and will be installed on target.
      cli_printMessage "$TARGET" "AsUpdatingLine"

      # Update file.
      #cp $SOURCE $TARGET

      # Set file's access rights.
      #chown root:root $TARGET
      #chmod 755 $TARGET
      #chcon system_u:object_r:usr_t $TARGET

done
}
