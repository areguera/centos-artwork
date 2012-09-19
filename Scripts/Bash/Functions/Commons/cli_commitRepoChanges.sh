#!/bin/bash
#
# cli_commitRepoChanges.sh -- This function is the interface we use
# inside centos-art.sh script to commit changes inside the repository.
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

function cli_commitRepoChanges {

    if [[ ! $FLAG_COMMIT_CHANGES == 'true' ]];then
        return
    fi
    
    local LOCATIONS="$@"

    cli_checkFiles -e ${LOCATIONS}

    ${CLI_NAME} svn --sync ${LOCATIONS}

}
