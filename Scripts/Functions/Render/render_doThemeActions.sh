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

    local -a MOTIFS
    local MOTIF=''
    local COUNT=0
    local NEXT_DIR=''

    # Define patterns using the design model specified by
    # FLAG_THEME_MODEL as reference to know what organization to
    # create inside artistic motifs. When rendering, this condition
    # let the artistic motif to be produced using the same
    # organization of its design model. The intersting thing of this
    # configuration is that you can have more than one design models
    # and each one can has its own unique organization.
    local MODELS_PATTERN=$(find \
        $(cli_getRepoTLDir)/Identity/Models/Themes/${FLAG_THEME_MODEL}/ \
        -type d | egrep -v '\.svn' | sed -r '/^$/d' | sed -r \
        "s!^.*/${FLAG_THEME_MODEL}/!!" | tr "\n" '|' \
        | sed -e 's!^|!!' -e 's!|$!!')

    # Define list of available artistic motifs include their names and
    # versions directory levels. To build this list use the theme
    # design model directory structure as renference. Also, build the
    # list using the most specific renderable directories (e.g., those
    # whose have a longer path) to avoid unnecessary rendition loops.
    for MOTIF in $(find $(cli_getRepoTLDir)/Identity/Images/Themes \
        -regextype posix-egrep -type d -regex ".+/(${MODELS_PATTERN})$" \
        | sort -r | grep "$ACTIONVAL");do
        if [[ $MOTIF != '' ]];then
            MOTIFS[((++${#MOTIFS[*]}))]=${MOTIF}
        fi
    done

    # Redefine counter using the grater value to perform an inverted
    # interpretation of the values and so, to process them using the
    # same order.
    if [[ ${#MOTIFS[*]} -gt 0 ]];then
        COUNT=${#MOTIFS[*]}
    else
        COUNT=0
    fi

    until [[ $COUNT -eq 0 ]];do

        # Decrement counter to match the correct count value.
        COUNT=$(($COUNT - 1))

        # Redefine action value to refer theme specific renderable
        # directory.
        ACTIONVAL=${MOTIFS[$COUNT]}

        # Define what is the next directory in the list, so we could
        # verify whether to render or not the current theme specific
        # renderable directory.
        if [[ $COUNT -eq 0 ]];then
            NEXT_DIR=''
        else
            NEXT_DIR=$(dirname ${MOTIFS[(($COUNT - 1))]})
        fi

        # Verify whether to render or not the current theme renderable
        # directory. This verificatin is required in order to avoid
        # unncessary rendition loops. For example, don't render
        # `path/to/dir/A' when `path/to/dir/A/B' does exist, that
        # configuration would produce `/path/to/dir/A/B twice.
        if [[ $ACTIONVAL =~ '[[:digit:]]$' ]] \
            || [[ $ACTIONVAL == $NEXT_DIR ]];then
            continue
        fi

        # Execute direct rendition on theme specific renderable
        # directory as specified by action value.
        render_doBaseActions

    done

}
