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

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    local ENTRY_SRC=${ENTRY}
    local ENTRIES=''
    local ENTRY=''
    local ENTRY_DEP=''

    # Initiate list of entries to remove using the entry specified in
    # the command line.
    ENTRIES=${ENTRY_SRC}

    # Verify existence of dependent entries.  Dependent entries are
    # stored inside a directory with the same name of the entry you
    # are trying to remove.
    if [[ -d ${ENTRY_DIR}/${ENTRY_FILE} ]];then

        # Add dependent files to list of entries. 
        ENTRIES="${ENTRIES} $(cli_getFilesList ${ENTRY_DIR}/${ENTRY_FILE} --pattern=".*\.texi")"

        # Add dependent directories to list of entries. Be aware of
        # nested directories.
        for ENTRY in ${ENTRIES};do
            ENTRY_DEP=$(echo $ENTRY | sed -r "s/\.texi$//")
            if [[ -d $ENTRY_DEP ]];then
                ENTRIES="${ENTRIES} ${ENTRY_DEP}"
            fi
        done

    fi

    # Prepare list of entries for action preamble.
    ENTRIES=$(echo ${ENTRIES} | tr ' ' "\n" | sort -r | uniq)
    
    # Print action preamble.
    cli_printActionPreamble $ENTRIES --to-delete

    # Remove documentation entry using Subversion's `delete' command
    # to know when the action took place.  Do not use regular `rm'
    # command here.
    svn del ${ENTRIES} --quiet

    # Verify exit status from subversion command to be sure everything
    # went well. Otherwhise stop script execution.
    if [[ $? -ne 0 ]];then
        cli_printMessage "${FUNCDIRNAM}" --as-toknowmore-line
    fi

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Print action message.
    cli_printMessage "Updating menus, nodes and cross-references." '--as-response-line'

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

        # Update menu and node definitions from manual sections to
        # reflect the changes.
        texinfo_updateMenu "remove-entry"
        texinfo_updateNodes

        # Update cross reference definitions from manual to reflect
        # the changes.
        texinfo_deleteCrossReferences

    done
 
    # Rebuild output files to propagate recent changes.
    texinfo_updateOutputFiles

}
