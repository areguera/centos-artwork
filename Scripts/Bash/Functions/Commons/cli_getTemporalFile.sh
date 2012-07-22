#!/bin/bash
#
# cli_getTemporalFile.sh -- This function returns the absolute path
# you need to use to create temporal files. Use this function whenever
# you need to create temporal files inside centos-art.sh script.
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

function cli_getTemporalFile {

    # Define base name for temporal file. This is required when svg
    # instances are created previous to be parsed by inkscape in order
    # to be exported as png. In such cases .svg file exention is
    # required in order to avoid complains from inkscape.
    local NAME="$(cli_getRepoName $1 -f)"

    # Check default base name for temporal file, it can't be an empty
    # value.
    if [[ "$NAME" == '' ]];then
        cli_printMessage "`gettext "The first argument cannot be empty."`" --as-error-line
    fi

    # Define absolute path for temporal file. 
    local TEMPFILE="$(mktemp ${CLI_TEMPDIR}/${NAME}.XXXXXXXXXX)"

    # Output absolute path to final temporal file.
    echo $TEMPFILE

}
