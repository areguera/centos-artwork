#!/bin/bash
######################################################################
#
#   prepare.sh -- This function standardizes configuration tasks
#   needed by files inside the working copy.  
#
#   When you download a fresh working copy of CentOS artwork
#   repository, most of its content is in source format. You need to
#   process source formats in order to produce final content and make
#   the connections between components (e.g., render brand images so
#   they can be applied to other images). This function takes care of
#   those actions and should be the first module you run in your
#   workstation after downloading a fresh working copy of CentOS
#   artwork repository.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#     Key fingerprint = D67D 0F82 4CBD 90BC 6421  DF28 7CCE 757C 17CA 3951
#
# Copyright (C) 2009-2013 The CentOS Project
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

function prepare {

    # Initialize module-specific configuration values.
    if [[ -f ${MODULE_DIR}/${MODULE_NAME}.conf ]];then
        . ${MODULE_DIR}/${MODULE_NAME}.conf
    fi

    # Interpret arguments and options passed through command-line.
    prepare_getOptions "${@}"

    # Reset positional parameters on this function, using output
    # produced from (getopt) arguments parser.
    eval set -- "${TCAR_ARGUMENTS}"

    # Execute module-specific actions.
    for MODULE_ACTION in ${MODULE_ACTIONS};do
        ${MODULE_ACTION} "${@}"
    done

}
