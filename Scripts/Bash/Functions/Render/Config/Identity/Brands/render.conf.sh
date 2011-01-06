#!/bin/bash
#
# render_loadConfig.sh -- This function defines brands pre-rendition
# configuration script.
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

function render_loadConfig {
    
    local TRANSLATION=''
    local TEMPLATE=''

    # Define rendition actions.
    ACTIONS[0]='BASE:renderImage'
    ACTIONS[1]='POST:renderBrands: tif xpm pdf ppm'

    # Define matching list.
    MATCHINGLIST="\
    $(for TEMPLATE in $(find /home/centos/artwork/trunk/Identity/Brands/Tpl \
        -name '*.svg' | sed -r 's!.*/Brands/Tpl/(.*)$!\1!' | sort );do
        TRANSLATION=$(find /home/centos/artwork/trunk/Translations/Identity/Brands/$(echo $TEMPLATE \
            | sed 's!\.svg!!') -name '*.sed' \
            | sed -r 's!^.*/Brands/(.*)$!\1!' \
            | sort | tr '\n' ' ');
        echo $TEMPLATE: $TRANSLATION
    done)
    "

}
