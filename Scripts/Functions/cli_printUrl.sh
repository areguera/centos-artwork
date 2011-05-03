#!/bin/bash
#
# cli_printUrl.sh -- This function standardize the way URLs are
# printed inside centos-art.sh script. This function describes the
# domain organization of The CentOS Project through its URLs and
# provides a way to print them out when needed.
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

function cli_printUrl {

    local URL=''

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='home,lists,wiki,forums,bugs,planet,docs,mirrors,irc,projects,cc-sharealike,with-locale,as-html-link'

    # Define ARGUMENTS as local variable in order to parse options
    # internlally.
    local ARGUMENTS=''

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_doParseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_doParseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do
        case "$1" in

            --home )
                URL='http://www.centos.org/'
                shift 1
                ;;

            --lists )
                URL='http://lists.centos.org/'
                shift 1
                ;;

            --wiki )
                URL='http://wiki.centos.org/'
                shift 1
                ;;

            --forums )
                URL='http://forums.centos.org/'
                shift 1
                ;;

            --bugs )
                URL='http://bugs.centos.org/'
                shift 1
                ;;

            --projects )
                URL='http://projects.centos.org/'
                shift 1
                ;;

            --projects-artwork )
                URL='http://projects.centos.org/svn/artwork'
                shift 1
                ;;

            --planet )
                URL='http://planet.centos.org/'
                shift 1
                ;;

            --docs )
                URL='http://docs.centos.org/'
                shift 1
                ;;

            --mirrors )
                URL='http://mirrors.centos.org/'
                shift 1
                ;;

            --irc )
                URL='http://www.centos.org/modules/tinycontent/index.php?id=8'
                shift 1
                ;;

            --cc-sharealike )
                URL="http://creativecommons.org/licenses/by-sa/3.0/"
                shift 1
                ;;

            --with-locale )
                if [[ ! $(cli_getCurrentLocale) =~ '^en' ]];then
                    URL="${URL}$(cli_getCurrentLocale '--langcode-only')/"
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
