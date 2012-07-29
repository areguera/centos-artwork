#!/bin/bash
#
# docbook.sh -- This function performs base-rendition actions for
# DocBook files.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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
    DOCBOOK_STYLES_DIR="${RENDER_FORMAT_DIR}/Docbook/Styles"

    docbook_convertToXhtmlChunk
    docbook_convertToXhtml

    # WARNING: There are some issues related to DocBook-to-PDF
    # transformations that make the whole process not so "clean" as
    # DocBook-to-XHTML transformation is. Based on this situation and
    # the need of providing a clean output, PDF transformation is
    # commented until these issues be corrected. If you have a release
    # of CentOS greater than 5.5, uncomment this to see what happen.
    #docbook_convertToPdf

    # Perform format post-rendition.
    docbook_doPostActions

    # Perform format last-rendition.
    docbook_doLastActions

}
