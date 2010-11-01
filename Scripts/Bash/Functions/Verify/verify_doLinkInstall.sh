#!/bin/bash
#
# verify_doLinkInstall.sh -- This function receives a list of missing
# links and installs them using `ln'.
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

function verify_doLinkInstall {

    local ID=0
    local LINKS_PARENT=''
    local WARNING=''

    for ID in $LINKS_MISSING_ID;do

        # Verify parent directory of missing link names that have a
        # file as target. If the parent directory doesn't exist,
        # create it first before creating links inside it. Because
        # links are not created yet, we use their targets as reference
        # to determine what type of link we are creating.
        if [[ -f ${TARGETS[$ID]} ]];then
            LINKS_PARENT=$(dirname ${LINKS[$ID]})
            cli_checkFiles $LINKS_PARENT 'd' '' '--quiet'
            if [[ $? -ne 0 ]];then
                mkdir -p $LINKS_PARENT
            fi
        fi

        # Verify missing link that already exists as regular file. If
        # a regular file exists with the same name of a required link,
        # warn the user about it and continue with the next file in
        # the list of missing links that need to be installed.
        cli_checkFiles ${LINKS[$ID]} 'f' '' '--quiet'
        if [[ $? -eq 0 ]];then
            WARNING=" (`gettext "Already exists as regular file."`)"
            cli_printMessage "${LINKS[$ID]}${WARNING}" 'AsResponseLine'
            continue
        fi

        # Create symbolic link.
        ln -s ${TARGETS[$ID]} ${LINKS[$ID]}

    done

}
