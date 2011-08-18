#!/bin/bash
#
# docbook_convertToPdf.sh -- This function takes DocBook XML as input
# and produces two different PDF as outputs; one from DocBook XML and
# another from DocBook SGML.  We decided to provide support for both
# ways of output production from DocBook XML and DocBook SGML for you
# to evaluate and if possible correct.
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

function docbook_convertToPdf {

    # Tranform DocBook XML to PDF.
    docbook_convertToPdfFromXml

    # Tranform DocBook SGML to PDF. 
    if [[ $(cli_getCurrentLocale) =~ '^en' ]];then
        # FIXME: This is only possible when no localization is
        # performed (i.e., xml2po is not involved.) to main DocBook
        # file, otherwise there will be errors and the PDF output
        # won't be created. The errors come out because when we passed
        # the validated DocBook file to xml2po all XML decimal
        # entities inside the main DocBook file are expanded and set
        # in the msgid field. Such expanded characters are not
        # recognized by openjade when they are used as source to
        # produce the PDF output. 
        docbook_convertToPdfFromSgml
    fi

}
