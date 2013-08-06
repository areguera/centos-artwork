#!/bin/bash

function asciidoc {

    local ASCIIDOC_FILE=''

    for ASCIIDOC_FILE in ${SOURCES[*]};do

        # Define POT's default location using the source file as
        # reference. The portable object template is
        # locale-independent so it must be out of locale-specific
        # directories.
        local POT_FILE=${ASCIIDOC_FILE}.pot

        tcar_printMessage "${POT_FILE}" --as-creating-line

        local DOCBOOK_FILE=$(tcar_getTemporalFile $(basename ${ASCIIDOC_FILE})).docbook

        asciidoc_convertAsciidocToDocbook

        locale_convertXmlToPot "${DOCBOOK_FILE}" "${POT_FILE}"

        # Verify, initialize or merge portable objects from portable
        # object templates.
        locale_convertPotToPo "${POT_FILE}" "${PO_FILE}"

    done
        
}
