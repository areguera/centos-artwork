#!/bin/bash

function locale_setLocaleType {

    local SECTION=''
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
  
        local SECTION=${SECTIONS[${COUNTER}]}

        local RENDER_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-from")
        for SOURCE in ${RENDER_FROM};do
            if [[ ${SOURCE} =~ "^/" ]];then
                SOURCES[((++${#SOURCES[*]}))]=${SOURCE}
            else
                SOURCES[((++${#SOURCES[*]}))]=$(dirname ${CONFIGURATION})/${SOURCE}
            fi
        done
        
        local RENDER_TYPE=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-type")
        if [[ -z ${RENDER_TYPE} ]];then
           RENDER_TYPE=$(echo ${SOURCES[0]} | sed -r 's/.+\.([[:alpha:]]+)$/\1/') 
        fi

        local LOCALE_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "locale-from")
        for TRANSLATION in ${LOCALE_FROM};do
            if [[ ${TRANSLATION} =~ "^/" ]];then
                TRANSLATIONS[((++${#TRANSLATIONS[*]}))]=${TRANSLATION}
            else
                TRANSLATIONS[((++${#TRANSLATIONS[*]}))]=$(dirname ${CONFIGURATION})/${TRANSLATION}
            fi
        done

        RENDER_FLOW=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-flow")
        if [[ -z ${RENDER_FLOW} ]];then
            RENDER_FLOW='article'
        fi

        PO_FILE=${TRANSLATIONS[0]}

        # Initialize locale's modules.
        for LOCALE_ACTION in ${LOCALE_ACTIONS};do
            tcar_setModuleEnvironment "${LOCALE_ACTION}" "${@}"
        done

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
