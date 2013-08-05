#!/bin/bash

function delete {

    local TRANSLATION=''
    
    for TRANSLATION in ${TRANSLATIONS[*]};do
        tcar_printMessage "${TRANSLATION}" --as-deleting-line
        tcar_checkFiles -ef ${TRANSLATION}
        /bin/rm ${TRANSLATION}
    done


}
