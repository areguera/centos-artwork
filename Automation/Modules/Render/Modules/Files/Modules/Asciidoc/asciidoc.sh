#!/bin/bash
######################################################################
#
#   asciidoc.sh -- This function standardizes rendition of asciidoc
#   files inside the centos-art.sh script.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
######################################################################

function asciidoc {

    local DOCBOOK_VER="1.69.1"
    local DOCBOOK_XSL="${TCAR_BASEDIR}/Artworks/Webenv/Docbook/${DOCBOOK_VER}/Xsl"
    local DOCBOOK_CSS="${TCAR_BASEDIR}/Artworks/Webenv/Docbook/${DOCBOOK_VER}/Css"

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
