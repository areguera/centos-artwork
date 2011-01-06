#!/bin/bash
#
# render_doIdentityGroupByTypes.sh -- This function provides
# post-rendition and last-rendition action to group file inside
# directories named as their file type.
#
# Usage:
# ------
# Post-rendition --> render_doIdentityGroupByTypes "$FILE" "$ACTION"
# Last-rendition --> render_doIdentityGroupByTypes "$ACTION"
#
# Note that post-rendition uses 2 arguments ($FILE and $ACTION) and
# last-rendition just one ($ACTION). This function uses the amount
# of arguments to determine when it is acting as post-rendition and
# when as last-rendition.
#
# This function create one directory for each different file type.
# Later files are moved inside directories respectively.  For example:
# if the current file is a .png file, it is moved inside a Png/
# directory; if the current file is a .jpg file, it is stored inside a
# Jpg/ directory, and so on.
#
# For this function to work correctly, you need to specify which file
# type you want to group. This is done in the post-rendition ACTIONS
# array inside the appropriate `render.conf.sh' pre-configuration
# script. 
#
# For example, the following three lines will create one jpg, ppm,
# xpm, and tif file for each png file available and groups them all by
# its file type, inside directories named as their file type (i.e.
# Png, Jpg, Ppm, Xpm, Tif). Note that in the example, groupByType is
# ivoked as post-rendition action. If you want to invoke it as
# last-rendition action use LAST definition instead of POST.
# 
# ACTIONS[0]='BASE:renderImage' 
# ACTIONS[1]='POST:renderFormats: jpg, ppm, xpm, tif' 
# ACTIONS[2]='POST:groupByType: png, jpg, ppm, xpm, tif'
#
# groupByType function is generally used with renderFormats function.
# Both definitions must match the file type you want to have rendered
# and grouped. You don't need to specify the png file type in
# renderFormats' definition, but in groupByType's definition it must
# be specified.  Otherwise png files will not be grouped inside a png
# directory.
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

function render_doIdentityGroupByType {

    local FILE=''
    local -a FILES
    local -a PATTERNS
    local FORMATS=''
    local SOURCE=''
    local TARGET=''
    local COUNT=0

    if [[ $# -eq 1 ]];then
        # Define file types for post-rendition action.
        FORMATS=$1
    elif [[ $# -eq 2 ]];then
        # Define file types for last-rendition action.
        FORMATS=$2
    else
        cli_printMessage "`gettext "groupByType: Wrong invokation."`" 'AsErrorLine'
        cli_printMessage $(caller) "AsToKnowMoreLine"
    fi

    # Sanitate file types passed from render.conf.sh pre-rendition
    # configuration script.
    FORMATS=$(render_getConfOption "$FORMATS" '2-')

    # Check file types passed from render.conf.sh pre-rendition
    # configuration script.
    if [[ "$FORMATS" == "" ]];then
        cli_printMessage "`gettext "There is no file type information to process."`" 'AsErrorLine'
        cli_printMessage $(caller) "AsToKnowMoreLine"
    fi

    if [[ $# -eq 1 ]];then

        # Define pattern for file extensions.
        PATTERNS[0]=$(echo "$FORMATS" | sed 's! !|!g')

        # Define pattern for directories.
        PATTERNS[1]=$(echo $(for i in $FORMATS; do cli_getRepoName $i 'd'; done) | sed 's! !|!g')

        # Define pattern for path. The path pattern combines both file
        # extension and directories patterns. This pattern is what we
        # use to match rendered file.
        PATTERNS[2]="^.*[^(${PATTERNS[1]})]/[[:alpha:]_-]+\.(${PATTERNS[0]})$"

        # Define list of files to process when acting as
        # last-rendition action. There may be many different files to
        # process here, so we need to build a list with them all
        # (without duplications).
        for FILE in $(find $ACTIONVAL -regextype posix-egrep -type f -regex ${PATTERNS[2]} \
            | sed -r 's!\.[[:alpha:]]{1,4}$!!' | sort | uniq \
            | egrep $REGEX);do
            FILES[$COUNT]="$FILE"
            COUNT=$(($COUNT + 1))
        done

    elif [[ $# -eq 2 ]];then

        # Define list of files to process when action as
        # post-rendition action. There is just one value to process
        # here, the one being currently rendered.
        FILES[0]="$1"
        
    fi

    # Start processing list of files.
    for FILE in "${FILES[@]}";do

        for FORMAT in $FORMATS;do

            # Redifine file path to add file type directory
            SOURCE=${FILE}.${FORMAT}
            TARGET=$(dirname $FILE)/$(cli_getRepoName "$FORMAT" 'd')

            # Check existence of source file.
            cli_checkFiles $SOURCE 'f'

            # Check existence of target directory.
            cli_checkFiles $TARGET 'd'

            # Redifine file path to add file and its type.
            TARGET=${TARGET}/$(basename $FILE).${FORMAT}

            # Move file into its final location.
            cli_printMessage "$TARGET" 'AsMovedToLine'
            mv ${SOURCE} ${TARGET}

      done

    done

}
