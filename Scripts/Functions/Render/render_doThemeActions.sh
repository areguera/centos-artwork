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

    local -a DIRS
    local DIR=''
    local COUNT=0
    local NEXT_DIR=''

    # Define patterns to know what organization to create inside
    # artistic motifs. Use the design model specified by
    # FLAG_THEME_MODEL as reference.  When rendering, this condition
    # let the artistic motif to be produced using the same
    # organization of its design model. The intersting thing of this
    # configuration is that you can have more than one design models
    # and each one can has its own unique organization.
    local PATTERN=$(cli_getFilesList \
        $(cli_getRepoTLDir)/Identity/Models/Themes/${FLAG_THEME_MODEL}/ \
        --type="d" | egrep -v '\.svn' | sed -r '/^[[:space:]]*$/d' | sed -r \
        "s!^.*/${FLAG_THEME_MODEL}/!!" | tr "\n" '|' \
        | sed -e 's!^|!!' -e 's!|$!!')

    # Define list of renderable directory structures inside the
    # artistic motif. As reference, to build this list, use the theme
    # design model directory structure. Later, reverse the list and
    # filter it using the action value as reference to control what
    # renderable directory structure to produce.
    local RENDERABLE_DIRS=$(\
        cli_getFilesList $(cli_getRepoTLDir)/Identity/Images/Themes \
        --pattern=".+/($PATTERN)$" --type="d" | sort -r \
        | grep "$ACTIONVAL")

    # Rebuild the list of renderable directory structures using an
    # array variable. This let us to predict what directory is one
    # step forward or backward from the current directory structure.
    for DIR in $RENDERABLE_DIRS;do
        DIRS[((++${#DIRS[*]}))]=${DIR}
    done

    # Redefine counter using the greater value to perform an inverted
    # interpretation of the values and so, to process them using the
    # same order.
    if [[ ${#DIRS[*]} -gt 0 ]];then
        COUNT=${#DIRS[*]}
    fi

    until [[ $COUNT -eq 0 ]];do

        # Decrement counter to match the correct count value.
        COUNT=$(($COUNT - 1))

        # Redefine action value to refer theme specific renderable
        # directory.
        ACTIONVAL=${DIRS[$COUNT]}

        # Define what is the next directory in the list, so we could
        # verify whether to render or not the current theme specific
        # renderable directory.
        if [[ $COUNT -gt 0 ]];then
            NEXT_DIR=$(dirname ${DIRS[(($COUNT - 1))]})
        else
            NEXT_DIR=''
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
