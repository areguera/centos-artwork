#!/bin/bash
#
# render_svg_checkColorFormats.sh -- This function verifies formats of
# colors (i.e., the way color information is specified).
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

function render_svg_checkColorFormats {

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='format:'

    # Initialize ARGUMENTS with an empty value and set it as local
    # variable to this function scope.
    local ARGUMENTS=''

    # Initialize pattern used for color sanitation.
    local PATTERN='^#[0-9a-f]{6}$'

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_parseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_parseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through positional parameters.
    while true;do

        case "$1" in

            --format )

                case "$2" in

                    rrggbb|*)
                        PATTERN='^#[0-9a-f]{6}$'
                        ;;

                esac
                shift 2
                ;;

            -- )
                shift 1
                break
                ;;
        esac
    done

    # Define the location we want to apply verifications to.
    local COLOR=''
    local COLORS="$@"

    # Loop through colors and perform format verification as specified
    # by pattern.
    for COLOR in $COLORS;do

        if [[ ! $COLOR =~ $PATTERN ]];then
            cli_printMessage "`eval_gettext "The \\\"\\\$COLOR\\\" string is not a valid color code."`" --as-error-line
        fi

    done

}
