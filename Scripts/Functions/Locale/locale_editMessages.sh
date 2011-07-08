#!/bin/bash
#
# locale_editMessages.sh -- This function edits portable objects (.po)
# using default text editor.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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
    cli_printMessage '-' --as-separator-line

    # Prepare localization working directory to receive translation
    # files.
    if [[ ! -d ${WORKDIR} ]];then

        # Print separator line.
        cli_printMessage "-" --as-separator-line

        # Output action message.
        cli_printMessage "${WORKDIR}" --as-creating-line

        # Create localization working directory making parent
        # directories as needed. Subversion doesn't create directories
        # recursively, so we use the system's `mkdir' command and then
        # subversion to register the changes.
        mkdir -p ${WORKDIR}

        # Commit changes from working copy to central repository only.
        # At this point, changes in the repository are not merged in
        # the working copy, but chages in the working copy do are
        # committed up to repository.
        cli_commitRepoChanges "${L10N_BASEDIR}"

    fi

    local FILES=''

    if [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/(Manuals|Identity/Models)/.*$" ]];then

        # Define list of locale files for XML-based files.
        FILES=$(cli_getFilesList ${WORKDIR} --pattern=".*/messages\.po")

        # Do not create machine objects for XML-based files.
        FLAG_DONT_CREATE_MO='true'

    elif [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Scripts$" ]];then

        # Define list of locale files for shell script files.
        FILES=$(cli_getFilesList ${WORKDIR} --pattern=".*/${TEXTDOMAIN}\.po")

    else

        cli_printMessage "`gettext "The path provided does not support localization."`" --as-error-line

    fi

    for FILE in $FILES;do

        # Print the file we are editing.
        cli_printMessage "$FILE" --as-updating-line

        # Use default text editor to edit file.
        eval ${EDITOR} ${FILE}

        # Update machine object (.mo) from portable object (.po).
        ${FUNCNAM}_updateMessageBinary ${FILE}

    done

}
