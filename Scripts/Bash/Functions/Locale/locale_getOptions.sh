#!/bin/bash
#
# locale_getOptions.sh -- This function interprets option parameters
# passed to `locale' functionality and defines action names
# accordingly.
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

function locale_getOptions {

    # Define short options we want to support.
    local ARGSS="h,q"

    # Define long options we want to support.
    local ARGSL="help,quiet,filter:,answer-yes,update,edit,delete,dont-create-mo,is-localizable,synchronize"

    # Redefine ARGUMENTS using getopt(1) command parser.
    cli_parseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "${ARGUMENTS}"

    # Look for options passed through command-line.
    while true; do
        case "$1" in

            -h | --help )
                cli_runFnEnvironment help --read --format="texinfo" "tcar-fs::scripts:bash-functions-locale"
                shift 1
                exit
                ;;

            -q | --quiet )
                FLAG_QUIET="true"
                shift 1
                ;;

            --filter )
                FLAG_FILTER="$2"
                shift 2
                ;;

            --answer-yes )
                FLAG_ANSWER="true"
                shift 1
                ;;

            --update )
                ACTIONNAMS="$ACTIONNAMS locale_updateMessages"
                shift 1
                ;;

            --edit )
                ACTIONNAMS="$ACTIONNAMS locale_editMessages"
                shift 1
                ;;

            --delete )
                ACTIONNAMS="$ACTIONNAMS locale_deleteMessages"
                shift 1
                ;;

            --is-localizable )
                ACTIONNAMS="$ACTIONNAMS locale_isLocalizable"
                shift 1
                ;;

            --dont-create-mo )
                FLAG_DONT_CREATE_MO="true"
                shift 1
                ;;

            --synchronize )
                FLAG_SYNCHRONIZE="true"
                shift 1
                ;;

            -- )
                # Remove the `--' argument from the list of arguments
                # in order for processing non-option arguments
                # correctly. At this point all option arguments have
                # been processed already but the `--' argument still
                # remains to mark ending of option arguments and
                # beginning of non-option arguments. The `--' argument
                # needs to be removed here in order to avoid
                # centos-art.sh script to process it as a path inside
                # the repository, which obviously is not.
                shift 1
                break
                ;;
        esac
    done

    # Verify action names. When no action name is specified, print an
    # error message explaining an action is required at least.
    if [[ $ACTIONNAMS == '' ]];then
        cli_printMessage "`gettext "You need to provide one action at least."`" --as-error-line
    fi

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_parseArgumentsReDef "$@"

}
