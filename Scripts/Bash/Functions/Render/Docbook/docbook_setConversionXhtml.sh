#!/bin/bash
#
# docbook_setConversionXhtml.sh -- This function uses DocBook XML as input
# and applies XSL stylesheets to produce a big XHTML files as output.
# The procedure was taken from the documentation of
# `docbook-style-xsl-1.69.1-5.1' package, which says: ---To publish
# HTML from your XML documents, you just need an XSL engine.---.
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

function docbook_setConversionXhtml {

    local -a STYLE_TEMPLATE
    local -a STYLE_INSTANCE
    local STYLE_INSTANCE_FINAL=''

    # Define absolute path to DocBook source file. This is the
    # repository documentation manual file where DOCTYPE and ENTITY
    # definition lines are set.
    local SOURCE_FILE=${1}

    # Define absolute path to xhtml target file. This is the final
    # location the xhtml file produced as result of DocBook to xhtml
    # transformation will be stored in.
    local TARGET_FILE=${FILE}-xhtml/$(basename ${FILE}).xhtml

    # Define absolute path to xhtml target file directory. This is the
    # location the xhtml target file will be sotred in.
    local TARGET_FILE_DIR=$(dirname ${TARGET_FILE})

    # Print action message.
    if [[ -f ${FILE}.xhtml ]];then
        cli_printMessage "${TARGET_FILE}" --as-updating-line
    else
        cli_printMessage "${TARGET_FILE}" --as-creating-line
    fi

    # Prepare XSL final instances used in transformations.
    docbook_setStyles $(cli_getFilesList \
        ${DOCBOOK_XSL} --pattern='^.*/docbook2xhtml-(single|common)\.xsl$')

    # Clean up output directory. This is required in order to prevent
    # old files from remaining therein when they are no longer needed.
    if [[ -d ${TARGET_FILE_DIR} ]];then
        rm -r "${TARGET_FILE_DIR}"
    fi 
    mkdir ${TARGET_FILE_DIR}

    # Transform DocBook XML to XHTML suppressing all stderr output.
    xsltproc --output ${TARGET_FILE} ${STYLE_INSTANCE_FINAL} ${SOURCE_FILE} &> /dev/null

    # Create `css' and `images' directories. In order to save disk
    # space, these directories are linked (symbolically) to their
    # respective locations inside the working copy. 
    ln -fs ${TCAR_WORKDIR}/Identity/Webenv/Themes/Default/Docbook/1.69.1/Css ${TARGET_FILE_DIR}/Css
    ln -fs ${TCAR_WORKDIR}/Identity/Images/Webenv ${TARGET_FILE_DIR}/Images

    # Remove XSL instance files.
    rm ${STYLE_INSTANCE[*]}

}
