#!/bin/bash
#
# docbook_convertToXhtmlChunk.sh -- This function uses DocBook XML as
# input and applies XSL stylesheets to produce a directory with many
# XHTML files as output.  The procedure was taken from the
# documentation of `docbook-style-xsl-1.69.1-5.1' package, which says:
# ---To publish HTML from your XML documents, you just need an XSLT
# engine.---.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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

    local -a STYLE_TEMPLATE
    local -a STYLE_INSTANCE
    local STYLE_INSTANCE_FINAL=''

    # Define absolute path to PDF target file. This is the final
    # location the PDF file produced as result of DocBook to PDF
    # transformation will be stored in.
    local DST="${FILE}-xhtml/"

    # Clean up output directory. This is required in order to prevent
    # old files from remaining therein when they are no longer needed.
    if [[ -d ${DST} ]];then
        rm -r "${DST}"
    fi 
    mkdir ${DST}

    # Print action message.
    cli_printMessage "${FILE}-xhtml" --as-creating-line

    # Define absolute path to DocBook source file. This is the
    # repository documentation manual file where DOCTYPE and ENTITY
    # definition lines are set.
    local SRC=${INSTANCE}

    # Prepare XSL final instances used in transformations.
    ${RENDER_BACKEND}_prepareStyles $(cli_getFilesList \
        ${DOCBOOK_STYLES_DIR} --pattern='.*docbook2xhtml-(chunks|common)\.xsl')

    # Transform DocBook XML to XHTML supressing all stderr output.
    xsltproc --output ${DST} ${STYLE_INSTANCE_FINAL} ${SRC} &> /dev/null

    # Remove XSL instance files.
    rm ${STYLE_INSTANCE[*]}

}
