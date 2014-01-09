#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Standardize the way URLs are printed by tcar.sh script. This
# function describes the domain organization of The CentOS Project
# through its URLs and provides a way to print them out when needed.
function tcar_printUrl {

    local URL=''

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='domain,home,lists,wiki,forums,bugs,planet,docs,mirrors,projects,svn,trac,irc,cc-sharealike,with-locale,as-html-link'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope. Doing this is very important to
    # avoid any clash with higher execution environments.
    local TCAR_MODULE_ARGUMENT=''

    # Process all arguments currently available in this function
    # environment. If either ARGSS or ARGSL local variables have been
    # defined, argument processing goes through getopt for validation.
    tcar_setModuleArguments "${@}"

    # Redefine positional parameters using TCAR_MODULE_ARGUMENT variable.
    eval set -- "${TCAR_MODULE_ARGUMENT}"

    # Look for options passed through command-line.
    while true; do
        case "${1}" in

            --domain )
                URL="centos.org"
                shift 1
                ;;

            --home )
                URL="http://www.$(tcar_printUrl --domain)/"
                shift 1
                ;;

            --lists )
                URL="http://lists.$(tcar_printUrl --domain)/"
                shift 1
                ;;

            --wiki )
                URL="http://wiki.$(tcar_printUrl --domain)/"
                shift 1
                ;;

            --forums )
                URL="http://forums.$(tcar_printUrl --domain)/"
                shift 1
                ;;

            --bugs )
                URL="http://bugs.$(tcar_printUrl --domain)/"
                shift 1
                ;;

            --projects )
                URL="https://projects.$(tcar_printUrl --domain)/"
                shift 1
                ;;

            --svn )
                URL="$(tcar_printUrl --projects)svn/"
                shift 1
                ;;

            --trac )
                URL="$(tcar_printUrl --projects)trac/"
                shift 1
                ;;

            --planet )
                URL="http://planet.$(tcar_printUrl --domain)/"
                shift 1
                ;;

            --docs )
                URL="http://docs.$(tcar_printUrl --domain)/"
                shift 1
                ;;

            --mirrors )
                URL="http://mirrors.$(tcar_printUrl --domain)/"
                shift 1
                ;;

            --irc )
                URL="http://$(tcar_printUrl --home)modules/tinycontent/index.php?id=8"
                shift 1
                ;;

            --cc-sharealike )
                URL="http://creativecommons.org/licenses/by-sa/3.0/"
                shift 1
                ;;

            --with-locale )
                if [[ ! ${LANG} =~ '^en' ]];then
                    URL="${URL}${TCAR_SCRIPT_LANG_LL}/"
                fi
                shift 1
                ;;

            --as-html-link )
                URL="<a href=\"${URL}\">${URL}</a>"
                shift 1
                ;;

            -- )

                shift 1
                break
                ;;
        esac
    done

    # Print Url.
    echo "${URL}"

}
