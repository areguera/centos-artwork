#!/bin/bash
#
# render_doThemeActions.sh -- This function performs theme-specific
# rendition.
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

function render_doThemeActions {

    # Define patterns using the design model specified by
    # FLAG_THEME_MODEL as reference to know what organization to
    # create inside artistic motifs. When rendering, this condition
    # let the artistic motif to be produced using the same
    # organization of its design model. The intersting thing of this
    # configuration is that you can have more than one design models
    # and each one can has its own unique organization.
    local MODELS_PATTERN=$(find \
        $(cli_getRepoTLDir)/Identity/Models/Themes/Default/ \
        -type d | egrep -v '\.svn' | sed -r '/^$/d' | sed -r \
        "s!^.*/${FLAG_THEME_MODEL}/!!" | tr "\n" '|' \
        | sed -e 's!^|!!' -e 's!|$!!')

    # Define list of available artistic motifs include their names and
    # versions directory levels. To build this list use the theme
    # design model directory structure as renference.
    local MOTIFS=$(find $(cli_getRepoTLDir)/Identity/Images/Themes \
        -regextype posix-egrep -type d \
        -regex ".+/(${MODELS_PATTERN})$" \
        | sort | egrep "$ACTIONVAL")

    # Redefine action value using the list of available artistic
    # motifs.
    for ACTIONVAL in $(echo $MOTIFS);do
        render_doBaseActions
    done

}
