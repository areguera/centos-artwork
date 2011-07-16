#!/bin/bash
#
# help_getEntries.sh -- This function interpretes non-option
# arguments passed to `help' functionality through the command-line
# and redefines array variables related to documentation entries.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function help_getEntries {

    local DOCENTRY=''

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    if [[ $@ == '' ]];then

        # Define default documentation entry. This happen when
        # non-option arguments aren't provided to centos-art.sh
        # script.  Default documentation entry defined here points to
        # manual's main definition file, so only the manual's self
        # name and manual's directory name need to be defined here.
        MANUAL_SLFN[0]='tcar-ug'
        MANUAL_DOCENTRY_COUNT=$(($MANUAL_DOCENTRY_COUNT + 1))

    else

        # Retrive documentation entries passed to centos-art.sh script
        # as non-option arguments and store them in array variables in
        # order to describe their parts (e.g., manual name, chapter
        # name and section name) that way.  Documentation entries
        # passed as non-opiton arguments must have the
        # `MANUAL:CHAPTER:SECTION' format in order to be processed
        # correctly here. Empty spaces are not permitted. To separate
        # words, use the minus sign (e.g., hello-world) or cammel case
        # (e.g., HelloWorld).
        for DOCENTRY in $@;do

            # Manual self name.
            MANUAL_SLFN[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                $(echo "$DOCENTRY" | gawk 'BEGIN{ FS=":" } { print $1 }') -f \
                | tr '[:upper:]' '[:lower:]')

            # Manual self directory name.
            MANUAL_DIRN[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                $(echo "$DOCENTRY" | gawk 'BEGIN{ FS=":" } { print $1 }') -d )

            # Manual chapter name.
            MANUAL_CHAN[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                $(echo "$DOCENTRY" | gawk 'BEGIN{ FS=":" } { print $2 }') -d )

            # Manual section name.
            MANUAL_SECN[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                $(echo "$DOCENTRY" | gawk 'BEGIN{ FS=":" } { print $3 }') -f )

            # Increment counting of non-option arguments.
            MANUAL_DOCENTRY_COUNT=$(($MANUAL_DOCENTRY_COUNT + 1))

        done

    fi
}
