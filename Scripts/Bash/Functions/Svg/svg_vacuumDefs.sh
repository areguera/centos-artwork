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

    # Redefine filter flag to specify the extension of scalable vector
    # graphics files we want to update metadata in.  Use action value
    # as reference to find out different shell files.
    FLAG_FILTER=".*${FLAG_FILTER}.*\.(svgz|svg)"

    # Build list of files to process.
    cli_getFilesList

    # Process list of files.
    for FILE in $FILES;do

        # Output action message.
        cli_printMessage "$FILE" 'AsUpdatingLine'

        # Vacuum unused svg definition using inkscape.
        inkscape --vacuum-defs $FILE &> /dev/null

    done

}
