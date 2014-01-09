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

# Print letters of a greeting message in a random order (e.g.,
# rdodldrl!,,!).  The final output is printed out one character per
# line. This might not have sense but it helps to describe how
# recursive execution of sibling modules work.
function random {

    local MESSAGE=${HELLO_WORLD}
    local MAXCHAR=${#MESSAGE}
    local COUNT=${1:-0}
    local OFFSET=${RANDOM}; let "OFFSET %= ${MAXCHAR}"

    tcar_printMessage "${MESSAGE:${OFFSET}:1}" --as-stdout-line

    COUNT=$(( ${COUNT} + 1))

    if [[ ${COUNT} -lt ${MAXCHAR} ]];then
        tcar_setModuleEnvironment -m random -t sibling -g "${COUNT}"
    fi

}
