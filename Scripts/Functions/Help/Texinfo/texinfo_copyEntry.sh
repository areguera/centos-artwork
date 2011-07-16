#!/bin/bash
#
# texinfo_copyEntry.sh -- This function standardizes the duplication
# actions related to manuals written in texinfo format. This function
# duplicates manuals, chapters inside manuals, and sections inside
# chapters.
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

function texinfo_copyEntry {

    local MANUAL_ENTRY_SRC=''
    local MANUAL_ENTRY_DST=''
    local MANUAL_ENTRY=''
    local MANUAL_ENTRIES=''

    # Define both source and target documentation entries. To build
    # the source and target documentation entries we take into
    # consideration the manual's main definition file, the chapter's
    # main definition file and non-option arguments passed to
    # centos-art.sh script through the command-line.
    if [[ ${MANUAL_SECN[${MANUAL_DOCENTRY_ID}]} != '' ]];then

        if [[ ${MANUAL_SECN[((${MANUAL_DOCENTRY_ID} + 1))]} != '' ]];then

            # When the section name is specified both in first and
            # second non-option arguments, source and target are set
            # as specified in first and second non-option arguments
            # respectively.

            # Define documentation entry source's location.
            MANUAL_ENTRY_SRC=$(${FLAG_BACKEND}_getEntry ${MANUAL_SECN[${MANUAL_DOCENTRY_ID}]})

            # Define documentation entry target's location.
            MANUAL_ENTRY_DST=$(${FLAG_BACKEND}_getEntry ${MANUAL_SECN[((${MANUAL_DOCENTRY_ID} + 1))]})

        elif [[ ${MANUAL_SECN[((${MANUAL_DOCENTRY_ID} + 1))]} == '' ]] \
            && [[ ${MANUAL_CHAN[((${MANUAL_DOCENTRY_ID} + 1))]} != '' ]];then

            # When the section name is specified only in the first
            # non-option argument and the chapter name has been
            # provided in the second non-option argument, use the
            # section name passed in first argument to build the
            # section name that will be used as target.

            # Define documentation entry source's location.
            MANUAL_ENTRY_SRC=$(${FLAG_BACKEND}_getEntry ${MANUAL_SECN[${MANUAL_DOCENTRY_ID}]})

            # Define documentation entry target's location.
            MANUAL_ENTRY_DST=$(echo $MANUAL_ENTRY_SRC \
                | sed -r "s!${MANUAL_CHAN[${MANUAL_DOCENTRY_ID}]}!${MANUAL_CHAN[((${MANUAL_DOCENTRY_ID} + 1))]}!")

        else
            cli_printMessage "`gettext "The location provided as target isn't valid."`" --as-error-line
        fi

        # Copy documentation entry using source and target locations.
        ${FLAG_BACKEND}_copyEntrySection
         
    elif [[ ${MANUAL_CHAN[${MANUAL_DOCENTRY_ID}]} != '' ]] \
        && [[ ${MANUAL_CHAN[((${MANUAL_DOCENTRY_ID} + 1))]} != '' ]];then

        # In this configuration, the section name wasn't specified
        # neither in first or second non-option argument.  So, we
        # perform a copying action for the chapter directory itself.
        # In this configuration, the whole chapter directory and all
        # the content inside it is duplicated from source to target.
        ${FLAG_BACKEND}_copyEntryChapter

    elif [[ ${MANUAL_DIRN[${MANUAL_DOCENTRY_ID}]} != '' ]] \
        && [[ ${MANUAL_DIRN[((${MANUAL_DOCENTRY_ID} + 1))]} != '' ]];then

        # In this configuration, the chapter name wasn't specified
        # neither in first or second non-option argument. So, we
        # perform copying actions on manual directory itself.  Notice
        # that, in this configuration, the whole manual is duplicated.
        ${FLAG_BACKEND}_copyEntryManual

        # In this configuration, there is no need to update section
        # menus, nodes and cross refereces. The section definition
        # files were copied from the source manual with any change so
        # the manual should build without any problem. Be sure such
        # verification will never happen.

    else
        cli_printMessage "`gettext "The parameters you provided are not supported."`" --as-error-line
    fi

}
