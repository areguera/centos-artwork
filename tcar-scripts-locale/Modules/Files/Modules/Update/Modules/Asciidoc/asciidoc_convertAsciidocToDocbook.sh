#!/bin/bash
######################################################################
#
#   asciidoc_convertAsciidocToDocbook.sh -- This function converts
#   asciicoc files into docbook files using asciidoc command's default
#   (article) doctype.
#
#   When docbook files are produced from asciidoc files it is
#   necessary to consider the format in which they are generated
#   (e.g., whether it is an article or a manpage). This information is
#   stored in render.conf file, in the same directory of asciidoc
#   file. Both locale and render modules need to produce the same
#   docbook output in order to produce html and manpages well
#   localized. Otherwise, there might be content that would be not
#   localized because the same content is produced using a different
#   markup (e.g., you localize asciidoc documents as articles but then
#   render them as manpage).  To solve this issue, it is necessary
#   that both locale and render module use the same configuration
#   file when producing localization and final content. This way, both
#   locale and render produce content using the same information.
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

function asciidoc_convertAsciidocToDocbook {

    tcar_checkFiles -m '^(manpage|article|book)$' "${RENDER_FLOW}"

    /usr/bin/asciidoc --backend="docbook" --doctype="${RENDER_FLOW}" \
        --out-file=${DOCBOOK} ${RENDER_FROM}

}
