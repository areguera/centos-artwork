#!/bin/bash
#
# locale_isLocalizable.sh -- This function determines whether a file
# or directory can have translation messages or not. This is the way
# we standardize what locations can and cannot be localized inside the
# repository.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function locale_isLocalizable {

    local DIR=''
    local -a DIRS

    # Initialize location will use as reference to determine whether
    # it can have translation messages or not.
    local LOCATION="$1"

    # Initialize answer value. By default all paths do not accept
    # localization.
    local L10N_ACCEPTED='no'
    
    # When no variable is passed to this function, use the action
    # value instead.
    if [[ $LOCATION == '' ]];then
        LOCATION=${ACTIONVAL}
    fi

    # Redefine location to be sure we'll always evaluate a directory,
    # as reference location.
    if [[ -f $LOCATION ]];then
        LOCATION=$(dirname $LOCATION)
    fi

    # Verify location existence. If it doesn't exist we cannot go on.
    cli_checkFiles -e $LOCATION

    # Initialize possible messages this function would print out.
    local -a MESSAGES

    # Define regular expression list of all directories inside the
    # repository that can have translation. Try to keep regular
    # expressions as simple as possible, so they can be understood by
    # sed program.
    DIRS[++((${#DIRS[*]}))]="${TCAR_WORKDIR}/Identity/Models/Themes/[[:alnum:]-]+/Distro/$(\
        cli_getPathComponent --release-pattern)/(Anaconda|Concept|Posters|Media)"
    DIRS[++((${#DIRS[*]}))]="${TCAR_WORKDIR}/Documentation/Models/Docbook/[[:alnum:]-]+"
    DIRS[++((${#DIRS[*]}))]="${TCAR_WORKDIR}/Documentation/Models/Svg/[[:alnum:]-]+"
    DIRS[++((${#DIRS[*]}))]="${TCAR_WORKDIR}/Scripts/Bash"

    # Verify location passed as first argument against the list of
    # directories that can have translation messages. By default, the
    # location passed as first argument is considered as a location
    # that cannot have translation messages until a positive answer
    # says otherwise.
    for DIR in ${DIRS[@]};do

        # Define the path part which is not present in the
        # localizable directories.
        local PATHDIFF=$(echo ${LOCATION} | sed -r "s,${DIR}/,,")

        # Define the path part that is present in the localizable
        # directories.
        local PATHSAME=$(echo ${LOCATION} | sed -r "s,/${PATHDIFF},,")

        # Initiate verification between location provided and
        # localizable directories.
        if [[ $LOCATION =~ "^$DIR$" ]];then

            # At this point the location provided is exactly the same
            # that matches the localizable directories. There is
            # nothing else to do here but return the script flow to
            # this function caller.
            L10N_ACCEPTED='yes' 
            break

        elif [[ ${PATHSAME} =~ "^${DIR}" ]] && [[ -d ${LOCATION} ]];then

            # At this point the location provided is a directory in
            # the repository which doesn't match any localizable
            # directory in the list, but it could be rendered if the
            # --filter option is provided with the appropriate path
            # argument. Print a suggestion about it.
            cli_printMessage "${PATHSAME} --filter=\"$PATHDIFF\"" --as-suggestion-line
            break
            
        fi

    done

    # At this point, we are safe to say that the path provided isn't
    # allow to have any localization for it. So, finish the script
    # execution with an error message.
    if [[ $L10N_ACCEPTED == 'no' ]];then
        cli_printMessage "`gettext "The path provided doesn't support localization."`" --as-error-line
    fi

}
