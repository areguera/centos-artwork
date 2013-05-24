#!/bin/bash
#
# texinfo_deleteEntryChapter.sh -- This function standardizes chapter
# deletion inside the manual structure.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function texinfo_deleteEntryChapter {

    # Verify existence of documentation entry before deleting it.
    # We cannot delete an entry which doesn't exist.
    cli_checkFiles "${MANUAL_CHAPTER_DIR}" -d
    cli_checkFiles "${MANUAL_CHAPTER_DIR}-menu.${MANUAL_EXTENSION}" -f
    cli_checkFiles "${MANUAL_CHAPTER_DIR}-nodes.${MANUAL_EXTENSION}" -f
    cli_checkFiles "${MANUAL_CHAPTER_DIR}.${MANUAL_EXTENSION}" -f

    # Define list of chapters that shouldn't be removed.
    local SPECIAL_CHAPTERS='/(Licenses|Index)$'

    # Verify list of chapters that shouldn't be removed against the
    # current chapter directory being removed.
    if [[ $MANUAL_CHAPTER_DIR =~ $SPECIAL_CHAPTERS ]];then
        cli_printMessage "`gettext "The chapter specified cannot be removed."`" --as-error-line
    fi

    # Build list of section entries inside the chapter. This is
    # required to delete cross references from other section entries
    # that point to section entries inside the chapter that will be
    # deleted. Take care don't include the chapter definition files.
    local MANUAL_ENTRIES=$(cli_getFilesList $MANUAL_CHAPTER_DIR \
        --pattern="^/.+\.${MANUAL_EXTENSION}$")

    # Remove chapter directory and related files using version control
    # to register the change.
    cli_runFnEnvironment vcs --delete ${MANUAL_CHAPTER_DIR}
    cli_runFnEnvironment vcs --delete ${MANUAL_CHAPTER_DIR}-menu.${MANUAL_EXTENSION}
    cli_runFnEnvironment vcs --delete ${MANUAL_CHAPTER_DIR}-nodes.${MANUAL_EXTENSION}
    cli_runFnEnvironment vcs --delete ${MANUAL_CHAPTER_DIR}.${MANUAL_EXTENSION}

    # Update chapter menu and nodes inside manual structure.
    texinfo_updateChapterMenu --delete-entry
    texinfo_updateChapterNodes

    # Loop through section entries retrieved from chapter, before
    # deleting it, in order to remove cross references pointing to
    # those section entries. Since the chapter and all its sections
    # have been removed, cross references pointing them will point to
    # non-existent section entries. This way, all cross references
    # pointing to non-existent section entries will be transformed in
    # order for documenters to advertise the section entry state.
    for MANUAL_ENTRY in $MANUAL_ENTRIES;do
        texinfo_deleteCrossReferences ${MANUAL_ENTRY}
    done

}
