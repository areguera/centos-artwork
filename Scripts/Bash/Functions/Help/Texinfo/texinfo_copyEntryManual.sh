#!/bin/bash
#
# texinfo_copyEntryChapter.sh -- This function standardizes
# duplication of manuals written in texinfo format.
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

function texinfo_copyEntryManual {

    # Define list of chapters inside source manual excluding those
    # created from template, rendition output and subversion.
    local MANUAL_CHAPTER=''
    local MANUAL_CHAPTERS=$(cli_getFilesList ${MANUAL_BASEDIR_L10N} \
        --maxdepth=1 --mindepth=1 --type="d" --pattern='.+' \
        | egrep -v "(Licenses|\.svn|${MANUAL_NAME}-xhtml)$")

    # Redefine manual name using manual name passed to `centos-art.sh'
    # script as second non-option argument.
    local MANUAL_NAME=${MANUAL_SLFN[((${MANUAL_DOCENTRY_ID} + 1))]}

    # Redefine absolute path to manual directory using manual name
    # passed to `centos-art.sh' script as second non-option argument.
    local MANUAL_BASEDIR="$(echo $MANUAL_BASEDIR \
        | sed -r "s!${MANUAL_DIRN[${MANUAL_DOCENTRY_ID}]}!${MANUAL_DIRN[((${MANUAL_DOCENTRY_ID} + 1))]}!")"

    # Redefine absolute path to manual directory using manual name
    # passed to `centos-art.sh' script as second non-option argument.
    local MANUAL_BASEDIR_L10N="${MANUAL_BASEDIR}/${MANUAL_L10N}"

    # Redefine absolute path to base file using manual name passed to
    # `centos-art.sh' script as second non-option argument.
    local MANUAL_BASEFILE="${MANUAL_BASEDIR_L10N}/${MANUAL_NAME}"

    # Create manual structure
    texinfo_createStructure

    # Print action maessage.
    cli_printMessage "`gettext "Updating chapter menus and nodes inside manual structure."`" --as-response-line

    # Loop through list of chapters.
    for MANUAL_CHAPTER in ${MANUAL_CHAPTERS};do

        # Copy chapter directory from source to target using
        # subversion.
        ${CLI_NAME} svn --copy ${MANUAL_CHAPTER} ${MANUAL_BASEDIR_L10N}

        # Define manual chapter name.
        local MANUAL_CHAPTER_NAME=$(basename ${MANUAL_CHAPTER})

        # Update chapter information inside the manual's texinfo
        # structure.
        texinfo_updateChapterMenu
        texinfo_updateChapterNodes

    done

}
