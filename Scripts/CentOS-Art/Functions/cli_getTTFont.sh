#!/bin/bash
#
# cli_getFont.sh -- This function creates a list of all True Type
# Fonts (TTF) installed in your workstation and returns the absolute
# path of the file matching the pattern passed as first argument.
# Assuming more than one value matches, the first one in the list is
# used. In case no match is found, the function verifies if there is
# any file in the list that can be used (giving preference to sans
# files). If no file is found at this point, an error will be printed
# out.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function cli_getTTFont {

    local -a FONT_PATTERNS
    local FONT_PATTERN=''
    local FONT_FILE=''

    # Define list of patterns used to build the list of TTF files.
    FONT_PATTERNS[((++${#FONT_PATTERNS[*]}))]="/${1}\.ttf$"
    FONT_PATTERNS[((++${#FONT_PATTERNS[*]}))]="sans\.ttf$"
    FONT_PATTERNS[((++${#FONT_PATTERNS[*]}))]="\.ttf$"

    # Define directory location where fonts are installed in your
    # workstation.
    local FONT_DIR='/usr/share/fonts'

    # Define list of all TTF files installed in your workstation.
    local FONT_FILES=$(cli_getFilesList ${FONT_DIR} --pattern="\.ttf")

    # Define TTF absolute path based on pattern. Notice that if the
    # pattern matches more than one value, only the first one of a
    # sorted list will be used.
    for FONT_PATTERN in ${FONT_PATTERNS[@]};do
       
        FONT_FILE=$(echo "$FONT_FILES" | egrep ${FONT_PATTERN} \
            | head -n 1)

        if [[ -f $FONT_FILE ]];then
            break
        fi

    done

    # Output TTF absolute path.
    if [[ -f $FONT_FILE ]];then
        echo $FONT_FILE
    else
        cli_printMessage "`gettext "The font provided doesn't exist."`" --as-error-line
    fi

}
