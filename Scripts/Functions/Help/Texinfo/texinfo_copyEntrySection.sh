#!/bin/bash
#
# texinfo_copyEntrySection.sh -- This function standardizes section
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

function texinfo_copyEntrySection {

    # Verify source and target locations to be sure they are different
    # one another. We cannot copy a source location to itself.
    if [[ $MANUAL_ENTRY_SRC == $MANUAL_ENTRY_DST ]];then
        cli_printMessage "`gettext "The source and target locations cannot be the same."`" --as-error-line
    fi

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Redefine chapter name using chapter name passed to
    # `centos-art.sh' script as second non-option argument.
    MANUAL_CHAPTER_NAME=${MANUAL_CHAN[((${MANUAL_DOCENTRY_ID} + 1))]}

    # Redefine chapter directory to use the chapter provided to
    # `centos-art.sh' script as second non-option argument. This is
    # required in order to update the `chapter-menu.texinfo' file on
    # the target chapter the documentation entry was copied in, not
    # the source chapter where the documentation entry was taken from.
    # This is particulary useful when a documentation entry is copied
    # from one chapter to another different.
    MANUAL_CHAPTER_DIR=$(dirname ${MANUAL_ENTRY_DST})

    # When we copy sections, the chapter directory where the section
    # copied will be placed in must exist first. In that sake, verify
    # the chapter directory of target documentation entry and if it
    # doesn't exist, create it adding it to version control.
    if [[ ! -d $(dirname ${MANUAL_ENTRY_DST}) ]];then
        svn mkdir $(dirname ${MANUAL_ENTRY_DST}) --quiet
    fi

    # Copy documentation entry from source to target using subversion.
    if [[ -a ${MANUAL_ENTRY_SRC} ]];then
        if [[ ! -a ${MANUAL_ENTRY_DST} ]];then
            cli_printMessage "${MANUAL_ENTRY_DST}" --as-creating-line
            svn cp "${MANUAL_ENTRY_SRC}" "${MANUAL_ENTRY_DST}" --quiet
        else
            cli_printMessage "`gettext "The target location is not valid."`" --as-error-line
        fi
    else
        cli_printMessage "`gettext "The source location is not valid."`" --as-error-line
    fi

    # At this point, all copying actions had took place and it is time
    # to update the document structure.
    ${FLAG_BACKEND}_updateStructureSection "${MANUAL_ENTRY_DST}"

}
