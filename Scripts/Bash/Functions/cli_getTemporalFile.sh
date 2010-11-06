#!/bin/bash
#
# cli_getTemporalFile.sh -- This function returns absolute path to
# temporal file. Use this function whenever you need to create
# temporal files inside centos-art.sh script.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

function cli_getTemporalFile {

    # Check amount arguments passed to this function.
    if [[ $# -ne 1 ]];then
        cli_printMessage "cli_getTemporalFile: `gettext "First argument is required."`"
        cli_printMessage "$(caller)" 'ToKnowMoreLine'
    fi

    # Define default basename for temporal file. This is required when
    # svg instances are created previous to be parsed by inkscape in
    # order to be exported as png. In such cases .svg file exention is
    # required in order to avoid inkscape complains.
    local NAME="$1"
    if [[ "$NAME" == '' ]];then
        cli_printMessage "cli_getTemporalFile: `gettext "First argument cannot be empty."`"
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    else
        NAME="-$(basename $1)" 
    fi

    # Define default source location where temporal files will be stored.
    local TMPDIR='/tmp'

    # Define default prefix for temporal file.
    local PREFIX='centos-art.sh-'

    # Define unique identifier for temporal file.
    local UUID=$(cat /proc/sys/kernel/random/uuid)

    # Join default source location and filename to build final
    # temporal file absolute path.
    local TMPFILE=$(echo -n "${TMPDIR}/${PREFIX}${UUID}${NAME}")

    # Output absolute path to final temporal file.
    echo $TMPFILE

}
