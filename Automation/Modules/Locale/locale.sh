#!/bin/bash
######################################################################
#
#   locale.sh -- This module standardizes localization inside the
#   repository.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

    locale_getOptions "${@}"

    eval set -- "${TCAR_ARGUMENTS}"

    if [[ ${TCAR_SCRIPT_LANG_LC} =~ '^en' ]];then
        tcar_printMessage "`gettext "The English language cannot be localized to itself."`" --as-error-line
    fi

    for ARGUMENT in ${@};do
        ARGUMENT=$(tcar_checkRepoDirSource "${ARGUMENT}")
        if [[ -f ${ARGUMENT} ]];then
            tcar_setModuleEnvironment "file" "${@}"
        elif [[ -d ${ARGUMENT} ]];then
            tcar_setModuleEnvironment "directory" "${@}"
        else
            tcar_printMessage "`gettext "The argument provided isn't valid."`" --as-error-line
        fi
    done

}
