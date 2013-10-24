#!/bin/bash
######################################################################
#
#   render.sh -- This function standardizes the way source files are
#   processed inside the working copy.
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

function render {

    # Define flag to control whether final content is produced inside
    # locale directories or not.
    RENDER_NO_LOCALE_DIR='false'

    # Interpret arguments and options passed through command-line.
    render_getOptions

    # Define action value. We use non-option arguments to define the
    # action value (ACTIONVAL) variable.
    for ARGUMENT in ${TCAR_MODULE_ARGUMENT};do

        # Sanitate non-option arguments to be sure they match the
        # directory conventions established by centos-art.sh script
        # against source directory locations in the working copy.
        local ARGUMENT=$(tcar_checkRepoDirSource ${ARGUMENT})

        if [[ -d ${ARGUMENT} ]];then
            tcar_setModuleEnvironment -m 'directories' -t 'child' -g ${ARGUMENT}
        elif [[ -f ${ARGUMENT} ]] && [[ ${ARGUMENT} =~ '\.conf$' ]];then
            tcar_setModuleEnvironment -m 'files' -t 'child' -g ${ARGUMENT}
        else
            tcar_printMessage "${ARGUMENT} `gettext "isn't supported."`" --as-error-line
        fi

    done

}
