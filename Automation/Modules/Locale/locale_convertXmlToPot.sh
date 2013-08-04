#!/bin/bash
function locale_convertXmlToPot {

    local XML_FILE=${1}
    local POT_FILE=${2}

    cat ${XML_FILE} | xml2po -a -l ${TCAR_SCRIPT_LANG_LC} - \
        | msgcat --output-file=${POT_FILE} --width=70 --no-location -

}
