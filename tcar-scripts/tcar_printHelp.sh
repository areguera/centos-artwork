#!/bin/bash
######################################################################
#
#   tcar_printHelp.sh -- This function standardizes the way
#   tcar.sh script prints help about itself.
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

function tcar_printHelp {

    # Retrieve the man page name. This is the file name you want to retrieve
    # documentation for. This value is optional. When it is not passed, the
    # module name is used. 
    local TCAR_MANPAGE_NAME="${1:-${TCAR_MODULE_NAME}}"

    # When the module name has not been set and the tcar_printHelp
    # function is called from tcar.sh file, the page name come
    # with with --help as opening string and probably as
    # --help=filename.sh. In the first case it prints the script
    # documentation. In the second case it prints documentation for
    # the file specified.
    if [[ -z ${TCAR_MODULE_NAME} ]];then
        if [[ ${TCAR_MANPAGE_NAME} =~ '^--help=[[:alnum:]_-.]+' ]];then
            TCAR_MANPAGE_NAME=$(echo ${TCAR_MANPAGE_NAME} | cut -d'=' -f2)
        else
            TCAR_MANPAGE_NAME=${TCAR_SCRIPT_NAME}
        fi
    fi

    # Print requested documentation. 
    /usr/bin/man -M ${TCAR_SCRIPT_DIR_MANUALS}:${TCAR_MODULE_DIR_MANUALS}/Final "${TCAR_MANPAGE_NAME}"

    # Finish script execution successfully.
    exit 0

}
