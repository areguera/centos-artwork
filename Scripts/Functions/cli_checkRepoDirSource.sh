#!/bin/bash
#
# cli_checkRepoDirSource.sh -- This function provides input validation
# to repository entries considered as source locations.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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

function cli_checkRepoDirSource {


    # Define location in order to make this function reusable not just
    # for action value variable but whatever value passed as first
    # positional argument.
    local LOCATION=$1

    # Verify location. Assuming no location is passed as first
    # positional parameter to this function, print an error message
    # and stop script execution.
    if [[ "$LOCATION" == '' ]];then
        cli_printMessage "`gettext "The first positional parameter is required."`" --as-error-line
    fi

    # Check action value to be sure strange characters are kept far
    # away from path provided.
    cli_checkPathComponent $LOCATION

    # Redefine source value to build repository absolute path from
    # repository top level on. As we are removing
    # /home/centos/artwork/ from all centos-art.sh output (in order to
    # save horizontal output space), we need to be sure that all
    # strings begining with trunk/..., branches/..., and tags/... use
    # the correct absolute path. That is, you can refer trunk's
    # entries using both /home/centos/artwork/trunk/... or just
    # trunk/..., the /home/centos/artwork/ part is automatically added
    # here. 
    if [[ $LOCATION =~ '^(trunk|branches|tags)' ]];then
        LOCATION=${HOME}/artwork/$LOCATION 
    fi

    # Re-define source value to build repository absolute path from
    # repository relative paths. This let us to pass repository
    # relative paths as source value.  Passing relative paths as
    # source value may save us some typing; specially if we are stood
    # a few levels up from the location we want to refer to as source
    # value.  There is no need to pass the absolute path to it, just
    # refere it relatively.
    if [[ -d ${LOCATION} ]];then

        # Add directory to the top of the directory stack.
        pushd "$LOCATION" > /dev/null

        # Check directory existence inside the repository.
        if [[ $(pwd) =~ "^${HOME}/artwork" ]];then
            # Re-define source value using absolute path.
            LOCATION=$(pwd)
        else
            cli_printMessage "`eval_gettext "The location \\\"\\\$LOCATION\\\" is not valid."`" --as-error-line
        fi

        # Remove directory from the directory stack.
        popd > /dev/null

    elif [[ -f ${LOCATION} ]];then

        # Add directory to the top of the directory stack.
        pushd "$(dirname "$LOCATION")" > /dev/null

        # Check directory existence inside the repository.
        if [[ $(pwd) =~ "^${HOME}/artwork" ]];then
            # Re-define source value using absolute path.
            LOCATION=$(pwd)/$(basename "$LOCATION")
        else
            cli_printMessage "`eval_gettext "The location \\\"\\\$LOCATION\\\" is not valid."`" --as-error-line
        fi

        # Remove directory from the directory stack.
        popd > /dev/null

    fi

    # Output sanitated location.
    echo $LOCATION

}
