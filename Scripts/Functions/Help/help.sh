#!/bin/bash
#
# help.sh -- This function standardizes the way documentation is
# produced and maintained for "The CentOS Artwork Repository
# Reference" documentation manual.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

    # Initialize the search option. The search option (`--search')
    # specifies the pattern used inside info files when an index
    # search is perform.
    FLAG_SEARCH=""

    # Define manual top level directory. This is where
    # language-specific documentation structures are stored in.
    MANUAL_TLDIR="$(cli_getRepoTLDir)/Manuals/RepoReference"

    # Define file name (without extension) for documentation manual.
    MANUAL_NAME=$(cli_getRepoName "repository" -f)

    # Define file extension used by documentation manual source files.
    MANUAL_EXTENSION='texinfo'

    # Define language information used by manual.
    MANUAL_LANG=$(cli_getCurrentLocale)

    # Define manual base directory. This is where the
    # language-specific document initialization file is stored in.
    MANUAL_BASEDIR="${MANUAL_TLDIR}/${MANUAL_LANG}"

    # Define base name for documentation manual files (without
    # extension). This is the main file name used to build output
    # related files (.info, .pdf, .xml, etc.).
    MANUAL_BASEFILE="${MANUAL_BASEDIR}/${MANUAL_NAME}"

    # Define chapter name of directory where repository documentation
    # entries will be stored in.
    MANUAL_CHAPTER_NAME=$(cli_getRepoName "Directories" -d)

    # Define absolute path to chapter directory where repository
    # documentation entries will be stored in.  At this point, we need
    # to take a desition about documentation design, in order to
    # answer the question: How do we assign chapters, sections and
    # subsections automatically, based on the repository structure?
    # and also, how such design could be adapted to changes in the
    # repository structure?
    #
    # One solution would be: represent the repository's directory
    # structure as sections inside a chapter named `Directories' or
    # something similar. Subsections and subsubsections will not have
    # their own files, they all will be written inside the same
    # section file that represents the repository documentation entry.
    MANUAL_CHAPTER_DIR=${MANUAL_BASEDIR}/${MANUAL_CHAPTER_NAME}

    # Define absolute path to backend template files.
    MANUAL_TEMPLATE=${FUNCDIR}/${FUNCDIRNAM}/Templates/${MANUAL_LANG}

    # Verify absolute path to backend template files. If the absolute
    # path doesn't exist, use the English language templates.
    if [[ ! -d $MANUAL_TEMPLATE ]];then
        MANUAL_TEMPLATE=${FUNCDIR}/${FUNCDIRNAM}/Templates/en_US
    fi

    # Create documentation structure, if it doesn't exist.
    ${FUNCNAM}_createStructure

    # Interpret option arguments passed through the command-line.
    ${FUNCNAM}_getOptions

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Syncronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    cli_syncroRepoChanges ${MANUAL_CHAPTER_DIR}

    # Execute backend functionalities. Notice that there are
    # functionalities that need more than one action value in order to
    # be executed (e.g.,  copying, and renaming), functionalities
    # that need just one action value to be executed (e.g.,
    # documentation reading and edition) and functionalities that
    # don't need action value at all (e.g., searching, reading and
    # updating output files). This way, the execution of backend
    # functionalities is splitted here.
    if [[ $ACTIONNAM =~ "${FUNCNAM}_(copy|rename|delete)Entry" ]];then

        # Execute backend action names that may need to use more than
        # one action value.
        ${ACTIONNAM} $@

    elif [[ $ACTIONNAM =~ "${FUNCNAM}_(search(Index|Node)|updateOutputFiles)" ]];then

        # Execute backend action names that might not need any action
        # value as reference to do their work.
        $ACTIONNAM $@

        # Backend action names that don't need to use any action value
        # as reference to do their work are of one-pass only. They are
        # executed and then the script execution is finished.
        exit

    else

        # Execute backend action names that use one action value, only.
        for ACTIONVAL in $@;do
        
            # Define documentation entry.
            MANUAL_ENTRY=$(${FUNCNAM}_getEntry $ACTIONVAL)

            # Execute backend action names that may need to use more
            # than one action value.
            $ACTIONNAM

        done

    fi

    # Commit changes from working copy to central repository only.  At
    # this point, changes in the repository are not merged in the
    # working copy, but chages in the working copy do are committed up
    # to repository.
    cli_commitRepoChanges ${MANUAL_CHAPTER_DIR}

    # Rebuild output files to propagate recent changes.
    ${FUNCNAM}_updateOutputFiles

}
