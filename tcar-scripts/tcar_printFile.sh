#!/bin/bash
######################################################################
#
#   tcar_printFile.sh -- This function standardizes the way files are
#   concatenated inside tcar.sh script.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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
######################################################################

function tcar_printFile {

    # Define absolute path to file you want to print. Take into
    # consideration that this file might be out of the repository
    # (e.g., it would be a temporal file stored under
    # /tmp/tcar-XXXXXX/ directory).
    local FILE="${1}"

    tcar_checkFiles -ef ${FILE}

    if [[ $(/usr/bin/file -b -i ${FILE}) =~ '^application/x-gzip$' ]];then
        /bin/zcat ${FILE}
    elif [[ $(/usr/bin/file -b -i ${FILE}) =~ '^application/x-bzip2$' ]];then
        /bin/bzcat ${FILE}
    else
        /bin/cat ${FILE}
    fi

}
