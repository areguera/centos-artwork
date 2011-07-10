#!/bin/bash
#
# help.sh -- This function initializes the interface used by
# centos-art.sh script to perform documentation tasks through
# different documentation backends.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------
    
function help {

    local ACTIONNAM=''
    local ACTIONVAL=''

    # Initialize search option (`--search'). This option is used to
    # look for documentation inside documentation backends.
    local FLAG_SEARCH=""

    # Initialize manual's ID. By default, The CentOS Artwork
    # Repository User's Guide is used. This value can be changed
    # using the `--manual' option from the command-line.
    local FLAG_MANUAL="TCAR-UG"

    # Initialize manual's language.
    local MANUAL_L10N=$(cli_getCurrentLocale)

    # Initialize manual's backend. By default, texinfo is used as
    # documentation backend. This value can be changed using the
    # `--backend' option from the command-line.
    local MANUAL_BACKEND='texinfo'

    # Interpret option arguments passed through the command-line.
    ${FUNCNAM}_getOptions

    # Initialize manual's backend directory. This is the place where
    # the backend specific documentation structure is stored in.
    MANUAL_TLDIR="${HOME}/artwork/branches/Manuals/$(cli_getRepoName \
        $MANUAL_BACKEND -d)/${FLAG_MANUAL}"

    # Initialize manual's file name (without extension).
    MANUAL_NAME=$(cli_getRepoName "$(basename $FLAG_MANUAL)" -f)

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS" 

    # Initialize backend-specific functionalities.
    cli_exportFunctions "${FUNCDIR}/${FUNCDIRNAM}/$(cli_getRepoName \
        ${MANUAL_BACKEND} -d)" "${MANUAL_BACKEND}"

    # Execute backend-specific actions.
    ${MANUAL_BACKEND} $@

}
