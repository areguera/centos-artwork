#!/bin/bash

function edit {

    local TRANSLATION=''

    for TRANSLATION in ${TRANSLATIONS[*]};do
        tcar_printMessage "${TRANSLATION}" --as-editing-line
        tcar_checkFiles -ef "${TRANSLATION}"
        ${TCAR_USER_EDITOR} ${TRANSLATION}
    done

}
