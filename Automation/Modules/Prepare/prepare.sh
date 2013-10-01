#!/bin/bash
######################################################################
#
#   prepare.sh -- This module standardizes repository configuration
#   tasks.
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

function prepare {

    local ACTION=''
    local ACTIONS=''

    prepare_getOptions

    if [[ -z ${ACTIONS} ]];then
        ACTIONS='packages locales images docs links'
    fi

    for ACTION in ${ACTIONS};do
        tcar_setModuleEnvironment -m "${ACTION}" -t "sub-module"
    done

}
