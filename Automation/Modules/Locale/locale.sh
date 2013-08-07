#!/bin/bash

function locale {

    locale_getOptions "${@}"

    eval set -- "${TCAR_ARGUMENTS}"

    if [[ ${TCAR_SCRIPT_LANG_LC} =~ '^en' ]];then
        tcar_printMessage "`gettext "The English language cannot be localized to itself."`" --as-error-line
    fi

    for ARGUMENT in ${@};do
        ARGUMENT=$(tcar_checkRepoDirSource "${ARGUMENT}")
        if [[ -f ${ARGUMENT} ]];then
            tcar_setModuleEnvironment "file" "${@}"
        elif [[ -d ${ARGUMENT} ]];then
            tcar_setModuleEnvironment "directory" "${@}"
        else
            tcar_printMessage "`gettext "The argument provided isn't valid."`" --as-error-line
        fi
    done

}
