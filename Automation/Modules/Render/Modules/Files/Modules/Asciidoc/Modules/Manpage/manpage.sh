#!/bin/bash

function manpage {

    local MANSECT=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "mansect")

    tcar_checkFiles -m '[1-9]' "${MANSECT}"

    for FORMAT in ${FORMATS};do

        tcar_checkFiles -m '(xhtml|manpage)' "${FORMAT}"

        case ${FORMAT} in 

            'xhtml' )
                local HTML_TARGET="$(dirname ${RENDER_TARGET})/htmlman${MANSECT}/$(basename ${RENDER_TARGET}).${MANSECT}.html"
                asciidoc_setXhtmlRendition "${HTML_TARGET}"
                ;;

            'manpage' )
                local MAN_TARGET="$(dirname ${RENDER_TARGET})/man${MANSECT}/$(basename ${RENDER_TARGET}).${MANSECT}"
                if [[ ! -d $(dirname ${MAN_TARGET}) ]];then
                    mkdir -p $(dirname ${MAN_TARGET})
                fi
                tcar_printMessage "${MAN_TARGET}" --as-creating-line
                /usr/bin/xsltproc -o ${MAN_TARGET} --nonet \
                    ${DOCBOOK_XSL}/docbook2manpage.xsl ${DOCBOOK_FILE}
                ;;
        esac

    done

}
