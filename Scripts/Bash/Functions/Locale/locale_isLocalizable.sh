#!/bin/bash
#
# locale_isLocalizable.sh -- This function determines whether a file or
# directory can have translation messages or not. This is the way we
# standardize what locations can be localized and what cannot inside
# the repository. This function returns 0 when the path is localizable
# and 1 when it is not.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function locale_isLocalizable {

    local DIR=''
    local -a DIRS

    # Initialize location will use as reference to determine whether
    # it can have translation messages or not.
    local LOCATION="$1"
    
    # When no variable is passed to this function, use the action
    # value instead.
    if [[ $LOCATION == '' ]];then
        LOCATION=${ACTIONVAL}
    fi

    # Redefine location to be sure we'll always evaluate a directory,
    # as reference location.
    if [[ -f $LOCATION ]];then
        LOCATION=$(dirname $LOCATION)
    fi

    # Verify location existence. If it doesn't exist we cannot go on.
    cli_checkFiles $LOCATION -d

    # Define regular expresion list of all directories inside the
    # repository that can have translation. These are the
    # locale-specific directories will be created for.
    DIRS[++((${#DIRS[*]}))]="$(cli_getRepoTLDir)/Identity/Models/Themes/[[:alnum:]-]+/(Distro/$(\
        cli_getPathComponent --release-pattern)/Anaconda|Concept|Posters|Media)"
    DIRS[++((${#DIRS[*]}))]="$(cli_getRepoTLDir)/Documentation/Models/Docbook/[[:alnum:]-]+$"
    DIRS[++((${#DIRS[*]}))]="$(cli_getRepoTLDir)/Scripts/Bash$"

    # Verify location passed as first argument agains the list of
    # directories that can have translation messages. By default, the
    # location passed as first argument is considered as a location
    # that cannot have translation messages until a positive answer
    # says otherwise.
    for DIR in ${DIRS[@]};do
        if [[ $LOCATION =~ $DIR ]];then
            return 0
        fi
    done

    # Output final answer to all verifications. 
    return 1

}
