#!/bin/bash
#
# texinfo_updateOutputFiles.sh -- This function exports documentation
# manual to different output formats.
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

function texinfo_updateOutputFiles {

    # Verify manual base file. We can update manual outputs only if
    # its base file exists. For example, we cannot update manual
    # outputs if the manual has been deleted previously.
    if [[ ! -a ${MANUAL_BASEFILE}.${MANUAL_EXTENSION} ]];then
        return
    fi

    # Print separator line.
    cli_printMessage "`gettext "Updating output files"`" --as-banner-line

    # Add the working copy root directory to directory stack to make
    # path construction correctly. Otherwise, makeinfo may produce
    # paths incorrectly.
    pushd ${CLI_WRKCOPY} > /dev/null

    ${FLAG_BACKEND}_updateOutputFileInfo
    ${FLAG_BACKEND}_updateOutputFileXhtml
    ${FLAG_BACKEND}_updateOutputFileXml
    ${FLAG_BACKEND}_updateOutputFileDocbook
    ${FLAG_BACKEND}_updateOutputFilePdf
    ${FLAG_BACKEND}_updateOutputFilePlaintext

    # Remove the working copy root directory from directory stack.
    popd > /dev/null

}
