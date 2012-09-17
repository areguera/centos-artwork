#!/bin/bash
#
# locale_combineLicenseMessages.sh -- This function combines template
# messages with license messages.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

    local TRANSLATION_INSTANCE=$1
    local TRANSLATION_TEMPLATE=$2

    if [[ $# -lt 1 ]];then
        cli_printMessage "`gettext "One argument is required."`" --as-error-message
    fi

    # Define list of all files you want to combine.
    local FILES="${DOCBOOK_MODELS_LOCALES_DIR}/Gpl/$(locale_getCurrentLocale)/messages.po \
        ${DOCBOOK_MODELS_LOCALES_DIR}/Gfdl/$(locale_getCurrentLocale)/messages.po \
        ${TRANSLATION_TEMPLATE}"

    # Be sure the files we want to combine do exist.
    cli_checkFiles ${FILES}

    # Combine files.
    msgcat --output=${TRANSLATION_INSTANCE} \
        --width=70 --no-location --use-first ${FILES}

}
