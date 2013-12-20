#!/bin/bash
######################################################################
#
#   asciidoc.sh -- This module standardizes update actions related to
#   localization of asciidoc files inside the repository.
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

    tcar_checkFiles -efm "\.asciidoc$" "${RENDER_FROM}"

    local DOCBOOK=$(tcar_getTemporalFile $(basename ${RENDER_FROM})).docbook

    asciidoc_convertAsciidocToDocbook

    update_convertXmlToPot "${DOCBOOK}" "${POT_FILE}"

    update_convertPotToPo "${POT_FILE}" "${PO_FILE}"

}
