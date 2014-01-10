#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Produce docbook documents using manpage document type.
function manpage {

    local MANSECT=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "mansect")

    tcar_checkFiles -m '[1-9]' "${MANSECT}"

    # xml2po (gnome-doc-utils-0.8.0-2.fc6) bug? For some reason xml2po
    # is not adding the lang attribute to refentry tag when it
    # produces manpage document types.  This make intrinsic docbook
    # construction like Name and Synopsis to be rendered without
    # localization. This doesn't happens with article and book
    # document types.
    sed -i -r "s/<refentry>/<refentry lang=\"${TCAR_SCRIPT_LANG_LC}\">/" ${TARGET_INSTANCES[${COUNTER}]}

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
                    ${DOCBOOK_XSL}/docbook2manpage.xsl ${TARGET_INSTANCES[${COUNTER}]}
                ;;
        esac

    done

}
