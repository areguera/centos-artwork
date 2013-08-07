#!/bin/bash

function actions {

    local ACTION=''

    for ACTION in ${ACTIONS};do
        tcar_setModuleEnvironment "${ACTION}" "${@}"
    done

}
