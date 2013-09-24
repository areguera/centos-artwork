#!/bin/bash
######################################################################
#
#   svg_createSvgInstance.sh -- This function verifies whether the
#   file being processed is compressed or not, then uses that
#   information to read the file and create an instance of it.
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

function svg_createSvgInstance {

    if [[ $(file -b -i ${SVG_FILE}) =~ '^application/x-gzip$' ]];then
        /bin/zcat ${SVG_FILE} > ${SVG_INSTANCE}
    else
        /bin/cat ${SVG_FILE} > ${SVG_INSTANCE}
    fi

}
