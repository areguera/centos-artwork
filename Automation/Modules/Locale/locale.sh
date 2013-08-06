#!/bin/bash
######################################################################
#
#   Initialize the locale module. This module let you edit, delete and
#   create/update translation files using gettext procedures. The
#   translation files produced by this module are used by render
#   module to produce localized images, documentation and automation
#   scripts output messages.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#     Key fingerprint = D67D 0F82 4CBD 90BC 6421  DF28 7CCE 757C 17CA 3951
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

    # Interpret arguments and options passed through command-line.
    locale_getOptions "${@}"

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "${TCAR_ARGUMENTS}"

    # Verify current locale information to avoid English messages from
    # being localized to themselves.  The English language is used as
    # reference to write translatable strings inside the source files.
    if [[ ${TCAR_SCRIPT_LANG_LC} =~ '^en' ]];then
        tcar_printMessage "`gettext "The English language cannot be localized to itself."`" --as-error-line
    fi

    # Process arguments passed to locale module, based on whether they
    # are files or directories.
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
