#!/bin/bash
######################################################################
#
#   prepare_setRenderEnvironment.sh -- This function provides a secure
#   interface to render content outside the render module. You can use
#   this function to call the render module from other modules,
#   safely. 
#
#   This function builds a list of all available configuration files
#   in locations passed as argument and reduces the list by applying
#   regular expression patterns to each file in the list. Only files
#   that match the regular expression pattern will remain in the final
#   list. The regular expression patterns are applied to file's
#   content, generally to find out if it has an specific option, value
#   or combination of both inside.  Later, the resultant list of
#   configuration files is passed to render module for processing.
#
#   This function verifies the search path provided to render module
#   to grant it is inside the repository before passing it to render
#   module for processing.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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
######################################################################

function prepare_setRenderEnvironment {

    OPTIND=1
    while getopts "o:,v:" OPTION "${@}"; do

        case "${OPTION}" in

            o )
                # Define the name of the option you want to look
                # configuration files for.
                local OPTION_NAME=${OPTARG}
                if [[ -z ${OPTION_NAME} ]];then
                    tcar_printMessage "`gettext "The option name cannot be empty."`" --as-error-line
                fi
                ;;

            v )
                # Define the value of the option you want to look
                # configuration files for.
                local OPTION_VALUE=${OPTARG}
                if [[ -z ${OPTION_VALUE} ]];then
                    tcar_printMessage "`gettext "The option value cannot be empty."`" --as-error-line
                fi
                ;;

        esac

    done

    # Clean up positional parameters to reflect the fact that options
    # have been processed already.
    shift $(( ${OPTIND} - 1 ))

    # Now that option arguments have been removed from positional
    # parameter, verify all other remaining arguments (the search
    # paths) do exist. They are required to search.
    if [[ -z ${@} ]];then
        tcar_printMessage "`gettext "The search path cannot be empty."`" --as-error-line
    fi

    # Define array variable to store configuration file paths.
    local -a CONFIGURATION_FILES

    # Define final filter regular expression. This regular expression
    # must match the option = "value" format we are using inside
    # configuration files.
    local CONFIGURATION_PATTERN="^${OPTION_NAME}[[:space:]]*=[[:space:]]*\"${OPTION_VALUE}\"$"

    for DIRECTORY in ${@};do

        # Clean-up the search path. This location must point to a
        # directory inside the workplace.
        DIRECTORY=$(tcar_checkWorkDirSource ${DIRECTORY})

        # Verify the search path. It must exist and being a directory.
        tcar_checkFiles -ed ${DIRECTORY}

        # Define the list of configuration files the render module
        # will use as reference to produce documentation. At this
        # point it is very difficult that DIRECTORY doesn't exist or
        # be outside the workplace directory structure.
        CONFIGURATION_FILES[++${#CONFIGURATION_FILES[*]}]=$(tcar_getFilesList \
            -p '.+\.conf$' -t 'l' ${DIRECTORY} \
                | xargs egrep ${CONFIGURATION_PATTERN} | cut -d: -f1 | sort | uniq)

    done

    # Process the list of configuration files using the render module.
    tcar_setModuleEnvironment -m "render" -t "parent" ${CONFIGURATION_FILES[*]}
}
