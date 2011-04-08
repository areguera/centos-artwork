#!/bin/bash
#
# render_checkSvgAbsref.sh -- This function retrives absolute files
# and checks their existence. In order for design templates to point
# different artistic motifs, design templates make use of external
# files that point to specific artistic motif background images. If
# such external files doesn't exist, print a message and stop script
# execution.  We cannot continue without background information.
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

function render_checkSvgAbsref {

    local FILE=''
    local ABSPATHS=''
    local ABSPATH=''

    # Define absolute path of file we need to retrive absolute paths
    # from.
    FILE="$1"

    # Verify existence of file we need to retrive absolute paths from.
    cli_checkFiles $FILE 'f'

    # Retrive absolute paths from file.
    ABSPATHS=$(egrep "(sodipodi:absref|xlink:href)=\"${HOME}.+" $FILE \
        | sed -r "s,.+=\"(${HOME}.+\.png)\".*,\1,")

    # Verify absolute paths retrived from file.
    for ABSPATH in $ABSPATHS;do
        cli_checkFiles "$ABSPATH" 'f'
    done

}
