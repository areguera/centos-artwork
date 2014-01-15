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

# Standardize the way docbook files are transformed in XHTML format.
function asciidoc_setXhtmlRendition {

    local LOCATION=$(tcar_printAbsolutePath "${1}")

    RENDER_PAGES=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-page")
    if [[ -z ${RENDER_PAGES} ]];then
        RENDER_PAGES='single'
    fi
    tcar_checkFiles -m '^(single-notoc|single|chunks)$' "${RENDER_PAGES}"

    IMAGES_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "images-from")
    if [[ -z ${IMAGES_FROM} ]];then
        IMAGES_FROM="${TCAR_WORKDIR}/Webenv/Final"
    fi

    STYLES_FROM=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "styles-from")
    if [[ -z ${STYLES_FROM} ]];then
        STYLES_FROM="${TCAR_BASEDIR}/Models/Documentation/Css"
    fi

    # When producing chunks, take into consideration that both single
    # and chunks share images produced in the root location. If we
    # create another level of directories to store chunks, that would
    # make impossible to use one unique image path for both single and
    # chunks from one unique asciidoc document.  So, to reuse image
    # files, produce both chunks and single XHTML output in the same
    # directory.
    if [[ ${RENDER_PAGES} == 'chunks' ]];then
        LOCATION="$(dirname ${LOCATION})/"
    fi

    if [[ ! -d $(dirname ${LOCATION}) ]];then
        mkdir -p $(dirname ${LOCATION})
    fi

    ln -sfn ${IMAGES_FROM} $(dirname ${LOCATION})/Images
    ln -sfn ${STYLES_FROM} $(dirname ${LOCATION})/Css

    tcar_printMessage "${LOCATION}" --as-creating-line

    for RENDER_PAGE in ${RENDER_PAGES};do
        /usr/bin/xsltproc -o ${LOCATION} --nonet \
            ${DOCBOOK_XSL}/docbook2xhtml-${RENDER_PAGE}.xsl ${TARGET_INSTANCES[${COUNTER}]}
    done

}
