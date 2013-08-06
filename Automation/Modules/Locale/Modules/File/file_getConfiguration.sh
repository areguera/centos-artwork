#!/bin/bash
function file_getConfiguration {

    # Define the rendition do you want to perform.
    local RENDER_TYPE=${FILE_EXTENSION}

    # Define the translation file you want to use.
    local -a TRANSLATIONS
    TRANSLATIONS[0]=${PO_FILE}

    # Define translation file. This is from which translatable strings
    # will be retrieved.
    local -a SOURCES
    for SOURCE in ${RENDER_FROM};do
        SOURCES[((++${#SOURCES[*]}))]=${SOURCE}
    done

    # Process configuration variables through locale's actions module.
    tcar_setModuleEnvironment "actions" "${@}"

}
