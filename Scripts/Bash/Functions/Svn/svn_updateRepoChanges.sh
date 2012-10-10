#!/bin/bash
#
# svn_updateRepoChanges.sh -- This function realizes a subversion
# update command against the working copy in order to bring changes
# from the central repository into the working copy.
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

function svn_updateRepoChanges {

    local -a FILES
    local -a INFO
    local -a FILESNUM
    local COUNT=0
    local UPDATEOUT=''
    local PREDICATE=''
    local CHNGTOTAL=0
    local LOCATION=$(cli_checkRepoDirSource "$1")

    # Update working copy and retrive update output.
    cli_printMessage "`gettext "Bringing changes from the repository into the working copy"`" --as-banner-line
    UPDATEOUT=$(${SVN} update ${LOCATION} --quiet)

    # Define path of files considered recent modifications from
    # central repository to working copy.
    FILES[0]=$(echo "$UPDATEOUT" | egrep "^A" | sed -r "s,^.+${TCAR_WORKDIR},,")
    FILES[1]=$(echo "$UPDATEOUT" | egrep "^D" | sed -r "s,^.+${TCAR_WORKDIR},,")
    FILES[2]=$(echo "$UPDATEOUT" | egrep "^U" | sed -r "s,^.+${TCAR_WORKDIR},,")
    FILES[3]=$(echo "$UPDATEOUT" | egrep "^C" | sed -r "s,^.+${TCAR_WORKDIR},,")
    FILES[4]=$(echo "$UPDATEOUT" | egrep "^G" | sed -r "s,^.+${TCAR_WORKDIR},,")

    # Define description of files considered recent modifications from
    # central repository to working copy.
    INFO[0]="`gettext "Added"`"
    INFO[1]="`gettext "Deleted"`"
    INFO[2]="`gettext "Updated"`"
    INFO[3]="`gettext "Conflicted"`"
    INFO[4]="`gettext "Merged"`"

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
        PREDICATE[$COUNT]=`ngettext "file from the repository" \
            "files from the repository" $((${FILESNUM[$COUNT]} + 1))`

        # Output report line.
        cli_printMessage "${INFO[$COUNT]}: ${FILESNUM[$COUNT]} ${PREDICATE[$COUNT]}" --as-stdout-line

        # Increase counter.
        COUNT=$(($COUNT + 1))

    done

}
