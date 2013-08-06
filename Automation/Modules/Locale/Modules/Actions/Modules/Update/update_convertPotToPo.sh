#!/bin/bash

function update_convertPotToPo {

    local POT_FILE="${1}"
    local PO_FILE="${2}"

    # Verify the portable object template. The portable object
    # template is used to create the portable object. We cannot
    # continue without it. 
    tcar_checkFiles -ef ${POT_FILE}

    # Create the PO's parent directory if it doesn't exist.
    if [[ ! -d $(dirname ${PO_FILE}) ]];then
        mkdir -p $(dirname ${PO_FILE})
    fi

    # Print action message.
    tcar_printMessage "${PO_FILE}" --as-creating-line

    # Verify existence of portable object. The portable object is the
    # file translators edit in order to make translation works.
    if [[ -f ${PO_FILE} ]];then

        # Update portable object merging both portable object and
        # portable object template.
        msgmerge --output-file="${PO_FILE}" "${PO_FILE}" "${POT_FILE}" --quiet

    else

        # Initiate portable object using portable object template.
        # Do not print msginit sterr output, use centos-art action
        # message instead.
        msginit -i ${POT_FILE} -o ${PO_FILE} --width=70 \
            --no-translator > /dev/null 2>&1

    fi

    # Sanitate metadata inside the PO file.
    update_setPoMetadata "${PO_FILE}"

}
