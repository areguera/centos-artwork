#!/bin/bash
#
# cli_getTemporalFile.sh -- This function returns the absolute path
# you need to use to create temporal files. Use this function whenever
# you need to create temporal files inside centos-art.sh script.
#
# Copyright (C) 2009-2011 The CentOS Project
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
    local NAME="$(cli_getRepoName "$1" 'f')"

    # Check default base name for temporal file, it can't be an empty
    # value.
    if [[ "$NAME" == '' ]];then
        cli_printMessage "${FUNCNAME}: `gettext "First argument cannot be empty."`"
        cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
    fi

    # Define source location where temporal files will be stored.
    local TMPDIR='/tmp'

    # Define unique identifier for temporal file.
    local UUID=$(cat /proc/sys/kernel/random/uuid)

    # Define absolute path for temporal file using the program name,
    # the current locale, the unique identifier and the file name. 
    local TMPFILE="${TMPDIR}/${CLI_PROGRAM}-$(cli_getCurrentLocale)-${UUID}-${NAME}"

    # Output absolute path to final temporal file.
    echo $TMPFILE

}
