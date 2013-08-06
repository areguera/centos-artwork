#!/bin/bash

function locale_convertPoToMo {

    # Print action message.
    tcar_printMessage "${MO_FILE}" --as-creating-line

    # Verify absolute path to machine object directory, if it doesn't
    # exist create it.
    if [[ ! -d $(dirname ${MO_FILE}) ]];then
        mkdir -p $(dirname ${MO_FILE})
    fi

    # Create machine object from portable object.
    msgfmt --check ${PO_FILE} --output-file=${MO_FILE}

}
