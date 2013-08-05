#!/bin/bash
######################################################################
#
#   Modules/Locale/Modules/Update/Modules/Asciidoc/asciidoc.sh -- This
#   module takes one or more asciidoc files as source and produces
#   docbook temporal files for one of them. The docbook temporal files
#   are used to create portable objects to different locale
#   information.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2013
#
# Copyright (C) 2009-2013 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

    local ASCIIDOC_FILE=''

    for ASCIIDOC_FILE in ${SOURCES[*]};do

        # Define POT's default location using the source file as
        # reference. The portable object template is
        # locale-independent so it must be out of locale-specific
        # directories.
        local POT_FILE=$(basename ${ASCIIDOC_FILE}).pot

        tcar_printMessage "${POT_FILE}" --as-creating-line

        local DOCBOOK_FILE=$(tcar_getTemporalFile $(basename ${ASCIIDOC_FILE})).docbook

        asciidoc_convertAsciidocToDocbook

        locale_convertXmlToPot "${DOCBOOK_FILE}" "${POT_FILE}"

        # Verify, initialize or merge portable objects from portable
        # object templates.
        locale_convertPotToPo "${POT_FILE}" "${PO_FILE}"

    done
        
}
