#!/bin/bash
#
# cli_commitRepoChanges.sh -- This function realizes a subversion
# commit command agains the workgin copy in order to send local
# changes up to central repository.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function cli_commitRepoChanges {

    # Verify `--dont-commit-changes' option.
    if [[ $FLAG_DONT_COMMIT_CHANGES == 'true' ]];then
        return
    fi

    local -a FILES
    local -a INFO
    local -a FILESNUM
    local COUNT=0
    local STATUSOUT=''
    local PREDICATE=''
    local CHNGTOTAL=0
    local LOCATIONS=''
    local LOCATION=''

    # Define source location the subversion status action will take
    # place on. If arguments are provided use them as srouce location.
    # Otherwise use action value as default source location.
    if [[ "$@" != '' ]];then
        LOCATIONS="$@"
    else
        LOCATIONS="$ACTIONVAL"
    fi

    # Print action message.
    cli_printMessage "`gettext "Checking changes in the working copy"`" --as-banner-line

    # Build list of files that have received changes in its versioned
    # status.  Be sure to keep output files off from this list.
    # Remember, output files are not versioned inside the working
    # copy, so they are not considered for evaluation here. But take
    # care, sometimes output files are in the same format of source
    # files, so we need to differentiate them using their locations.
    for LOCATION in $LOCATIONS;do

        if [[ $LOCATION =~ 'trunk/Manuals' ]];then
            STATUSOUT="$(svn status ${LOCATION} | egrep -v '(pdf|txt|xhtml)$')\n$STATUSOUT"
        elif [[ $LOCATION =~ 'trunk/Identity' ]];then
            STATUSOUT="$(svn status ${LOCATION} | egrep -v '(pdf|png|jpg|rc|xpm|xbm|tif|ppm|pnm|gz|lss|log|)$')\n$STATUSOUT"
        elif [[ $LOCATION =~ 'branches/Manuals/Texinfo' ]];then
            STATUSOUT="$(svn status ${LOCATION} | egrep -v '(pdf|txt|xhtml|xml|docbook|bz2)$')\n$STATUSOUT"
        else
            STATUSOUT="$(svn status ${LOCATION})\n$STATUSOUT"
        fi

    done

    # Sanitate status output. Expand new lines, remove leading spaces
    # and empty lines.
    STATUSOUT=$(echo -e "$STATUSOUT" | sed -r 's!^[[:space:]]*!!' | egrep -v '^[[:space:]]*$')

    # Define path fo files considered recent modifications from
    # working copy up to central repository.
    FILES[0]=$(echo "$STATUSOUT" | egrep "^M.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")
    FILES[1]=$(echo "$STATUSOUT" | egrep "^\?.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")
    FILES[2]=$(echo "$STATUSOUT" | egrep "^D.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")
    FILES[3]=$(echo "$STATUSOUT" | egrep "^A.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")

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
        cli_printMessage "${INFO[$COUNT]}: ${FILESNUM[$COUNT]} ${PREDICATE[$COUNT]}"

        # Increase counter.
        COUNT=$(($COUNT + 1))

    done

    # Check total amount of changes and, if any, check differences and
    # commit them up to central repository.
    if [[ $CHNGTOTAL -gt 0 ]];then

        # Outout separator line.
        cli_printMessage '-' --as-separator-line

        # In the very specific case unversioned files, we need to add
        # them to the repository first, in order to make them
        # available for subversion commands (e.g., `copy') Otherwise,
        # if no unversioned file is found, go ahead with change
        # differences and committing. Notice that if there is mix of
        # changes (e.g., aditions and modifications), addition take
        # preference and no other change is considered.  In order
        # for other changes to be considered, be sure no adition is
        # present, or that they have already happened.
        if [[ ${FILESNUM[1]} -gt 0 ]];then

            cli_printMessage "`ngettext "The following file is unversioned" \
                "The following files are unversioned" ${FILESNUM[1]}`:"
            for FILE in ${FILES[1]};do
                cli_printMessage "$FILE" --as-response-line
            done
            cli_printMessage "`ngettext "Do you want to add it now?" \
                "Do you want to add them now?" ${FILESNUM[1]}`" --as-yesornorequest-line
            svn add ${FILES[1]} --quiet

        else

            # Verify changes on locations.
            cli_printMessage "`gettext "Do you want to see changes now?"`" --as-yesornorequest-line
            svn diff $LOCATIONS | less

            # Commit changes on locations.
            cli_printMessage "`gettext "Do you want to commit changes now?"`" --as-yesornorequest-line
            svn commit $LOCATIONS

        fi

    fi

}
