#!/bin/bash
#
# texinfo_copyEntry.sh -- This function standardizes the duplication
# actions related to manuals written in texinfo format. This function
# duplicates manuals, chapters inside manuals, and sections inside
# chapters.
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

    # Initialize source and target locations.
    local MANUAL_ENTRY_SRC=''
    local MANUAL_ENTRY_DST=''

    # Execute copying action based on documentation entries passed as
    # non-option arguments to `centos-art.sh' script in the
    # command-line.
    if [[ ${MANUAL_SECT[${MANUAL_DOCENTRY_ID}]} != '' ]];then

        # In this configuration, the section name is specified in
        # first non-option argument and optionally in the second
        # non-option arugment.
        texinfo_copyEntrySection
         
    elif [[ ${MANUAL_CHAP[${MANUAL_DOCENTRY_ID}]} != '' ]] \
        && [[ ${MANUAL_CHAP[((${MANUAL_DOCENTRY_ID} + 1))]} != '' ]];then

        # In this configuration, the section name wasn't specified
        # neither in first or second non-option argument.  So, we
        # perform a copying action for the chapter directory itself.
        # In this configuration, the whole chapter directory and all
        # the content inside are duplicated from source to target.
        texinfo_copyEntryChapter

    elif [[ ${MANUAL_DIRN[${MANUAL_DOCENTRY_ID}]} != '' ]] \
        && [[ ${MANUAL_DIRN[((${MANUAL_DOCENTRY_ID} + 1))]} != '' ]];then

        # In this configuration, the chapter name wasn't specified
        # neither in first or second non-option argument. So, we
        # perform copying actions on manual directory itself.  Notice
        # that, in this configuration, the whole manual is duplicated.
        texinfo_copyEntryManual

        # In this configuration, there is no need to update section
        # menus, nodes and cross refereces. The section definition
        # files were copied from the source manual with any change so
        # the manual should build without any problem. Be sure such
        # verification will never happen.

    else
        cli_printMessage "`gettext "The parameters you provided are not supported."`" --as-error-line
    fi

}
