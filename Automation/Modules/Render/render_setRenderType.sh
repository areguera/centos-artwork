#!/bin/bash
######################################################################
#
#   render_setRenderType.sh -- This file evaluates a configuration
#   file and determines what kind of rendition to do.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2013
#     Key fingerprint = D67D 0F82 4CBD 90BC 6421  DF28 7CCE 757C 17CA 3951
#
# Copyright (C) 2013 The CentOS Project
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

function render_setRenderType {

    local -a SECTIONS

    # Define motif-specific environment variables, based on
    # configuration file path. These variables might save
    # configuration file writers from typing motif-specific
    # information when they produce motif-specific content. These
    # variables will be empty if the configuration file isn't inside
    # a motif-specific directory structure.
    MOTIF=$(tcar_getPathComponent ${CONFIGURATION} --motif)
    MOTIF_NAME=$(tcar_getPathComponent ${CONFIGURATION} --motif-name)
    MOTIF_VERSION=$(tcar_getPathComponent ${CONFIGURATION} --motif-version)

    # Use arrays to store section names. This make possible to make
    # use of post-rendition and last-rendition concepts. Otherwise it
    # would be difficult to predict information about sections inside
    # deeper environments.
    for SECTION in $(tcar_getConfigSectionNames "${CONFIGURATION}" \
        | egrep ${TCAR_FLAG_FILTER});do
        SECTIONS[((++${#SECTIONS[*]}))]="${SECTION}"
    done

    local COUNTER=0

    while [[ ${COUNTER} -lt ${#SECTIONS[*]} ]];do

        # Initialize array variables locally.
        local -a TRANSLATIONS
        local -a SOURCES
  
        SECTION=${SECTIONS[${COUNTER}]}

        if [[ ${SECTION} =~ "^/" ]];then
            TARGET=${SECTION}
        else
            if [[ ${TCAR_SCRIPT_LANG_LC} =~ '^en' ]];then
                TARGET=$(dirname ${CONFIGURATION})/${SECTION}
            else
                TARGET=$(dirname ${CONFIGURATION})/${TCAR_SCRIPT_LANG_LC}/${SECTION}
            fi
        fi

        RENDER_TYPE=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-type")

        RENDER_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-from")

        for SOURCE in ${RENDER_FROM};do
            if [[ ${SOURCE} =~ "^/" ]];then
                SOURCES[((++${#SOURCES[*]}))]=${SOURCE}
            else
                SOURCES[((++${#SOURCES[*]}))]=$(dirname ${CONFIGURATION})/${SOURCE}
            fi
        done

        if [[ -z ${RENDER_TYPE} ]];then
           RENDER_TYPE=$(echo ${SOURCES[0]} | sed -r 's/.+\.([[:alpha:]]+)$/\1/') 
        fi

        LOCALE_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "locale-from")

        # When the current locale information is not English, don't
        # process section blocks unless they have any related
        # translation file. There is no need to have untranslated
        # content inside language-specific directories.
        if [[ ! ${TCAR_SCRIPT_LANG_LC} =~ '^en' ]];then

            if [[ -z ${LOCALE_FROM}  ]];then

                # Increment array counter.
                COUNTER=$(( ${COUNTER} + 1 ))

                # Reset array variable to avoid undesired
                # concatenations between sections blocks.
                unset TRANSLATIONS
                unset SOURCES

                # Move to next section block.
                continue

            fi

            for TRANSLATION in ${LOCALE_FROM};do
                if [[ ${TRANSLATION} =~ "^/" ]];then
                    TRANSLATIONS[((++${#TRANSLATIONS[*]}))]=${TRANSLATION}
                else
                    TRANSLATIONS[((++${#TRANSLATIONS[*]}))]=$(dirname ${CONFIGURATION})/${TRANSLATION}
                fi
            done

            tcar_checkFiles -ef ${TRANSLATIONS[*]}

        fi

        # Initialize render's modules.
        case ${RENDER_TYPE} in
            "svgz" | "svg" )
                tcar_setModuleEnvironment "svg" "${@}"
                ;;
            * )
                tcar_setModuleEnvironment "${RENDER_TYPE}" "${@}"
                ;;
        esac

        # Increment section's counter.
        COUNTER=$(( ${COUNTER} + 1 ))

        # Reset array variable to avoid undesired concatenations
        # between sections blocks.
        unset TRANSLATIONS
        unset SOURCES

    done

    # Reset array variables and their counters to avoid undesired
    # concatenations between configuration files.
    unset COUNTER
    unset SECTIONS

}
