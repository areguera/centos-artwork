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

# Process configuration files provided as argument in the command-line
# to locale command. Basically, it redefines values previously set in
# the files-related function using the configuration file provided in
# the command-line.
function conf {

    local CONFIGURATION=${RENDER_FROM}

    # Use arrays to store section names. This make possible to make
    # use of post-rendition and last-rendition concepts. Otherwise it
    # would be difficult to predict information about sections inside
    # deeper environments.
    local -a SECTIONS
    for SECTION in $(tcar_getConfigSectionNames "${CONFIGURATION}" \
        | egrep ${TCAR_FLAG_FILTER});do
        SECTIONS[++${#SECTIONS[*]}]="${SECTION}"
    done

    # Verify the configuration file has one section entry at least.
    if [[ ${#SECTIONS[*]} -eq 0 ]];then
        tcar_printMessage "`eval_gettext "No section definition was found in \\\$CONFIGURATION."`" --as-error-line
    fi

    local COUNTER=0

    while [[ ${COUNTER} -lt ${#SECTIONS[*]} ]];do

        local SECTION=${SECTIONS[${COUNTER}]}

        local RENDER_TYPE=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-type")
        if [[ -z ${RENDER_TYPE} ]];then
            tcar_printMessage "${CONFIGURATION} `gettext "hasn't render-type set in."`" --as-error-line
        fi

        local RENDER_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-from")
        if [[ -z ${RENDER_FROM} ]];then
            tcar_printMessage "${CONFIGURATION} `gettext "hasn't render-from set in."`" --as-error-line
        fi
        if [[ ! ${RENDER_FROM} =~ "^/" ]];then
            RENDER_FROM=$(dirname ${CONFIGURATION})/${RENDER_FROM}
        fi

        local RENDER_FLOW=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-flow")
        if [[ -z ${RENDER_FLOW} ]];then
            tcar_printMessage "${CONFIGURATION} `gettext "hasn't render-flow set in."`" --as-error-line
        fi

        local LOCALE_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "locale-from")
        if [[ -z ${LOCALE_FROM} ]];then
            tcar_printMessage "${CONFIGURATION} `gettext "hasn't locale-from set in."`" --as-error-line
        fi
        if [[ ! ${LOCALE_FROM} =~ "^/" ]];then
            LOCALE_FROM=$(dirname ${CONFIGURATION})/${LOCALE_FROM}
        fi

        # Re-define package name written in POT and PO files. This is
        # the name of the initialization file you provided as argument
        # to the command line to provide localization for.
        local PACKAGE_NAME=$(basename ${RENDER_FROM})

        # Re-define absolute path to portable and machine objects.
        local POT_FILE=$(tcar_getTemporalFile "${PACKAGE_NAME}.pot")
        local PO_FILE=${LOCALE_FROM}
        local MO_FILE=$(dirname ${RENDER_FROM})/Locales/${TCAR_SCRIPT_LANG_LC}/LC_MESSAGES/${PACKAGE_NAME}.mo

        # Execute type-specific module for processing files.
        tcar_setModuleEnvironment -m "${RENDER_TYPE}" -t "sibling"

        # Increment section's counter.
        COUNTER=$(( ${COUNTER} + 1 ))

    done

    # Reset array variables and their counters to avoid undesired
    # concatenations between configuration files.
    unset COUNTER
    unset SECTIONS

}
