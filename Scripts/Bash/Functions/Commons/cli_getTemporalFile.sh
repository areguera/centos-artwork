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

    # Redefine file name for the temporal file. Make it a combination
    # of the program name, the program process id, a random string and
    # the design model name. Using the program name and process id in
    # the file name let us to relate both the shell script execution
    # and the temporal files it creates, so they can be removed in
    # case an interruption signal be detected. The random string let
    # us to produce the same artwork in different terminals at the
    # same time. the The design model name provides file
    # identification.
    NAME=${CLI_NAME}-${CLI_PPID}-${RANDOM}-${NAME}

    # Define absolute path for temporal file using the program name,
    # the current locale, the unique identifier and the file name. 
    local TEMPFILE="${CLI_TEMPDIR}/${NAME}"

    # Output absolute path to final temporal file.
    echo $TEMPFILE

}
