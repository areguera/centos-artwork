#!/bin/bash
#
# help_updateOutputFiles.sh -- This function exports documentation
# manual to different output formats.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function help_updateOutputFiles {

    # Print separator line.
    cli_printMessage '-' 'AsSeparatorLine'

    # Remove extension from manual's base file. This way it is
    # possible to reuse the same filename on different types of files.
    MANUAL_BASEFILE=$(echo ${MANUAL_BASEFILE} | sed -r 's!\.texi!!')

    # Add the working copy root directory to directory stack to make
    # path construction correctly. Otherwise, makeinfo may produce
    # paths incorrectly.
    pushd ${HOME}/artwork > /dev/null

    help_updateOutputFileInfo
    help_updateOutputFileXhtml
    help_updateOutputFileXml
    help_updateOutputFilePdf
    help_updateOutputFilePlaintext

    # Remove the working copy root directory from directory stack.
    popd > /dev/null

}
