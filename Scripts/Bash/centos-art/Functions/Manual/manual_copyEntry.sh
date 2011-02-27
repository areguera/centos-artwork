#!/bin/bash
#
# manual_copyEntry.sh -- This function copies documentation entries and
# updates documentation structure to reflect changes.
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

function manual_copyEntry {

    # Print action message.
    cli_printMessage "${FLAG_TO}" 'AsCreatingLine'

    # Copy main documentation entry.
    if [[ ! -f $FLAG_TO ]];then
        svn cp "${ENTRY}" "${FLAG_TO}" --quiet
    fi

    # Define target location of directory holding dependent
    # documentation entries.
    local ENTRY_DIR_DST=$(echo ${FLAG_TO} | sed -r 's!\.texi$!!')

    # Print action message.
    cli_printMessage "${ENTRY_DIR_DST}" 'AsCreatingLine'

    # Copy dependent documentation entries.
    if [[ ! -d $ENTRY_DIR_DST ]];then
        svn cp "${ENTRY_DIR}/${ENTRY_FILE}" "${ENTRY_DIR_DST}" --quiet
    fi
                
    # Define list of files to process.
    ENTRIES=$(cli_getFilesList "$(dirname ${ENTRY_DIR_DST})" "$(basename ${ENTRY_DIR_DST}).*\.texi")

    # Set action preamble.
    cli_printActionPreamble "${ENTRIES}"

    # Redefine ENTRY variable in order to update documentation
    # structure, taking recently created entries as reference.
    for ENTRY in ${ENTRIES};do

        # Update menu and node definitions from manual sections to
        # reflect the changes.
        manual_updateMenu
        manual_updateNodes

        # Update cross reference definitions from manual to reflect
        # the changes.
        manual_restoreCrossReferences

    done

}
