#!/bin/bash
######################################################################
#
#   cli_getOptions.sh -- This function parses common options passed to
#   to `centos-art.sh' script. Because option parsing is different for
#   each function environment inside centos-art.sh script, we cannot
#   use getopt here. That would enter in conflict with options from
#   deeper function environments making impossible to parse both
#   common and specific options through getopt in a modular way (e.g.,
#   without duplicating common option definition inside each different
#   module the centos-art.sh script is made of).
#
#   To solve this issue centos-art.sh script restricts the order in
#   which common options are passed through the command line. This
#   way, common options must be passed first and specific options
#   later. Common options are defined in this file and specific
#   options are defined in module-specific files.
#
#   This introduces the nature of common options: common options do
#   not modify the centos-art.sh script behaviour in any way. Common
#   options exist to show information about centos-art.sh script and
#   its modules only (e.g., --help and --version) and once done, exit
#   successfully without processing any other option or argument
#   passed in the command-line.
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

function cli_getOptions {

    # Define valid short options.
    local ARGSS="h,v"

    # Define valid long options.
    local ARGSL="help,version"

    # Define module arguments local to this function. This is very
    # important in order to provide option parsing for different
    # function environment levels.
    local TCAR_ARGUMENTS=''

    # Redefine arguments using getopt(1) command parser.
    cli_setArguments "${@}"

    # Reset positional parameters on this function, using output
    # produced from (getopt) arguments parser.
    eval set -- "${TCAR_ARGUMENTS}"

    # Look for options passed through command-line.
    while true; do
        case ${1} in

            -h | --help )
                cli_printHelp
                ;;

            -v | --version )
                cli_printVersion
                ;;

            * )
                # At this point none of the valid options were
                # provided so, finish the script execution. This is
                # not absolutely needed because getopt will complain
                # about non-valid options and probably never execution
                # reaches this point. Consider this a backup
                # verification.
                exit 0
                ;;

        esac

    done

}
