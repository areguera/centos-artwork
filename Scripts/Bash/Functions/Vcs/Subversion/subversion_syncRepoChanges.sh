#!/bin/bash
#
# subversion_syncRepoChanges.sh -- This function synchronizes both
# central repository and working copy directory structures by
# performing a subversion update command first and a subversion commit
# command later.
#
# Copyright (C) 2009-2013 The CentOS Project
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

function subversion_syncRepoChanges {

    local LOCATION=''
    local LOCATIONS="${@}"

    for LOCATION in $LOCATIONS;do

        # Verify whether the location is valid or not.
        LOCATION=$(cli_checkRepoDirSource ${LOCATION})

        # Verify source location absolute path. It should point either
        # to existent files or directories both under version control
        # inside the working copy.  Otherwise, if it doesn't point to
        # an existent file under version control, finish the script
        # execution with an error message.
        cli_checkFiles ${LOCATION} -e --is-versioned

        # Bring changes from the repository into the working copy.
        subversion_updateRepoChanges ${LOCATION}

        # Check changes in the working copy.
        subversion_commitRepoChanges ${LOCATION}

    done

}
