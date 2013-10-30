#!/bin/bash
######################################################################
#
#   palette_getColors.sh -- This function takes one palette produced
#   by Gimp (e.g., syslinux.gpl) as input and outputs a list of colors
#   in #rrggbb format set in the fourth column of it. 
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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
######################################################################

function palette_getColors {

    local COLOR=''
    local PALETTE_COLORS=''
    local PALETTE=${1}

    if [[ -f ${PALETTE} ]];then

        # Retrieve the fourth column from GPL palette. The fourth
        # column of a GPL palette contains the palette commentary
        # field. The palette commentary field can be anything, but for
        # the sake of our own convenience we use it to store the color
        # value in hexadecimal format (e.g., rrggbb).  Notice that you
        # can put your comments from the fifth column on, using an
        # space as field separator.
        PALETTE_COLORS=$(sed -r '1,/^#/d' ${PALETTE} \
            | gawk '{ printf "%s\n", $4 }')

    else

        # Redefine default background color using The CentOS Project
        # default color then.
        PALETTE_COLORS='#204c8d'

    fi

    # Be sure all color information be output in the #rrggbb format.
    for COLOR in ${PALETTE_COLORS};do
        if [[ ! ${COLOR} =~ '^#' ]];then
            COLOR="#${COLOR}"
        fi
        echo "${COLOR}"
    done

}
