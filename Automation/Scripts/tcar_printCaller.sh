#!/bin/bash
######################################################################
#
#   tcar_printCaller.sh -- This function standardizes the way caller
#   information is retrieved.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Project
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
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
######################################################################

function tcar_printCaller {

    local EXPR=${1}
    local OPTS=${2}

    case ${OPTS} in

        --line )
            caller ${EXPR} | gawk '{ print $1 }'
            ;;

        --name )
            caller ${EXPR} | gawk '{ print $2 }'
            ;;

        --path )
            caller ${EXPR} | gawk '{ print $3 }'
            ;;

        * )
            # Define where the error was originated inside the
            # centos-art.sh script. Print out the function name and
            # line from the caller.
            caller ${EXPR} | gawk '{ print $2 " L." $1 }'
            ;;

    esac

}
