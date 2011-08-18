#!/bin/bash
#
# cli_getPathComponent.sh -- This function standardizes the way
# directory structures are organized inside the working copy of CentOS
# Artwork Repository. You can use this function to retrive information
# from paths (e.g., releases, architectures and theme artistic motifs)
# or the patterns used to build the paths.
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
    local ARGSL='release,release-major,release-minor,release-pattern,architecture,architecture-pattern,motif,motif-name,motif-release,motif-pattern'

    # Initialize ARGUMENTS with an empty value and set it as local
    # variable to this function scope.
    local ARGUMENTS=''

    # Define release pattern.
    local RELEASE="(([[:digit:]]+)(\.([[:digit:]]+)){0,1})"

    # Define architecture pattern. Make it match the architectures the
    # CentOS distribution is able to be installed on.
    local ARCHITECTURE="(i386|x86_64)"

    # Define pattern for themes' artistic motifs.
    local THEME_MOTIF="Identity/Images/Themes/(([[:alnum:]]+)/(${RELEASE}))"

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_parseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_parseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Define location we want to apply verifications to.
    local LOCATION=$(echo $@ | sed -r 's!^.*--[[:space:]](.+)$!\1!')

    # Look for options passed through positional parameters.
    while true;do

        case "$1" in

            --release )
                echo "$LOCATION" | egrep "${RELEASE}" | sed -r "s!.*/${RELEASE}/.*!\1!"
                shift 1
                break
                ;;

            --release-major )
                echo "$LOCATION" | egrep "${RELEASE}" | sed -r "s!.*/${RELEASE}/.*!\2!"
                shift 1
                break
                ;;

            --release-minor )
                echo "$LOCATION" | egrep "${RELEASE}" | sed -r "s!.*/${RELEASE}/.*!\4!"
                shift 1
                break
                ;;

            --release-pattern )
                echo "${RELEASE}"
                shift 1
                break
                ;;

            --architecture )
                echo "$LOCATION" | egrep "${ARCHITECTURE}" | sed -r "s!${ARCHITECTURE}!\1!"
                shift 1
                break
                ;;

            --architecture-pattern )
                echo "${ARCHITECTURE}"
                shift 1
                break
                ;;

            --motif )
                echo "$LOCATION" | egrep "${THEME_MOTIF}" | sed -r "s!.*${THEME_MOTIF}.*!\1!"
                shift 1
                break
                ;;

            --motif-name )
                echo "$LOCATION" | egrep "${THEME_MOTIF}" | sed -r "s!.*${THEME_MOTIF}.*!\2!"
                shift 1
                break
                ;;

            --motif-release )
                echo "$LOCATION" | egrep "${THEME_MOTIF}" | sed -r "s!.*${THEME_MOTIF}.*!\3!"
                shift 1
                break
                ;;

            --motif-pattern )
                echo "${THEME_MOTIF}"
                shift 1
                break
                ;;

        esac

    done
}
