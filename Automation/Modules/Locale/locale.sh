#!/bin/bash
######################################################################
#
#   locale.sh -- This module standardizes localization inside the
#   repository.
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

function locale {

    local ACTIONS=''

    # Define flags controlling locale module's file processing. There
    # are three possible values here. Produce localization files for
    # the file you provided in the command-line only (default
    # behavior). --siblings, to produce localization files for all the
    # siblings of the files you provided in the command-line,
    # inclusively. --all, this option makes a recursive inside the
    # directory of the file you provided as argument to the
    # command-line and produces localization files for all files found.
    LOCALE_FLAG_SIBLINGS="false"
    LOCALE_FLAG_ALL="false"

    # Define flags controlling locale module's processing reports.
    LOCALE_FLAG_REPORT='false'

    # Interpret arguments and options passed through command-line.
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

        local ARGUMENT=$(tcar_checkRepoDirSource "${ARGUMENT}")

        if [[ -f ${ARGUMENT} ]];then
            tcar_setModuleEnvironment -m "file" -t "child" "${ARGUMENT}"
        elif [[ -d ${ARGUMENT} ]];then
            tcar_setModuleEnvironment -m "directory" -t "child" "${ARGUMENT}"
        else
            tcar_printMessage "`gettext "The argument provided isn't valid."`" --as-error-line
        fi

    done

}
