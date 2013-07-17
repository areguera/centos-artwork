#!/bin/bash
######################################################################
#
#   tcar_synchronizeRepoChanges.sh -- This function standardizes the
#   way changes are synchronized between the working copy and the
#   central repository. This function is an interface to the Svn
#   functionality of the centos-art.sh script.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#     Key fingerprint = D67D 0F82 4CBD 90BC 6421  DF28 7CCE 757C 17CA 3951
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
######################################################################

function tcar_synchronizeRepoChanges {

    # Verify synchronization flag.
    if [[ ${FLAG_SYNCHRONIZE} != 'true' ]];then
        return
    fi
    
    # Verify existence of locations passed to this function.
    tcar_checkFiles -e ${@}

    # Synchronize changes.
    tcar_runFnEnvironment vcs --synchronize ${@}

}
