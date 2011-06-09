#!/bin/bash
#
# docbook_updateOutputFileXhtml.sh -- This function uses the xsltproc
# for transforming the repository documentation manual from DocBook to
# Xhtml.
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

function docbook_updateOutputFileXhtml {

    # Print action message.
    cli_printMessage "${MANUAL_BASEFILE}.xhtml" --as-updating-line

    # Verify temporal directory and create it if doesn't exist.
    if [[ ! -d ${MANUAL_BASEFILE}.xhtml ]];then
        mkdir ${MANUAL_BASEFILE}.xhtml
    fi

    # Execute docbook2pdf convertion.
    xsltproc /usr/share/sgml/docbook/xsl-stylesheets/xhtml/chunk.xsl \
    --output ${MANUAL_BASEFILE}.xhtml/ ${MANUAL_BACKEND}/${MANUAL_NAME}.docbook 2> /dev/null

}
