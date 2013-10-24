#!/bin/bash
######################################################################
#
#   file.sh -- This module sets file-specific information needed by
#   localization actions and executes the actions requested through
#   the command-line.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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
######################################################################

function files {

    # Define absolute path of argument passed in the command-line.
    local RENDER_FROM=$(tcar_checkRepoDirSource "${1}")

    # Verify the argument passed in the command-line is a regular
    # file.
    tcar_checkFiles -ef ${RENDER_FROM}

    # Retrieve the file extension of argument provided in the
    # command-line.
    local RENDER_TYPE=$(echo ${RENDER_FROM} | sed -r 's/.+\.([[:alnum:]]+)$/\1/')

    # Define location where final content will be stored. This is
    # required for producing docbook document that contain relative
    # paths inside (e.g., relative calls to image files) correctly.
    RENDER_TARGET=$(dirname ${RENDER_FROM})/Final/${TCAR_SCRIPT_LANG_LC}

    # Define absolute path of directory holding localization files.
    local LOCALE_FROM=$(dirname ${RENDER_FROM})/Locales
    if [[ ! -d ${LOCALE_FROM} ]];then
        mkdir ${LOCALE_FROM}
    fi

    # Define package name written in POT and PO files. This is the
    # name of the initialization file you provided as argument to the
    # command line to provide localization for.
    local PACKAGE_NAME=$(basename ${RENDER_FROM})

    # Define package version written in POT and PO files. The script
    # version is used here.  Modules doesn't have a version by now.
    # They share the same version of the centos-art.sh script.
    local PACKAGE_VERSION=${TCAR_SCRIPT_VERSION}

    # Define absolute path to portable and machine objects.
    local POT_FILE=$(tcar_getTemporalFile "${PACKAGE_NAME}.pot")
    local PO_FILE=${LOCALE_FROM}/${TCAR_SCRIPT_LANG_LC}/${PACKAGE_NAME}.po
    local MO_FILE=${LOCALE_FROM}/${TCAR_SCRIPT_LANG_LC}/LC_MESSAGES/${PACKAGE_NAME}.mo

    # Execute actions using the variables defined here as reference.
    for ACTION in ${ACTIONS};do
        tcar_setModuleEnvironment -m "${ACTION}" -t 'child'
    done

}
