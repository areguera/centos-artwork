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

    # Verify the location is a working copy. Whe it is not a working
    # copy don't do any subversion stuff in it.
    if [[ $(svn_isVersioned) != 0 ]];then
        return
    fi

    # Bring changes from the repository into the working copy.
    svn_updateRepoChanges

    # Check changes in the working copy.
    svn_commitRepoChanges

}
