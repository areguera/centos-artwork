#!/bin/bash
######################################################################
#
#   tcar_printCopyrightInfo.sh -- This function standardizes the
#   copyright information printed on content produced by tcar.sh
#   script.
#
#   As far as I understand, the copyright exists to make people create
#   more.  The copyright gives creators the legal power over their
#   creations and so the freedom to distribute them under the ethical
#   terms the creator considers better.  At this moment I don't feel
#   very confident about this legal affairs and their legal
#   implications, but I need to decide what copyright information the
#   tcar.sh script will print out when someone request
#   information about it.  So, in that sake, I am using The CentOS
#   Artwork SIG as copyright holder and the GNU Public License,
#   version 2 or any later, for software distribution.
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

function tcar_printCopyrightInfo {

    # Reset text domain locally, in order to prevent this function
    # from using the last text domain definition. By default all
    # common functions do use the same MO file.
    local TEXTDOMAIN="${TCAR_SCRIPT_PACKAGE}"

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

            # The software release year. This information should never
            # be the current year. Instead, to make this information
            # maintainable, relay on tcar package build-time.
            rpm -q --qf "%{BUILDTIME:date}" tcar | gawk '{ print $4 }'
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
            
            # Print tcar.sh script default copyright holder. Be
            # pragmatic about this information, please. The CentOS
            # Project exists to produce The CentOS Distribution, not
            # tcar.sh script. Nevertheless, The CentOS Artwork SIG is
            # an organizational unit of The CentOS Project which is
            # focused on producing The CentOS Project corporate visual
            # identity, by means of The CentOS Artwork Repository.
            # The tcar.sh script automates frequent tasks inside The
            # CentOS Artwork Repository so, based on these
            # considerations, the copyright holder of the tcar.sh
            # script is "closer" to be The CentOS Artwork SIG than it
            # would be The CentOS Project. These are the logical
            # choosing ideas behind the copyright holder of tcar.sh
            # script.
            echo "`gettext "The CentOS Artwork SIG"`"
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
