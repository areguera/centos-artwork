#!/bin/bash

function locale_deletePoFiles {

    local TRANSLATIONS="${1}"
    local TRANSLATION=''

    for TRANSLATION in ${TRANSLATIONS};do
        tcar_printMessage "${TRANSLATION}" --as-deleting-line
        /bin/rm ${TRANSLATION}
    done

}
