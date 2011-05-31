#!/bin/bash
#
# texinfo_copyEntry.sh -- This function copies documentation entries
# inside the working copy and updates the documentation structure to
# reflect the changes.
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

function texinfo_copyEntry {

    # Verify number of non-option arguments passed to centos-art.sh
    # script.
    if [[ $# -lt 2 ]];then
        cli_printMessage "`gettext "Two paths are required."`" --as-error-line
    elif [[ $# -gt 2 ]];then
        cli_printMessage "`gettext "Only two paths are supported."`" --as-error-line
    fi

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Define source documentation entry. This is the documentation
    # entry that will be duplicated.
    local MANUAL_ENTRY_SRC=$(${FLAG_BACKEND}_getEntry "${1}")

    # Define target documentation entry. This is the new documentation
    # entry created from the source documentation entry.
    local MANUAL_ENTRY_DST=$(${FLAG_BACKEND}_getEntry "${2}")

    # Verify parent directory of target documentation entry. If it
    # doesn't exist, create it and add it to version control.
    if [[ ! -d $(dirname ${MANUAL_ENTRY_DST}) ]];then
        mkdir -p $(dirname ${MANUAL_ENTRY_DST})
        svn add $(dirname ${MANUAL_ENTRY_DST}) --quiet
    fi

    # Copy source documentation entry to target documentation entry.
    if [[ -f ${MANUAL_ENTRY_SRC} ]];then
        if [[ ! -f ${MANUAL_ENTRY_DST} ]];then
            cli_printMessage "${MANUAL_ENTRY_DST}" --as-creating-line
            svn cp "${MANUAL_ENTRY_SRC}" "${MANUAL_ENTRY_DST}" --quiet
        else
            cli_printMessage "`gettext "The target location is not valid."`" --as-error-line
        fi
    else
        cli_printMessage "`gettext "The source location is not valid."`" --as-error-line
    fi

    # Redefine both source and target locations to refer the directory
    # where dependent documentation entries are stored in.
    MANUAL_ENTRY_SRC=$(echo ${MANUAL_ENTRY_SRC} | sed -r "s/\.${FLAG_BACKEND}$//")
    MANUAL_ENTRY_DST=$(echo ${MANUAL_ENTRY_DST} | sed -r "s/\.${FLAG_BACKEND}$//")

    # Copy dependent documentation entries, if any.
    if [[ -d ${MANUAL_ENTRY_SRC} ]];then
        if [[ ! -a ${MANUAL_ENTRY_DST} ]];then
            cli_printMessage "${MANUAL_ENTRY_DST}" --as-creating-line
            svn cp "${MANUAL_ENTRY_SRC}" "${MANUAL_ENTRY_DST}" --quiet
        fi
    fi

    # Define list of target documentation entries.
    local MANUAL_ENTRY=''
    local MANUAL_ENTRIES=$(cli_getFilesList \
        $(dirname ${MANUAL_ENTRY_DST}) \
        --pattern="${MANUAL_ENTRY_DST}.*\.${FLAG_BACKEND}")

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Print action message.
    cli_printMessage "`gettext "Updating menus, nodes and cross-references."`" --as-response-line

    # Loop through target documentation entries in order to update
    # the documentation structure (e.g., It is not enough with copying
    # documentation entry files, it is also needed to update menu,
    # nodes and related cross-references).
    for MANUAL_ENTRY in ${MANUAL_ENTRIES};do

        # Update menu and node definitions from manual sections to
        # reflect the changes.
        ${FLAG_BACKEND}_updateMenu
        ${FLAG_BACKEND}_updateNodes

        # Update cross reference definitions from manual to reflect
        # the changes.
        ${FLAG_BACKEND}_restoreCrossReferences $MANUAL_ENTRY

    done

}
