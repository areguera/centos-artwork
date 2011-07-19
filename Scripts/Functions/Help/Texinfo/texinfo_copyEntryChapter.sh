#!/bin/bash
#
# texinfo_copyEntryChapter.sh -- This function standardizes chapter
# duplication inside manuals written in texinfo format.
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

function texinfo_copyEntryChapter {

    # Redefine documentation entry source's location.
    MANUAL_ENTRY_SRC=${MANUAL_BASEDIR_L10N}/${MANUAL_CHAN[${MANUAL_DOCENTRY_ID}]}

    # Redefine documentation entry target's location.
    MANUAL_ENTRY_DST=${MANUAL_BASEDIR_L10N}/${MANUAL_CHAN[((${MANUAL_DOCENTRY_ID} + 1))]}

    # When we are copying chapters, the source location and the target
    # location must be different in value. They cannot point to the
    # same chapter directory.
    if [[ $MANUAL_ENTRY_SRC == $MANUAL_ENTRY_DST ]];then
        cli_printMessage "`gettext "The chapter cannot be copied into itself."`" --as-error-line
    fi

    # When we are copying chapters, document structure actualization
    # needs to be performed against the target chapter not the source
    # one used to create the duplication.  To achieve this goal,
    # define both chapter's directory and chapter's name at this
    # point.
    local MANUAL_CHAPTER_DIR=$MANUAL_ENTRY_DST
    local MANUAL_CHAPTER_NAME=${MANUAL_CHAN[((${MANUAL_DOCENTRY_ID} + 1))]}

    # When we are copying chapters, the chapter itself cannot be
    # copied as we regularly do with sections. Instead, the target
    # chapter must be created as a new chapter and then sections from
    # source chapter must be copied one by one to the recently created
    # chapter. At this point then, is when menu, nodes and cross
    # references for the new chapter are updated.
    ${FLAG_BACKEND}_createChapter

    # Create list of sections from source chapter that need to be
    # copied to target chapter. Don't include chapter main definition
    # files.
    local MANUAL_ENTRIES=$(cli_getFilesList $MANUAL_ENTRY_SRC \
        --pattern="${MANUAL_ENTRY_SRC}/.+\.${MANUAL_EXTENSION}" \
        | egrep -v '/chapter')

    # Copy sections from source chapter to target chapter.
    for MANUAL_ENTRY in $MANUAL_ENTRIES;do
        svn cp $MANUAL_ENTRY $MANUAL_ENTRY_DST --quiet
    done

    # Update section menu, nodes and cross reference definitions
    # inside target chapter where all section entries were copied to.
    ${FLAG_BACKEND}_updateStructureSection "${MANUAL_ENTRY_DST}/.+\.${MANUAL_EXTENSION}"

    # Update chapter menu and node definitions inside the manual
    # structure.
    ${FLAG_BACKEND}_updateChapterMenu
    ${FLAG_BACKEND}_updateChapterNodes

}
