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

    # Initialize the search option. The search option (`--search')
    # specifies the pattern used inside info files when an index
    # search is perform.
    FLAG_SEARCH=""

    # Initialize the backend option. The backend option (`--backend')
    # specifies the backend used to manipulate the repository
    # documentation manual.
    FLAG_BACKEND="texinfo"

    # Interpret option arguments passed through the command-line.
    ${FUNCNAM}_getOptions

    # Define manuals base directory. This is the place where
    # documentation manuals base directory structures are stored and
    # organized in.
    MANUAL_BASEDIR="$(cli_getRepoTLDir)/Manuals/$(cli_getRepoName ${FLAG_BACKEND} -d)"

    # Define file name (without extension) for documentation manual.
    MANUAL_NAME=repository

    # Define base name for documentation manual files (without
    # extension). This is the main file name used to build output
    # related files (.info, .pdf, .xml, etc.).
    MANUAL_BASEFILE="${MANUAL_BASEDIR}/${MANUAL_NAME}"

    # Define function configuration directory. The function
    # configuration directory is used to store functionality's related
    # files.
    MANUAL_TEMPLATE=${FUNCDIR}/${FUNCDIRNAM}/Templates

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"
 
    # Verify and initialize backend functions.  There is no need to
    # load all backend-specific functions when we can use just one
    # backend among many. Keep the cli_getFunctions function calling
    # after all variables and arguments definitions.
    if [[ ${FLAG_BACKEND} =~ '^texinfo$' ]];then
        cli_getFunctions "${FUNCDIR}/${FUNCDIRNAM}" 'texinfo'
    elif [[ ${FLAG_BACKEND} =~ '^docbook$' ]];then
        cli_getFunctions "${FUNCDIR}/${FUNCDIRNAM}" 'docbook'
    else
        cli_printMessage "`gettext "The backend provided is not supported."`" --as-error-line
    fi

    # Execute backend functionalities. Notice that there are
    # functionalities that need more than one action value in order to
    # be executed (e.g.,  copying, and renaming), functionalities
    # that need just one action value to be executed (e.g.,
    # documentation reading and edition) and functionalities that
    # don't need action value at all (e.g., searching, reading and
    # updating output files). This way, the execution of backend
    # functionalities is splitted here.
    if [[ $ACTIONNAM =~ "${FLAG_BACKEND}_(copy|rename|delete)Entry" ]];then

        # Define directories where documentation entries are stored
        # in.  Since more than one action value might be affected
        # here, more than one directory might be considered as chapter
        # directory, as well.
        MANUAL_CHAPTER_DIR=$(${FLAG_BACKEND}_getChapterDir "$@")

        # Syncronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_syncroRepoChanges ${MANUAL_CHAPTER_DIR}

        # Execute backend action names that may need to use more than
        # one action value.
        ${ACTIONNAM} $@

        # Commit changes from working copy to central repository only.
        # At this point, changes in the repository are not merged in
        # the working copy, but chages in the working copy do are
        # committed up to repository.
        cli_commitRepoChanges ${MANUAL_CHAPTER_DIR}

    elif [[ $ACTIONNAM =~ "${FLAG_BACKEND}_(search(Index|Node)|updateOutputFiles)" ]];then

        # Bring changes from the repository to the working copy.
        cli_updateRepoChanges ${MANUAL_BASEDIR}

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
        
            # Define directories where documentation entries are
            # stored in.  Since just one action value is
            # affected here, just one directory is considered as
            # chapter directory, as well.
            MANUAL_CHAPTER_DIR=$(${FLAG_BACKEND}_getChapterDir "${ACTIONVAL}")

            # Define chapter name for documentation entry we're working with.
            MANUAL_CHAPTER_NAME=$(basename "$MANUAL_CHAPTER_DIR")

            # Define documentation entry.
            MANUAL_ENTRY=$(${FLAG_BACKEND}_getEntry $ACTIONVAL)

            # Syncronize changes between repository and working copy.
            # At this point, changes in the repository are merged in
            # the working copy and changes in the working copy
            # committed up to repository.
            cli_syncroRepoChanges ${MANUAL_CHAPTER_DIR}

            # Execute backend action names that may need to use more
            # than one action value.
            $ACTIONNAM 

            # Commit changes from working copy to central repository
            # only.  At this point, changes in the repository are not
            # merged in the working copy, but chages in the working
            # copy do are committed up to repository.
            cli_commitRepoChanges ${MANUAL_CHAPTER_DIR}

        done

    fi

    # Rebuild output files to propagate recent changes.
    ${FLAG_BACKEND}_updateOutputFiles

    # Perform language-specific actions when the current language is
    # other but English language.
    if [[ ! $(cli_getCurrentLocale) =~ '^en' ]];then

        # Update translatable strings in related portable objects.
        eval ${CLI_BASEDIR}/${CLI_PROGRAM}.sh locale --update ${MANUAL_BASEFILE}.xhtml --dont-commit-changes

        # Update translatable strings in related portable objects.
        eval ${CLI_BASEDIR}/${CLI_PROGRAM}.sh locale --edit ${MANUAL_BASEFILE}.xhtml

        # Print separator.
        cli_printMessage '-' --as-separator-line

        # Print action message.
        cli_printMessage "${MANUAL_BASEFILE}.xhtml/$(cli_getCurrentLocale)" '--as-updating-line'

        # Render translated versions of the XHTML output files,
        # supressing the rendition output.
        eval ${CLI_BASEDIR}/${CLI_PROGRAM}.sh render ${MANUAL_BASEFILE}.xhtml --dont-commit-changes --quiet

    fi

}
