#!/bin/bash
#
# render_groupSimilarFiles.sh -- This function provides
# post-rendition action to group files inside directories named as
# their file extensions.  For example: if the current file is a .png
# file, it is moved inside a Png/ directory; if the current file is a
# .jpg file, it is stored inside a Jpg/ directory, and so on.
#
# For this function to work correctly, you need to specify which file
# type you want to group. This is done in the post-rendition ACTIONS
# array inside the appropriate `render.conf.sh' pre-configuration
# script. This function cannot be used as last-rendition action.
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

function render_groupSimilarFiles {

    local SOURCE=''
    local TARGET=''

    # Sanitate file types passed from render.conf.sh pre-rendition
    # configuration script.
    local FORMATS=$(render_getConfigOption "$ACTION" '2-')

    for FORMAT in $FORMATS;do

        # Redifine source file we want to move.
        SOURCE=${FILE}.${FORMAT}

        # Define target directory where source file will be moved
        # into.
        TARGET=$(dirname "$FILE")/$(cli_getRepoName "$FORMAT" 'd')

        # Check existence of source file.
        cli_checkFiles $SOURCE 'f'

        # Check existence of target directory.
        if [[ ! -d $TARGET ]];then
            mkdir -p $TARGET
        fi

        # Redifine file path to add file and its type.
        TARGET=${TARGET}/$(cli_getRepoName "$FILE" 'f').${FORMAT}

        # Move file into its final location.
        cli_printMessage "$TARGET" 'AsMovedToLine'
        mv ${SOURCE} ${TARGET}

    done

}
