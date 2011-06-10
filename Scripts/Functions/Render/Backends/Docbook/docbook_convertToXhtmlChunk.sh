#!/bin/bash
#
# render_docbook_convertToXhtmlChunk.sh -- This function uses DocBook
# XML as input and applies XSL stylesheets to produce a directory with
# many XHTML files as output.  The procedure was taken from the
# documentation of `docbook-style-xsl-1.69.1-5.1' package, which says:
# ---To publish HTML from your XML documents, you just need an XSLT
# engine.---.
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

function docbook_convertToXhtmlChunk {

    # Print action message.
    if [[ -d ${FILE}-xhtml ]];then
        cli_printMessage "${FILE}-xhtml" --as-updating-line
    else
        cli_printMessage "${FILE}-xhtml" --as-creating-line
        mkdir ${FILE}-xhtml
    fi

    # Define absolute path to DocBook source file. This is the
    # repository documentation manual file where DOCTYPE and ENTITY
    # definition lines are set.
    local SRC=${INSTANCE}

    # Define absolute path to PDF target file. This is the final
    # location the PDF file produced as result of DocBook to PDF
    # transformation will be stored in.
    local DST="${FILE}-xhtml/"

    # Define absolute path to XSLT file.
    local XSLT=/usr/share/sgml/docbook/xsl-stylesheets/xhtml/chunk.xsl

    # Transform DocBook XML to XHTML supressing all stderr output.
    xsltproc $XSLT --output $DST $SRC 2> /dev/null

}
