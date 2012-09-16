#!/bin/bash
#
# svn_syncroRepoChanges.sh -- This function syncronizes both central
# repository and working copy performing a subversion update command
# first and a subversion commit command later.
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

function svn_syncroRepoChanges {

    # Verify don't commit changes flag.
    if [[ $FLAG_DONT_COMMIT_CHANGES != 'false' ]];then
        return
    fi

    # Define source location the subversion update action will take
    # place on. If arguments are provided use them as srouce location.
    # Otherwise use action value as default source location.
    if [[ "$@" != '' ]];then
        LOCATIONS="$@"
    else
        LOCATIONS="$ACTIONVAL"
    fi

    # Bring changes from the repository into the working copy.
    cli_exportFunctions "Svn/svn_updateRepoChanges"
    svn_updateRepoChanges "$LOCATIONS"

    # Check changes in the working copy.
    cli_exportFunctions "Svn/svn_commitRepoChanges"
    svn_commitRepoChanges "$LOCATIONS"

}
