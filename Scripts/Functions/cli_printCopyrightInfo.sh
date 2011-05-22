#!/bin/bash
#
# cli_printCopyrightInfo.sh -- This function standardizes the
# copyright information used by centos-art.sh script.
#
# As far as I understand, the copyright exists to make people create
# more.  The copyright gives creators the legal power over their
# creations and so the freedom to distribute them under the ethical
# terms the creator considers better.  At this moment I don't feel
# very confident about this legal affairs and their legal
# implications, but I need to decide what copyright information the
# centos-art.sh script will print out. So, in that sake, I'll assume
# the same copyright information used by The CentOS Wiki
# (http://wiki.centos.org/) as reference.
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

function cli_printCopyrightInfo {

    # Define short options.
    local ARGSL=''

    # Define long options.
    local ARGSL='license,license-url,coyright,copyright-year,copyright-year-last,copyright-year-first,copyright-year-list,copyright-year-range,copyright-holder'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope.
    local ARGUMENTS=''

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_parseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_parseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through positional parameters.
    while true; do

        case "$1" in

            --license )

                # Print out the name of the license used by to release
                # the content produced by centos-art.sh script, inside
                # CentOS Artwork Repository.
                echo "Creative Common Attribution-ShareAlike 3.0"
                shift 2
                break
                ;;

            --license-url )

                # Print out the url of the license used by to release
                # the content produced by centos-art.sh script, inside
                # CentOS Artwork Repository.
                cli_printUrl --cc-sharealike
                shift 2
                break
                ;;

            --copyright-year-first )

                # The former year when I (as part of The CentOS
                # Project) started to consolidate The CentOS Project
                # Corporate Visual Identity through the CentOS Artwork
                # Repository.
                echo '2009'
                shift 2
                break
                ;;

            --copyright-year|--copyright-year-last )

                # The last year when The CentOS Project stopped
                # working in its Corporate Visual Identity through the
                # CentOS Artwork Repository. That is something that I
                # hope does never happen, so assume the current year
                # as last working year.
                date +%Y
                shift 2
                break
                ;;

            --copyright-year-range )

                local FIRST_YEAR=$(cli_printCopyrightInfo '--copyright-year-first')
                local LAST_YEAR=$(cli_printCopyrightInfo '--copyright-year-last')
                echo "${FIRST_YEAR}-${LAST_YEAR}"
                shift 2
                break
                ;;

            --copyright-year-list )

                local FIRST_YEAR=$(cli_printCopyrightInfo '--copyright-year-first')
                local LAST_YEAR=$(cli_printCopyrightInfo '--copyright-year-last')

                # Define full copyright year string based on first and
                # last year.
                local FULL_YEAR=$(\
                    while [[ ${FIRST_YEAR} -le ${LAST_YEAR} ]];do
                        echo -n "${FIRST_YEAR}, "
                        FIRST_YEAR=$(($FIRST_YEAR + 1))
                    done)

                # Prepare full copyright year string and print it out. 
                echo "${FULL_YEAR}" | sed 's!, *$!!'
                shift 2
                break
                ;;
    
            --copyright-holder )
            
                # Output default copyright holder.
                echo "The CentOS Project"
                shift 2
                break
                ;;

            --copyright )

                local YEAR=$(cli_printCopyrightInfo '--copyright-year-last')
                local HOLDER=$(cli_printCopyrightInfo '--copyright-holder')
                echo "Copyright © $YEAR $HOLDER"
                shift 2
                break
                ;;

            -- )
                cli_printMessage "`gettext "At least one option is required."`" --as-error-line
                shift 1
                break
                ;;

        esac

    done

}
