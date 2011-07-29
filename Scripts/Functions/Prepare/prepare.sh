#!/bin/bash
#
# prepare.sh (initialization) -- This function creates the base
# execution environment required to standardize final configuration
# stuff needed by your workstation, once the working copy of The
# CentOS Artwork Repository has been downloaded in it.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function prepare {

    local ACTIONNAM=''
    local ACTIONNAMS=''

    # Define absolute path to directory holding prepare's
    # configuration files.
    local PREPARE_CONFIG_DIR=${CLI_FUNCDIR}/${CLI_FUNCDIRNAM}/Config

    # Interpret arguments and options passed through command-line.
    ${CLI_FUNCNAME}_getOptions

    # Execute action names based on whether they were provided or not.
    if [[ $ACTIONNAMS == '' ]];then

        # When action names are not provided, define action names that
        # will take place, explicitly.
        ${CLI_FUNCNAME}_updatePackages
        ${CLI_FUNCNAME}_updateLinks
        ${CLI_FUNCNAME}_updateImages
        ${CLI_FUNCNAME}_updateManuals

    else

        # When action names are provided, loop through them and
        # execute them one by one.
        for ACTIONNAM in $ACTIONNAMS;do
            ${CLI_FUNCNAME}_${ACTIONNAM}
        done

    fi

}
