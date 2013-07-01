#!/bin/bash
#
# render_setBrandsDirVerification.sh -- This function standardize path
# verification between path provided in the command line and
# repository directory structure.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------


function render_setBrandsDirValidates {

    local BRANDS_PATH_OK=$(cli_checkRepoDirSource ${1})
    local BRANDS_PATH_UNKNOWN=$(cli_checkRepoDirSource ${2})

    cli_checkFiles ${BRANDS_PATH_UNKNOWN} --match="^${BRANDS_PATH_OK}"

    local BRANDS_PATH_UNKNOWN_MODEL=$(echo ${BRANDS_PATH_UNKNOWN} \
        | sed -r "s,/Images/,/Models/,")

    cli_checkFiles ${BRANDS_PATH_UNKNOWN_MODEL} -d

}
