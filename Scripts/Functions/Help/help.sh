#!/bin/bash
#
# help.sh -- This function standardizes the way documentation is
# produced and maintain inside the working copy of CentOS Artwork
# Repository.
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
    
function help {

    local ACTIONNAM=''
    local ACTIONVAL=''
    local -a ACTIONVALS

    # Define manuals base directory. This is the place where
    # documentation manuals base directory structures are stored and
    # organized in.
    MANUAL_BASEDIR="${HOME}/artwork/trunk/Manual"

    # Define file name for documentation manual. This is the file used
    # to initiate the structure of documentation manual.
    MANUAL_NAME=repository

    # Define base name for documentation manual files (without
    # extension). This is the main file name used to build texinfo
    # related files (.info, .pdf, .xml, etc.).
    MANUAL_BASEFILE="${MANUAL_BASEDIR}/${MANUAL_NAME}"

    # Interpret option arguments passed through command-line.
    help_getOptions

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Store remaining arguments into an array. This way it is possible
    # to find out which is the last argument in the list.  When
    # copying files inside the repository, the last argument in the
    # list is considered the target location and all other arguments
    # are considered the source locations. Similary, when renaming
    # files, only two arguments can be passed.
    for ACTIONVAL in "$@";do
        ACTIONVALS[((++${#ACTIONVALS[*]}))]="$ACTIONVAL"
    done

    # Enforce conditions against remaining non-option arguments before
    # processing them.
    if [[ ${ACTIONNAM} == ${FUNCNAM}_copyEntry ]];then

        # When a documentation entry is copied, we need to determine
        # what location to use as target.  To solve this, the last
        # argument passed to centos-art script is taken as target
        # location. All other arguments previously defined are
        # considered source locations. Notice that more than one
        # source location can be specified, but just one target
        # location can exist.
        local -a ENTRY_SRC
        local ENTRY_DST=''
        local COUNT=0

        # Define list of source locations using remaining arguments.
        while [[ ${COUNT} -lt $((${#ACTIONVALS[*]} - 1)) ]];do
            ENTRY_SRC[((++${#ENTRY_SRC[*]}))]=${ACTIONVALS[$COUNT]}
            COUNT=$(($COUNT + 1))
        done

        # Define target location.
        ENTRY_DST=$(cli_checkRepoDirTarget "${ACTIONVALS[((${#ACTIONVALS[*]} - 1))]}")

        # Define target documentation entry.
        ENTRY_DST=$(help_getEntry "$ENTRY_DST")

        # Redefine arguments to store source locations only.
        ARGUMENTS=${ENTRY_SRC[@]}

    elif [[ ${ACTIONNAM} == ${FUNCNAM}_renameEntry ]];then

        # When documentation entry is renamed, we need to restrict the
        # number of arguments to two arguments only.  More than two
        # arguments are useless since the renaming action works with
        # two arguments only. This is, the source location and the
        # target location.
        local ENTRY_SRC=''
        local ENTRY_DST=''

        # Verify number of arguments passed to centos-art.sh script.
        if [[ ${#ACTIONVALS[*]} -gt 2 ]];then
            cli_printMessage "`gettext "Only two arguments are accepted."`" --as-error-line
        elif [[ ${#ACTIONVALS[*]} -lt 2 ]];then
            cli_printMessage "`gettext "Two arguments are required."`" --as-error-line
        fi

        # Define source location. 
        ENTRY_SRC=${ACTIONVALS[0]}

        # Define target location.
        ENTRY_DST=$(cli_checkRepoDirTarget "${ACTIONVALS[1]}")

        # Define target documentation entry.
        ENTRY_DST=$(help_getEntry "${ACTIONVALS[1]}")

        # Redefine arguments to store source locations only.
        ARGUMENTS=$ENTRY_SRC

    else

        # Redefine arguments to store all arguments.
        ARGUMENTS=$@

    fi

    # Define action name. It does matter what option be passed to
    # centos-art, there are many different actions to perform based on
    # the option passed (e.g., `--edit', `--read', `--search', etc.).
    # In that sake, we defined action name inside help_getArguments,
    # at the moment of interpreting options.

    # Define action value. As convenction, we use non-option arguments
    # to define the action value (ACTIONVAL) variable.
    for ACTIONVAL in $ARGUMENTS;do

        # Check action value passed through the command-line using
        # source directory definition as reference.
        cli_checkRepoDirSource

        # Define documentation entry.
        ENTRY=$(help_getEntry)

        # Define documentation entry directory. This is the directory
        # where the entry file is stored.
        ENTRY_DIR=$(dirname ${ENTRY} | sed -r 's!\.texi$!!')

        # Define documentation entry file (without extension).
        ENTRY_FILE=$(basename ${ENTRY} | sed -r 's!\.texi$!!')

        # Define directory to store documentation entries.  At this
        # point, we need to take a desition about documentation
        # design, in order to answer the question: How do we assign
        # chapters, sections and subsections automatically, based on
        # the repository structure?  and also, how such design could
        # be adapted to changes in the repository structure?
        #
        # One solution would be: represent the repository's directory
        # structure as sections inside a chapter named `Directories'
        # or something similar. Subsections and subsubsections will
        # not have their own files, they all will be written inside
        # the same section file that represents the repository
        # documentation entry.
        MANUAL_CHAPTER_DIR=$(echo $ENTRY | cut -d / -f-7)

        # Define chapter name for the documentation entry we are
        # working with.
        MANUAL_CHAPTER_NAME=$(basename "$MANUAL_CHAPTER_DIR")

        # Syncronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_syncroRepoChanges ${MANUAL_CHAPTER_DIR}

        # Execute action name.
        if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
            eval $ACTIONNAM
        else
            cli_printMessage "`gettext "A valid action is required."`" --as-error-line
        fi

        # Commit changes from working copy to central repository only.
        # At this point, changes in the repository are not merged in
        # the working copy, but chages in the working copy do are
        # committed up to repository.
        cli_commitRepoChanges ${MANUAL_CHAPTER_DIR}

    done
}
