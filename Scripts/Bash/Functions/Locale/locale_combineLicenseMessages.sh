#!/bin/bash
#
# locale_combineLicenseMessages.sh -- This function combines template
# messages with license messages.
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

function locale_combineLicenseMessages {

    if [[ $# -lt 1 ]];then
        cli_printMessage "`gettext "One argument is required."`" --as-error-message
    fi

    local TRANSLATION_INSTANCE=$1
    local TRANSLATION_TEMPLATE=$2

    local DOCBOOK_LOCALES=$(echo $DOCBOOK_MODELS \
        | sed -r 's!^!Locales/!')

    # Define list of all files you want to combine.
    local FILES="${DOCBOOK_LOCALES}/Gpl/${CLI_LANG_LC}/messages.po \
        ${DOCBOOK_LOCALES}/Gfdl/${CLI_LANG_LC}/messages.po \
        ${TRANSLATION_TEMPLATE}"

    # Be sure the files we want to combine do exist.
    cli_checkFiles -e ${FILES}

    # Combine files.
    msgcat --output=${TRANSLATION_INSTANCE} \
        --width=70 --no-location --use-first ${FILES}

}
