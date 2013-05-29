#!/bin/bash
#
# help_getEntries.sh -- This function interpretes non-option
# arguments passed to `help' functionality through the command-line
# and redefines array variables related to documentation entries.
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

function help_getEntries {

    # Initialize manual's documentation entry as an empty value local
    # to this function.
    local MANUAL_DOCENTRY=''

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Retrive documentation entries passed to `centos-art.sh' script
    # as non-option arguments and store them in array variables in
    # order to describe their parts (e.g., manual name, chapter name
    # and section name) that way.  Documentation entries passed as
    # non-opiton arguments must be written either in
    # `MANUAL:PART:CHAPTER:SECTION' or `path/to/dir' formats in order
    # to be processed correctly here. Empty spaces are not permitted.
    # To separate words, use the minus sign (e.g., hello-world) or
    # cammel case (e.g., HelloWorld).
    for MANUAL_DOCENTRY in $@;do

        if [[ ${MANUAL_DOCENTRY} =~ '^[[:alpha:]][[:alnum:]-]+:([[:alnum:]-]*:){2}[[:alnum:]/]*' ]];then

            # When `MANUAL:PART:CHAPTER:SECTION' is used as format to
            # documentation entry, you can specify the manual, chapter
            # and section where documentation actions will take place
            # on.

            # Manual self name.
            MANUAL_SLFN[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                $(echo "${MANUAL_DOCENTRY}" | gawk 'BEGIN { FS=":" } { print $1 }') -f \
                | tr '[:upper:]' '[:lower:]')

            # Manual self directory name.
            MANUAL_DIRN[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                $(echo "${MANUAL_DOCENTRY}" | gawk 'BEGIN { FS=":" } { print $1 }') -d )

            # Manual part name.
            MANUAL_PART[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                $(echo "${MANUAL_DOCENTRY}" | gawk 'BEGIN { FS=":" } { print $2 }') -d )

            # Manual chapter name.
            MANUAL_CHAP[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                $(echo "${MANUAL_DOCENTRY}" | gawk 'BEGIN { FS=":" } { print $3 }') -d )

            # Manual section name.
            MANUAL_SECT[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                $(echo "${MANUAL_DOCENTRY}" | gawk 'BEGIN { FS=":" } { print $4 }' | tr '/' '-') -f )

        elif [[ ${MANUAL_DOCENTRY} =~ "^(trunk|branches|tags)?(/)?($(ls ${TCAR_WORKDIR} \
            | tr '[[:space:]]' '|' | sed 's/|$//'))" ]];then

            # When we use the `path/to/dir' as format to reach
            # documentation entries, you cannot specify the manual
            # chapter or section where documentation actions will take
            # place on. Instead, they are predefined for you here. Use
            # this format to quickly document directories inside your
            # working copy.
            #
            # When we use the `path/to/dir' format to reach
            # documentation entries, there is a distinction between
            # Subversion and Git version control system we need to be
            # aware of.  This is the directory structure layout used
            # in the repository.  In Subversion, we use a trunk/,
            # branches/, tags/ layout as first level in the repository
            # directory structure but, in Git, we don't need such
            # special layout in the repository's first directory
            # level. The script must be able to understand both
            # directory structures.

            # Manual's self name.
            MANUAL_SLFN[${MANUAL_DOCENTRY_COUNT}]='tcar-fs'

            # Manual's self directory name.
            MANUAL_DIRN[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                ${MANUAL_SLFN[${MANUAL_DOCENTRY_COUNT}]} -d)

            # Manual's chapter name.
            MANUAL_CHAP[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                $(echo "${MANUAL_DOCENTRY}" | gawk 'BEGIN { FS="/" }; { if ( NF >= 1 ) print $1 }' ) -d )

            # Manual's section name.
            MANUAL_SECT[${MANUAL_DOCENTRY_COUNT}]=$(cli_getRepoName \
                $(echo "${MANUAL_DOCENTRY}" | gawk 'BEGIN { FS="/" }; { if ( NF >= 2 ) print $0 }' \
                | cut -d/ -f2- | tr '/' '-') -f )

        else

            cli_printMessage "`gettext "The documentation entry provided isn't supported."`" --as-error-line

        fi

        # Increment counting of non-option arguments.
        MANUAL_DOCENTRY_COUNT=$(($MANUAL_DOCENTRY_COUNT + 1))

    done

}
