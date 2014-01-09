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

# Take an XML file and create a portable object template (.pot) for
# it.
function update_convertXmlToPot {

    local XML_FILE=${1}
    local POT_FILE=${2}

    # Move to final location before processing source file in order
    # for relative calls (e.g., image files) inside the source files
    # can be found by xml2po and no warning be printed from it.
    if [[ -d ${RENDER_TARGET} ]];then
        pushd ${RENDER_TARGET} > /dev/null
    fi

    cat ${XML_FILE} | xml2po -a -l ${TCAR_SCRIPT_LANG_LC} - \
        | msgcat --output-file=${POT_FILE} --width=70 --no-location -

    if [[ -d ${RENDER_TARGET} ]];then
        popd > /dev/null
    fi
}
