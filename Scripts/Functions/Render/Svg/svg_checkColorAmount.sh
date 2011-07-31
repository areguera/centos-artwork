#!/bin/bash
#
# svg_checkColorAmount.sh -- This function verifies whether the list
# of colors provided in the first argument matches the amount of
# colors specified by the second argument.
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

function svg_checkColorAmount {

    # Define list of colors. 
    local COLORS=$1

    # Define the amount of colors the list provided must have, in
    # order to be considered as valid.
    local NUMBER=$2

    # Verify amount of colors provided in the list.
    if [[ $(echo "$COLORS" |  wc -l) -ne $NUMBER ]];then
        cli_printMessage "`gettext "The palette does not have the correct number of colors."`" --as-error-line
    fi

}
