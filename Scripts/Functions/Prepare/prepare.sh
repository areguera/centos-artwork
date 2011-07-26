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

    # Initialize action name variable. Here is where we store the
    # name of the actions that will be executed based on the options
    # passed in the command-line.
    local ACTIONNAM=''
    local ACTIONNAMS=''

    # Define absolute path to directory holding prepare's
    # configuration files.
    PREPARE_CONFIG_DIR=${FUNCDIR}/${FUNCDIRNAM}/Config

    # Interpret arguments and options passed through command-line.
    prepare_getOptions

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Execute action names.
    for ACTIONNAM in $ACTIONNAMS;do
        ${ACTIONNAM}
    done

}
