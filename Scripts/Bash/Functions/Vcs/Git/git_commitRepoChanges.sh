#!/bin/bash
#
# git_commitRepoChanges.sh -- This function standardizes the way local
# changes are committed up to central repository.
#
# Copyright (C) 2009-2013 The CentOS Project
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

function git_commitRepoChanges {

    local -a FILES
    local -a INFO
    local -a FILESNUM
    local COUNT=0
    local STATUSOUT=''
    local PREDICATE=''
    local CHNGTOTAL=0
    local LOCATION=$(cli_checkRepoDirSource "${1}")

    # Verify source location absolute path. It should point to
    # existent files or directories. They don't need to be under
    # version control.
    cli_checkFiles ${LOCATION} -e

    # Print action message.
    cli_printMessage "`gettext "Checking changes in the working copy"`" --as-banner-line

    # Build list of files that have received changes in its version
    # status.  Be sure to keep output files off from this list.
    # Remember, output files are not version inside the working copy,
    # so they are not considered for evaluation here. But take care,
    # sometimes output files are in the same format of source files,
    # so we need to differentiate them using their locations.
    STATUSOUT="$(${COMMAND} status --porcelain ${LOCATION})"

    # Process location based on its path information. Both
    # by-extension and by-location exclusions are no longer needed
    # here.  They are already set in the `.git/info/exclude' file.

    # Define path to files considered recent modifications from
    # working copy up to local repository.
    FILES[0]=$(echo "$STATUSOUT" | egrep "^[[:space:]]M")
    FILES[1]=$(echo "$STATUSOUT" | egrep "^\?\?")
    FILES[2]=$(echo "$STATUSOUT" | egrep "^[[:space:]]D")
    FILES[3]=$(echo "$STATUSOUT" | egrep "^[[:space:]]A")
    FILES[4]=$(echo "$STATUSOUT" | egrep "^(A|M|R|C)( |M|D)")

    # Define description of files considered recent modifications from
    # working copy up to local repository.
    INFO[0]="`gettext "Modified"`"
    INFO[1]="`gettext "Untracked"`"
    INFO[2]="`gettext "Deleted"`"
    INFO[3]="`gettext "Added"`"
    INFO[4]="`gettext "Staged"`"

    while [[ $COUNT -ne ${#FILES[*]} ]];do

        # Define total number of files. Avoid counting empty line.
        if [[ "${FILES[$COUNT]}" == '' ]];then
            FILESNUM[$COUNT]=0
        else
            FILESNUM[$COUNT]=$(echo "${FILES[$COUNT]}" | wc -l)
        fi

        # Calculate total amount of changes.
        CHNGTOTAL=$(($CHNGTOTAL + ${FILESNUM[$COUNT]}))

        # Build report predicate. Use report predicate to show any
        # information specific to the number of files found. For
        # example, you can use this section to show warning messages,
        # notes, and so on. By default we use the word `file' or
        # `files' at ngettext's consideration followed by change
        # direction.
        PREDICATE[$COUNT]=`ngettext "file in the working copy" \
            "files in the working copy" $((${FILESNUM[$COUNT]} + 1))`

        # Output report line.
        cli_printMessage "${INFO[$COUNT]}: ${FILESNUM[$COUNT]} ${PREDICATE[$COUNT]}" --as-stdout-line

        # Increase counter.
        COUNT=$(($COUNT + 1))

    done

    # Stage files
    cli_printMessage "`gettext "Do you want to stage files?"`" --as-yesornorequest-line
    ${COMMAND} add ${LOCATION}

    # See staged differences.
    cli_printMessage "`gettext "Do you want to see staged files differences?"`" --as-yesornorequest-line
    ${COMMAND} diff --staged ${LOCATION} | less

    # Commit staged files.
    cli_printMessage "`gettext "Do you want to commit staged files differences?"`" --as-yesornorequest-line
    ${COMMAND} commit ${LOCATION}

    # Push committed files.
    cli_printMessage "`gettext "Do you want to push committed files?"`" --as-yesornorequest-line
    ${COMMAND} push 

}
