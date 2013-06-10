#!/bin/bash
#
# cli_getLocalizationDir.sh -- This function standardizes the way
# localization paths are created. The first argument of this function
# must be a path pointing a directory inside the repository.
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

function cli_getLocalizationDir {

    # Sanitate non-option arguments to be sure they match the
    # directory conventions established by centos-art.sh script
    # against source directory locations in the working copy.
    LOCATION=$(cli_checkRepoDirSource "${1}")

    # Make path transformation.
    case "${2}" in

        '--no-lang')
            LOCATION=$(echo "${LOCATION}" \
                | sed -r -e "s!(Identity|Scripts|Documentation)!Locales/\1!")
            ;;

        * )
            LOCATION=$(echo "${LOCATION}" \
                | sed -r -e "s!(Identity|Scripts|Documentation)!Locales/\1!")/${CLI_LANG_LC}
            ;;

    esac 

    # Output transformed path.
    echo "${LOCATION}"

}
