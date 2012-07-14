#!/bin/bash
#
# cli_terminateScriptExecution.sh -- This function standardizes the
# actions that must be realized just before leaving the script
# execution (e.g., cleaning temporal files).  This function is the one
# called when interruption signals like EXIT, SIGHUP, SIGINT and
# SIGTERM are detected.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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

function cli_terminateScriptExecution {

    # Build list of temporal files related to this script execution.
    # Remember that inside `/tmp' directory there are files and
    # directories you might have no access to (due permission
    # restrictions), so command cli_getFilesList to look for files in
    # the first level of files that you are owner of.  Otherwise,
    # undesired `permission denied' messages might be output.
    local FILES=$(cli_getFilesList ${CLI_TEMPDIR} \
        --pattern="${CLI_NAME}-${CLI_PPID}-.+" \
        --maxdepth="1" --uid="$(id -u)")

    # Remove list of temporal files related to this script execution,
    # if any of course. Remember that some of the temporal files can
    # be directories, too.
    if [[ $FILES != '' ]];then
        rm -rf $FILES
    fi

    # Terminate script correctly.
    exit 0

}
