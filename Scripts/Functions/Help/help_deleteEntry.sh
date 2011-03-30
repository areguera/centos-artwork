#!/bin/bash
#
# help_deleteEntry.sh -- This function removes a documentation entry
# from documentation directory structure.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function help_deleteEntry {

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
        ENTRIES="${ENTRIES} $(cli_getFilesList "${ENTRY_DIR}/${ENTRY_FILE}" ".*\.texi")"

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
    cli_printActionPreamble "$ENTRIES" 'doDelete' 'AsResponseLine'

    # Remove documentation entry using regular subversion commands.
    # Do not use regular rm command here, use subversion del command
    # instead. Otherwise, even the file is removed, it will be brought
    # back when the final cli_commitRepoChange be executed. Remember
    # there is a subversion update there, no matter what you remove
    # using regular commands, when you do update the directory
    # structure on the working copy the removed files (not removed in
    # the repository, nor marked to be removed) are brought down to
    # the working copy again.
    svn del ${ENTRIES} --quiet
    if [[ $? -ne 0 ]];then
        cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
    fi

    # Print separator line.
    cli_printMessage '-' 'AsSeparatorLine'

    # Print action message.
    cli_printMessage "Updating manual menus, nodes and cross-references." 'AsResponseLine'

    # Process list of entries in order to update menus, nodes and
    # cross references. Since we are verifying entry status before
    # remove the we cannot update the information in the same loop we
    # remove files. This would modify some file before be removed and
    # that would stop script execution. Similary, if we do update
    # menus, nodes and cross references before removing files it would
    # be needed to remove farther status verification in order for the
    # script to continue its execution. Thereby, I can't see a
    # different way but removing files first using status verification
    # and later go through entities list again to update menus, nodes
    # and cross references from remaining files.
    for ENTRY in ${ENTRIES};do

        # Use entry files only. Directories are used to store
        # dependent entries. Directories are not considered entries on
        # themselves.
        if [[ ! -f $ENTRY ]];then
            continue
        fi

        # Update menu and node definitions from manual sections to
        # reflect the changes.
        help_updateMenu "remove-entry"
        help_updateNodes

        # Update cross reference definitions from manual to reflect
        # the changes.
        help_deleteCrossReferences

    done
 
    # Remove entry menus and nodes from chapter definition to reflect
    # the fact it has been removed.  This is mainly applied when one
    # of the chapters (e.g., trunk/, tags/, or branches/) is removed.
    if [[ ! -d $MANUAL_CHAPTER_DIR ]];then
        help_updateChaptersMenu 'remove-entry'
        help_updateChaptersNodes
    fi

}
