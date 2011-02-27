#!/bin/bash
#
# manual_deleteEntry.sh -- This function removes a documentation entry
# from documentation directory structure.
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

function manual_deleteEntry {

    local ENTRIES=''

    # Check if the entry has been already removed.
    cli_checkFiles $ENTRY 'f'

    # Initiate list of entries to remove using the entry specified in
    # the command line.
    ENTRIES=${ENTRY}

    # Verify existence of dependent entries.  Dependent entries are
    # stored inside a directory with the same name of the entry you
    # are trying to remove.
    if [[ -d ${ENTRY_DIR}/${ENTRY_FILE} ]];then

        # If such directory doesn't exists, the related entry doesn't
        # have dependent entries, but if it exists is because there is
        # at least one dependent entry inside it, in this case add
        # dependent all dependent entries. This is required in order
        # for menus, nodes and cross-references to be updated correctly.
        ENTRIES="${ENTRIES} $(cli_getFilesList "${ENTRY_DIR}/${ENTRY_FILE}" ".*\.texi")"

        # Also, add the directory that stores dependent entries. This
        # is required since directories by themselves are not
        # considered entries by themselves and so they aren't put on
        # the list of entries. We don't want to have dependent
        # directories still there, when there is no parent entry for
        # them.        
        ENTRIES="${ENTRIES} ${ENTRY_DIR}/${ENTRY_FILE}"

    fi

    # Prepare list of entries for action preamble.
    ENTRIES=$(echo $ENTRIES | tr ' ' "\n" | sort | uniq)
    
    # Print action preamble.
    cli_printActionPreamble "$ENTRIES" 'doDelete' 'AsResponseLine'

    # Process list of entries in order to remove files.
    for ENTRY in $ENTRIES;do

        # Print action message.
        cli_printMessage "$ENTRY" "AsDeletingLine"

        # Remove documentation entry using regular subversion
        # commands.  Do not use regular rm command here, use
        # subversion del command instead. Otherwise, even the file is
        # removed, it will be brought back when the final
        # cli_commitRepoChange be executed. Remember there is a
        # subversion update there, no matter what you remove using
        # regular commands, when you do update the directory structure
        # on the working copy the removed files (not removed in the
        # repository, nor marked to be removed) are brought down to
        # the working copy again.
        svn del "$ENTRY" --quiet

    done

    # Print separator line.
    cli_printMessage '-' 'AsSeparatorLine'

    # Print action message.
    cli_printMessage "Updating definition of menus, nodes and cross-references." 'AsResponseLine'

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
    for ENTRY in $ENTRIES;do

        # Update menu and node definitions from manual sections to
        # reflect the changes.
        manual_updateMenu "remove-entry"
        manual_updateNodes

        # Update cross reference definitions from manual to reflect
        # the changes.
        manual_deleteCrossReferences

    done
 
    # Remove entry menus and nodes from chapter definition to reflect
    # the fact it has been removed.  This is mainly applied when one
    # of the chapters (e.g., trunk/, tags/, or branches/) is removed.
    if [[ ! -d $MANUAL_DIR_CHAPTER ]];then
        manual_updateChaptersMenu 'remove-entry'
        manual_updateChaptersNodes
    fi

    # Print separator line.
    cli_printMessage '-' 'AsSeparatorLine'

    # Rebuild output files to propagate recent changes.
    manual_updateOutputFiles

}
