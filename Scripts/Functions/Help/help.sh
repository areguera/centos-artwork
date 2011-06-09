#!/bin/bash
#
# help.sh -- This function standardizes the way documentation is
# produced and maintained inside the working copy of CentOS Artwork
# Repository.
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
    
function help {

    local ACTIONNAM=''
    local ACTIONVAL=''

    # Initialize the search option. The search option (`--search')
    # specifies the pattern used inside info files when an index
    # search is perform.
    FLAG_SEARCH=""

    # Initialize the backend option. The backend option (`--backend')
    # specifies the backend used to manipulate the repository
    # documentation manual.
    FLAG_BACKEND="texinfo"

    # Define manual base directory. This is the place where all
    # different formats of repository documentation manual are stored
    # in.
    MANUAL_BASEDIR="$(cli_getRepoTLDir)/Manuals"

    # Define file name (without extension) for documentation manual.
    MANUAL_NAME=$(cli_getRepoName "repository" -f)

    # Define language information used by manual.
    MANUAL_LANG=$(cli_getCurrentLocale)

    # Interpret option arguments passed through the command-line.
    ${FUNCNAM}_getOptions

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Verify and initialize backend functions.  There is no need to
    # load all backend-specific functions when we can use just one
    # backend among many. Keep the cli_getFunctions function calling
    # after all variables and arguments definitions.
    if [[ ${FLAG_BACKEND} =~ '^texinfo$' ]];then
        cli_getFunctions "${FUNCDIR}/${FUNCDIRNAM}" 'texinfo'
    elif [[ ${FLAG_BACKEND} =~ '^docbook$' ]];then
        cli_getFunctions "${FUNCDIR}/${FUNCDIRNAM}" 'docbook'
    else
        cli_printMessage "`gettext "The backend provided is not supported."`" --as-error-line
    fi

    # Execute backend initialization.
    ${FLAG_BACKEND} "$@"

}
