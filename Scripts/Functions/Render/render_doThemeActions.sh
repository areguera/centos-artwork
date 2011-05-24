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
    local COUNT=0
    local NEXT_DIR=''
    local MOTIF_NAME=''
    local MOTIF_DIR=''

    # Define base directory of artistic motifs. This is the location
    # where all artistic motifs are stored in.
    local MOTIF_BASEDIR="$(cli_getRepoTLDir $ACTIONVAL)/Identity/Images/Themes"

    # Define base directory of design models. This is the location
    # where all design models are stored in.
    local MODEL_BASEDIR="$(cli_getRepoTLDir $ACTIONVAL)/Identity/Models/Themes"

    # Define directory structure of design models. Design models
    # directory structures are used as reference to create artistic
    # motifs directory structure.
    local MODEL_DIR=''
    local MODEL_DIRS="$(cli_getFilesList ${MODEL_BASEDIR}/${FLAG_THEME_MODEL} \
        --type="d" | egrep -v '\.svn' | sed -r '/^[[:space:]]*$/d' | sed -r \
        "s!^.*/${FLAG_THEME_MODEL}/!!" | sed -r '/^[[:space:]]*$/d')"

    # Define design model regular expression patterns from design
    # models directory structure.
    local MODEL_PATTERN=$(echo "$MODEL_DIRS" | tr "\n" '|' \
        | sed -e 's!^|!!' -e 's!|$!!')

    # Define list of renderable directory structures inside the
    # artistic motif. As reference, to build this list, use design
    # model directory structure. Later, filter the result using the
    # action value as reference to control what renderable directory
    # structure to produce. The more specific you be in the path
    # specification the more specific theme rendition will be.
    local MOTIF_RENDERABLE_DIR=''
    local MOTIF_RENDERABLE_DIRS=$(cli_getFilesList ${MOTIF_BASEDIR} \
        --pattern=".+/($MODEL_PATTERN)" --type="d" | grep "$ACTIONVAL")

    # Rebuild list of renderable directory structures using an array
    # variable. This let us to predict what directory is one step
    # forward or backward from the current directory structure.
    for MOTIF_RENDERABLE_DIR in $MOTIF_RENDERABLE_DIRS;do
        DIRS[((++${#DIRS[*]}))]=${MOTIF_RENDERABLE_DIR}
    done

    # Define total number of directories to process. This is required
    # in order to correct the counting value and so, make it to match
    # the zero based nature of bash array variables.
    local DIRS_TOTAL=$((${#DIRS[*]} - 1))

    while [[ $COUNT -le ${DIRS_TOTAL} ]];do

        # Redefine action value to refer the theme-specific renderable
        # directory.
        ACTIONVAL=${DIRS[$COUNT]}

        # Refine artistic motif name using the current action value.
        MOTIF_NAME=$(cli_getPathComponent $ACTIONVAL --motif)

        # Verify artistic motif name. The name of the artistic motif
        # must be present in order for theme rendition to happen.
        # Theme rendition takes place inside artistic motifs and the
        # artistic motif name is an indispensable part of it. Take
        # care of not using design models directory structure as name
        # for artistic motifs. They, sometimes, match the pattern used
        # to verify artistic motifs names but must not be confused.
        if [[ $MOTIF_NAME == '' ]] || [[ $MOTIF_NAME =~ "^$MODEL_PATTERN" ]];then
            COUNT=$(($COUNT + 1))
            continue
        fi

        # Refine artistic motif directory. This is the top directory
        # where all visual manifestations of an artistic motif are
        # stored in (e.g., Backgrounds, Brushes, Concept, Distro,
        # etc.).
        MOTIF_DIR="${MOTIF_BASEDIR}/${MOTIF_NAME}"

        # Define what is the next directory in the list, so we could
        # verify whether to render or not the current theme-specific
        # renderable directory.
        if [[ $COUNT -lt ${DIRS_TOTAL} ]];then
            NEXT_DIR=$(dirname ${DIRS[(($COUNT + 1))]})
        else
            NEXT_DIR=''
        fi

        # Verify whether to render or not the current theme's
        # renderable directory. This verification is needed in order
        # to avoid unncessary rendition loops. For example, don't
        # render `path/to/dir/A' when `path/to/dir/A/B' does exist,
        # that configuration would produce `/path/to/dir/A/B twice.
        if [[ $ACTIONVAL =~ '[[:digit:]]$' ]] || [[ $ACTIONVAL == $NEXT_DIR ]];then
            COUNT=$(($COUNT + 1))
            continue
        fi

        # Execute direct rendition on theme specific renderable
        # directory as specified by action value.
        render_doBaseActions

        # Increment counter to match the correct count value.
        COUNT=$(($COUNT + 1))

    done

}
