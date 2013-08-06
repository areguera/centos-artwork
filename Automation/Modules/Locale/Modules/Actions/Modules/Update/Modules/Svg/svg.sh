#!/bin/bash

function svg {

    local SVG_FILE=''

    for SVG_FILE in ${SOURCES[*]};do

        # Define POT's default location using the source file as
        # reference. The portable object template is
        # locale-independent so it must be out of locale-specific
        # directories.
        local POT_FILE=${SVG_FILE}.pot

        tcar_printMessage "${POT_FILE}" --as-creating-line

        local SVG_INSTANCE=$(tcar_getTemporalFile $(basename ${SVG_FILE}))

        svg_createSvgInstance

        update_convertXmlToPot "${SVG_INSTANCE}" "${POT_FILE}"

        # Verify, initialize or merge portable objects from portable
        # object templates.
        update_convertPotToPo "${POT_FILE}" "${PO_FILE}"

    done



}
