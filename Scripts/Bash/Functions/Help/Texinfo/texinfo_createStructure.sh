#!/bin/bash
#
# texinfo_createStructure.sh -- This function creates the
# documentation structure of a manual using the current language as
# reference.
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

function texinfo_createStructure {

    # Verify manual main definition file. If it already exist, assume
    # it was correctly created in the past. Otherwise try to create
    # it. Don't use the manual base directory here, it would prevent
    # documentation manuals from being created on different languages.
    if [[ -f ${MANUAL_BASEFILE}.${MANUAL_EXTENSION} ]];then
        return
    else
        cli_printMessage "-" --as-separator-line
        cli_printMessage "`eval_gettext "The following documentation manual will be created:"`"
        cli_printMessage "${MANUAL_BASEFILE}.texinfo" --as-response-line
        cli_printMessage "`gettext "Do you want to continue?"`" --as-yesornorequest-line
    fi

    # Initialize manual's information (e.g., title, subtitle, abstract).
    local MANUAL_TITLE=''
    local MANUAL_SUBTITLE=''
    local MANUAL_ABSTRACT=''

    # Create manual's top-level directory using subversion. This is
    # the place where all texinfo documentation manuals is stored in.
    if [[ ! -d ${MANUAL_BASEDIR} ]];then
        svn mkdir ${MANUAL_BASEDIR} --quiet
    fi

    # Create manual's base directory. This is the place where
    # language-specific documentation source files are stored in.
    svn mkdir ${MANUAL_BASEDIR_L10N} --quiet

    # Retrive manual's information from standard input.
    cli_printMessage "`gettext "Manual Title"`" --as-request-line
    read MANUAL_TITLE
    cli_printMessage "`gettext "Manual Subtitle"`" --as-request-line
    read MANUAL_SUBTITLE
    cli_printMessage "`gettext "Manual Abstract"`" --as-request-line
    read MANUAL_ABSTRACT

    # Print action message.
    cli_printMessage "-" --as-separator-line
    cli_printMessage "`gettext "Creating manual structure in texinfo format."`" --as-response-line

    # Verify manual's information. The title information must be
    # non-empty value.
    if [[ $MANUAL_TITLE == '' ]];then
        cli_printMessage "`gettext "The manual title cannot be empty."`" --as-error-line
    fi

    # Define file names required to build the manual.
    local FILE=''
    local FILES=$(cli_getFilesList "${MANUAL_TEMPLATE_L10N}" \
        --maxdepth='1' \
        --pattern="manual((-menu|-nodes|-index)?\.${MANUAL_EXTENSION}|\.conf)")

    # Verify manual base file. The manual base file is where the
    # documentation manual is defined in the format format. Assuming
    # no file exists (e.g., a new language-specific manual is being
    # created), use texinfo templates for it.
    for FILE in $FILES;do
        if [[ ! -f ${MANUAL_BASEDIR_L10N}/$(basename ${FILE}) ]];then

            # Be sure the file is inside the working copy and under
            # version control. 
            ${CLI_NAME} svn --is-versioned ${FILE}
            if [[ $? -ne 0 ]];then
                cli_printMessage "${FILE} `gettext "is not under version control."`" --as-error-line
            fi

            # Define target file.
            local DST=${MANUAL_BASEDIR_L10N}/$(basename ${FILE} \
                | sed -r "s!manual!${MANUAL_NAME}!")

            # Copy using subversion to register this action.
            svn cp ${FILE} ${DST} --quiet

            # Expand common translation markers inside target file.
            cli_expandTMarkers ${DST}

            # Expand specific translation markers inside target file.
            sed -r -i -e "s!=MANUAL_NAME=!${MANUAL_NAME}!g" \
                -e "s!=MANUAL_TITLE=!${MANUAL_TITLE}!g" \
                -e "s!=MANUAL_SUBTITLE=!${MANUAL_SUBTITLE}!g" \
                -e "s!=MANUAL_ABSTRACT=!${MANUAL_ABSTRACT}!g" $DST

        fi
    done

    # Initialize chapter structure inside the manual.
    texinfo_createStructureChapters

    # Redefine absolute path to changed directory.
    MANUAL_CHANGED_DIRS=${MANUAL_BASEDIR}

}
