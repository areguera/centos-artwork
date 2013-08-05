#!/bin/bash
function locale_setFileProcessing {

    local FILE=$(tcar_checkRepoDirSource "${1}")

    local FILE_NAME="$(basename ${FILE})"

    local FILE_EXTENSION=$(echo ${FILE} | sed -r 's/.+\.([[:alnum:]]+)$/\1/')

    local DIRECTORY=$(dirname ${FILE})

    local RENDER_FROM=$(tcar_getFilesList ${DIRECTORY} \
        --pattern="^.+/.+\.${FILE_EXTENSION}$" --type="f")

    local LOCALE_FROM=${DIRECTORY}/Locales

    local POT_FILE=${LOCALE_FROM}/${FILE_NAME}.pot
    local PO_FILE=${LOCALE_FROM}/${TCAR_SCRIPT_LANG_LC}/${FILE_NAME}.po
    local MO_FILE=${LOCALE_FROM}/${TCAR_SCRIPT_LANG_LC}/LC_MESSAGES/${FILE_NAME}.mo

    # The locale's modules require specific environment variables we
    # need to define here in order for such modules to work as
    # expected. From this point on we set such variables using the
    # information set above.

    local RENDER_TYPE=${FILE_EXTENSION}

    local -a TRANSLATIONS
    TRANSLATIONS[0]=${PO_FILE}

    for SOURCE in ${RENDER_FROM};do
        SOURCES[((++${#SOURCES[*]}))]=${SOURCE}
    done

    # Initialize locale's action modules.
    for LOCALE_ACTION in ${LOCALE_ACTIONS};do
        tcar_setModuleEnvironment "${LOCALE_ACTION}" "${@}"
    done

}
