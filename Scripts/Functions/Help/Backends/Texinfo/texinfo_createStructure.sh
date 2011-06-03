#!/bin/bash
#
# texinfo_createStructure.sh -- This function creates the
# documentation structure of a manual using the current language as
# reference.
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

function texinfo_createStructure {

    # Verify manual base directory. The manual base directory is where
    # the whole documentation manual is stored in. If it already
    # exist, assume it was correctly created in the past.
    if [[ -d $MANUAL_BASEDIR ]];then
        return
    fi

    # Print action message.
    cli_printMessage "-" --as-separator-line
    cli_printMessage "`gettext "Creating manual structure."`"

    # Create the language-specific directory used to store all files
    # related to documentation manual.
    svn mkdir ${MANUAL_BASEDIR} --quiet

    # Define file names required to build the manual.
    local FILE=''
    local FILES=$(cli_getFilesList "${MANUAL_TEMPLATE}" \
        --maxdepth='1' \
        --pattern="repository(-menu|-nodes|-index)?\.${FLAG_BACKEND}")

    # Verify manual base file. The manual base file is where the
    # documentation manual is defined in the backend format. Assuming
    # no file exists (e.g., a new language-specific manual is being
    # created), use texinfo templates for it.
    for FILE in $FILES;do
        if [[ ! -f ${MANUAL_BASEDIR}/$(basename ${FILE}) ]];then
            cli_checkFiles ${FILE} -wn
            svn cp ${FILE} ${MANUAL_BASEDIR}/$(basename ${FILE}) --quiet
            cli_replaceTMarkers ${MANUAL_BASEDIR}/$(basename ${FILE})
        fi
    done

    # Update manual chapter related files.
    ${FLAG_BACKEND}_createChapters

    # Update manual chapter related menu.
    ${FLAG_BACKEND}_updateChaptersMenu

    # Update manual chapter related nodes (based on chapter related
    # menu).
    ${FLAG_BACKEND}_updateChaptersNodes

    # Commit changes from working copy to central repository only.  At
    # this point, changes in the repository are not merged in the
    # working copy, but chages in the working copy do are committed up
    # to repository.
    cli_commitRepoChanges ${MANUAL_BASEDIR}

}
