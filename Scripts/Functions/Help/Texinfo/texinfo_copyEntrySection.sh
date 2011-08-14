#!/bin/bash
#
# texinfo_copyEntrySection.sh -- This function standardizes section
# duplication inside manuals written in texinfo format.
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

function texinfo_copyEntrySection {

    # Define absolute path to section source and target locations
    # based on non-option arguments passed to `centos-art.sh' script.
    if [[ ${MANUAL_SECT[((${MANUAL_DOCENTRY_ID} + 1))]} != '' ]];then

        # When the section name is specified in first and second
        # non-option arguments, source and target are set as specified
        # in first and second non-option arguments respectively.
        MANUAL_ENTRY_SRC=$(texinfo_getEntry ${MANUAL_SECT[${MANUAL_DOCENTRY_ID}]})
        MANUAL_ENTRY_DST=$(texinfo_getEntry ${MANUAL_SECT[((${MANUAL_DOCENTRY_ID} + 1))]})

    elif [[ ${MANUAL_SECT[((${MANUAL_DOCENTRY_ID} + 1))]} == '' ]] \
        && [[ ${MANUAL_CHAP[((${MANUAL_DOCENTRY_ID} + 1))]} != '' ]];then

        # When the section name is specified only in the first
        # non-option argument and the chapter name has been provided
        # in the second non-option argument, use the section name
        # passed in first argument to build the section name that will
        # be used as target.
        MANUAL_ENTRY_SRC=$(texinfo_getEntry ${MANUAL_SECT[${MANUAL_DOCENTRY_ID}]})
        MANUAL_ENTRY_DST=$(echo $MANUAL_ENTRY_SRC \
            | sed -r "s!${MANUAL_CHAP[${MANUAL_DOCENTRY_ID}]}!${MANUAL_CHAP[((${MANUAL_DOCENTRY_ID} + 1))]}!")

    else
        cli_printMessage "`gettext "The location provided as target isn't valid."`" --as-error-line
    fi

    # Print separator line along with action message.
    cli_printMessage '-' --as-separator-line
    cli_printMessage "${MANUAL_ENTRY_DST}" --as-creating-line

    # Verify entry source and target locations.
    texinfo_checkEntrySrcDst "${MANUAL_ENTRY_SRC}" "${MANUAL_ENTRY_DST}"

    # Copy section entry from source to target using subversion.
    svn cp "${MANUAL_ENTRY_SRC}" "${MANUAL_ENTRY_DST}" --quiet

    # Redefine chapter name using chapter name passed to
    # `centos-art.sh' script as second non-option argument.
    local MANUAL_CHAPTER_NAME=${MANUAL_CHAP[((${MANUAL_DOCENTRY_ID} + 1))]}

    # Redefine chapter directory to use the chapter provided to
    # `centos-art.sh' script as second non-option argument. This is
    # required in order to update the `chapter-menu.texinfo' file
    # inside the target chapter where section entry was copied to, not
    # the source chapter where the section entry was taken from.  This
    # is particulary useful section entries are copied from one
    # chapter into another different.
    local MANUAL_CHAPTER_DIR=$(dirname ${MANUAL_ENTRY_DST})

    # At this point, all copying actions and chapter related
    # redefinitions have took place. It is time, then, to update the
    # document structure using the information collected so far.
    texinfo_updateStructureSection "${MANUAL_ENTRY_DST}"

}
