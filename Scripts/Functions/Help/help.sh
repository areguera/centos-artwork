#!/bin/bash
#
# help.sh -- This function initializes the interface used by
# centos-art.sh script to perform documentation tasks through
# different documentation backends.
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

    # Initialize action name with an empty value.
    local ACTIONNAM=''

    # Initialize search option (`--search'). This option is used to
    # look for documentation inside documentation backends.
    local FLAG_SEARCH=""

    # Initialize the backend flag (`--backend'). This option sets the
    # documentation backed used to perform documentation actions.
    local FLAG_BACKEND='texinfo'

    # Initialize manual's language.
    local MANUAL_L10N=$(cli_getCurrentLocale)

    # Initialize arrays related to documentation entries. Arrays
    # defined here contain all the information needed to process
    # documentation entries written in texinfo format.
    local -a MANUAL_SLFN
    local -a MANUAL_DIRN
    local -a MANUAL_CHAN
    local -a MANUAL_SECN

    # Initialize counter of non-option arguments.
    local MANUAL_DOCENTRY_COUNT=0
    local MANUAL_DOCENTRY_ID=0

    # Interpret option arguments passed through the command-line.
    ${FUNCNAM}_getOptions

    # Redefine arrays related to documentation entries using
    # non-option arguments passed through the command-line. At this
    # point all options have been removed from ARGUMENTS and
    # non-option arguments remain. Evaluate ARGUMENTS to retrive the
    # information related documentation entries from there.
    ${FUNCNAM}_getEntries

    # Syncronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    cli_syncroRepoChanges ${MANUAL_BASEDIR}

    # Initialize backend functionalities. At this point we load all
    # functionalities required into the centos-art.sh's execution
    # environment and make them available, this way, to perform
    # backend-specific documentation tasks.
    cli_exportFunctions "${FUNCDIR}/${FUNCDIRNAM}/$(cli_getRepoName \
        ${FLAG_BACKEND} -d)" "${FLAG_BACKEND}"

    # Execute backend-specific documentation tasks for each
    # documentation entry specified in the command-line, individually.
    # Notice that we've stored all documentation entries passed as
    # non-option arguments in array variables in order to process them
    # now, one by one.  This is particularily useful when we need to
    # reach items in the array beyond the current iteration cycle. For
    # example, when we perform actions that require source and target
    # locations (e.g., copying and renaming): we use the current value
    # as source location and the second value in the array as target
    # location; both defined from the first iteration cycle.
    while [[ $MANUAL_DOCENTRY_ID -lt $MANUAL_DOCENTRY_COUNT ]];do

        # Define name used by manual's main definition file.
        MANUAL_NAME=${MANUAL_SLFN[${MANUAL_DOCENTRY_ID}]}

        # Define absolute path to directory holding manual's main
        # definition file.
        MANUAL_TLDIR="${HOME}/artwork/branches/Manuals/$(cli_getRepoName \
            ${FLAG_BACKEND} -d)/${MANUAL_DIRN[${MANUAL_DOCENTRY_ID}]}"

        # Define chapter name.
        MANUAL_CHAPTER_NAME=${MANUAL_CHAN[${MANUAL_DOCENTRY_ID}]}

        # Define section name.
        MANUAL_SECTION_NAME=${MANUAL_SECN[${MANUAL_DOCENTRY_ID}]}

        # Execute backend-specific documentation tasks.
        ${FLAG_BACKEND}

        # Increment documentation entry counter id.
        MANUAL_DOCENTRY_ID=$(($MANUAL_DOCENTRY_ID + 1))

    done

    # Rebuild output files to propagate recent changes.
    ${FLAG_BACKEND}_updateOutputFiles

    # Commit changes from working copy to central repository only.  At
    # this point, changes in the repository are not merged in the
    # working copy, but chages in the working copy do are committed up
    # to repository.
    cli_commitRepoChanges ${MANUAL_BASEDIR}

}
