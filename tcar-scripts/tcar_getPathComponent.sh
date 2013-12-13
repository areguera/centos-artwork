#!/bin/bash
######################################################################
#
#   tcar_getPathComponent.sh -- This function standardizes the way
#   directory structures are organized inside the working copy of
#   CentOS Artwork Repository. You can use this function to retrieve
#   information from paths (e.g., releases, architectures and theme
#   artistic motifs) or the patterns used to build the paths.
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

function tcar_getPathComponent {

    # Define release pattern.
    local VERSION="(([[:digit:]]+)(\.([[:digit:]]+))?)"

    # Define architecture pattern. Make it match the architectures the
    # CentOS distribution is able to be installed on.
    local ARCHITECTURE="(i386|x86_64)"

    # Define regular expression pattern that match the theme artistic
    # motif component inside the path strings.
    local THEME_MOTIF="Themes/Motifs/(([[:alnum:]]+)/(${VERSION}))"

    # Define location we want to apply verifications to.
    local LOCATION=${1}

    # Remove location from positional parameters, so only the option
    # remain.
    shift 1

    # Look for options passed through positional parameters.
    while true;do

        case "${1}" in

            --release )
                echo "${LOCATION}" | egrep "${VERSION}" | sed -r "s!.*/${VERSION}/.*!\1!"
                shift 1
                break
                ;;

            --release-major )
                echo "${LOCATION}" | egrep "${VERSION}" | sed -r "s!.*/${VERSION}/.*!\2!"
                shift 1
                break
                ;;

            --release-minor )
                echo "${LOCATION}" | egrep "${VERSION}" | sed -r "s!.*/${VERSION}/.*!\4!"
                shift 1
                break
                ;;

            --release-pattern )
                echo "${VERSION}"
                shift 1
                break
                ;;

            --architecture )
                echo "${LOCATION}" | egrep "${ARCHITECTURE}" | sed -r "s!${ARCHITECTURE}!\1!"
                shift 1
                break
                ;;

            --architecture-pattern )
                echo "${ARCHITECTURE}"
                shift 1
                break
                ;;

            --motif )
                echo "${LOCATION}" | egrep "${THEME_MOTIF}" | sed -r "s!.*${THEME_MOTIF}.*!\1!"
                shift 1
                break
                ;;

            --motif-name )
                echo "${LOCATION}" | egrep "${THEME_MOTIF}" | sed -r "s!.*${THEME_MOTIF}.*!\2!"
                shift 1
                break
                ;;

            --motif-version )
                echo "${LOCATION}" | egrep "${THEME_MOTIF}" | sed -r "s!.*${THEME_MOTIF}.*!\3!"
                shift 1
                break
                ;;

            --motif-pattern )
                echo "${THEME_MOTIF}"
                shift 1
                break
                ;;

            --repo-dir )
                echo "${LOCATION}" | sed "s,${TCAR_USER_WRKDIR}/,,"
                shift 1
                break
                ;;

        esac

    done

}
