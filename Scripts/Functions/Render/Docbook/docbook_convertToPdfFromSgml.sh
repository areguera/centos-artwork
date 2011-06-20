#!/bin/bash
#
# docbook_convertToPdfFromSgml.sh -- This function transforms DocBook
# files which have set the SGML DTD in them.  To produce PDF from
# DocBook SGML DTD, we take the DocBook XML DTD file and change its
# DTD from XML to SGML. Since XML is SGML shoudn't be any problem.
# Once the DTD has been changed from XML to SGML, we use openjade
# (through `jw' shell script) to convert the SGML-based DocBook file
# to PDF.  Customization can be achieved through DSL
# (docbook-style-dsssl-1.79-4.1) shipped in this distribution.
#
# In this configuration and using default configuration settings, I've
# presented the following problems:
#
#   1. It is not possible to produce localized PDF outputs through
#   `xml2po', the default way of producing localized content inside
#   `centos-art.sh' script.
#
# In this configuration and using default configuration settins, I've
# presented the following advantages:
#
#   1. The PDF output produced from SGML-based files seem to be better
#   looking an less buggy than PDF output produced from XML-based
#   files, visually I mean.
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

function docbook_convertToPdfFromSgml {

    # Print action message.
    if [[ -f ${FILE}.sgml.pdf ]];then
        cli_printMessage "${FILE}.sgml.pdf" --as-updating-line
    else
        cli_printMessage "${FILE}.sgml.pdf" --as-creating-line
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
    local DST="${FILE}.sgml.pdf"

    # Define file name of PDF file.  This is the file we were looking
    # for and the one moved, once produced.
    local PDF=$(basename ${SRC} | sed -r 's!\.docbook$!.pdf!')

    # Replace document definition from XML to SGML.
    sed -i -r \
        -e 's!"-//OASIS//DTD DocBook XML!"-//OASIS//DTD DocBook!' \
        -e 's!"http://www\.oasis-open\.org/docbook/xml/([[:digit:]])\.([[:digit:]])/docbookx\.dtd"!"docbook/sgml-dtd-\1.\2-1.0-30.1/docbook.dtd"!' \
        $SRC

    # Prepare style final instance used in transformations.
    ${RENDER_BACKEND}_prepareStyles "${DOCBOOK_STYLES_DIR}/docbook2pdf.dsl"

    # Verify temporal directory and create it if doesn't exist.
    if [[ ! -d $TMPDIR ]];then
        mkdir $TMPDIR
    fi

    # Move inside temporal directory.
    pushd $TMPDIR > /dev/null

    # Create PDF format.
    docbook2pdf --dsl ${STYLE_INSTANCE_FINAL} ${SRC} &> /dev/null

    # Verify `docbook2pdf' exit status and, if everything is ok, move
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
