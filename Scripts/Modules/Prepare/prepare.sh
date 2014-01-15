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

# Standardize configuration tasks related to the repository's
# workplace.
#
# When you install The CentOS Artwork Repository most of its content
# is in source format (e.g., svgz, asciidoc, etc.). In order to
# produce final content and make the connections between the produced
# components, you need to process the source formats somewhere inside
# your workstation.  The prepare module takes the first non-option
# argument passed in the command-line as the working directory where
# you are going to process source formats in your workstation. During
# the preparation process, the prepare command creates the directory
# structure, the connection with The CentOS Artwork Repository using
# symbolic links, and images required to brand other images.
#
# prepare must be the first command you run after installing The
# CentOS Artwork Repository in your workstation.
function prepare {

    if [[ ${TCAR_SCRIPT_ARGUMENT} =~ '^ *$' ]];then
        prepare_printUsage
    else
        prepare_getOptions
    fi

    for TCAR_WORKDIR in ${TCAR_SCRIPT_ARGUMENT};do
        prepare_setWorkdir
    done

}
