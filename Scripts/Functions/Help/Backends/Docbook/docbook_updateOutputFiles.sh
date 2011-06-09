#!/bin/bash
#
# docbook_updateOutputFiles.sh -- This function exports documentation
# manual from docbook input format to different output formats (e.g.,
# pdf, xhtml, rtf and txt).
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

function docbook_updateOutputFiles {

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Update docbook output files.
    docbook_updateOutputFilePdf
    docbook_updateOutputFileXhtml

}
