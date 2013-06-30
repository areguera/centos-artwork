#!/bin/bash
#
# render_setThemeDirectoryStructre.sh -- This function verifies
# theme-specific directory structures using common theme models
# directory structure as pattern. If there are missing directories inside
# theme-specific directories, this function will create it.  This is a
# requisite of rendition process, so be sure to call this function
# before building the list of render-able theme directories.
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


function render_setThemesDirStructure {

    local THEMES_SOURCE_DIR=$(cli_checkRepoDirSource "${1}")
    local THEMES_TARGET_DIR=$(cli_checkRepoDirSource "${2}")

    local THEMES_FILTER=${THEMES_TARGET_DIR}/$(cli_getPathComponent --motif ${ACTIONVAL})

    THEMES_TARGET_DIRS=$(cli_getFilesList ${THEMES_TARGET_DIR} \
        --pattern=".+/[[:digit:]]+$" --maxdepth=2 --mindepth=2 \
        | grep "${THEMES_FILTER}")

    for THEMES_TARGET_DIR in $THEMES_TARGET_DIRS;do
        cli_printMessage "$THEMES_TARGET_DIR `gettext "directory structure..."`" --as-checking-line
        cli_runFnEnvironment prepare ${THEMES_SOURCE_DIR} ${THEMES_TARGET_DIR} --directories
    done

}
