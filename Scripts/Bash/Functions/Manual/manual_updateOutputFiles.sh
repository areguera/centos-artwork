#!/bin/bash
#
# manual_updateOutputFiles.sh -- This function updates manuals' related
# output files.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function manual_updateOutputFiles {

    # Add division line to differentiate action output visually.
    cli_printMessage '-' 'AsSeparatorLine'

    # Add the working copy root directory to directory stack to make
    # path construction correctly. Otherwise, makeinfo may produce
    # paths incorrectly.
    pushd /home/centos/artwork > /dev/null

    manual_updateOutputFileInfo
    manual_updateOutputFileHtml
    manual_updateOutputFilePdf
    manual_updateOutputFilePlaintext

    # Remove the working copy root directory from directory stack.
    popd > /dev/null

}
