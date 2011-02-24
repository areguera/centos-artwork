#!/bin/bash
#
# svg_vacuumDefs.sh -- This function removes all unused items from the
# <lt>defs<gt> section of the SVG file massively.
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

function svg_vacuumDefs {

    local FILE=''
    local FILES=''

    # Build list of files to process.
    FILES=$(cli_getFilesList "${ACTIONVAL}" "${FLAG_FILTER}.*\.(svgz|svg)")

    # Set action preamble.
    cli_printActionPreamble "${FILES}"

    # Process list of files.
    for FILE in $FILES;do

        # Output action message.
        cli_printMessage "$FILE" 'AsUpdatingLine'

        # Vacuum unused svg definition using inkscape.
        inkscape --vacuum-defs $FILE &> /dev/null

    done

}
