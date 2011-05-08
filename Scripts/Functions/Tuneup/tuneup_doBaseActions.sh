#!/bin/bash
#
# tuneup_doBaseActions.sh -- This function builds the list of files to
# process and performs maintainance tasks, file by file.
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

function tuneup_doBaseActions {

    local FILE=''
    local FILES=''
    local EXTENSION=''

    # Define file extensions we'll look files for. This is, the
    # extension of files we want to perform maintainance tasks for.
    EXTENSION='(svg|xhtml|sh)'

    # Build list of files to process using action value as reference.
    FILES=$(cli_getFilesList ${ACTIONVAL} --pattern="${FLAG_FILTER}.*\.${EXTENSION}")

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Process list of files and perform maintainance tasks
    # accordingly.
    for FILE in $FILES;do

        # Print action message.
        cli_printMessage "$FILE" --as-tuningup-line

        # Define what to do based on file extension.
        if [[ $FILE =~ '\.svg$' ]];then
            ${FUNCNAM}_doSvg
        elif [[ $FILE =~ '\.xhtml$' ]];then
            ${FUNCNAM}_doXhtml
        elif [[ $FILE =~ '\.sh$' ]];then
            ${FUNCNAM}_doShell
        fi

    done

}
