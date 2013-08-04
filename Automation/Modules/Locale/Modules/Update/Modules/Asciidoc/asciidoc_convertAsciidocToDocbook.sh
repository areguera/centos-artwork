#!/bin/bash

function asciidoc_convertAsciidocToDocbook {

    /usr/bin/asciidoc --backend="docbook" --doctype="${RENDER_FLOW}" \
        --out-file=${DOCBOOK_FILE} ${ASCIIDOC_FILE}

}
