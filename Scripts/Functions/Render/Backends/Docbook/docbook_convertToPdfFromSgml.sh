#!/bin/bash
#
# docbook_convertToPdfFromSgml.sh -- This function transforms DocBook
# files which have set the SGML DTD in them.  To produce PDF from
# DocBook SGML DTD, we take the DocBook XML DTD file and change its
# DTD from XML to SGML. Since XML is SGML shoudn't be any problem.
# Once the DTD has been changed from XML to SGML, we use the jw shell
# script to convert the SGML-based DocBook file to PDF.  Customization
# can be achieved through DSL (docbook-style-dsssl-1.79-4.1) shipped
# in this distribution.
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

function docbook_convertToPdfFromSgml {

    # Print action message.
    cli_printMessage "${FILE}-sgml.pdf" --as-updating-line

    local -a STYLE_TEMPLATE
    local -a STYLE_INSTANCE
    local STYLE_INSTANCE_FINAL=''

    # Define file name of SGML-based file. This is a mere copy of
    # XML-based file, but using the `-sgml.docbook' prefix.
    SRC=$(echo $TEMPLATE | sed -r 's!\.docbook$!-sgml.docbook!')

    # Create SGML-based file as copy of main XML-based DocBook file.
    cp $TEMPLATE $SRC

    # Replace document definition from XML to SGML.
    sed -i -r \
        -e 's!"-//OASIS//DTD DocBook XML!"-//OASIS//DTD DocBook!' \
        -e 's!"http://www\.oasis-open\.org/docbook/xml/([[:digit:]])\.([[:digit:]])/docbookx\.dtd"!"docbook/sgml-dtd-\1.\2-1.0-30.1/docbook.dtd"!' \
        $SRC

    # Prepare style final instance used in transformations.
    ${RENDER_BACKEND}_prepareStyles "${DOCBOOK_STYLES_DIR}/docbook2pdf.dsl"

    # Create PDF format.
    docbook2pdf --dsl ${STYLE_INSTANCE_FINAL} ${SRC} &> /dev/null

    # Remove temporal directory and temporal style instances created.
    rm $SRC
    rm ${STYLE_INSTANCE[*]}

}
