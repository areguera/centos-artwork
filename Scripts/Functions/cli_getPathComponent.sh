#!/bin/bash
#
# cli_getPathComponent.sh -- This function standardizes the way
# directory structures are organized inside the working copy of CentOS
# Artwork Repository. You can use this function to retrive information
# from path (e.g., releases, architectures and themes) or the patterns
# used to build the paths.
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

function cli_getPathComponent {

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='release,release-major,release-minor,release-pattern,architecture,architecture-pattern,theme,theme-name,theme-release,theme-pattern'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope.
    local ARGUMENTS=''

    # Define release pattern.
    local RELEASE="(([[:digit:]]+)(\.([[:digit:]]+)){,1})"

    # Define architecture pattern. Make it match the architectures the
    # CentOS distribution is able to be installed on.
    local ARCHITECTURE="(i386|x86_64)"

    # Define theme pattern for trunk, branches, and tags directory
    # structures.
    local THEME="Identity/Images/Themes/(([A-Za-z0-9]+)/(${RELEASE}))/"

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_doParseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_doParseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Define location we want to apply verifications to.
    local LOCATION=$(echo $@ | sed -r 's!^.*--[[:space:]](.+)$!\1!')

    # Look for options passed through positional parameters.
    while true;do

        case "$1" in

            --release )
                echo "$LOCATION" | egrep "${RELEASE}" | sed -r "s!.*/${RELEASE}/.*!\1!"
                shift 2
                break
                ;;

            --release-major )
                echo "$LOCATION" | egrep "${RELEASE}" | sed -r "s!.*/${RELEASE}/.*!\2!"
                shift 2
                break
                ;;

            --release-minor )
                echo "$LOCATION" | egrep "${RELEASE}" | sed -r "s!.*/${RELEASE}/.*!\4!"
                shift 2
                break
                ;;

            --release-pattern )
                echo "${RELEASE}"
                shift 2
                break
                ;;

            --architecture )
                echo "$LOCATION" | egrep "${ARCHITECTURE}" | sed -r "s!${ARCHITECTURE}!\1!"
                shift 2
                break
                ;;

            --architecture-pattern )
                echo "${ARCHITECTURE}"
                shift 2
                break
                ;;

            --theme )
                echo "$LOCATION" | egrep "${THEME}" | sed -r "s!.*${THEME}.*!\1!"
                shift 2
                break
                ;;

            --theme-name )
                echo "$LOCATION" | egrep "${THEME}" | sed -r "s!.*${THEME}.*!\2!"
                shift 2
                break
                ;;

            --theme-release )
                echo "$LOCATION" | egrep "${THEME}" | sed -r "s!.*${THEME}.*!\3!"
                shift 2
                break
                ;;

            --theme-pattern )
                echo "${THEME}"
                shift 2
                break
                ;;

        esac

    done
}
