#!/bin/bash
#
# path_doDelete.sh -- This function deletes files inside the working
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

function path_doDelete {

    # Verify target directory.
    cli_checkRepoDirTarget

    # Print action preamble.
    cli_printActionPreamble "$ACTIONVAL" 'doDelete' 'AsResponseLine'

    # Syncronize parallel directories related to action value.
    . /home/centos/bin/centos-art manual --delete="$ACTIONVAL"
    . /home/centos/bin/centos-art render --delete="$ACTIONVAL"
    . /home/centos/bin/centos-art locale --delete="$ACTIONVAL"

    # Print action message.
    cli_printMessage "${ACTIONVAL}" 'AsDeletingLine'

    # Perform action.
    svn del ${ACTIONVAL} --quiet

    # Syncronize changes between working copy and central repository.
    cli_commitRepoChanges "$ACTIONVAL $(cli_getRepoParallelDirs "$ACTIONVAL")"

}
