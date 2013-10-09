#!/bin/bash
######################################################################
#
#   directory_getConfiguration.sh -- This function retrieves options
#   from configuration files and process them accordingly.
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

function directory_getConfiguration {

    local CONFIGURATION="${1}"
    local SECTION=''
    local -a SECTIONS

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

    local COUNTER=0

    while [[ ${COUNTER} -lt ${#SECTIONS[*]} ]];do

        # Initialize array variables locally.
        local -a TRANSLATIONS
        local -a SOURCES
        local SOURCE=''

        local SECTION=${SECTIONS[${COUNTER}]}

        local RENDER_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-from")
        for SOURCE in ${RENDER_FROM};do
            if [[ ${SOURCE} =~ "^/" ]];then
                SOURCES[++${#SOURCES[*]}]=${SOURCE}
            else
                SOURCES[++${#SOURCES[*]}]=$(dirname ${CONFIGURATION})/${SOURCE}
            fi
        done
        
        local RENDER_TYPE=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-type")
        if [[ -z ${RENDER_TYPE} ]];then
           RENDER_TYPE=$(echo ${SOURCES[0]} | sed -r 's/.+\.([[:alpha:]]+)$/\1/') 
        fi

        local LOCALE_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "locale-from")
        for TRANSLATION in ${LOCALE_FROM};do
            if [[ ${TRANSLATION} =~ "^/" ]];then
                TRANSLATIONS[++${#TRANSLATIONS[*]}]=${TRANSLATION}
            else
                TRANSLATIONS[++${#TRANSLATIONS[*]}]=$(dirname ${CONFIGURATION})/${TRANSLATION}
            fi
        done

        local RENDER_FLOW=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-flow")
        if [[ -z ${RENDER_FLOW} ]];then
            RENDER_FLOW='article'
        fi

        local PO_FILE=${TRANSLATIONS[0]}

        # Define package name written in POT and PO files. This is the
        # name of the initialization file you provided as argument to
        # the command line to provide localization for.
        local PACKAGE_NAME=$(basename ${SOURCES[0]})

        # Define package version written in POT and PO files. The
        # script version is used here.  Modules doesn't have a version
        # by now. They share the same version of the centos-art.sh
        # script.
        local PACKAGE_VERSION=${TCAR_SCRIPT_VERSION}

        # Initialize locale's actions module.
        tcar_setModuleEnvironment -m "actions" -t "sibling"

        # Increment section's counter.
        COUNTER=$(( ${COUNTER} + 1 ))

        # Reset array variables to prevent section-specific
        # information from being concatenated to other sections.
        unset SOURCES
        unset TRANSLATIONS

    done

    # Print report about how many files were processed.
    if [[ ${LOCALE_FLAG_REPORT} == 'true' ]];then
        local TOTAL_FILES_PROCESSED=${#SECTIONS[*]}
        tcar_printMessage "`eval_ngettext "Translatable strings were extracted from \\\$TOTAL_FILES_PROCESSED file." \
                                          "Translatable strings were extracted from \\\$TOTAL_FILES_PROCESSED files." \
                                          ${TOTAL_FILES_PROCESSED}`" --as-banner-line
    fi

    # Reset array variables and their counters to avoid undesired
    # concatenations between configuration files.
    unset COUNTER
    unset SECTIONS

}
