#!/bin/bash
#
# render.sh -- This function provides rendering features to
# centos-art.sh script. Here we initialize rendering variables and
# call render_getActions functions.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function render {

    # Define rendering variables.
    local RELEASE_FORMAT='[[:digit:]]+(\.[[:digit:]]+){,1}'

    # Re-define root directory used to load pre-rendering
    # configuration scripts based on option value.
    local ARTCONF=$(echo "$OPTIONVAL" \
        | sed -r -e 's!/(Identity|Translations)!/Scripts/Bash/Functions/Render/Config/\1!' \
                 -e "s!Motifs/$(cli_getThemeName)/?!!")

    # Define rendering actions.
    render_getActions

}
