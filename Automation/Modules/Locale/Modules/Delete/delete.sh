#!/bin/bash

function delete {

    local TRANSLATION=''
    
    for TRANSLATION in ${TRANSLATIONS[*]};do
        tcar_printMessage "${TRANSLATION}" --as-deleting-line
        /bin/rm ${TRANSLATION}
    done


}
