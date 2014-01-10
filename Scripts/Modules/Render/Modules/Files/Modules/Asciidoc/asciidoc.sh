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

# Standardize rendition of asciidoc files inside the tcar.sh script.
function asciidoc {

    local DOCBOOK_XSL="${TCAR_BASEDIR}/Models/Documentation/Xsl"
    local DOCBOOK_CSS="${TCAR_BASEDIR}/Models/Documentation/Css"

    RENDER_FLOW=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" 'render-flow')
    if [[ -z ${RENDER_FLOW} ]];then
        RENDER_FLOW="article"
    fi
    tcar_checkFiles -m '^(article|book|manpage)$' "${RENDER_FLOW}"

    FORMATS=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" 'formats')
    if [[ -z ${FORMATS} ]];then
        FORMATS='xhtml'
    fi

    RELEASE=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" 'release')
    if [[ -z ${RELEASE} ]];then
        RELEASE=$(cut -f3 -d' ' /etc/redhat-release)
    fi
    MAJOR_RELEASE=$(echo ${RELEASE} | cut -d. -f1)

    asciidoc_setBaseRendition

}
