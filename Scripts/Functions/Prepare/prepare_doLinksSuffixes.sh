#!/bin/bash
#
# prepare_doLinksSuffixes.sh -- This function uses the first argument
# passed as reference to build the link suffix required by
# prepare_doLinks function.
#
# Copyright (C) 2009-2011 The CentOS Project
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

function prepare_doLinksSuffixes {

    local FILE="$1"
    local SUFFIX='centos-'

    if [[ "$FILE" =~ "$(cli_getPathComponent '--theme-pattern')" ]];then
        SUFFIX="${SUFFIX}$(cli_getRepoName "$(cli_getPathComponent "$FILE" '--theme-name')" 'f')-"
        SUFFIX="${SUFFIX}$(cli_getPathComponent "$FILE" '--theme-release')-"
    fi

    echo "${SUFFIX}"

}
