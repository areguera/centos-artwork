#!/bin/bash

function edit {

    local TRANSLATION=''

    for TRANSLATION in ${TRANSLATIONS[*]};do
        tcar_printMessage "${TRANSLATION}" --as-editing-line
        ${TCAR_USER_EDITOR} ${TRANSLATION}
    done

}
