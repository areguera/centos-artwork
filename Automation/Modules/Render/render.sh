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

    # Interpret arguments and options passed through command-line.
    render_getOptions "${@}"

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "${TCAR_ARGUMENTS}"

    # Define action value. We use non-option arguments to define the
    # action value (ACTIONVAL) variable.
    for ARGUMENT in "${@}";do

        # Sanitate non-option arguments to be sure they match the
        # directory conventions established by centos-art.sh script
        # against source directory locations in the working copy.
        ARGUMENT=$(tcar_checkRepoDirSource ${ARGUMENT})

        # Retrieve list of configuration files from directory.
        if [[ -d ${ARGUMENT} ]];then
            CONFIGURATIONS=$(tcar_getFilesList ${ARGUMENT} \
                --pattern=".+/.+\.conf$" --type="f")
        else
            CONFIGURATIONS=${ARGUMENT}
        fi

        # Verify non-option arguments passed to centos-art.sh
        # command-line. The path provided as argument must exist in
        # the repository.  Otherwise, it would be possible to create
        # arbitrary directories inside the repository without any
        # meaning. In order to be sure all required directories are
        # available in the repository it is necessary use the prepare
        # functionality.
        tcar_checkFiles -ef ${CONFIGURATIONS}

        # Process each configuration file.
        for CONFIGURATION in ${CONFIGURATIONS};do
            render_setRenderType "${@}"
        done

    done

}
