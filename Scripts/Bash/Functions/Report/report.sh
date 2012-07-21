#!/bin/bash
#
# report.sh -- This functionality performs system reports.
#
# Copyright (C) 2012 Alain Reguera Delgado
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

function report {

    local ACTIONNAM=''
    local ACTIONNAMS=''

    # Define list of available sub-functionalities.
    local CLI_SUBFUNC=''
    local CLI_SUBFUNCS=$(cli_getFilesList --maxdepth 1 --mindepth 1 \
        --type d --pattern="^[[:alnum:]/]+$" ${CLI_FUNCDIR}/${CLI_FUNCDIRNAM})

    # Show available sub-functionalities in order to choose one.
    select CLI_SUBFUNC in $(basename $CLI_SUBFUNCS);do
        break
    done 

    # Verify that no empty value be passed as sub-functionality.
    if [[ $CLI_SUBFUNC == '' ]];then
        exit
    fi

    # Make sub-functionality all lower-case. This is required in order
    # to build names correctly when exporting related function files.
    CLI_SUBFUNC=$(cli_getRepoName $CLI_SUBFUNC -f)

    # Initialize specific functionalities. At this point we load all
    # functionalities required into the application's execution
    # environment and make them available, this way, to perform
    # report-specific tasks.
    cli_exportFunctions "${CLI_FUNCDIR}/${CLI_FUNCDIRNAM}/$(cli_getRepoName \
       ${CLI_SUBFUNC} -d)" "${CLI_SUBFUNC}"

    # Execute specific functionality.
    ${CLI_SUBFUNC}

}
