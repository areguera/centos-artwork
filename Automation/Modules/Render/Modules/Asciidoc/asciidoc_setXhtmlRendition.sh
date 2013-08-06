#!/bin/bash

function asciidoc_setXhtmlRendition {

    local TARGET="${1}"

    RENDER_PAGES=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-page")
    if [[ -z ${RENDER_PAGES} ]];then
        RENDER_PAGES='single'
    fi
    tcar_checkFiles -m '^(single|chunks)$' "${RENDER_PAGE}"

    IMAGES_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "images-from")
    if [[ -z ${IMAGES_FROM} ]];then
        IMAGES_FROM="${TCAR_BASEDIR}/Artworks/Icons/Webenv"
    fi

    STYLES_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "styles-from")
    if [[ -z ${STYLES_FROM} ]];then
        STYLES_FROM="${TCAR_BASEDIR}/Artworks/Webenv/Docbook/1.69.1/Css"
    fi

    # When producing chunks, take into consideration that both single
    # and chunks share images produced in the root location. If we
    # create another level of directories to store chunks, that would
    # make impossible to use one unique image path for both single and
    # chunks from one unique asciidoc document.  So, to reuse image
    # files, produce both chunks and single XHTML output in the same
    # directory.
    if [[ ${RENDER_PAGE} == 'chunks' ]];then
        TARGET="$(dirname ${TARGET})/"
    fi

    if [[ ! -d $(dirname ${TARGET}) ]];then
        mkdir -p $(dirname ${TARGET})
    fi

    ln -sfn ${IMAGES_FROM} $(dirname ${TARGET})/Images
    ln -sfn ${STYLES_FROM} $(dirname ${TARGET})/Css

    tcar_printMessage "${TARGET}" --as-creating-line

    for RENDER_PAGE in ${RENDER_PAGES};do
        /usr/bin/xsltproc -o ${TARGET} --nonet \
            ${DOCBOOK_XSL}/docbook2xhtml-${RENDER_PAGE}.xsl ${DOCBOOK_FILE}
    done

}
