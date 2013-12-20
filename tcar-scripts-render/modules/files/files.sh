#!/bin/bash
######################################################################
#
#   files.sh -- This module initializes processing of configuration
#   files when the argument passed in the command-line points to a
#   regular file or symbolic link.
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

function files {

    local CONFIGURATION=$(tcar_checkRepoDirSource "${1}")

    local -a SECTIONS
    local SECTION=''

    # Define motif-specific environment variables, based on
    # configuration file path. These variables might save
    # configuration file writers from typing motif-specific
    # information when they produce motif-specific content. These
    # variables will be empty if the configuration file isn't inside
    # a motif-specific directory structure.
    local MOTIF=$(tcar_getPathComponent ${CONFIGURATION} --motif)
    local MOTIF_NAME=$(tcar_getPathComponent ${CONFIGURATION} --motif-name)
    local MOTIF_VERSION=$(tcar_getPathComponent ${CONFIGURATION} --motif-version)

    # Use arrays to store section names. This make possible to make
    # use of post-rendition and last-rendition concepts. Otherwise it
    # would be difficult to predict information about sections inside
    # deeper environments.
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

        # Initialize array variables locally.
        local -a TRANSLATIONS
        local -a SOURCES
  
        SECTION=${SECTIONS[${COUNTER}]}

        if [[ ${SECTION} =~ "^/" ]];then
            RENDER_TARGET=${SECTION}
        else
            RENDER_TARGET=$(dirname ${CONFIGURATION})/Final/${TCAR_SCRIPT_LANG_LC}/${SECTION}
        fi

        RENDER_TYPE=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-type")
        if [[ -z ${RENDER_TYPE} ]];then
            tcar_printMessage "${CONFIGURATION} `gettext "hasn't render-type set in."`" --as-error-line
        fi

        RENDER_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-from")
        if [[ -z ${RENDER_TYPE} ]];then
            tcar_printMessage "${CONFIGURATION} `gettext "hasn't render-from set in."`" --as-error-line
        fi

        for SOURCE in ${RENDER_FROM};do
            if [[ ${SOURCE} =~ "^/" ]];then
                SOURCES[++${#SOURCES[*]}]=${SOURCE}
            else
                SOURCES[++${#SOURCES[*]}]=$(dirname ${CONFIGURATION})/${SOURCE}
            fi
        done

        if [[ -z ${RENDER_TYPE} ]];then
           RENDER_TYPE=$(echo ${SOURCES[0]} | sed -r 's/.+\.([[:alpha:]]+)$/\1/') 
        fi

        LOCALE_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "locale-from")
        if [[ -z ${LOCALE_FROM} ]] || [[ ${LOCALE_FROM} == 'no-locale' ]] ;then
            RENDER_FLAG_NO_LOCALE='true'
            RENDER_TARGET=$(echo ${RENDER_TARGET} | sed "s,${TCAR_SCRIPT_LANG_LC}/,,")
        else
            for TRANSLATION in ${LOCALE_FROM};do
                if [[ ${TRANSLATION} =~ "^/" ]];then
                    TRANSLATIONS[++${#TRANSLATIONS[*]}]=${TRANSLATION}
                else
                    TRANSLATIONS[++${#TRANSLATIONS[*]}]=$(dirname ${CONFIGURATION})/${TRANSLATION}
                fi
            done
        fi

        # Execute module for processing type-specific files.
        tcar_setModuleEnvironment -m "${RENDER_TYPE}" -t "child"

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

    # Tuneup final files.
    tcar_setModuleEnvironment -m 'tuneup' -t 'parent' -g $(dirname ${RENDER_TARGET})

}
