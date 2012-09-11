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
    DOCBOOK_XSL_DIR="${TCAR_WORKDIR}/trunk/Identity/Webenv/Themes/Default/Docbook/1.69.1/Xsl"

    # Convert DocBook source files to other formats.
    #docbook_convertToXhtmlChunk
    #docbook_convertToXhtml
    #docbook_convertToText
    docbook_convertToPdfFromXml

    # NOTE: From version 5.0 on, DocBook specification is no longer a
    # SGML specification but an XML specification only. Thus,
    # transformations related to DocBook SGML specification won't be
    # supported in `centos-art.sh' script.

    # Perform format post-rendition.
    docbook_doPostActions

    # Perform format last-rendition.
    docbook_doLastActions

}
