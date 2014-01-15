#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Standardize localization tasks.  The locale command provides three
# ways of producing localization files:
#
#   1. Produce localization for one file only (when a regular file is
#   provided as argument in the command-line),
#
#   2. Produce localization files for all files in the current
#   directory you provided in the command-line (when a directory is
#   provided as argument), and
#
#   3. Produce localization files for all files in the current
#   directory recursively (when a directory is provided as argument in
#   the command-line and the --recursive option is also provided).
function locale {

    # Define flags controlling they way locale module produce
    # localization files.
    local LOCALE_FLAG_RECURSIVE="false"

    # Initialize module's actions.
    local ACTIONS=''

    # Redefine module's actions based on arguments passed through
    # command-line.
    locale_getOptions

    # Verify the current locale information to avoid English messages
    # from being localized to themselves. The English language is used
    # as reference to write translatable strings inside the source
    # files.
    if [[ ${TCAR_SCRIPT_LANG_LC} =~ '^C$' ]];then
        tcar_printMessage "`gettext "The C locale cannot be localized to itself."`" --as-error-line
    fi

    # Process arguments passed to locale module, based on whether they
    # are files or directories.
    for ARGUMENT in ${TCAR_MODULE_ARGUMENT};do

        local ARGUMENT=$(tcar_printPath "${ARGUMENT}")

        if [[ -f ${ARGUMENT} ]];then
            tcar_setModuleEnvironment -m "files" -t "child" -g "${ARGUMENT}"
        elif [[ -d ${ARGUMENT} ]];then
            tcar_setModuleEnvironment -m "directories" -t "child" -g "${ARGUMENT}"
        else
            tcar_printMessage "`gettext "The argument provided isn't valid."`" --as-error-line
        fi

    done

}
