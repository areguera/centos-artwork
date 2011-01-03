#!/bin/bash
#
# cli_commitRepoChanges.sh -- This function looks for revision changes
# inside absolute path passed as action value and ask you to commit
# them up to central repository. Use this function before or after
# whatever function that makes changes to files inside the working
# copy. It is better to commit small changes than long ones.
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
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
    local LOCALFILES=''
    local CHNGDIRECTION=''
    local CHNGTOTAL=0
    local LOCATIONS=''

    # Define location. If function arguments are provided to
    # cli_commitRepoChanges assume them as path location to work with.
    # Function arguments can contain more than one path enclosed by
    # quotation mark. In that case all paths are used as location to
    # work with.  If function arguments are not provided, the
    # ACTIONVAL variable default value is used instead.
    if [[ "$@" != '' ]];then
        LOCATIONS="$@"
    else
        LOCATIONS="$ACTIONVAL"
    fi

    # Verify locations. The location value may point to the working
    # copy in the workstation, or to a URL in the central repository.
    # The cli_commitRepoChanges function performs actions over working
    # copy files only. So, we need to exclude all URL from location
    # inside this function. Whatever action you perform over URL will
    # take place immediatly through direct commit.
    LOCATIONS=$(echo -e "$LOCATIONS" | sed -r "s! +!\n!g" \
        | egrep '^/home/centos/artwork/(trunk|branches|tags)/.+$')

    echo '----------------------------------------------------------------------'
    # Update working copy.
    cli_printMessage "`gettext "Bringing changes from the repository into the working copy"`" 'AsResponseLine'
    UPDATEOUT=$(svn update ${LOCATIONS})

    # Check working copy.
    cli_printMessage "`gettext "Checking changes in the working copy"`" 'AsResponseLine'
    STATUSOUT=$(svn status ${LOCATIONS})
    echo '----------------------------------------------------------------------'

    # Define path of files considered recent modifications from
    # central repository to working copy.
    FILES[0]=$(echo "$UPDATEOUT" | egrep "^A.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")
    FILES[1]=$(echo "$UPDATEOUT" | egrep "^D.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")
    FILES[2]=$(echo "$UPDATEOUT" | egrep "^U.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")
    FILES[3]=$(echo "$UPDATEOUT" | egrep "^C.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")
    FILES[4]=$(echo "$UPDATEOUT" | egrep "^G.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")

    # Define path fo files considered recent modifications from
    # working copy up to central repository.
    FILES[5]=$(echo "$STATUSOUT" | egrep "^M.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")
    FILES[6]=$(echo "$STATUSOUT" | egrep "^\?.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")
    FILES[7]=$(echo "$STATUSOUT" | egrep "^D.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")
    FILES[8]=$(echo "$STATUSOUT" | egrep "^A.+$(cli_getRepoTLDir "${LOCATIONS}").+$" | sed -r "s,^.+($(cli_getRepoTLDir "${LOCATIONS}").+)$,\1,")

    # Define description of files considered recent modifications from
    # central repository to working copy.
    INFO[0]="`gettext "Added"`"
    INFO[1]="`gettext "Deleted"`"
    INFO[2]="`gettext "Updated"`"
    INFO[3]="`gettext "Conflicted"`"
    INFO[4]="`gettext "Merged"`"

    # Define description of files considered recent modifications from
    # working copy up to central repository.
    INFO[5]="`gettext "Modified"`"
    INFO[6]="`gettext "Unversioned"`"
    INFO[7]=${INFO[1]}
    INFO[8]=${INFO[0]}

    while [[ $COUNT -ne ${#FILES[*]} ]];do

        # Get total number of files. Avoid counting empty line.
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
        if [[ ${FILESNUM[$COUNT]} -lt 1 ]];then
            PREDICATE[$COUNT]=`gettext "file"`
        else
            PREDICATE[$COUNT]=`ngettext "file" "files" ${FILESNUM[$COUNT]}`
        fi

        # Redefine report predicate to add direction of changes.
        if [[ $COUNT -le 4 ]]; then
            # Consider recent modifications from central repository
            # down to working copy.
            CHNGDIRECTION="`gettext "from the repository."`"
        elif [[ $COUNT -gt 4 ]];then
            # Consider recent modifications from working copy up to
            # central repository.
            CHNGDIRECTION="`gettext "from the working copy."`"
        fi

        # Redefine report predicate using change direction.
        PREDICATE[$COUNT]="${PREDICATE[$COUNT]} ${CHNGDIRECTION}"

        # Output report line.
        cli_printMessage "${INFO[$COUNT]}: ${FILESNUM[$COUNT]} ${PREDICATE[$COUNT]}" 'AsRegularLine'

        # Increase counter.
        COUNT=$(($COUNT + 1))

    done

    echo '----------------------------------------------------------------------'

    # Check total amount of changes. If there is no change, there is
    # nothing more to do here except to return flow control to this
    # function caller.
    if [[ $CHNGTOTAL -eq 0 ]];then
       return 0 
    fi

    # In case new unversioned files exist, ask user to add them into
    # the repository. This may happen when new documentation entries
    # are created.
    if [[ ${FILESNUM[6]} -gt 0 ]];then
        cli_printMessage "`ngettext "The following file is unversioned" \
            "The following files are unversioned" ${FILESNUM[6]}`:"
        for FILE in ${FILES[6]};do
            cli_printMessage $FILE 'AsResponseLine'
        done
        cli_printMessage "`ngettext "Do you want to add it now?" \
            "Do you want to add them now?" ${FILESNUM[6]}`" 'AsYesOrNoRequestLine'
        svn add ${FILES[6]} --quiet
    fi

    # Reset counter.
    COUNT=0

    # Unify local changes into a common variable so common actions can
    # be applied to them.
    while [[ $COUNT -ne ${#FILES[*]} ]];do
        LOCALFILES="$LOCALFILES ${FILES[$COUNT]}"
        COUNT=$(($COUNT + 1 ))
    done

    # Check list of changed files. If there are changes in the working
    # copy, ask the user to verify, and later, commit them up to
    # central repository.
    if [[ $LOCALFILES != '' ]];then

        # Verify changes.
        cli_printMessage "`gettext "Do you want to see changes now?"`" "AsYesOrNoRequestLine"
        svn diff $LOCALFILES | less

        # Commit changes.
        cli_printMessage "`gettext "Do you want to commit changes now?"`" "AsYesOrNoRequestLine"
        svn commit $LOCALFILES

    fi

}
