#!/bin/bash
#
# path_doDelete.sh -- This function deletes files inside the working
# copy using subversion commands.
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

function path_doDelete {

    local -a SRC
    local -a DOC
    local COUNT=0

    # Verify target variable. We can't continue if target is empty.
    if [[ $ACTIONVAL == '' ]];then
        cli_printMessage "`gettext "There is no source to work with."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Update texinfo related entry documentation.
    . /home/centos/bin/centos-art manual --delete="$ACTIONVAL"

    # Define source locations. Start with parent directory at position
    # zero and continue with related parallel directories.
    SRC[0]=$ACTIONVAL
    SRC[1]=$(cli_getRepoDirParallel "${SRC[0]}" "$(cli_getRepoTLDir "${SRC[0]}")/Scripts/Bash/Functions/Render/Config")
    SRC[2]=$(cli_getRepoDirParallel "${SRC[0]}" "$(cli_getRepoTLDir "${SRC[0]}")/Translations")

    # Print preamble with affected entries.
    cli_printMessage "`ngettext "The following entry will be deleted" \
        "The following entries will be deleted" "${#SRC[*]}"`:"
    while [[ $COUNT -lt ${#SRC[*]} ]];do
        # Print affected entry.
        cli_printMessage "${SRC[$COUNT]}" 'AsResponseLine'
        # Increment counter.
        COUNT=$(($COUNT + 1))
    done

    # Request confirmation before continue with action.
    cli_printMessage "`gettext "Do you want to continue"`" 'AsYesOrNoRequestLine'

    # Reset counter.
    COUNT=0

    while [[ $COUNT -lt ${#SRC[*]} ]];do

        # Print action message.
        cli_printMessage "${SRC[$COUNT]}" 'AsDeletingLine'

        # Perform action.
        svn del ${SRC[$COUNT]} --quiet

        # Increase counter.
        COUNT=$(($COUNT + 1))

    done 

    # Syncronize changes between working copy and central repository.
    cli_commitRepoChanges "${SRC[@]}"

}
