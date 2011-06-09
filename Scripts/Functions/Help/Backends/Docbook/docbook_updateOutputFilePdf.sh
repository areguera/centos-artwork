#!/bin/bash
#
# docbook_updateOutputFilePdf.sh -- This function produces PDF output
# for repository documentation manual, in DocBook XML format. The
# procedure was taken from `docbook-style-xsl-1.69.1-5.1'
# documentation, which says: ---To get to print, you need an XSLT
# engine (e.g., `xsltproc') to produce formatting objects (FO), which
# then must be processed with an FO engine (e.g., `pdfxmltex') to
# produce PostScript or PDF output---. To make the whole process
# transparent, a temporal directory is created for intermediate works.
# Once the PDF file is produced there, it is moved to its final
# location.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

function docbook_updateOutputFilePdf {

    # Print action message.
    cli_printMessage "${MANUAL_BASEFILE}.pdf" --as-updating-line

    # Define name of temporal directory where the DocBook to PDF
    # transformation will take place.
    local TMPDIR=$(cli_getTemporalFile "docbook2pdf")

    # Define absolute path to DocBook source file. This is the
    # repository documentation manual file where DOCTYPE and ENTITY
    # definition lines are set.
    local SRC=${MANUAL_BACKEND}/${MANUAL_NAME}.docbook

    # Define absolute path to PDF target file. This is the final
    # location the PDF file produced as result of DocBook to PDF
    # transformation will be stored in.
    local DST="${MANUAL_BASEFILE}.pdf"

    # Define absolute path of the XSLT file used to create the
    # formatting object (.fo) file.
    local XSLT=/usr/share/sgml/docbook/xsl-stylesheets/fo/docbook.xsl

    # Define file name of formatting object (.fo) file. This file is
    # an intermediate file needed to produced the PDF.
    local FO=${MANUAL_NAME}.fo

    # Define file name of PDF file.  This is the file we were looking
    # for and the one moved, once produced.
    local PDF=${MANUAL_NAME}.pdf

    # Verify temporal directory and create it if doesn't exist.
    if [[ ! -d $TMPDIR ]];then
        mkdir $TMPDIR
    fi

    # Move inside temporal directory.
    pushd $TMPDIR > /dev/null

    # Create formatting object supressing output from stderr.
    xsltproc ${XSLT} ${SRC} 2> /dev/null > ${FO}

    # Create PDF format from formatting object. The `pdfxmltex' commad
    # must be executed twice in order for document's cross-references
    # to be built correctly.
    if [[ $? -eq 0 ]];then
        pdfxmltex ${FO} > /dev/null
        pdfxmltex ${FO} > /dev/null
    else 
        cli_printMessage "`gettext "Cannot produce the formatting object."`" --as-error-line
    fi

    # Verify `' exit status and, if everything is ok, move PDF file
    # from temporal directory to its target location.
    if [[ $? -eq 0 ]];then
        mv $PDF $DST
    else 
        cli_printMessage "`gettext "Cannot produce the PDF file."`" --as-error-line
    fi

    # Return to where we initially were.
    popd > /dev/null

    # Remove temporal directory.
    rm -r $TMPDIR

}
