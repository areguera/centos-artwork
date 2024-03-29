#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Output the absolute path you need to use to create temporal files to
# standard output.  Use this function whenever you need to create new
# temporal files inside tcar.sh script.
function tcar_getTemporalFile {

    # Define base name for temporal file. This is required when svg
    # instances are created previous to be parsed by inkscape in order
    # to be exported as png. In such cases .svg file extension is
    # required in order to avoid complains from inkscape.
    local FILENAME="${RANDOM}${RANDOM}-$(tcar_getRepoName ${1} -f)"

    # Check default base name for temporal file, it can't be an empty
    # value.
    if [[ -z "${FILENAME}" ]];then
        tcar_printMessage "`gettext "The first argument cannot be empty."`" --as-error-line
    fi

    # Define absolute path for temporal file and send it out to
    # standard output.
    echo "${TCAR_SCRIPT_TEMPDIR}/${FILENAME}"

}
