#!/bin/bash
#
# render_doTranslationMarkers.sh -- This function standardizes
# replacements for common translation markers.  This function must be
# called from render_getIdentityDefs.sh function (after instance
# creation and before final file creation).  Raplacements are applied
# to temporal instances used to produced the final file.
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

function render_doTranslationMarkers {

    # Initialize theme replacements.
    local -a SRC
    local -a DST
    local COUNT=0

    # Redefine theme translation markers.
    SRC[0]='=THEME='
    SRC[1]='=COPYRIGHT='
    SRC[2]='=DESCRIPTION='
    SRC[3]='=LICENSE='
    SRC[4]='=NAME='
    SRC[5]='=RELEASE='
    SRC[6]='=URL='

    # Redefine theme replacements.
    DST[0]="$(cli_getThemeName)"
    DST[1]="$(cli_getCopyrightInfo '--copyright')"
    DST[2]="$(cli_getCopyrightInfo '--description')"
    DST[3]="$(cli_getCopyrightInfo '--license')"
    DST[4]="$(cli_getThemeName '--name')"
    DST[5]="$(cli_getThemeName '--release')"
    DST[6]="http://www.centos.org/"

    # Replace translation markes with theme values.
    while [[ ${COUNT} -lt ${#SRC[*]} ]];do

        # Replace translation markers.
        sed -r -i "s!${SRC[$COUNT]}!${DST[$COUNT]}!g" $INSTANCE

        # Increment counter.
        COUNT=$(($COUNT + 1))

    done

}
