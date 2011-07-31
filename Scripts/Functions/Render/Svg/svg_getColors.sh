#!/bin/bash
#
# svg_getColors.sh -- This function takes one palette produced by Gimp
# (e.g., syslinux.gpl) as input and outputs a list of colors in the
# specified format. In order for this function to output the color in
# the format specified, it is needed that the fourth column in the gpl
# palette be set in the `rrggbb' format and the appropriate conversion
# be implemented here.
#
# Notice that using both the `--head' and `--tail' options it is
# possible to control how many consecutive items does the list of
# colors is going to have.  It is possible to output all colors in the
# list, or a consecutive range of them.
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

function svg_getColors {

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='head:,tail:,format:'
    
    # Initialize ARGUMENTS with an empty value and set it as local
    # variable to this function scope.
    local ARGUMENTS=''
    
    # Initialize both head and tail values to return the first line of
    # color information from the palette.
    local HEAD=1
    local TAIL=1

    # Initialize format value used as default when no format option be
    # provided.
    local FORMAT='rrggbb'

    # Initialize list of colors.
    local COLORS=''

    # Redefine ARGUMENTS variable using current positional parameters.
    cli_parseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_parseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through positional parameters.
    while true;do

        case "$1" in 

            --head )
                HEAD=$2
                shift 2
                ;;

            --tail )
                TAIL=$2
                shift 2
                ;;

            --format )
                FORMAT=$2
                shift 2
                ;;

            -- )
                shift 1
                break
                ;;
        esac
    done

    # Define path to gpl palette. This is the first file we use to
    # retrive color information from. Only the first file provided
    # will be used.
    local PALETTE=$(echo $@ | cut -d' ' -f1)

    if [[ $PALETTE == '' ]];then

        # Define palette path inside the theme's artistic motif.
        local MOTIF_PALETTE=$(cli_getRepoTLDir)/Identity/Images/Themes/$(cli_getPathComponent $ACTIONVAL --motif)/Palettes/grub.gpl

        # Define palette path inside the theme's design model.
        local MODEL_PALETTE=$(cli_getRepoTLDir)/Identity/Models/Themes/${THEME_MODEL_NAME}/Palettes/grub.gpl

        # Redefine default background color using palettes provided by
        # artistic motif first, and design model later. Assuming none
        # of them is present, use The CentOS Project default color
        # then.
        if [[ -f $MOTIF_PALETTE ]];then
            COLORS=$(${RENDER_BACKEND}_getColors $MOTIF_PALETTE --head=1 --tail=1)
        elif [[ -f $MODEL_PALETTE ]];then
            COLORS=$(${RENDER_BACKEND}_getColors $MODEL_PALETTE --head=1 --tail=1)
        else
            COLORS='#204c8d'
        fi

    else

        # Retrive the fourth column from GPL palette. The fourth
        # column of a GPL palette contains the palette commentary
        # field. The palette commentary field can be anything, but for
        # the sake of our own convenience we use it to store the color
        # value in hexadecimal format (e.g., rrggbb).  Notice that you
        # can put your comments from the fifth column on using an
        # space as field separator.
        COLORS=$(sed -r '1,/^#/d' $PALETTE \
            | awk '{ printf "%s\n", $4 }' | head -n $HEAD | tail -n $TAIL)

    fi

    # Implement color formats convertions from rrggbb to other formats
    # that you might need to use.
    for COLOR in $COLORS;do

        case $FORMAT in

            rrggbb|* )
                if [[ ! $COLOR =~ '^#' ]];then
                    COLOR="#${COLOR}"
                fi
                ;;

        esac

        # Output color value.
        echo "$COLOR"

    done

}
