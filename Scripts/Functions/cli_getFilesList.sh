#!/bin/bash
#
# cli_getFilesList.sh -- This function defines the list of FILES to
# process.
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

function cli_getFilesList {

    local LOCATION=''
    local FILTER=''
    local FILES=''

    # If first argument is provided to cli_getFilesList, use it as
    # default location. Otherwise, if first argument is not provided,
    # location takes the action value (ACTIONVAL) as default.
    if [[ "$1" != '' ]];then
        LOCATION="$1"
    else
        LOCATION="$ACTIONVAL"
    fi

    # If second argument is provided to cli_getFilesList, use it as
    # default extension to look for files. Otherwise, if second
    # argument is not provided, use flag filter instead.
    if [[ "$2" != '' ]];then
        FILTER="$2"
    else
        FILTER="$FLAG_FILTER"
    fi

    # Define filter as regular expression pattern. When we use regular
    # expressions with find, regular expressions are evaluated against
    # the whole file path.  This way, when the regular expression is
    # specified, we need to build it in a way that matches the whole
    # path. Doing so, everytime we pass the `--filter' option in the
    # command-line could be a tedious task. Instead, in the sake of
    # reducing some typing, we prepare the regular expression here to
    # match the whole path using the regular expression provided by
    # the user as pattern. Do not use LOCATION variable as part of
    # regular expresion so it could be possible to use path expansion.
    # Using path expansion reduce the amount of places to find out
    # things and so the time required to finish the task.
    FILTER="^.+/${FILTER}$"

    # Define list of files to process. At this point we cannot verify
    # whether the LOCATION is a directory or a file since path
    # expansion coul be introduced to it. The best we can do is
    # verifying exit status and go on.
    FILES=$(find ${LOCATION} -regextype posix-egrep -regex "${FILTER}" | sort | uniq)

    # Output list of files to process.
    if [[ $? -eq 0 ]];then
        echo "$FILES"
    fi

}
