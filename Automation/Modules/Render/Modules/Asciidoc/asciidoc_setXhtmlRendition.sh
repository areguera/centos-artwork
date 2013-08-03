#!/bin/bash

function asciidoc_setXhtmlRendition {

    local TARGET="${1}"

    RENDER_PAGE=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-page")
    if [[ -z ${RENDER_PAGE} ]];then
        RENDER_PAGE='single'
    fi
    tcar_checkFiles ${RENDER_PAGE} --match='^(single|chunks)$'

    IMAGES_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "images-from")
    if [[ -z ${IMAGES_FROM} ]];then
        IMAGES_FROM="${TCAR_BASEDIR}/Artworks/Icons/Webenv"
    fi

    STYLES_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "styles-from")
    if [[ -z ${STYLES_FROM} ]];then
        STYLES_FROM="${TCAR_BASEDIR}/Artworks/Webenv/Docbook/1.69.1/Css"
    fi

    if [[ ${RENDER_PAGE} == 'chunks' ]];then
        TARGET="${TARGET}/"
        if [[ ! -d ${TARGET} ]];then
            mkdir -p ${TARGET}
        fi
        ln -sfn ${IMAGES_FROM} ${TARGET}/Images
        ln -sfn ${STYLES_FROM} ${TARGET}/Css
    else
        if [[ ! -d $(dirname ${TARGET}) ]];then
            mkdir -p $(dirname ${TARGET})
        fi
        ln -sfn ${IMAGES_FROM} $(dirname ${TARGET})/Images
        ln -sfn ${STYLES_FROM} $(dirname ${TARGET})/Css
    fi

    tcar_printMessage "${TARGET}" --as-creating-line

    /usr/bin/xsltproc -o ${TARGET} --nonet \
        ${DOCBOOK_XSL}/docbook2xhtml-${RENDER_PAGE}.xsl ${DOCBOOK_FILE}

}
