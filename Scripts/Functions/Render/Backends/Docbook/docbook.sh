#!/bin/bash
#
# docbook.sh -- This function performs base-rendition action for
# DocBook files.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function docbook {

    # Initialize absolute path to Xsl directory. This is the location
    # where customization of XSL tranformations are stored in.
    DOCBOOK_STYLES_DIR="${RENDER_BACKEND_DIR}/$(cli_getRepoName ${RENDER_BACKEND} -d)/Styles"

    ${RENDER_BACKEND}_convertToPdf
    ${RENDER_BACKEND}_convertToXhtml
    ${RENDER_BACKEND}_convertToXhtmlChunk

}
