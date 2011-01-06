#!/bin/bash
#
# cli_getFilesList.sh -- This function defines the list of FILES to
# process.
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

function cli_getFilesList {

    local LOCATION=''

    # If first argument is provided to cli_getFilesList, use it as
    # default location. Otherwise, if first argument is not provided,
    # location takes the action value (ACTIONVAL) as default.
    if [[ "$1" != '' ]];then
        LOCATION="$1"
    else
        LOCATION="$ACTIONVAL"
    fi

    # Define regular expression (FLAG_FILTER) local variable, using regular
    # expression (FLAG_FILTER) global variable, to reduce the amount of
    # characters we type in order to match find's output. When using
    # regular expression with find, in order to reduce the amount
    # files found, the regular expression is evaluated against the
    # whole file path. This way, when the regular expression is
    # specified, we need to build it in a way that matches the whole
    # path. Doing so each time we pass a `--filter' command-line
    # argument may be a tedious task, so, in the sake of reducing some
    # typing, we prepare the regular expression here to match the
    # whole path using the regular expression provided by the user as
    # pattern.
    local FLAG_FILTER="^${LOCATION}/${FLAG_FILTER}$"

    # Define list of files to process.
    if [[ -d $LOCATION ]];then
        FILES=$(find $LOCATION -regextype posix-egrep -type f -regex "${FLAG_FILTER}" | sort)
    elif [[ -f $LOCATION ]];then
        FILES=$LOCATION
    fi

    # Check list of files to process. If we have an empty list of
    # files, inform about it and stop script execution.
    if [[ $FILES == '' ]];then
        cli_printMessage "`gettext "There is no file to process."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

}
