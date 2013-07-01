#!/bin/bash
#
# texinfo_updateOutputFiles.sh -- This function exports documentation
# manual to different output formats.
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

function texinfo_updateOutputFiles {

    # Verify manual base file. We can update manual outputs only if
    # its base file exists. For example, we cannot update manual
    # outputs if the manual has been deleted previously.
    if [[ ! -a ${MANUAL_BASEFILE}.${MANUAL_EXTENSION} ]];then
        return
    fi

    # Verify output directory.
    if [[ ! -d $(dirname $MANUAL_OUTPUT_BASEFILE) ]];then
        mkdir -p $(dirname $MANUAL_OUTPUT_BASEFILE)
    fi

    # Move script execution to manuals base directory in order for
    # makeinfo to produce content correctly. This is the location
    # where the documentation's main definition file is stored in.
    # Related content outside this location is accessible through
    # symbolic links.
    pushd ${MANUAL_BASEDIR_L10N} > /dev/null

    # Verify existence of link to Licenses information.
    texinfo_updateLicenseLink

    # Keep the order in which these actions are performed. Begin with
    # actions that use the makeinfo file to realize the export. Later,
    # continue with action that need other tools to realize the export
    # (e.g., texi2html to produce XHTML and texi2pdf to produce PDF
    # outputs).
    texinfo_updateOutputFileInfo
    texinfo_updateOutputFileXml
    texinfo_updateOutputFileDocbook
    texinfo_updateOutputFilePlaintext
    texinfo_updateOutputFileXhtml
    texinfo_updateOutputFilePdf

    # Remove the working copy root directory from directory stack.
    popd > /dev/null

}
