#!/bin/bash
#
# render_docbook_convertToXhtml.sh -- This function produces XHTML
# output from docbook template instance using XSL stylesheets as
# reference.
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

function render_docbook_convertToXhtml {

    # Print action message.
    if [[ -f ${FILE}.xhtml ]];then
        cli_printMessage "${FILE}.xhtml" --as-updating-line
    else
        cli_printMessage "${FILE}.xhtml" --as-creating-line
    fi

    # Define list of XSL stylesheets.
    local XSL='/usr/share/sgml/docbook/xsl-stylesheets/xhtml/docbook.xsl'

    # Produce xhtml output from docbook template instance using XSL
    # stylesheets as reference.
    xsltproc ${XSL} $INSTANCE > ${FILE}.xhtml

}
