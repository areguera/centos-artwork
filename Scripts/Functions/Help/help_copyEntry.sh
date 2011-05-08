#!/bin/bash
#
# help_copyEntry.sh -- This function copies documentation entries and
# updates documentation structure to reflect changes.
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

function help_copyEntry {

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    local ENTRY_SRC="$ENTRY"
    local ENTRIES=''
    local ENTRY=''

    # Verify parent directory of entry destination. If its parent
    # directory doesn't exist, create it and add it to the repository.
    if [[ ! -d $(dirname ${ENTRY_DST}) ]];then
        mkdir -p $(dirname ${ENTRY_DST})
        svn add $(dirname ${ENTRY_DST}) --quiet
    fi

    # Copy main documentation entry.
    if [[ -a ${ENTRY_SRC} ]] && [[ ! -a ${ENTRY_DST} ]];then
        cli_printMessage "${ENTRY_DST}" --as-creating-line
        svn cp "${ENTRY_SRC}" "${ENTRY_DST}" --quiet
    fi

    # Define target location of directory holding dependent
    # documentation entries.
    ENTRY_DST=$(echo ${ENTRY_DST} | sed -r 's!\.texi$!!')

    # Copy dependent documentation entries, if any.
    if [[ -d ${ENTRY_DIR}/${ENTRY_FILE} ]] && [[ ! -d ${ENTRY_DST} ]];then
        cli_printMessage "${ENTRY_DST}" --as-creating-line
        svn cp "${ENTRY_DIR}/${ENTRY_FILE}" "${ENTRY_DST}" --quiet
    fi
                
    # Define list of files to process.
    ENTRIES=$(cli_getFilesList $(dirname ${ENTRY_DST}) --pattern=".*$(basename ${ENTRY_DST}).*\.texi")

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Print action message.
    cli_printMessage "Updating menus, nodes and cross-references." --as-response-line

    # Redefine ENTRY variable in order to update documentation
    # structure, taking recently created entries as reference.
    for ENTRY in ${ENTRIES};do

        # Update menu and node definitions from manual sections to
        # reflect the changes.
        help_updateMenu
        help_updateNodes

        # Update cross reference definitions from manual to reflect
        # the changes.
        help_restoreCrossReferences

    done

}
