#!/bin/bash
#
# path_doCopy.sh -- This function implements duplication of files
# inside the working copy.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

function path_doCopy {

    local ARGSL
    local ARGSS

    # Define short options supported by copy command we want to
    # support inside centos-art.sh script. The value of this variable
    # is used as `getopt --options' option.
    ARGSS="t:r:m:F:"

    # Define long options supported by copy command we want to support
    # inside centos-art.sh script. The value of this variable is used
    # as defined by `getopt --longoptions' option.
    ARGSL="to:,revision:,message:,file:,force-log,editor-cmd:,encoding:,username:,password:,no-auth-cache,non-interactive,config-dir:"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define target locations using positonal parameters as
    # reference.
    while true; do
        case "$1" in
            -t|--to )
                TARGET="$2"
                shift 2
                ;;
            * )
                break 
        esac
    done

    # Redefine positional parameters stored inside ARGUMENTS variable.
    cli_doParseArgumentsReDef "$@"

    # Parse positional parameters sotred inside ARGUMENTS variable.
    cli_doParseArguments

    # Build subversion command to duplicate locations inside the
    # workstation.
    eval svn copy $SOURCE $TARGET --quiet $ARGUMENTS

    # Output action results.
    if [[ $? -ne 0 ]];then
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi
    
}
