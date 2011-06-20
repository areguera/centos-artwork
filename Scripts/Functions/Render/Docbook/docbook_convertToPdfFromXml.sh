#!/bin/bash
#
# docbook_convertToPdfFromXml.sh -- This function transforms DocBook
# files which have set the XML DTD in them.  To produce PDF from
# DocBook XML DTD, we need an XSLT engine (e.g., through `xsltproc'
# command) to produce formatting objects (FO), which then must be
# processed with an FO engine (e.g., through `pdfxmltex' command,
# which uses PassiveTex) to produce the PDF output.
#
# In this configuration and using default configuration settings, I've
# presented the following problems:
#
#   1. Something is wrong with headings. They are not expanded along
#   the whole page-body. They seem to be rendered in a reduced width
#   (1 inch approximatly). This provokes the heading to be broken in a
#   two-to-five letters column and sometimes it overlaps the
#   sectioning titles (e.g., chatper, section). I tried to customize
#   the value of `header.column.widths' and `page.margin.top' but it
#   seems to be not there where I need to touch.
#
#   2. TOC's indentation is not rendered. Even the `toc.indent.width'
#   property is set to 24 by default.
#
#   3. Inside lists, when items are more than one line, the
#   indentation seems to work for the first line only.  All other
#   lines in the same item are not indented and begin completly
#   unaligned.
#
#   4. Long file paths near the end of page-body aren't hyphenated.
#   Even the `hyphenate' property is set to `true' by default.
#
# In this configuration and using default configuration settings, I've
# presented the following advantages:
#
#   1. It is possible to produce localized PDF outputs through
#   `xml2po', the default way of producing localized content inside
#   the `centos-art.sh' script.
#
# To make the whole process transparent, a temporal directory is
# created for intermediate works and final files are moved then to
# their final location.
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

function docbook_convertToPdfFromXml {

    # Print action message.
    if [[ -f ${FILE}.sgml.pdf ]];then
        cli_printMessage "${FILE}.xml.pdf" --as-updating-line
    else
        cli_printMessage "${FILE}.xml.pdf" --as-creating-line
    fi

    local -a STYLE_TEMPLATE
    local -a STYLE_INSTANCE
    local STYLE_INSTANCE_FINAL=''

    # Define name of temporal directory where the DocBook to PDF
    # transformation will take place.
    local TMPDIR=$(cli_getTemporalFile "docbook2pdf")

    # Define absolute path to DocBook source file. This is the
    # repository documentation manual file where DOCTYPE and ENTITY
    # definition lines are set.
    local SRC=${INSTANCE}

    # Define absolute path to PDF target file. This is the final
    # location the PDF file produced as result of DocBook to PDF
    # transformation will be stored in.
    local DST="${FILE}.xml.pdf"

    # Define file name of formatting object (.fo) file. This file is
    # an intermediate file needed to produced the PDF.
    local FO=$(basename ${FILE}).fo

    # Define file name of PDF file.  This is the file we were looking
    # for and the one moved, once produced.
    local PDF=$(basename ${FILE}).pdf

    # Prepare XSL final instances used in transformations.
    ${RENDER_BACKEND}_prepareStyles "${DOCBOOK_STYLES_DIR}/docbook2fo.xsl"

    # Verify temporal directory and create it if doesn't exist.
    if [[ ! -d $TMPDIR ]];then
        mkdir $TMPDIR
    fi

    # Move inside temporal directory.
    pushd $TMPDIR > /dev/null

    # Create formatting object supressing output from stderr.
    xsltproc --output ${FO} ${STYLE_INSTANCE_FINAL} ${SRC} &> /dev/null

    # Create PDF format from formatting object. The `pdfxmltex'
    # command (which use the `PassiveTex' engine) must be executed
    # twice in order for the document's cross references to be built
    # correctly.
    if [[ $? -eq 0 ]];then
        pdfxmltex ${FO} > /dev/null
        pdfxmltex ${FO} > /dev/null
    else 
        cli_printMessage "`gettext "Cannot produce the formatting object."`" --as-error-line
    fi

    # Verify `pdfxmltex' exit status and, if everything is ok, move
    # PDF file from temporal directory to its target location.
    if [[ $? -eq 0 ]];then
        mv $PDF $DST
    else 
        cli_printMessage "`gettext "Cannot produce the PDF file."`" --as-error-line
    fi

    # Return to where we initially were.
    popd > /dev/null

    # Remove temporal directory and temporal style instances created.
    rm -r $TMPDIR
    rm ${STYLE_INSTANCE[*]}

}
