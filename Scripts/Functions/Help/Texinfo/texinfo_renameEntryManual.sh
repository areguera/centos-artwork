#!/bin/bash
#
# texinfo_renameEntryManual.sh -- This function standardizes renaming
# tasks related to documenation manuals written in texinfo format
# inside the working copy.
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

function texinfo_renameEntryManual {

    # Copy section source entry to target location.
    ${MANUAL_BACKEND}_copyEntryManual

    # Delete section source entry.
    ${MANUAL_BACKEND}_deleteEntryManual

    # Redefine absolute paths to changed directories.  This is
    # required in order for `cli_commitRepoChanges' to be aware of
    # manual source and target locations we've just renamed.
    MANUAL_CHANGED_DIRS="${MANUAL_BASEDIR} $(echo $MANUAL_BASEDIR \
        | sed -r "s!${MANUAL_DIRN[${MANUAL_DOCENTRY_ID}]}!${MANUAL_DIRN[((${MANUAL_DOCENTRY_ID} + 1))]}!")"

    # From this time on, the manual information set so far is no
    # longer useful. Redefine it to start using the new manual
    # information instead.

    # Redefine manual name using manual name passed to `centos-art.sh'
    # script as second non-option argument.
    MANUAL_NAME=${MANUAL_SLFN[((${MANUAL_DOCENTRY_ID} + 1))]}

    # Redefine absolute path to manual directory using manual name
    # passed to `centos-art.sh' script as second non-option argument.
    MANUAL_BASEDIR="$(echo $MANUAL_BASEDIR \
        | sed -r "s!${MANUAL_DIRN[${MANUAL_DOCENTRY_ID}]}!${MANUAL_DIRN[((${MANUAL_DOCENTRY_ID} + 1))]}!")"

    # Redefine absolute path to manual directory using manual name
    # passed to `centos-art.sh' script as second non-option argument.
    MANUAL_BASEDIR_L10N="${MANUAL_BASEDIR}/${MANUAL_L10N}"

    # Redefine absolute path to base file using manual name passed to
    # `centos-art.sh' script as second non-option argument.
    MANUAL_BASEFILE="${MANUAL_BASEDIR_L10N}/${MANUAL_NAME}"

}
