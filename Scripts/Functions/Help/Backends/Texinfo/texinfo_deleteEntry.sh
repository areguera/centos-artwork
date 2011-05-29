#!/bin/bash
#
# texinfo_deleteEntry.sh -- This function removes a documentation entry
# from documentation directory structure.
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

function texinfo_deleteEntry {

    local ENTRY=''
    local ENTRY_DIR=''
    local ENTRY_SUBDIR=''

    # Define list of entries to remove using the entry specified in
    # the command line.
    local ENTRIES=$(${FLAG_BACKEND}_getEntry "${ACTIONVALS[*]}")

    # Define path to directory where repository documentation entries
    # are stored in.  As reference, take the first non-option argument
    # passed to centos-art.sh script. Since all action values point to
    # directories inside the working copy, no matter what non-option
    # argument do we use as reference to determine the manual chapter
    # directory used to store documentation entries in.
    local MANUAL_CHAPTER_DIR=$(${FLAG_BACKEND}_getChapterDir "$ENTRIES")

    # Syncronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    cli_syncroRepoChanges ${MANUAL_CHAPTER_DIR}

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Define list of dependen entries. Dependent entries are stored
    # inside a directory with the same name of the entry being
    # removed.
    for ENTRY in $ENTRIES;do

        # Define directory where dependent documentation entries are
        # stored in.
        ENTRY_DIR=$(echo $ENTRY | sed -r "s/\.${FLAG_BACKEND}$//")

        if [[ -d $ENTRY_DIR ]];then

            # Add dependent documentation entries to the list of
            # documentation entries that will be deleted.
            ENTRIES="${ENTRIES} $(cli_getFilesList ${ENTRY_DIR} --pattern=".*\.${FLAG_BACKEND}")"

            for ENTRY in $ENTRIES;do

                # Define directory name for dependent documentation
                # entries which have their own dependent directories.
                ENTRY_SUBDIR=$(basename $ENTRY | sed -r "s/\.${FLAG_BACKEND}$//")

                # Add directory paths from dependent documentation
                # entries which have their own dependent directories
                # to the list of documentation entries that will be
                # deleted.
                ENTRIES="${ENTRIES} $(cli_getFilesList ${ENTRY_DIR} --pattern=".*/${ENTRY_SUBDIR}" --type='d')"

            done

        fi

    done

    # Sanitate list of documentation entries that will be removed.
    ENTRIES=$(echo ${ENTRIES} | tr ' ' "\n" | sort -r | uniq | tr "\n" ' ')
    
    # Print action preamble.
    cli_printActionPreamble $ENTRIES --to-delete

    # Remove documentation entry using Subversion's `delete' command
    # to know when the action took place.  Do not use regular `rm'
    # command here.
    svn del ${ENTRIES} --quiet

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
    for ENTRY in ${ENTRIES};do

        # Skip all directories, they are not documentation entries on
        # themselves. Use documentation entries only.
        if [[ ! $ENTRY =~ "\.${FLAG_BACKEND}$" ]];then
            continue
        fi

        # Update menu and node definitions from manual sections to
        # reflect the changes.
        ${FLAG_BACKEND}_updateMenu "remove-entry"
        ${FLAG_BACKEND}_updateNodes

        # Update cross reference definitions from manual to reflect
        # the changes.
        ${FLAG_BACKEND}_deleteCrossReferences

    done
 
    # Commit changes from working copy to central repository only.  At
    # this point, changes in the repository are not merged in the
    # working copy, but chages in the working copy do are committed up
    # to repository.
    cli_commitRepoChanges ${MANUAL_CHAPTER_DIR}

    # Rebuild output files to propagate recent changes.
    ${FLAG_BACKEND}_updateOutputFiles

}
