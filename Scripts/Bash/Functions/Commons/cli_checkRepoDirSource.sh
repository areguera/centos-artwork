#!/bin/bash
#
# cli_checkRepoDirSource.sh -- This function standardizes the path
# construction to directories inside the working copy, using absolute
# paths. This function transforms relative paths passed as non-option
# arguments to centos-art.sh script command-line into absolute paths
# inside the working copy and verifies whether they really exist as
# directories inside the working copy or not. If the path provided
# doesn't exist as directory inside the working copy, the script will
# finish its execution immediately with an error message. Otherwise,
# if the directory exists, the variable ACTIONVAL is redefined with
# the related absolute path for further use.
#
#   NOTE: Transforming relative paths into absolute paths before
#   processing them is very useful when you need to execute the
#   centos-art.sh script anywhere inside the workstation.
#
# Use this function whenever you need to be sure that non-option
# arguments passed to centos-art.sh script command-line will always
# point to directories inside the working copy.
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

function cli_checkRepoDirSource {

    local LOCATION=${1}

    # Redefine source value to build repository absolute path from
    # repository top level on. As we are removing the absolute path
    # prefix (e.g., `/home/centos/artwork/') from all centos-art.sh
    # output (in order to save horizontal output space), we need to be
    # sure that all strings begining with `trunk/...', `branches/...',
    # and `tags/...' use the correct absolute path. That is, you can
    # refer trunk's entries using both
    # `/home/centos/artwork/trunk/...' or just `trunk/...', the
    # `/home/centos/artwork/' part is automatically added here. 
    if [[ $ACTIONVAL =~ '^(trunk|branches|tags)' ]];then
        ACTIONVAL=${TCAR_WORKDIR}/$ACTIONVAL 
    fi

    # Generally, action value should point to directories inside the
    # working copy. However, when we are working with documentation,
    # it points to documentation entries (i.e., regular files). Lets
    # consider this and realize verification of source locations based
    # on whether they are directories or files.
    if [[ -f ${ACTIONVAL} ]];then

        # Check action value to be sure strange characters are kept
        # far away from the path provided as action value.
        if [[ ! ${ACTIONVAL} =~ "^[[:alnum:]/_-]+\.[[:alnum:]]+$" ]];then
            cli_printMessage "${ACTIONVAL} `gettext "contains an invalid format"`" --as-error-line
        fi

    else

        # Check action value to be sure strange characters are kept
        # far away from the path provided as action value.
        if [[ ! ${ACTIONVAL} =~ "^[[:alnum:]/_-]+$" ]];then
            cli_printMessage "${ACTIONVAL} `gettext "contains an invalid format"`" --as-error-line
        fi

        # Be sure that action value does exist and is a directory
        # before processing it.
        cli_checkFiles -d ${ACTIONVAL}

    fi

}
