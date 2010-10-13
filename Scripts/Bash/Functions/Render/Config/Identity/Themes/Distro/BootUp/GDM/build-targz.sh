#!/bin/bash
#
# GDM Display Manager tar.gz building script.
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
# $Id: build-targz.sh 42 2010-09-17 05:51:32Z al $
# ----------------------------------------------------------------------

# Define artwork component
ARTCOMP="Themes/Distro/BootUp/GDM"

# Define directory holding GdmGreeterTheme.xml and
# GdmGreeterTheme.desktop design model files.
XML=/home/centos/artwork/trunk/Identity/Themes/Models/Default/Distro/BootUp/GDM/Xml

# Define image directory.
IMG=/home/centos/artwork/trunk/Identity/Themes/Motifs/$(getThemeName)/Distro/BootUp/GDM/

# Define tar.gz directory. Use the current location because the
# build.sh script is (and it should be) inside `tgz/' direcotry.
TGZ='.'

# Define directory holding backgrounds.
BGS=/home/centos/artwork/trunk/Identity/Themes/Motifs/$(getThemeName)/Backgrounds/Img

# Define file holding CentOS Symbol.
SYMBOL=/home/centos/artwork/trunk/Identity/Brands/Img/CentOS/Symbol/5c-a/64.png
checkFiles $SYMBOL

# Define VERSIONS list.
VERSIONS=$(getThemeVersion "$1")

# Define RESOLUTION list.
RESOLUTIONS=$(getThemeResolution "$2")

for VERSION in $VERSIONS;do

   # Strip directory from $VERSION.
   VERSION=$(basename $VERSION)

   for RESOLUTION in $RESOLUTIONS;do

      # There are some resolutions available inside backgrounds that
      # we don't need to build tar.gz files for.
      case $RESOLUTION in
         200x150 | 160x600 )
            continue
      esac

      # Check tar.gz directory existence.
      if [ ! -d $TGZ/$VERSION/$RESOLUTION ];then
         mkdir -p $TGZ/$VERSION/$RESOLUTION
      fi

      cli_printMessage "$TGZ/$VERSION/$RESOLUTION/$(getThemeName).tar.gz" "AsCreatingLine"

      # Create temporal directory.
      if [ ! -d $(getThemeName) ]; then
         mkdir $(getThemeName)
      fi

      # Copy files into temporal directory.
      cp $SYMBOL	         		            $(getThemeName)/centos-symbol.png
      cp $IMG/$VERSION/release.png              $(getThemeName)/centos-release.png
      cp $IMG/$VERSION/screenshot.png           $(getThemeName)/screenshot.png
      cp $BGS/$RESOLUTION.png                   $(getThemeName)/background.png
      cp $IMG/*.png         		            $(getThemeName)/
      cp $XML/$(getThemeName).xml        		$(getThemeName)/
      cp $XML/GdmGreeterTheme.desktop           $(getThemeName)/

      # Create tar.gz package.
      tar -czf $(getThemeName).tar.gz           $(getThemeName)

      # Remove temporal directory.
      rm  -r                  		            $(getThemeName)

      # Move the tar.gz file to its directory.
      mv $(getThemeName).tar.gz                 $TGZ/$VERSION/$RESOLUTION

   done
done
