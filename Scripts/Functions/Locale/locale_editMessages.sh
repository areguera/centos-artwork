#!/bin/bash
#
# locale_editMessages.sh -- This function edits portable objects (.po)
# using default text editor.
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

function locale_editMessages {

    # Print separator line.
    cli_printMessage '-' 'AsSeparatorLine'

    # Initialize local variables.
    local FILES=''

    # Define list of locale files to process using action value as
    # reference.
    if [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Identity/(Models|Manual|Themes/Models)/.+$" ]];then
        FILES=$(cli_getFilesList "${WORKDIR}" ".*/messages\.po")
    elif [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Scripts$" ]];then
        FILES=$(cli_getFilesList "${WORKDIR}" ".*/${TEXTDOMAIN}\.po")
    else
        cli_printMessage "`gettext "The path provided doesn't support localization."`" 'AsErrorLine'
        cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
    fi

    # Go throguh files, one by one.
    for FILE in $FILES;do

        # Print the file we are editing.
        cli_printMessage "$FILE" 'AsUpdatingLine'

        # Use default text editor to edit file.
        eval ${EDITOR} ${FILE}

        # Update machine object (.mo) from portable object (.po).
        locale_updateMessageBinary ${FILE}

    done

}
