#!/bin/bash

function locale_editPoFiles {

    local TRANSLATIONS="${1}"
    local TRANSLATION=''

    for TRANSLATION in ${TRANSLATIONS};do
        tcar_printMessage "${TRANSLATION}" --as-editing-line
        ${TCAR_USER_EDITOR} ${TRANSLATION}
    done


}
