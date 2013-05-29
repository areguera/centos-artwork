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
# 1. Something is wrong with headings. They are not expanded along the
# whole page-body. They seem to be rendered in a reduced width (1 inch
# approximately). This provokes the heading to be broken in a
# two-to-five letters column and sometimes it overlaps the sectioning
# titles (e.g., chapter, section). I tried to customize the value of
# `header.column.widths' and `page.margin.top' but it seems to be not
# there where I need to touch.
#
# 2. TOC's indentation is not rendered. Even the `toc.indent.width'
# property is set to 24 by default.
#
# 3. Inside lists, when items are more than one line, the indentation
# seems to work for the first line only.  All other lines in the same
# item are not indented and begin completely unaligned.
#
# 4. Long file paths near the end of page-body aren't hyphenated.
# Even the `hyphenate' property is set to `true' by default.
#
# In this configuration and using default configuration settings, I've
# presented the following advantages:
#
# 1. It is possible to produce localized PDF outputs through
# `xml2po', the default way of producing localized content inside
# the `centos-art.sh' script.
#
# To make the whole process transparent, a temporal directory is
# created for intermediate works and final files are moved then to
# their final location.
#
# Copyright (C) 2009-2013 The CentOS Project
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
    cli_printMessage "${FILE}.pdf" --as-creating-line

    local -a STYLE_TEMPLATE
    local -a STYLE_INSTANCE
    local STYLE_INSTANCE_FINAL=''

    # Define absolute path to DocBook source file. This is the
    # repository documentation manual file where DOCTYPE and ENTITY
    # definition lines are set.
    local SRC=${INSTANCE}

    # Define absolute path to PDF target file. This is the final
    # location the PDF file produced as result of DocBook to PDF
    # transformation will be stored in.
    local DST="${FILE}.pdf"

    # Define file name of formatting object (.fo) file. This file is
    # an intermediate file needed to produced the PDF.
    local FO=$(echo ${INSTANCE} | sed -r 's/docbook$/fo/g')

    # Define file name of PDF file.  This is the file we were looking
    # for and the one moved, once produced.
    local PDF=$(echo ${INSTANCE} | sed -r 's/docbook$/pdf/g')

    # Prepare XSL final instances used in transformations.
    docbook_prepareStyles "${DOCBOOK_XSL}/docbook2fo.xsl"

    # Create link to `Images' directory. This is the directory where
    # images used by documentation are stored in. Be sure to remove
    # previous links first to prevent a recursive creation of links.
    ln -sf ${TCAR_WORKDIR}/Identity/Images/Webenv $(dirname ${INSTANCE})/Images

    # Create formatting object suppressing output from stderr.
    xsltproc --output ${FO} ${STYLE_INSTANCE_FINAL} ${SRC} 2> /dev/null

    # Create PDF format from formatting object. Because we are using
    # relative path to access `Images', it is necessary to move the
    # directory stack into the temporal directory where instance files
    # are created. Otherwise, the location used to load images will
    # fail.
    if [[ $? -eq 0 ]];then
        pushd $(dirname ${INSTANCE}) > /dev/null
        xmlto -o $(dirname ${FILE}) pdf ${FO}
        popd > /dev/null
    else 
        cli_printMessage "`gettext "Cannot produce the PDF file."`" --as-error-line
    fi

}
