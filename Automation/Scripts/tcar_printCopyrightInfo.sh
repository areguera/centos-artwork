#!/bin/bash
######################################################################
#
#   tcar_printCopyrightInfo.sh -- This function standardizes the
#   copyright information printed on content produced by centos-art.sh
#   script.
#
#   As far as I understand, the copyright exists to make people create
#   more.  The copyright gives creators the legal power over their
#   creations and so the freedom to distribute them under the ethical
#   terms the creator considers better.  At this moment I don't feel
#   very confident about this legal affairs and their legal
#   implications, but I need to decide what copyright information the
#   centos-art.sh script will print out when it be requested about it.
#   So, in that sake, I'll assume the same copyright information used
#   by The CentOS Wiki (http://wiki.centos.org/) as reference.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#     Key fingerprint = D67D 0F82 4CBD 90BC 6421  DF28 7CCE 757C 17CA 3951
#
# Copyright (C) 2009-2013 The CentOS Project
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

function tcar_printCopyrightInfo {

    case "${1}" in

        --license )

            # Print the license name. 
            echo "`gettext "Creative Common Attribution-ShareAlike 3.0 License"`"
            ;;

        --license-url )

            # Print the url related to license name.
            tcar_printUrl --cc-sharealike
            ;;

        --first-year )

            # The former year when I (as collaborator of The CentOS
            # Project) started to consolidate The CentOS Project
            # Corporate Visual Identity through the CentOS Artwork
            # Repository.
            echo '2009'
            ;;

        --year|--last-year)

            # The last year when The CentOS Project stopped working in
            # its Corporate Visual Identity through the CentOS Artwork
            # Repository. That is something that I hope never happens,
            # so assume the current year as last working year.
            date +%Y
            ;;

        --years-range )

            local FIRST_YEAR=$(tcar_printCopyrightInfo --first-year)
            local LAST_YEAR=$(tcar_printCopyrightInfo --last-year)
            echo "${FIRST_YEAR}-${LAST_YEAR}"
            ;;

        --years-list )

            local FIRST_YEAR=$(tcar_printCopyrightInfo --first-year)
            local LAST_YEAR=$(tcar_printCopyrightInfo --last-year)

            # Define full copyright year string based on first and
            # last year.
            local FULL_YEAR=$(\
                while [[ ${FIRST_YEAR} -le ${LAST_YEAR} ]];do
                    echo -n "${FIRST_YEAR}, "
                    FIRST_YEAR=$((${FIRST_YEAR} + 1))
                done)

            # Prepare full copyright year string and print it out. 
            echo "${FULL_YEAR}" | sed 's!, *$!!'
            ;;
    
        --holder )
            
            # Print centos-art.sh script default copyright holder.
            echo "The CentOS Project"
            ;;

        --holder-predicate )

            local HOLDER=$(tcar_printCopyrightInfo --holder)
            echo "${HOLDER}. `gettext "All rights reserved."`"
            ;;

        * )

            local YEAR=$(tcar_printCopyrightInfo --last-year)
            local HOLDER=$(tcar_printCopyrightInfo --holder)
            echo "Copyright © ${YEAR} ${HOLDER}"
            ;;

    esac

}
