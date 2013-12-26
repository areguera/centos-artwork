#!/bin/bash
######################################################################
#
#   prepare.sh -- This module standardizes configuration tasks related
#   to repository workplace.
#
#   When you install The CentOS Artwork Repository most of its content
#   is in source format. In order to produce final content and make
#   the connections between the produced components, you need to
#   process the source formats somewhere inside your workstation.
#   This module takes the first non-option argument passed in the
#   command-line as the workplace where you are going to process
#   source formats in your workstation. During the preparation
#   process, this module creates the workplace directory structure,
#   the workplace connection with The CentOS Artwork Repository using
#   symbolic links, and images required to brand other images.
#
#   This module should be the first module you run in your workstation
#   after installing The CentOS Artwork Repository.
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

    prepare_getOptions

    # Define absolute path to workplace. The workplace is where final
    # images produced from source files will be stored and organized
    # in.
    local TCAR_WORKPLACE=${TCAR_SCRIPT_ARGUMENT}

    prepare_setWorkplace

}
