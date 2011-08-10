#!/bin/bash
#
# texinfo_renameEntry.sh -- This function standardizes renaming tasks
# related to manual, chapters and sections inside the working copy.
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

function texinfo_renameEntry {

    # Initialize source and target locations.
    local MANUAL_ENTRY_SRC=''
    local MANUAL_ENTRY_DST=''

    # Define both source and target documentation entries. To build
    # the source and target documentation entries we take into
    # consideration the manual's main definition file, the chapter's
    # main definition file and non-option arguments passed to
    # centos-art.sh script through the command-line.
    if [[ ${MANUAL_SECT[${MANUAL_DOCENTRY_ID}]} != '' ]];then

        # When a section is renamed, the section source location is
        # duplicated into the section target location and later
        # removed from the working copy. Once the section source
        # location has been renamed, the section menu, nodes and cross
        # references are updated to keep consistency inside the
        # manual.
        ${MANUAL_BACKEND}_renameEntrySection

    elif [[ ${MANUAL_CHAP[$MANUAL_DOCENTRY_ID]} != '' ]] \
        && [[ ${MANUAL_CHAP[(($MANUAL_DOCENTRY_ID + 1))]} != '' ]];then

        # When a chapter is renamed, the chapter source location is
        # duplicated into the chapter source location and later
        # removed from the working copy. Once the chapter source
        # location has been renamed, the chapter and section menu,
        # nodes and cross references are updated to keep consistency
        # inside the manual.
        ${MANUAL_BACKEND}_renameEntryChapter

    elif [[ ${MANUAL_DIRN[$MANUAL_DOCENTRY_ID]} != '' ]] \
        && [[ ${MANUAL_DIRN[(($MANUAL_DOCENTRY_ID + 1))]} != '' ]] ;then

        # When a manual is renamed, a new manual structure is created
        # in the manual target location and all chapters and sections
        # are duplicated from manual source location to manual target
        # location. Once the source manual has been renamed, chapter
        # and section menu, nodes and cross references are updated to
        # keep consistency inside the manual.
        ${MANUAL_BACKEND}_renameEntryManual

    else
        cli_printMessage "`gettext "The parameters you provided are not supported."`" --as-error-line
    fi

}
