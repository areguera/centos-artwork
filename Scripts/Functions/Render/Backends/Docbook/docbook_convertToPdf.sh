#!/bin/bash
#
# docbook_convertToPdf.sh -- This function takes DocBook XML as input
# and produces two different PDF as outputs; one from DocBook XML and
# another from DocBook SGML.  To make the whole process transparent, a
# temporal directory is created for intermediate works and final files
# are moved then to their final location.
#
# Inside `centos-art.sh' script we provide support for both outputs
# produced from DocBook XML and DocBook SGML for you to evaluate and
# if possible correct.
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

function docbook_convertToPdf {

    # Tranform DocBook XML to PDF.
    ${RENDER_BACKEND}_convertToPdfFromXml

    # Tranform DocBook SGML to PDF.
    ${RENDER_BACKEND}_convertToPdfFromSgml

}
