#!/bin/bash
#
# cli_printUrl.sh -- This function standardizes the way URLs are
# printed by centos-art.sh script. This function describes the
# domain organization of The CentOS Project through its URLs and
# provides a way to print them out when needed.
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

function cli_printUrl {

    local URL=''

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='domain,home,lists,wiki,forums,bugs,planet,docs,mirrors,irc,projects,projects-artwork,cc-sharealike,with-locale,as-html-link'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope. Doing this is very important to
    # avoid any clash with higher execution environments.
    local ARGUMENTS=''

    # Prepare ARGUMENTS for getopt.
    cli_parseArgumentsReDef "$@"

    # Redefine ARGUMENTS using getopt(1) command parser.
    cli_parseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do
        case "$1" in

            --domain )
                URL="${TCAR_BRAND}.org"
                shift 1
                ;;

            --home )
                URL="http://www.$(cli_printUrl --domain)/"
                shift 1
                ;;

            --lists )
                URL="http://lists.$(cli_printUrl --domain)/"
                shift 1
                ;;

            --wiki )
                URL="http://wiki.$(cli_printUrl --domain)/"
                shift 1
                ;;

            --forums )
                URL="http://forums.$(cli_printUrl --domain)/"
                shift 1
                ;;

            --bugs )
                URL="http://bugs.$(cli_printUrl --domain)/"
                shift 1
                ;;

            --projects )
                URL="https://projects.$(cli_printUrl --domain)/svn/"
                shift 1
                ;;

            --projects-artwork )
                URL="$(cli_printUrl --projects)artwork/"
                shift 1
                ;;

            --planet )
                URL="http://planet.$(cli_printUrl --domain)/"
                shift 1
                ;;

            --docs )
                URL="http://docs.$(cli_printUrl --domain)/"
                shift 1
                ;;

            --mirrors )
                URL="http://mirrors.$(cli_printUrl --domain)/"
                shift 1
                ;;

            --irc )
                URL="http://$(cli_printUrl --home)modules/tinycontent/index.php?id=8"
                shift 1
                ;;

            --cc-sharealike )
                URL="http://creativecommons.org/licenses/by-sa/3.0/"
                shift 1
                ;;

            --with-locale )
                if [[ ! ${LANG} =~ '^en' ]];then
                    URL="${URL}${CLI_LANG_LL}/"
                fi
                shift 1
                ;;

            --as-html-link )
                URL="<a href=\"$URL\">${URL}</a>"
                shift 1
                ;;

            -- )

                shift 1
                break
                ;;
        esac
    done

    # Print Url.
    echo "$URL"

}
