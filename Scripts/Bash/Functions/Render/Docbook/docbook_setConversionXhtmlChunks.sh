#!/bin/bash
#
# docbook_setConversionXhtmlChunks.sh -- This function uses DocBook XML as
# input and applies XSL stylesheets to produce a directory with many
# XHTML files as output.  The procedure was taken from the
# documentation of `docbook-style-xsl-1.69.1-5.1' package, which says:
# ---To publish HTML from your XML documents, you just need an XSLT
# engine.---.
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

function docbook_setConversionXhtmlChunks {

    local -a STYLE_TEMPLATE
    local -a STYLE_INSTANCE
    local STYLE_INSTANCE_FINAL=''

    # Define absolute path to DocBook source file. This is the
    # repository documentation manual file where DOCTYPE and ENTITY
    # definition lines are set.
    local SOURCE_FILE=${1}

    # Define absolute path to XHTML target file. This is the final
    # location the XHTML file produced as result of DocBook to PDF
    # transformation will be stored in.
    local TARGET_FILE="${FILE}-xhtml-chunks/"

    # Clean up output directory. This is required in order to prevent
    # old files from remaining therein when they are no longer needed.
    if [[ -d ${TARGET_FILE} ]];then
        rm -r "${TARGET_FILE}"
    fi 
    mkdir ${TARGET_FILE}

    # Print action message.
    cli_printMessage "${TARGET_FILE}" --as-creating-line

    # Prepare XSL final instances used in transformations.
    docbook_setStyles $(cli_getFilesList \
        ${DOCBOOK_XSL} --pattern='^.*/docbook2xhtml-(chunks|common)\.xsl$')

    # Transform DocBook XML to XHTML suppressing all stderr output.
    xsltproc --output ${TARGET_FILE} ${STYLE_INSTANCE_FINAL} ${SOURCE_FILE} &> /dev/null

    # Create `css' and `images' directories. In order to save disk
    # space, these directories are linked (symbolically) to their
    # respective locations inside the working copy. Be sure to remove
    # previous links first to prevent a recursive creation of links.
    ln -sf ${TCAR_WORKDIR}/Identity/Webenv/Themes/Default/Docbook/1.69.1/Css ${TARGET_FILE}/Css
    ln -sf ${TCAR_WORKDIR}/Identity/Images/Webenv ${TARGET_FILE}/Images

    # Remove XSL instance files.
    rm ${STYLE_INSTANCE[*]}

}
