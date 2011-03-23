#!/bin/bash
#
# help.sh -- This function provides documentation features to
# centos-art.sh script. Here we initialize documentation variables and
# call help_getArguments functions.
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
    
function help {

    local ACTIONNAM=''
    local ACTIONVAL=''

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

    # Interpret arguments and options passed through command-line.
    help_getArguments

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Define action name. It does matter what option be passed to
    # centos-art, there are many different actions to perform based on
    # the option passed (e.g., `--edit', `--read', `--search', etc.).
    # In that sake, we defined action name inside help_getArguments,
    # at the moment of interpreting options.

    # Define default manual node shown when no argument is provided to
    # help functionality.  By default, the Top node of repository
    # manual is called.
    if [[ $ACTIONNAM == '' ]] && [[ $ACTIONVAL == '' ]];then
        /usr/bin/info --node="Top" --file=${MANUAL_BASEFILE}.info.bz2
    fi

    # Define action value. As convenction, we use non-option arguments
    # to define the action value (ACTIONVAL) variable.
    for ACTIONVAL in "$@";do

        if [[ $ACTIONVAL == '--' ]];then
            continue
        fi

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
        # structure as sections inside a chapter named Filesystem or
        # something similar. Subsections and subsubsections will not
        # have their own files, they all will be written inside the
        # same section file that represents the repository directory.
        MANUAL_CHAPTER_DIR=$(echo $ENTRY | cut -d / -f-7)

        # Define chapter name for the documentation entry we are
        # working with.
        MANUAL_CHAPTER_NAME=$(basename "$MANUAL_CHAPTER_DIR")

        # Set action preable.
        cli_printActionPreamble "${MANUAL_BASEFILE}.texi" '' ''

        # Syncronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_syncroRepoChanges ${MANUAL_BASEDIR}

        # Execute action name.
        if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
            eval $ACTIONNAM
        else
            cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
            cli_printMessage "$(caller)" 'AsToKnowMoreLine'
        fi

        # Commit changes from working copy to central repository only.
        # At this point, changes in the repository are not merged in
        # the working copy, but chages in the working copy do are
        # committed up to repository.
        cli_commitRepoChanges ${MANUAL_BASEDIR}

    done
}
