#!/bin/bash
#
# cli_commitRepoChanges.sh -- This function looks for revision changes
# inside absolute path passed as option value and ask you to commit
# them up to central repository. Use this function at the end of
# whatever function that makes changes to the working copy files. It
# is better to commit small changes than long ones.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function cli_commitRepoChanges {

    local -a FILES
    local -a INFO
    local -a FILESNUM
    local COUNT=0
    local UPDATEOUT=''
    local PREDICATE=''

    # Update working copy.
    echo '----------------------------------------------------------------------'
    cli_printMessage "`gettext "Bringing changes from the repository into the working copy"`"
    UPDATEOUT=$(svn update ${OPTIONVAL})
    echo '----------------------------------------------------------------------'

    # Define path of files considered recent modifications from
    # central repository to working copy.
    FILES[0]=$(echo "$UPDATEOUT" | egrep '^A' | cut -d' ' -f7)
    FILES[1]=$(echo "$UPDATEOUT" | egrep '^D' | cut -d' ' -f7)
    FILES[2]=$(echo "$UPDATEOUT" | egrep '^U' | cut -d' ' -f7)
    FILES[3]=$(echo "$UPDATEOUT" | egrep '^C' | cut -d' ' -f7)
    FILES[4]=$(echo "$UPDATEOUT" | egrep '^G' | cut -d' ' -f7)
    FILES[5]=$(svn status "$OPTIONVAL" | egrep '^M' | cut -d' ' -f7)

    # Define description of files considered recent modifications from
    # central repository to working copy.
    INFO[0]="`gettext "Added"`"
    INFO[1]="`gettext "Deleted"`"
    INFO[2]="`gettext "Updated"`"
    INFO[3]="`gettext "Conflicted"`"
    INFO[4]="`gettext "Merged"`"
    INFO[5]="`gettext "Modified"`"

    while [[ $COUNT -ne ${#FILES[*]} ]];do

        # Get total number of files. Avoid counting empty line.
        if [[ ${FILES[$COUNT]} == '' ]];then
            FILESNUM[$COUNT]=0
        else
            FILESNUM[$COUNT]=$(echo "${FILES[$COUNT]}" | wc -l)
        fi

        # Build report predicate. Use report predicate to show any
        # information specific to the number of files found. For
        # example, you can use this section to show warning messages,
        # notes, and so on. By default we just output the word `file'
        # or `files' at ngettext's consideration.
        if [[ ${FILESNUM[$COUNT]} -lt 1 ]];then
            PREDICATE[$COUNT]=''
        else
            PREDICATE[$COUNT]=`ngettext "file" "files" ${FILESNUM[$COUNT]}`
        fi

        # Output report line.
        cli_printMessage "${INFO[$COUNT]}: ${FILESNUM[$COUNT]} ${PREDICATE[$COUNT]}" 'AsRegularLine'

        # Increase counter.
        COUNT=$(($COUNT + 1))

    done

    echo '----------------------------------------------------------------------'

    # Check list of changed files. If there are changes in the working
    # copy, ask the user to verify, and later, commit them up to
    # central repository.
    if [[ ${FILESNUM[5]} -gt 0 ]];then

        # Verify changes.
        cli_printMessage "`gettext "Do you want to see changes now?"`" "AsYesOrNoRequestLine"
        svn diff ${FILES[5]} | less

        # Commit changes.
        cli_printMessage "`gettext "Do you want commit changes now?"`" "AsYesOrNoRequestLine"
        svn commit ${FILES[5]}

    fi

}
