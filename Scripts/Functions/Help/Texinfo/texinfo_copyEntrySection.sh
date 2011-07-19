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

    # Define absolute path to section source and target locations
    # based on non-option arguments passed to `centos-art.sh' script.
    if [[ ${MANUAL_SECN[((${MANUAL_DOCENTRY_ID} + 1))]} != '' ]];then

        # When the section name is specified in first and second
        # non-option arguments, source and target are set as specified
        # in first and second non-option arguments respectively.
        MANUAL_ENTRY_SRC=$(${FLAG_BACKEND}_getEntry ${MANUAL_SECN[${MANUAL_DOCENTRY_ID}]})
        MANUAL_ENTRY_DST=$(${FLAG_BACKEND}_getEntry ${MANUAL_SECN[((${MANUAL_DOCENTRY_ID} + 1))]})

    elif [[ ${MANUAL_SECN[((${MANUAL_DOCENTRY_ID} + 1))]} == '' ]] \
        && [[ ${MANUAL_CHAN[((${MANUAL_DOCENTRY_ID} + 1))]} != '' ]];then

        # When the section name is specified only in the first
        # non-option argument and the chapter name has been provided
        # in the second non-option argument, use the section name
        # passed in first argument to build the section name that will
        # be used as target.
        MANUAL_ENTRY_SRC=$(${FLAG_BACKEND}_getEntry ${MANUAL_SECN[${MANUAL_DOCENTRY_ID}]})
        MANUAL_ENTRY_DST=$(echo $MANUAL_ENTRY_SRC \
            | sed -r "s!${MANUAL_CHAN[${MANUAL_DOCENTRY_ID}]}!${MANUAL_CHAN[((${MANUAL_DOCENTRY_ID} + 1))]}!")

    else
        cli_printMessage "`gettext "The location provided as target isn't valid."`" --as-error-line
    fi

    # Verify source and target locations to be sure they are different
    # one another. We cannot copy a source location to itself.
    if [[ $MANUAL_ENTRY_SRC == $MANUAL_ENTRY_DST ]];then
        cli_printMessage "`gettext "The source and target locations cannot be the same."`" --as-error-line
    fi

    # Print separator line along with action message.
    cli_printMessage '-' --as-separator-line
    cli_printMessage "${MANUAL_ENTRY_DST}" --as-creating-line

    # Verify existence of source location.
    if [[ ! -a ${MANUAL_ENTRY_SRC} ]];then
        cli_printMessage "`gettext "The source location doesn't exist."`" --as-error-line
    fi

    # When we copy sections, the target chapter directory where the
    # source section will be duplicated in, must exist first.  In that
    # sake, verify the chapter directory of target section entry and
    # if it doesn't exist, create it adding using subversion.
    if [[ ! -d $(dirname ${MANUAL_ENTRY_DST}) ]];then
        svn mkdir $(dirname ${MANUAL_ENTRY_DST}) --quiet
    fi

    # Verify existence of target location.
    if [[ -a ${MANUAL_ENTRY_DST} ]];then
        cli_printMessage "`gettext "The target location already exists."`" --as-error-line
    fi

    # Copy section entry from source to target using subversion.
    svn cp "${MANUAL_ENTRY_SRC}" "${MANUAL_ENTRY_DST}" --quiet

    # Redefine chapter name using chapter name passed to
    # `centos-art.sh' script as second non-option argument.
    local MANUAL_CHAPTER_NAME=${MANUAL_CHAN[((${MANUAL_DOCENTRY_ID} + 1))]}

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
    ${FLAG_BACKEND}_updateStructureSection "${MANUAL_ENTRY_DST}"

}
