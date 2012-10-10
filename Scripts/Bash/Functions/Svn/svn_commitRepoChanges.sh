#!/bin/bash
#
# svn_commitRepoChanges.sh -- This function explores the working copy
# and commits changes up to central repository after checking changes
# and adding unversioned files.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function svn_commitRepoChanges {

    local -a FILES
    local -a INFO
    local -a FILESNUM
    local COUNT=0
    local STATUSOUT=''
    local PREDICATE=''
    local CHNGTOTAL=0
    local LOCATION=$(cli_checkRepoDirSource "$1")

    # Print action message.
    cli_printMessage "`gettext "Checking changes in the working copy"`" --as-banner-line

    # Build list of files that have received changes in its versioned
    # status.  Be sure to keep output files off from this list.
    # Remember, output files are not versioned inside the working
    # copy, so they are not considered for evaluation here. But take
    # care, sometimes output files are in the same format of source
    # files, so we need to differentiate them using their locations.

    # Process location based on its path information.
    if [[ ${LOCATION} =~ 'trunk/Documentation/Manuals/Texinfo)' ]];then
        STATUSOUT="$(${SVN} status ${LOCATION} | egrep -v '(pdf|txt|xhtml|xml|docbook|bz2)$')\n$STATUSOUT"
    elif [[ $LOCATION =~ 'trunk/Documentation/Manuals/Docbook' ]];then
        STATUSOUT="$(${SVN} status ${LOCATION} | egrep -v '(pdf|txt|xhtml)$')\n$STATUSOUT"
    elif [[ $LOCATION =~ 'trunk/Identity' ]];then
        STATUSOUT="$(${SVN} status ${LOCATION} | egrep -v '(pdf|png|jpg|rc|xpm|xbm|tif|ppm|pnm|gz|lss|log)$')\n$STATUSOUT"
    else
        STATUSOUT="$(${SVN} status ${LOCATION})\n$STATUSOUT"
    fi

    # Sanitate status output. Expand new lines, remove leading spaces
    # and empty lines.
    STATUSOUT=$(echo -e "$STATUSOUT" | sed -r 's!^[[:space:]]*!!' | egrep -v '^[[:space:]]*$')

    # Define path to files considered recent modifications from
    # working copy up to central repository.
    FILES[0]=$(echo "$STATUSOUT" | egrep "^M"  | sed -r "s,^.+${TCAR_WORKDIR}/,,")
    FILES[1]=$(echo "$STATUSOUT" | egrep "^\?" | sed -r "s,^.+${TCAR_WORKDIR}/,,")
    FILES[2]=$(echo "$STATUSOUT" | egrep "^D"  | sed -r "s,^.+${TCAR_WORKDIR}/,,")
    FILES[3]=$(echo "$STATUSOUT" | egrep "^A"  | sed -r "s,^.+${TCAR_WORKDIR}/,,")

    # Define description of files considered recent modifications from
    # working copy up to central repository.
    INFO[0]="`gettext "Modified"`"
    INFO[1]="`gettext "Unversioned"`"
    INFO[2]="`gettext "Deleted"`"
    INFO[3]="`gettext "Added"`"

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

    # When files have changed in the target location, show which these
    # files are and request user to see such changes and then, for
    # commtting them up to the central repository.
    if [[ ${FILESNUM[0]} -gt 0 ]];then

        cli_printMessage "`gettext "Do you want to see changes now?"`" --as-yesornorequest-line
        ${SVN} diff ${LOCATION} | less

        # Commit changes up to central repository.
        cli_printMessage "`gettext "Do you want to commit changes now?"`" --as-yesornorequest-line
        ${SVN} commit ${LOCATION}

    fi

    # When there are unversioned files in the target location, show
    # which these files are and request user to add such files into
    # the working copy.
    if [[ ${FILESNUM[1]} -gt 0 ]];then

        cli_printMessage '-' --as-separator-line
        cli_printMessage "`gettext "Do you want to add unversioned files now?"`" --as-yesornorequest-line
        for FILE in ${FILES[1]};do
            ${SVN} add "${TCAR_WORKDIR}/$FILE"
        done

        # Commit changes up to central repository.
        cli_printMessage "`gettext "Do you want to commit changes now?"`" --as-yesornorequest-line
        ${SVN} commit ${LOCATION}

    fi

    # When there are added files in the target location, show which
    # these files are and request user to commit them up to central
    # repository.
    if [[ ${FILESNUM[3]} -gt 0 ]];then
        cli_printMessage '-' --as-separator-line
        cli_printMessage "`gettext "Do you want to commit changes now?"`" --as-yesornorequest-line
        ${SVN} commit ${LOCATION}
    fi

}
