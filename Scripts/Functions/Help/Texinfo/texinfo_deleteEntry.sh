#!/bin/bash
#
# texinfo_deleteEntry.sh -- This function removes a documentation entry
# from documentation directory structure.
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

function texinfo_deleteEntry {

    local MANUAL_ENTRY=''
    local MANUAL_ENTRY_DIR=''
    local MANUAL_ENTRY_SUBDIR=''

    # Define list of entries to remove using the entry specified in
    # the command line.
    local MANUAL_ENTRIES=$(${FLAG_BACKEND}_getEntry "$@")

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Define list of dependen entries. Dependent entries are stored
    # inside a directory with the same name of the entry being
    # removed.
    for MANUAL_ENTRY in $MANUAL_ENTRIES;do

        # Define directory where dependent documentation entries are
        # stored in.
        MANUAL_ENTRY_DIR=$(echo $MANUAL_ENTRY \
            | sed -r "s/\.${MANUAL_EXTENSION}$//")

        if [[ -d $MANUAL_ENTRY_DIR ]];then

            # Add dependent documentation entries to the list of
            # documentation entries that will be deleted.
            MANUAL_ENTRIES="${MANUAL_ENTRIES} $(cli_getFilesList ${MANUAL_ENTRY_DIR} \
                --pattern=".*\.${MANUAL_EXTENSION}")"

            for MANUAL_ENTRY in $MANUAL_ENTRIES;do

                # Define directory name for dependent documentation
                # entries which have their own dependent directories.
                MANUAL_ENTRY_SUBDIR=$(basename $MANUAL_ENTRY \
                    | sed -r "s/\.${MANUAL_EXTENSION}$//")

                # Add directory paths from dependent documentation
                # entries which have their own dependent directories
                # to the list of documentation entries that will be
                # deleted.
                MANUAL_ENTRIES="${MANUAL_ENTRIES} $(cli_getFilesList \
                    ${MANUAL_ENTRY_DIR} \
                    --pattern=".*/${MANUAL_ENTRY_SUBDIR}" \
                    --type='d')"

            done

        fi

    done

    # Sanitate list of documentation entries that will be removed.
    MANUAL_ENTRIES=$(echo ${MANUAL_ENTRIES} | tr ' ' "\n" | sort -r | uniq | tr "\n" ' ')

    # Verify existence of entries before deleting them. We cannot
    # delete an entry which doesn't exist. Assuming that an entry
    # doesn't exist, end script execution with an error message.
    cli_checkFiles "$MANUAL_ENTRIES"
    
    # Remove documentation entry using Subversion's `delete' command
    # to know when the action took place.  Do not use regular `rm'
    # command here.
    for MANUAL_ENTRY in $MANUAL_ENTRIES;do
        cli_printMessage "$MANUAL_ENTRY" --as-deleting-line
        svn del ${MANUAL_ENTRY} --quiet
    done

    # Verify exit status from subversion command to be sure everything
    # went well. Otherwise stop script execution with an error
    # message.
    if [[ $? -ne 0 ]];then
        cli_printMessage "`gettext "An error occurred when deleting entries."`" --as-toknowmore-line
    fi

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Print action message.
    cli_printMessage "`gettext "Updating menus, nodes and cross-references."`" --as-response-line

    # Process list of entries in order to update menus, nodes and
    # cross references. Since we are verifying entry status before
    # remove the we cannot update the information in the same loop we
    # remove files. This would modify some file before be removed and
    # that would stop script execution. Similary, if we do update
    # menus, nodes and cross references before removing files it would
    # be needed to remove farther status verification in order for the
    # script to continue its execution. Thereby, I can't see a
    # different way but removing files first using status verification
    # and later go through entries list again to update menus, nodes
    # and cross references in remaining files.
    for MANUAL_ENTRY in ${MANUAL_ENTRIES};do

        # Skip all directories, they are not documentation entries on
        # themselves. Use documentation entries only.
        if [[ ! $MANUAL_ENTRY =~ "\.${MANUAL_EXTENSION}$" ]];then
            continue
        fi

        # Update menu and node definitions from manual sections to
        # reflect the changes.
        ${FLAG_BACKEND}_updateMenu "remove-entry"
        ${FLAG_BACKEND}_updateNodes

        # Update cross reference definitions from manual to reflect
        # the changes.
        ${FLAG_BACKEND}_deleteCrossReferences $MANUAL_ENTRY

    done
 
}
