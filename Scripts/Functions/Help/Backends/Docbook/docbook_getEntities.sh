#!/bin/bash
#
# docbook_getEntities.sh -- This function explores docbook's directory
# structure, takes file paths and transforms them into their related
# entity parts.
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

function docbook_getEntities {

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='name,path,pattern:'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope.
    local ARGUMENTS=''

    # Initialize entity related variable as local to avoid conflicts
    # outside this function scope.
    local ENTITY_NAMES=''
    local ENTITY_PATHS=''

    # Initialize name flag (`--name'). This flag specifies whether to
    # retrive the name part of the entity or not.
    local FLAG_NAME='false'

    # Initialize path flag (`--path'). This flag specifies whether to
    # retrive the name part of the entity or not.
    local FLAG_PATH='false'

    # Initialize pattern flag (`--pattern'). This flag specifies the
    # regular expression pattern applied to docbook list of files.  By
    # default no reduction is applied to docbook list of files (i.e.,
    # all docbook files are printed out).
    local FLAG_PATTERN=''

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_parseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_parseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through positional parameters.
    while true; do

        case "$1" in

            --name )
                FLAG_NAME='true'
                shift 1
                ;;

            --path )
                FLAG_PATH='true'
                shift 1
                ;;

            --pattern )
                FLAG_PATTERN="$2"
                shift 2
                ;;

            -- )
                shift 1
                break

        esac

    done

    # Build list of all docbook files inside docbook directory
    # structure.
    local FILE=''
    local FILES=$(cli_getFilesList ${@} --pattern="${FLAG_PATTERN}.*\.${FLAG_BACKEND}" --type='f')

    # Loop through all docbook files under docbook directory structure
    # to retrive both entity names and entity relative paths.
    for FILE in $FILES;do

        # Build entity's name.
        ENTITY_NAME=$(echo $FILE | cut -d/ -f 9- \
            | sed -r 's!/!-!'g | tr '[:upper:]' '[:lower:]' \
            | sed "s/\.${FLAG_BACKEND}$//")

        # Build entity's relative path.
        ENTITY_PATH=$(echo $FILE | sed -r "s!${MANUAL_BASEDIR}/Entities/!!")

        # Output entity information as specified by options. When no
        # option is specified the entity full definition is output.
        if [[ $FLAG_NAME == 'true' ]];then
            echo "&${ENTITY_NAME};"
        elif [[ $FLAG_PATH == 'true' ]];then
            echo ${ENTITY_PATH}
        else
            echo ${ENTITY_NAME} ${ENTITY_PATH} \
                | gawk '{ printf "\t<!ENTITY %s SYSTEM \"%s\">\n", $1, $2}'
        fi

    done

}
