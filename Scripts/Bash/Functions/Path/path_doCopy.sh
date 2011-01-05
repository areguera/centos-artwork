#!/bin/bash
#
# path_doCopy.sh -- This function duplicates files inside the working
# copy using subversion commands.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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

function path_doCopy {

    # Verify target variable. We can't continue if target is empty.
    if [[ $FLAG_TO == '' ]];then
        cli_printMessage "`gettext "There is no target to work with."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Print action preamble.
    cli_printActionPreamble "${FLAG_TO}" 'doCreate' 'AsResponseLine'
    
    # Verify relation between source and target locations. We cannot
    # duplicate an entry if its parent directory doesn't exist as
    # entry inside the working copy.
    if [[ -f ${ACTIONVAL} ]];then
        if [[ ! -d $(dirname ${FLAG_TO}) ]];then
           mkdir -p $(dirname ${FLAG_TO})
        fi
        svn add $(dirname ${FLAG_TO}) --quiet
    fi

    # Print action message.
    cli_printMessage "${FLAG_TO}" 'AsCreatingLine'

    # Copy parent directory.
    svn copy ${ACTIONVAL} ${FLAG_TO} --quiet

    # Verify syncronization flag.
    if [[ $FLAG_SYNC == 'true' ]];then

        # Copy parallel directories.
        . /home/centos/bin/centos-art manual --copy="$ACTIONVAL" --to="$FLAG_TO"
        . /home/centos/bin/centos-art render --copy="$ACTIONVAL" --to="$FLAG_TO"
        . /home/centos/bin/centos-art locale --copy="$ACTIONVAL" --to="$FLAG_TO"

        # Syncronize changes from working copy to central repository.
        cli_commitRepoChanges "$ACTIONVAL $FLAG_TO $(cli_getRepoParallelDirs "$FLAG_TO")"

    else

        # Syncronize changes from working copy to central repository.
        cli_commitRepoChanges "$ACTIONVAL $FLAG_TO"

    fi

}
