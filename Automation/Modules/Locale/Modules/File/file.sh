#!/bin/bash

function file {

    local FILE=$(tcar_checkRepoDirSource "${1}")

    tcar_checkFiles -ef ${FILE}

    local FILE_NAME="$(basename ${FILE})"

    local FILE_EXTENSION=$(echo ${FILE} | sed -r 's/.+\.([[:alnum:]]+)$/\1/')

    local DIRECTORY=$(dirname ${FILE})

    local RENDER_FROM=$(tcar_getFilesList ${DIRECTORY} \
        --pattern="^.+/.+\.${FILE_EXTENSION}$" --type="f")

    local LOCALE_FROM=${DIRECTORY}/Locales

    local POT_FILE=${LOCALE_FROM}/${FILE_NAME}.pot
    local PO_FILE=${LOCALE_FROM}/${TCAR_SCRIPT_LANG_LC}/${FILE_NAME}.po
    local MO_FILE=${LOCALE_FROM}/${TCAR_SCRIPT_LANG_LC}/LC_MESSAGES/${FILE_NAME}.mo

    # The locale's action modules relay in specific environment
    # variables for working. From this point on we set such
    # variable's name convention, using the information set above.
    file_getConfiguration

}
