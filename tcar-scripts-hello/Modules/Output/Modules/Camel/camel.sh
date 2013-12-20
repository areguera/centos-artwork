#!/bin/bash
######################################################################
#
#   camel.sh -- Print greeting messages in camel-case (e.g., "HeLlO,
#   WoRlD!").  The output is printed out one character per line. This
#   might not have sense but it helps to describe how execution of
#   sibling modules work. Notice that, when printing final output,
#   punctuation marks doesn't count for formating. 
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2013
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

function camel {

    local GREETING_CAMEL=1
    local GREETING_OFFSET=0
    local GREETING_CHARS=${#HELLO_WORLD}
    local GREETING_MESSAGE=${HELLO_WORLD}

    while [[ ${GREETING_OFFSET} -lt ${GREETING_CHARS} ]]; do

        local HELLO_WORLD=${GREETING_MESSAGE:${GREETING_OFFSET}:1}

        if [[ ${GREETING_MESSAGE:${GREETING_OFFSET}:1} =~ '[[:alpha:]]' ]];then

            if [[ ${GREETING_CAMEL} -eq 1 ]];then
                tcar_setModuleEnvironment -m 'upper' -t 'sibling'
                GREETING_CAMEL=0
            else
                tcar_setModuleEnvironment -m 'lower' -t 'sibling'
                GREETING_CAMEL=1
            fi

        else
            
            if [[ ${GREETING_MESSAGE:${GREETING_OFFSET}:1} =~ ' ' ]];then
                HELLO_WORLD='·'
            fi

            tcar_printMessage "${HELLO_WORLD}" --as-stdout-line

        fi

        GREETING_OFFSET=$(( ${GREETING_OFFSET} + 1 ))

    done

}
