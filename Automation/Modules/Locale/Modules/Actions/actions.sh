#!/bin/bash

function actions {

    local LOCALE_ACTION=''

    for LOCALE_ACTION in ${LOCALE_ACTIONS};do
        tcar_setModuleEnvironment "${LOCALE_ACTION}" "${@}"
    done

}
