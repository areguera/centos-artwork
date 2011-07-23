#!/bin/bash
#
# texinfo_updateOutputFilePdf.sh -- This function exports documentation
# manual to PDF format.
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

function texinfo_updateOutputFilePdf {

    # Output action message.
    cli_printMessage "${MANUAL_BASEFILE}.pdf" --as-response-line

    # Update plaintext output directory.
    /usr/bin/texi2pdf --quiet \
        ${MANUAL_BASEFILE}.${MANUAL_EXTENSION} --output=${MANUAL_BASEFILE}.pdf

}
