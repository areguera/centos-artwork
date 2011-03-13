#!/bin/bash
#
# prepare_doLinks.sh -- This function verifies the required symbolic
# links your workstation needs to have installed in order for
# centos-art command to run correctly.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function prepare_doLinks {

    # Verify `--links' option.
    if [[ $FLAG_LINKS == 'false' ]];then
        return
    fi

    # Print line separator.
    cli_printMessage '-' 'AsSeparatorLine'

    local -a LINKS_SRC
    local -a LINKS_SRC_MISSING
    local -a LINKS_DST
    local -a LINKS_DST_UNKNOWN
    local ID=''
    local COUNT=0
    local WARNING=''
    local LINKS_MISSING_ID=''
    local GIMP_USERDIR=${HOME}/.$(rpm -q gimp | cut -d. -f-2)

    # Define link sources.
    LINKS_SRC[0]=${HOME}/bin/$CLI_PROGRAM
    LINKS_SRC[1]=${HOME}/.fonts/denmark.ttf
    LINKS_SRC[2]=${HOME}/.inkscape/palettes/CentOS.gpl
    LINKS_SRC[3]=${GIMP_USERDIR}/palettes/CentOS.gpl

    # Define link targets.
    LINKS_DST[0]=${CLI_BASEDIR}/init.sh
    LINKS_DST[1]=${HOME}/artwork/trunk/Identity/Fonts/denmark.ttf
    LINKS_DST[2]=${HOME}/artwork/trunk/Identity/Colors/CentOS.gpl
    LINKS_DST[3]=${LINKS_DST[2]}

    # Define both source and target location for Gimp brushes.
    for FILE in $(find ${HOME}/artwork/trunk/Identity/Models/Gbr/ -name '*.gbr');do
        LINKS_SRC[((++${#LINKS_SRC[*]}))]=${GIMP_USERDIR}/brushes/$(basename $FILE)
        LINKS_DST[((++${#LINKS_DST[*]}))]=$FILE
    done

    # Print action message.
    cli_printMessage "`gettext "Symbolic links"`" 'AsCheckingLine'

    # Define which links are missing from the list of source links.
    until [[ $COUNT -eq ${#LINKS_SRC[*]} ]];do

        if [[ -h ${LINKS_SRC[$COUNT]} ]]; then

            # At this point the required link does exist but we don't
            # know if its target is the one it should be. Get target
            # from required link in order to check it later.
            LINKS_DST_UNKNOWN[$COUNT]=$(stat --format='%N' ${LINKS_SRC[$COUNT]} \
                | tr '`' ' ' | tr "'" ' ' | tr -s ' ' | cut -d' ' -f4)

            # Check required target from required link in order to
            # know if it is indeed the one it should be. Otherwise add
            # required link to list of missing links.
            if [[ ${LINKS_DST_UNKNOWN[$COUNT]} != ${LINKS_DST[$COUNT]} ]] ;then
                LINKS_MISSING_ID="$COUNT $LINKS_MISSING_ID"
            fi

        else

            # Add required link to list of missing links.  At this
            # point the required link doesn't exist at all.
            LINKS_MISSING_ID="$COUNT $LINKS_MISSING_ID"

        fi

        # Increase link counter.
        COUNT=$(($COUNT + 1))
        
    done

    # Print separator line.
    cli_printMessage '-' 'AsSeparatorLine'

    # Is there any link missing?
    if [[ $LINKS_MISSING_ID == '' ]];then
        cli_printMessage "`gettext "The required links has been already created."`"
        return
    fi

    # Sort the list of missing links identifications.
    LINKS_MISSING_ID=$(echo $LINKS_MISSING_ID | tr ' ' "\n" | sort )

    # Define number of missing links. This is required for gettext to
    # set the plural form of messages.
    LINKS_MISSING_ID_COUNT=$(echo $LINKS_MISSING_ID | wc -l)

    # At this point there is one or more missing links that need to be
    # created in the workstation. Report this issue and specify which
    # these links are.
    cli_printMessage "`ngettext "The following link needs to be created" \
        "The following links need to be created" \
        "$LINKS_MISSING_ID_COUNT"`:"

    # Build report of missing packages and remark those comming from
    # third party repository.
    for ID in $LINKS_MISSING_ID;do
        # Consider missing link that already exists as regular file. If
        # a regular file exists with the same name of a required link,
        # warn the user about it and continue with the next file in
        # the list of missing links that need to be created.
        if [[ -f ${LINKS_SRC[$ID]} ]];then
            WARNING=" (`gettext "Caution! It already exists as regular file."`)"
        fi
        cli_printMessage "${LINKS_SRC[$ID]}${WARNING}" 'AsResponseLine'
    done

    # Print confirmation request.
    cli_printMessage "`gettext "Do you want to continue"`" 'AsYesOrNoRequestLine'

    # Create symbolic links using their identifications.
    for ID in $LINKS_MISSING_ID;do

        # Print action message.
        cli_printMessage "${LINKS_SRC[$ID]}" 'AsCreatingLine'

        # Create the symbolic link.
        ln ${LINKS_DST[$ID]} ${LINKS_SRC[$ID]} --force --symbolic

    done

    # At this point all required links must be installed. To confirm
    # required links installation let's verify them once more.
    prepare_doLinks

}
